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

@property (nonatomic, strong) MCMenubarController *menubarController;
@property (nonatomic, strong, readonly) MCPanelController *panelController;
@property (nonatomic, strong) MCPreferenceController *preferenceController;

- (void)openPreferencePanel:(MCPanelController *)controller;
- (IBAction)toggleStatus:(id)sender;

@end
