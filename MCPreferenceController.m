//
//  MCPreferenceController.m
//  MultipleClocks
//
//  Created by tonyzhou on 11/17/12.
//  Copyright (c) 2012 tonyzhou. All rights reserved.
//

#import "MCPreferenceController.h"

NSString * const kLaunchAtLoginKey = @"LaunchAtLogin";
NSString * const kShortCutKey = @"ShortCut";
NSString * const kUse24HourKey = @"Use24Hour";
NSString * const kClocksKey= @"Clocks";
NSString * const kCurrentProfileKey = @"CurrentProfile";

@interface MCPreferenceController()

@end

@implementation MCPreferenceController

- (id)init
{
    self = [super initWithWindowNibName:@"Preference"];
    if(self)
    {
        //write the initialize code here
    }
    
    return self;
}


- (BOOL)launchAtLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:kLaunchAtLoginKey];
}

- (NSString *)shortCut
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kShortCutKey];
}

- (BOOL)use24Hour
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:kUse24HourKey];
}

- (NSMutableArray *)clocks
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kClocksKey];
}

- (NSString *)currentProfile
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kCurrentProfileKey];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [_launchAtLoginButton setState:[self launchAtLogin]];
    [_hotKeyTextField setStringValue:[self shortCut]];
    [_use24HourButton setState:[self use24Hour]];
    
    NSLog(@"Nib file is loaded");
}

@end
