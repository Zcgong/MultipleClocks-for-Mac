//
//  MCPreferenceController.h
//  MultipleClocks
//
//  Created by tonyzhou on 11/17/12.
//  Copyright (c) 2012 tonyzhou. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#pragma mark -

@interface MCPreferenceController : NSWindowController<NSTableViewDataSource>
{
    NSMutableArray * _clockConfigs;
    
    IBOutlet NSButton *_use24HourButton;
    IBOutlet NSButton *_launchAtLoginButton;
    IBOutlet NSTextField *_hotKeyTextField;
    IBOutlet NSButton *_quitButton;
    IBOutlet NSTableView *_clocksTable;
    IBOutlet NSComboBox *_profileCombo;
    IBOutlet NSImageView *_profileView;
}

@property (nonatomic, strong) NSMutableArray * clockConfigs;

@end
