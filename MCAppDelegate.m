//
//  MCAppDelegate.m
//  MultipleClocks
//
//  Created by tonyzhou on 11/15/12.
//  Copyright (c) 2012 tonyzhou. All rights reserved.
//

#import "MCAppDelegate.h"

@implementation MCAppDelegate

@synthesize menubarController = _menubarController;
@synthesize panelController = _panelController;
@synthesize preferenceController = _preferenceController;

+ (void)initialize
{
    NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
    [defaultValues setObject:[NSNumber numberWithBool:NO] forKey:kLaunchAtLoginKey];
    [defaultValues setObject:@"" forKey:kShortCutKey];
    [defaultValues setObject:[NSNumber numberWithBool:YES] forKey:kUse24HourKey];
    [defaultValues setObject:[[NSMutableArray alloc] init] forKey:kClocksKey];
    [defaultValues setObject:@"" forKey:kCurrentProfileKey];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.menubarController = [[MCMenubarController alloc] init];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    self.menubarController = nil;
    return NSTerminateNow;
}

- (IBAction)toggleStatus:(id)sender
{
    NSLog(@"begin toggleStatus...");
    self.menubarController.isItemActive = !self.menubarController.isItemActive;
    self.panelController.isActive = !self.panelController.isActive;
    NSLog(@"toggleStatus end!");
}

- (MCPanelController *)panelController
{
    if(_panelController == nil)
    {
        _panelController = [[MCPanelController alloc] initWithDelegate:self];
    }
    
    return _panelController;
}

- (MCStatusItemView *)statusItemViewForPanelController:(MCPanelController *)controller
{
    return self.menubarController.statusItemView;
}

- (void)openPreferencePanel:(MCPanelController *)controller
{
    NSLog(@"openPreferencePanel");
    if(_preferenceController == nil)
    {
        NSLog(@"alloc and init a new window: ################################");
        _preferenceController = [[MCPreferenceController alloc] init];
    }
    
    [_preferenceController showWindow:self];
}


@end
