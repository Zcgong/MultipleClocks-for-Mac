//
//  MCPanelController.m
//  MultipleClocks
//
//  Created by tonyzhou on 11/15/12.
//  Copyright (c) 2012 tonyzhou. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MCPanelController.h"
#import "MCStatusItemView.h"
#import "MCBackgroundView.h"
#import "MCClockTableCellView.h"
#import "MCClockItem.h"

#define OPEN_DURATION .15
#define CLOSE_DURATION .1

#define SEARCH_INSET 17

#define POPUP_HEIGHT 122
//#define PANEL_WIDTH 280
#define MENU_ANIMATION_DURATION .1

@implementation MCPanelController

@synthesize delegate = _delegate;
@synthesize backgroundView = _backgroundView;
@synthesize clockTable = _clockTable;
@synthesize tableContainer = _tableContainer;

- (id)initWithDelegate:(id<PanelControllerDelegate>)d
{
    self = [super initWithWindowNibName:@"ClockPanel"];
    if(self)
    {
        _delegate = d;
        
        _clockList = [[NSMutableArray alloc] init];
        
        MCClockItem * item = [[MCClockItem alloc] init];
        item.clockName = @"Hangzhou";
        item.timeZone = [NSTimeZone defaultTimeZone];
        item.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [item.calendar setTimeZone:item.timeZone];
        
        [_clockList insertObject:item atIndex:0];
        
        item = [[MCClockItem alloc] init];
        item.clockName = @"PST";
        item.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"PST"];
        item.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [item.calendar setTimeZone:item.timeZone];

        [_clockList insertObject:item atIndex:1];
        
        item = [[MCClockItem alloc] init];
        item.clockName = @"GMT";
        item.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        item.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [item.calendar setTimeZone:item.timeZone];
        
        [_clockList insertObject:item atIndex:2];
        
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Make a fully skinned panel
    NSPanel *panel = (id)[self window];
    [panel setAcceptsMouseMovedEvents:YES];
    [panel setLevel:NSPopUpMenuWindowLevel];
    [panel setOpaque:NO];
    [panel setBackgroundColor:[NSColor clearColor]];
    
    // Resize panel
    NSRect panelRect = [[self window] frame];
    CGFloat marginHeight = _backgroundView.frame.size.height - _tableContainer.frame.size.height;
    panelRect.size.height = _clockTable.frame.size.height + marginHeight + 10;
    [[self window] setFrame:panelRect display:NO];
}


- (BOOL)isActive
{
    return _isActive;
}

- (void)setIsActive:(BOOL)flag
{
    if(_isActive != flag)
    {
        _isActive = flag;
        
        if(_isActive)
        {
            [self openPanel];
        }
        else
        {
            [self closePanel];
        }
    }
}

- (void)windowDidResize:(NSNotification *)notification
{
    NSWindow *panel = [self window];
    NSRect statusRect = [self statusRectForWindow:panel];
    NSRect panelRect = [panel frame];
    
    CGFloat statusX = roundf(NSMidX(statusRect));
    CGFloat panelX = statusX - NSMinX(panelRect);
    
    self.backgroundView.arrowX = panelX;
}

- (NSRect)statusRectForWindow:(NSWindow *)window
{
    NSRect screenRect = [[[NSScreen screens] objectAtIndex:0] frame];
    NSRect statusRect = NSZeroRect;
    
    MCStatusItemView *statusItemView = nil;
    if ([self.delegate respondsToSelector:@selector(statusItemViewForPanelController:)])
    {
        statusItemView = [self.delegate statusItemViewForPanelController:self];
    }
    
    if (statusItemView)
    {
        statusRect = statusItemView.globalRect;
        statusRect.origin.y = NSMinY(statusRect) - NSHeight(statusRect);
    }
    else
    {
        statusRect.size = NSMakeSize(24.0, [[NSStatusBar systemStatusBar] thickness]);
        statusRect.origin.x = roundf((NSWidth(screenRect) - NSWidth(statusRect)) / 2);
        statusRect.origin.y = NSHeight(screenRect) - NSHeight(statusRect) * 2;
    }
    return statusRect;
}

- (void)openPanel
{
    NSWindow *panel = [self window];
    
    NSRect screenRect = [[[NSScreen screens] objectAtIndex:0] frame];
    NSRect statusRect = [self statusRectForWindow:panel];
    
    NSRect panelRect = [panel frame];
    panelRect.origin.x = roundf(NSMidX(statusRect) - NSWidth(panelRect) / 2);
    panelRect.origin.y = NSMaxY(statusRect) - NSHeight(panelRect);
    
    if (NSMaxX(panelRect) > (NSMaxX(screenRect) - ARROW_HEIGHT))
        panelRect.origin.x -= NSMaxX(panelRect) - (NSMaxX(screenRect) - ARROW_HEIGHT);
    
    [NSApp activateIgnoringOtherApps:NO];
    [panel setAlphaValue:0];
    [panel setFrame:statusRect display:YES];
    [panel makeKeyAndOrderFront:nil];
    
    NSTimeInterval openDuration = OPEN_DURATION;
    
    NSEvent *currentEvent = [NSApp currentEvent];
    if ([currentEvent type] == NSLeftMouseDown)
    {
        NSUInteger clearFlags = ([currentEvent modifierFlags] & NSDeviceIndependentModifierFlagsMask);
        BOOL shiftPressed = (clearFlags == NSShiftKeyMask);
        BOOL shiftOptionPressed = (clearFlags == (NSShiftKeyMask | NSAlternateKeyMask));
        if (shiftPressed || shiftOptionPressed)
        {
            openDuration *= 10;
            
            if (shiftOptionPressed)
                NSLog(@"Icon is at %@\n\tMenu is on screen %@\n\tWill be animated to %@",
                      NSStringFromRect(statusRect), NSStringFromRect(screenRect), NSStringFromRect(panelRect));
        }
    }
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:openDuration];
    [[panel animator] setFrame:panelRect display:YES];
    [[panel animator] setAlphaValue:1];
    [NSAnimationContext endGrouping];
    
    [self startClock];
    
}

- (void)closePanel
{
    [self stopClock];
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:CLOSE_DURATION];
    [[[self window] animator] setAlphaValue:0];
    [NSAnimationContext endGrouping];
    
    dispatch_after(dispatch_walltime(NULL, NSEC_PER_SEC * CLOSE_DURATION * 2), dispatch_get_main_queue(), ^{
        
        [self.window orderOut:nil];
    });
}

- (IBAction)EditPreference:(id)sender
{
    NSLog(@"EditPreference");
    [self.delegate openPreferencePanel:self];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [_clockList count];
}

- (BOOL)tableView:(NSTableView *)aTableView shouldSelectRow:(NSInteger)rowIndex
{
    return NO;
}

- (void)UpdateACellView:(MCClockTableCellView *)cellView withDataItem:(MCClockItem *)item
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:item.timeZone];
    
    [dateFormatter setDateFormat:@"EEE, MMM dd"];
    NSString * dateStr = [dateFormatter stringFromDate:currentDate];
    
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *timeStr = [dateFormatter stringFromDate:currentDate];
    
    cellView.clockNameField.stringValue = item.clockName;
    cellView.clockDateField.stringValue = dateStr;
    cellView.clockTimeField.stringValue = timeStr;
    
    NSDateComponents *dateComponents = [item.calendar components:(NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit) fromDate:currentDate];
    [cellView.clockView setDateTime:dateComponents];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    MCClockItem *clockItem = [_clockList objectAtIndex:row];
    MCClockTableCellView *cellView = [tableView makeViewWithIdentifier:@"ClockCell" owner:self];
    
    //Initialize the clockview control instance
    NSRect clockFrame = CGRectMake(0, 0, cellView.clockContainer.frame.size.width, cellView.clockContainer.frame.size.height);
    MCStaticAnalogClock *aClock = [[MCStaticAnalogClock alloc] initWithFrame:clockFrame];
    aClock.autoresizingMask = NSViewWidthSizable|NSViewHeightSizable;
    cellView.clockView = aClock;
    [cellView addSubview:cellView.clockView];
    
    [self UpdateACellView:cellView withDataItem:clockItem];
    
    return cellView;
}

- (void)UpdateClockViews:(NSTimer *)theTimer
{
    for (int i=0; i<[_clockList count];  ++i)
    {
        MCClockItem *item = [_clockList objectAtIndex:i];
        MCClockTableCellView *cellView = [self.clockTable viewAtColumn:0 row:i makeIfNecessary:NO];
        
        [self UpdateACellView:cellView withDataItem:item];
    }
}

- (void)startClock
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(UpdateClockViews:) userInfo:nil repeats:YES];
}

- (void)stopClock
{
    [_timer invalidate];
    _timer = nil;
}


@end
