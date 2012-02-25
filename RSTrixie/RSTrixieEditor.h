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

@property (weak) IBOutlet NSPopover *popover;
@property (weak) IBOutlet NSPopover *reactionPopover;
@property (weak) IBOutlet NSPopover *conditionPopover;

@property (retain) IBOutlet NSBox * box1;
@property (retain) IBOutlet NSBox * box2;
@property (retain) IBOutlet NSBox * box3;

@property (retain) IBOutlet NSView * actionPanel;
@property (retain) IBOutlet NSView * reactionPanel;
@property (retain) IBOutlet NSView * conditionPanel;
@property (retain) IBOutlet NSView * commentPanel;
@property (retain) IBOutlet NSTextField * comment;

@property (retain) IBOutlet NSArray * actionPlugins;
@property (retain) IBOutlet NSArray * reactionPlugins;
@property (retain) IBOutlet NSArray * conditionPlugins;

@property (retain) IBOutlet NSPopUpButton * actionMenu;
@property (retain) IBOutlet NSPopUpButton * reactionMenu;
@property (retain) IBOutlet NSPopUpButton * conditionMenu;

@property (retain) IBOutlet NSButton * actionHelp;
@property (retain) IBOutlet NSButton * reactionHelp;
@property (retain) IBOutlet NSButton * conditionHelp;

@property (retain) IBOutlet RSTrixiePlugin * activeActionPlugin;
@property (retain) IBOutlet RSTrixiePlugin * activeReactionPlugin;
@property (retain) IBOutlet RSTrixiePlugin * activeConditionPlugin;


- (IBAction) showActionHelp:(id)sender;
- (IBAction) showReactionHelp:(id)sender;
- (IBAction) showConditionHelp:(id)sender;

- (NSArray*) loadPluginsWithPrefix:(NSString*)prefix;

- (IBAction) setActionSelectorStringValue:(id)sender;
- (IBAction) setReactionSelectorStringValue:(id)sender;
- (IBAction) setConditionSelectorStringValue:(id)sender;

- (RSTrixieRule *) composeRule;

- (IBAction) addRule:(id)sender;
- (IBAction) removeRule:(id)sender;
- (IBAction) saveRule:(id)sender;



@end
