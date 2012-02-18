//
//  RSAppDelegate.m
//  RSTrixie
//
//  Created by Erik Stainsby on 12-02-15.
//  Copyright (c) 2012 Roaring Sky. All rights reserved.
//

#import "RSAppDelegate.h"

@implementation RSAppDelegate

@synthesize box;
@synthesize window = _window;
@synthesize plugins;	// view controllers 
@synthesize pluginMenu;

- (id)init
{
	if(nil!=(self=[super init]))
	{
		[self setPlugins:[self loadPlugins]];
		NSLog(@"%s- [%04d] %lu", __PRETTY_FUNCTION__, __LINE__, [plugins count]);
		
	}
	return self;
}

- (void) applicationWillFinishLaunching:(NSNotification *)notification {

	NSMenu * menu = [[NSMenu alloc] init];	
	
	for(RSTrixiePlugin * p in plugins)
	{
		NSMenuItem * menuItem = [[NSMenuItem alloc] initWithTitle:[p name] action:@selector(showPluginInView:) keyEquivalent:@""];
		[menuItem setRepresentedObject:p];
		[menu addItem:menuItem];
		NSLog(@"%s- [%04d] added menu item for plugin: %@", __PRETTY_FUNCTION__, __LINE__, [p name]);
	}
	[pluginMenu setMenu:menu];

}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	
}

static NSView * activePluginView = nil;

- (IBAction) showPluginInView:(id)sender {
	NSString * name = [sender title];
	RSTrixiePlugin * p  = [sender representedObject];
	if( activePluginView == nil) {
		[box addSubview:[p view]];
	}
	else {
		[box replaceSubview:activePluginView with:[p view]];
	}
	activePluginView = [p view];
	NSLog(@"%s- [%04d] %@", __PRETTY_FUNCTION__, __LINE__, name);
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
