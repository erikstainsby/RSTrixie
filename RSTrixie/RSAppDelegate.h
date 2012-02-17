//
//  RSAppDelegate.h
//  RSTrixie
//
//  Created by Erik Stainsby on 12-02-15.
//  Copyright (c) 2012 Roaring Sky. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <RSTrixiePlugin/RSTrixiePlugin.h>

@interface RSAppDelegate : NSObject <NSApplicationDelegate>

@property (retain) IBOutlet NSBox * box;
@property (retain) IBOutlet NSArray * plugins;
@property (assign) IBOutlet NSWindow * window;
@property (retain) IBOutlet NSPopUpButton * pluginMenu;

- (NSArray*) loadPlugins;

@end
