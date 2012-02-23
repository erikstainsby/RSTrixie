//
//  RSTrixieEditor.m
//  RSTrixie
//
//  Created by Erik Stainsby on 12-02-18.
//  Copyright (c) 2012 Roaring Sky. All rights reserved.
//

#import "RSTrixieEditor.h"

@implementation RSTrixieEditor

@synthesize segmentedControl;
@synthesize popover = _popover;
@synthesize reactionPopover = _reactionPopover;
@synthesize conditionPopover = _conditionPopover;

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

@synthesize actionHelp;
@synthesize reactionHelp;
@synthesize conditionHelp;

@synthesize activeActionPlugin;
@synthesize activeReactionPlugin;
@synthesize activeConditionPlugin;

- (id)init {
	
    self = [super initWithWindowNibName:@"RSTrixieEditor" owner:self];
    if (self) {
		NSLog(@"%s- [%04d] %@", __PRETTY_FUNCTION__, __LINE__, @"");
       
		actionPlugins = [NSMutableArray array];
		reactionPlugins = [NSMutableArray array];
		conditionPlugins = [NSMutableArray array];
				
		[self setActionPlugins:[self loadPluginsWithPrefix:@"Action"]];
		[self setReactionPlugins:[self loadPluginsWithPrefix:@"Reaction"]];
		[self setConditionPlugins:[self loadPluginsWithPrefix:@"Condition"]];

    }
    
    return self;
}
- (void) windowWillLoad {

}
- (void) windowDidLoad {
	
    [super windowDidLoad];
	
	NSMenu * menu = [[NSMenu alloc] init];

	for(RSTrixiePlugin * p in actionPlugins)
	{
		NSMenuItem * menuItem = [[NSMenuItem alloc] initWithTitle:[p name] action:@selector(showActionPlugin:) keyEquivalent:@""];
		[menuItem setRepresentedObject:p];
		[menu addItem:menuItem];
			//		NSLog(@"%s- [%04d] added action menu item for plugin: %@", __PRETTY_FUNCTION__, __LINE__, [p name]);
	}
	[actionMenu setMenu:menu];
	menu = nil;
	
	NSMenu * menu2 = [[NSMenu alloc] init];	
	for(RSTrixiePlugin * p in reactionPlugins)
	{
		NSMenuItem * menuItem = [[NSMenuItem alloc] initWithTitle:[p name] action:@selector(showReactionPlugin:) keyEquivalent:@""];
		[menuItem setRepresentedObject:p];
		[menu2 addItem:menuItem];
			//		NSLog(@"%s- [%04d] added reaction menu item for plugin: %@", __PRETTY_FUNCTION__, __LINE__, [p name]);
	}
	[reactionMenu setMenu:menu2];
	menu2 = nil;
	
	NSMenu * menu3 = [[NSMenu alloc] init];	
	for(RSTrixiePlugin * p in conditionPlugins)
	{
		NSMenuItem * menuItem = [[NSMenuItem alloc] initWithTitle:[p name] action:@selector(showConditionPlugin:) keyEquivalent:@""];
		[menuItem setRepresentedObject:p];
		[menu3 addItem:menuItem];
			//		NSLog(@"%s- [%04d] added condition menu item for plugin: %@", __PRETTY_FUNCTION__, __LINE__, [p name]);
	}
	[conditionMenu setMenu:menu3];
	

		// now we can set the current plugin's views
	
	[self showActionPlugin:[actionMenu itemAtIndex:0]];
	[self showReactionPlugin:[reactionMenu itemAtIndex:0]];
	[self showConditionPlugin:[conditionMenu itemAtIndex:0]];

}

- (IBAction) showActionPlugin:(id)sender {
	
	NSString * name = [sender title];
	RSTrixiePlugin * p  = [sender representedObject];
	
	if( activeActionPlugin == nil) {
		[actionPanel addSubview:[p view]];
	}
	else {	
		[actionPanel replaceSubview:[activeActionPlugin view] with:[p view]];
	}
	[[p view] setFrameTopLeftPoint:actionMenu.frame.origin];
	
	activeActionPlugin = p;
	
	NSLog(@"%s- [%04d] %@", __PRETTY_FUNCTION__, __LINE__, name);
}
- (IBAction) showReactionPlugin:(id)sender {
	
	NSString * name = [sender title];
	RSTrixiePlugin * p  = [sender representedObject];
	
	if( activeReactionPlugin == nil) {
		[reactionPanel addSubview:[p view]];
	}
	else {
		[reactionPanel replaceSubview:[activeReactionPlugin view] with:[p view]];
	}
	[[p view] setFrameTopLeftPoint:reactionMenu.frame.origin];
	
	activeReactionPlugin = p;
	
	NSLog(@"%s- [%04d] %@", __PRETTY_FUNCTION__, __LINE__, name);
}
- (IBAction) showConditionPlugin:(id)sender {
	
	NSString * name = [sender title];
	RSTrixiePlugin * p  = [sender representedObject];
	
	if( activeConditionPlugin == nil) {
		[conditionPanel addSubview:[p view]];
	}
	else {
		[conditionPanel replaceSubview:[activeConditionPlugin view] with:[p view]];
	}
	[[p view] setFrameTopLeftPoint:conditionMenu.frame.origin];	
	
	activeConditionPlugin = p;
	
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
			// skip
			continue;
		}
		
		pluginBundle = [NSBundle bundleWithPath:path];
		
		id bundleId = [pluginBundle bundleIdentifier];
		
			//	NSLog(@"%s- [%04d] %@", __PRETTY_FUNCTION__, __LINE__, bundleId);
		
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

- (IBAction) setActionSelectorStringValue:(id)sender {
	NSLog(@"%s- [%04d] %@", __PRETTY_FUNCTION__, __LINE__, sender);
	[[activeActionPlugin selectorField] setStringValue:sender];
}
- (IBAction) setReactionSelectorStringValue:(id)sender {
	NSLog(@"%s- [%04d] %@", __PRETTY_FUNCTION__, __LINE__, sender);
	[[activeReactionPlugin selectorField] setStringValue:sender];
}
- (IBAction) setConditionSelectorStringValue:(id)sender {
	NSLog(@"%s- [%04d] %@", __PRETTY_FUNCTION__, __LINE__, sender);
	[[activeConditionPlugin selectorField] setStringValue:sender];
}

- (RSTrixieRule*) composeRule {
	
	RSTrixieRule * rule = [[RSTrixieRule alloc] init];
	
	[rule setBindEvent:			[activeActionPlugin bindEvent]];
	[rule setActionSelector:	[activeActionPlugin hasSelectorField]];
	[rule setBindSelector:		[[activeActionPlugin selectorField] stringValue]];
	[rule setPreventDefault:	[activeActionPlugin preventDefault]];
	[rule setStopBubbling:		[activeActionPlugin stopBubbling]];
	[rule setCallbackFunction:	[activeReactionPlugin callbackFunction]];
	[rule setPredicate:			[activeConditionPlugin predicate]];
	
	return rule;
}

- (IBAction) addRule:(id)sender {
	NSLog(@"%s- [%04d] %@", __PRETTY_FUNCTION__, __LINE__, [[self composeRule] description]);
}
- (IBAction) removeRule:(id)sender {
	NSLog(@"%s- [%04d] %@", __PRETTY_FUNCTION__, __LINE__, [[self composeRule] emitScript]); 
}
- (IBAction) saveRule:(id)sender {
	
}



@end
