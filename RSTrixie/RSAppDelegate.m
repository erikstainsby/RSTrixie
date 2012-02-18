//
//  RSAppDelegate.m
//  RSTrixie
//
//  Created by Erik Stainsby on 12-02-15.
//  Copyright (c) 2012 Roaring Sky. All rights reserved.
//

#import "RSAppDelegate.h"

@implementation RSAppDelegate

@synthesize windowController;
@synthesize window = _window;

@synthesize segmentedControl;

@synthesize box1;
@synthesize box2;
@synthesize box3;

@synthesize actionPanel;		// custom view
@synthesize reactionPanel;		// custom view
@synthesize conditionPanel;		// custom view
@synthesize commentPanel;

@synthesize actionPlugins;		// view controllers 
@synthesize reactionPlugins;	// view controllers 
@synthesize conditionPlugins;	// view controllers 

@synthesize actionMenu;			// popup button
@synthesize reactionMenu;		// popup button
@synthesize conditionMenu;		// popup button


static NSView * activeActionPlugin;
static NSView * activeReactionPlugin;
static NSView * activeConditionPlugin;

- (id)init {
	if(nil!=(self=[super init]))
	{
		activeActionPlugin = box1;
		activeReactionPlugin = box2;
		activeConditionPlugin = box3;
		
		[self setActionPlugins:[self loadPluginsWithPrefix:@"Action"]];
		[self setReactionPlugins:[self loadPluginsWithPrefix:@"Reaction"]];
		[self setConditionPlugins:[self loadPluginsWithPrefix:@"Condition"]];
		
		windowController = [[NSWindowController alloc] initWithWindowNibName:@"RSTrixieEditor" owner:self];
		[[windowController window] makeKeyAndOrderFront:self];
	}
	return self;
}

- (void) applicationWillFinishLaunching:(NSNotification *)notification {

	NSMenu * menu = [[NSMenu alloc] init];	
	for(RSTrixiePlugin * p in actionPlugins)
	{
		NSMenuItem * menuItem = [[NSMenuItem alloc] initWithTitle:[p name] action:@selector(showActionPlugin:) keyEquivalent:@""];
		[menuItem setRepresentedObject:p];
		[menu addItem:menuItem];
		NSLog(@"%s- [%04d] added action menu item for plugin: %@", __PRETTY_FUNCTION__, __LINE__, [p name]);
	}
	[actionMenu setMenu:menu];
	
	
	NSMenu * menu2 = [[NSMenu alloc] init];	
	for(RSTrixiePlugin * p in reactionPlugins)
	{
		NSMenuItem * menuItem = [[NSMenuItem alloc] initWithTitle:[p name] action:@selector(showReactionPlugin:) keyEquivalent:@""];
		[menuItem setRepresentedObject:p];
		[menu2 addItem:menuItem];
		NSLog(@"%s- [%04d] added reaction menu item for plugin: %@", __PRETTY_FUNCTION__, __LINE__, [p name]);
	}
	[reactionMenu setMenu:menu2];
	
	
	NSMenu * menu3 = [[NSMenu alloc] init];	
	for(RSTrixiePlugin * p in conditionPlugins)
	{
		NSMenuItem * menuItem = [[NSMenuItem alloc] initWithTitle:[p name] action:@selector(showConditionPlugin:) keyEquivalent:@""];
		[menuItem setRepresentedObject:p];
		[menu3 addItem:menuItem];
		NSLog(@"%s- [%04d] added condition menu item for plugin: %@", __PRETTY_FUNCTION__, __LINE__, [p name]);
	}
	[conditionMenu setMenu:menu3];

}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	
}

- (IBAction) showActionPlugin:(id)sender {
	
	NSString * name = [sender title];
	RSTrixiePlugin * p  = [sender representedObject];
	
	if( activeActionPlugin == nil) {
		[actionPanel addSubview:[p view]];
	}
	else {	
		[actionPanel replaceSubview:activeActionPlugin with:[p view]];
	}
	[[p view] setFrameTopLeftPoint:actionMenu.frame.origin];
	
	activeActionPlugin = [p view];
	
	NSLog(@"%s- [%04d] %@", __PRETTY_FUNCTION__, __LINE__, name);
}


- (IBAction) showReactionPlugin:(id)sender {
	
	NSString * name = [sender title];
	RSTrixiePlugin * p  = [sender representedObject];
	
	if( activeReactionPlugin == nil) {
		[reactionPanel addSubview:[p view]];
	}
	else {
		[reactionPanel replaceSubview:activeReactionPlugin with:[p view]];
	}
	[[p view] setFrameTopLeftPoint:reactionMenu.frame.origin];
			
	activeReactionPlugin = [p view];
	
	NSLog(@"%s- [%04d] %@", __PRETTY_FUNCTION__, __LINE__, name);
}


- (IBAction) showConditionPlugin:(id)sender {
	
	NSString * name = [sender title];
	RSTrixiePlugin * p  = [sender representedObject];
	
	if( activeConditionPlugin == nil) {
		[conditionPanel addSubview:[p view]];
	}
	else {
		[conditionPanel replaceSubview:activeConditionPlugin with:[p view]];
	}
	[[p view] setFrameTopLeftPoint:conditionMenu.frame.origin];	
	
	activeConditionPlugin = [p view];
	
	NSLog(@"%s- [%04d] %@", __PRETTY_FUNCTION__, __LINE__, name);
}



- (NSArray*) loadPluginsWithPrefix:(NSString*)prefix {
	
	NSBundle * main = [NSBundle mainBundle];
	NSArray * all = [main pathsForResourcesOfType:@"bundle" inDirectory:@"../Plugins"];
	
	NSMutableArray * ourPlugins = [NSMutableArray array];
	
	id plugin = nil;
	NSBundle * pluginBundle = nil;
	
	for(NSString * path in all)
	{
		NSString * filename = [path lastPathComponent];
		
		if( ![filename hasPrefix:prefix] ) 
		{
			continue;
		}
		
		pluginBundle = [NSBundle bundleWithPath:path];
		
		id bundleId = [pluginBundle bundleIdentifier];
		
		NSLog(@"%s- [%04d] %@", __PRETTY_FUNCTION__, __LINE__, bundleId);
		
		[pluginBundle load];
		
		Class prinClass = [pluginBundle principalClass];
		if(![prinClass isSubclassOfClass:[RSTrixiePlugin class]]) {
				// skip 
			continue;
		}
		
		plugin = [[prinClass alloc] initWithNibName:[prinClass className] bundle:bundleId];
		[ourPlugins addObject:plugin];
		
		plugin = nil;
		pluginBundle = nil;
	}
	
	return ourPlugins;
}



- (NSArray*) loadPlugins {
	
	NSBundle * main = [NSBundle mainBundle];
	NSArray * all = [main pathsForResourcesOfType:@"bundle" inDirectory:@"../Plugins"];
	
	NSMutableArray * ourPlugins = [NSMutableArray array];
	
	id plugin = nil;
	NSBundle * pluginBundle = nil;
	
	for(NSString * path in all)
	{
		pluginBundle = [NSBundle bundleWithPath:path];
		
		id bundleId = [pluginBundle bundleIdentifier];
		
		NSLog(@"%s- [%04d] %@", __PRETTY_FUNCTION__, __LINE__, bundleId);
		
		[pluginBundle load];
		
		Class prinClass = [pluginBundle principalClass];
		if(![prinClass isSubclassOfClass:[RSTrixiePlugin class]]) {
				// skip 
			continue;
		}
		
		plugin = [[prinClass alloc] initWithNibName:[prinClass className] bundle:bundleId];
		[ourPlugins addObject:plugin];
		
		plugin = nil;
		pluginBundle = nil;
	}
	
	return ourPlugins;
}

@end
