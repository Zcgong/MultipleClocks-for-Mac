//
//  StatusItemView.m
//  MultipleClocks
//
//  Created by tonyzhou on 11/15/12.
//  Copyright (c) 2012 tonyzhou. All rights reserved.
//

#import "MCStatusItemView.h"

@implementation MCStatusItemView

@synthesize normalImage = _normalImage;
@synthesize activeImage = _activeImage;
@synthesize statusItem = _statusItem;
@synthesize isActive = _isActive;
@synthesize action = _action;
@synthesize target = _target;

- (id)initWithStatusItem:(NSStatusItem *)statusItem
{
    CGFloat itemWidth = [statusItem length];
    CGFloat itemHeight = [[NSStatusBar systemStatusBar] thickness];
    NSRect itemRect = NSMakeRect(0.0, 0.0, itemWidth, itemHeight);
    self = [super initWithFrame:itemRect];
    
    if (self != nil) {
        _statusItem = statusItem;
        _statusItem.view = self;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
   	[self.statusItem drawStatusBarBackgroundInRect:dirtyRect withHighlight:self.isActive];
    
    NSImage *icon = self.isActive ? self.activeImage : self.normalImage;
    NSSize iconSize = [icon size];
    NSRect bounds = self.bounds;
    CGFloat iconX = roundf((NSWidth(bounds) - iconSize.width) / 2);
    CGFloat iconY = roundf((NSHeight(bounds) - iconSize.height) / 2);
    NSPoint iconPoint = NSMakePoint(iconX, iconY);
    
	[icon drawAtPoint:iconPoint fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
}

- (void)mouseDown:(NSEvent *)theEvent
{
    [NSApp sendAction:self.action to:self.target from:self];
}

- (void)setIsActive:(BOOL)flag
{
    if(_isActive == flag) return;
    _isActive = flag;
    [self setNeedsDisplay:YES];
}

- (NSRect)globalRect
{
    NSRect frame = [self frame];
    frame.origin = [self.window convertBaseToScreen:frame.origin];
    return frame;
}

@end
