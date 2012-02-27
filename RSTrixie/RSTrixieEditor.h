//
//  RSTrixieEditor.h
//  RSTrixie
//
//  Created by Erik Stainsby on 12-02-18.
//  Copyright (c) 2012 Roaring Sky. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <RSTrixiePlugin/RSTrixie.h>
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

@property (retain) RSActionPlugin * activeActionPlugin;
@property (retain) RSReactionPlugin * activeReactionPlugin;
@property (retain) RSConditionPlugin * activeConditionPlugin;



- (IBAction) showActionPlugin:(id)sender;
- (IBAction) showReactionPlugin:(id)sender;
- (IBAction) showConditionPlugin:(id)sender;

- (NSArray*) loadPluginsWithPrefix:(NSString*)prefix;

- (IBAction) setActionSelectorStringValue:(id)sender;
- (IBAction) setReactionSelectorStringValue:(id)sender;
- (IBAction) setConditionSelectorStringValue:(id)sender;

- (RSTrixieRule *) composeRule;

- (IBAction) addRule:(id)sender;
- (IBAction) removeRule:(id)sender;
- (IBAction) saveRule:(id)sender;



@end
