//
//  MCPreferenceController.h
//  MultipleClocks
//
//  Created by tonyzhou on 11/17/12.
//  Copyright (c) 2012 tonyzhou. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const kLaunchAtLoginKey;
extern NSString * const kShortCutKey;
extern NSString * const kUse24HourKey;
extern NSString * const kClocksKey;
extern NSString * const kCurrentProfileKey;

@interface MCPreferenceController : NSWindowController
{
    IBOutlet NSButton *_use24HourButton;
    IBOutlet NSButton *_launchAtLoginButton;
    IBOutlet NSTextField *_hotKeyTextField;
    IBOutlet NSButton *_quitButton;
    IBOutlet NSTableView *_clocksTable;
    IBOutlet NSComboBox *_profileCombo;
    IBOutlet NSImageView *_profileView;
}

- (BOOL)launchAtLogin;
- (NSString *) shortCut;
- (BOOL) use24Hour;
- (NSMutableArray *) clocks;
- (NSString *) currentProfile;

@end
