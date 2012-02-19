//
//  RSTrixieEditor.h
//  RSTrixie
//
//  Created by Erik Stainsby on 12-02-18.
//  Copyright (c) 2012 Roaring Sky. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <RSTrixiePlugin/RSTrixiePlugin.h>
#import "NSView+RSPositionView.h"

@interface RSTrixieEditor : NSWindowController

@property (retain) IBOutlet NSSegmentedControl * segmentedControl;

@property (retain) IBOutlet NSBox * box1;
@property (retain) IBOutlet NSBox * box2;
@property (retain) IBOutlet NSBox * box3;

@property (retain) IBOutlet NSView * actionPanel;
@property (retain) IBOutlet NSView * reactionPanel;
@property (retain) IBOutlet NSView * conditionPanel;
@property (retain) IBOutlet NSView * commentPanel;

@property (retain) IBOutlet NSArray * actionPlugins;
@property (retain) IBOutlet NSArray * reactionPlugins;
@property (retain) IBOutlet NSArray * conditionPlugins;

@property (retain) IBOutlet NSPopUpButton * actionMenu;
@property (retain) IBOutlet NSPopUpButton * reactionMenu;
@property (retain) IBOutlet NSPopUpButton * conditionMenu;

- (NSArray*) loadPluginsWithPrefix:(NSString*)prefix;

@end
