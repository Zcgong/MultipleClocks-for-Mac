//
//  MCMenubarController.m
//  MultipleClocks
//
//  Created by tonyzhou on 11/15/12.
//  Copyright (c) 2012 tonyzhou. All rights reserved.
//

#import "MCMenubarController.h"
#import "MCStatusItemView.h"

@implementation MCMenubarController

@synthesize statusItemView = _statusItemView;

- (id)init
{
    self = [super init];
    if(self)
    {
        NSStatusItem *statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength: 24.0];
        _statusItemView = [[MCStatusItemView alloc] initWithStatusItem:statusItem];
        _statusItemView.normalImage = [NSImage imageNamed:@"normalImage"];
        _statusItemView.activeImage = [NSImage imageNamed:@"activeImage"];
        _statusItemView.action = @selector(toggleStatus:);
    }
    
    return self;
}

- (void)dealloc
{
    [[NSStatusBar systemStatusBar] removeStatusItem:self.statusItem];
}

- (NSStatusItem *)statusItem
{
    return self.statusItemView.statusItem;
}

- (BOOL)isItemActive
{
    return self.statusItemView.isActive;
}

- (void)setIsItemActive:(BOOL)flag
{
    self.statusItemView.isActive = flag;
}

@end
