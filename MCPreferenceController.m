//
//  MCPreferenceController.m
//  MultipleClocks
//
//  Created by tonyzhou on 11/17/12.
//  Copyright (c) 2012 tonyzhou. All rights reserved.
//

#import "MCPreferenceController.h"

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


- (void)windowDidLoad
{
    [super windowDidLoad];
    [_launchAtLoginButton setState:[MCPreference launchAtLogon]];
    [_hotKeyTextField setStringValue:[MCPreference shortCut]];
    [_use24HourButton setState:[MCPreference use24Hour]];
    
    NSLog(@"Nib file is loaded");
}

@end
