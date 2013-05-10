//
//  MCAppDelegate.h
//  MultipleClocks
//
//  Created by tonyzhou on 11/15/12.
//  Copyright (c) 2012 tonyzhou. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MCMenubarController.h"
#import "MCPanelController.h"
#import "MCPreferenceController.h"

@interface MCAppDelegate : NSObject <NSApplicationDelegate, PanelControllerDelegate>

@property (nonatomic, strong) MCMenubarController *menubarController;           // controller for status item in menubar
@property (nonatomic, strong, readonly) MCPanelController *panelController;     // controller for clock panel
@property (nonatomic, strong) MCPreferenceController *preferenceController;     // controller for preference setting dialog

- (void)openPreferencePanel:(MCPanelController *)controller;
- (IBAction)toggleStatus:(id)sender;

@end
