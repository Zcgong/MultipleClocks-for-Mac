//
//  CTClockView.h
//  ClockTest
//
//  Created by tonyzhou on 11/20/12.
//  Copyright (c) 2012 tonyzhou. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

@interface MCClockHand : NSObject
{
    CALayer *_handLayer;
}

@property (nonatomic, strong, readonly) NSImage *handImage;
@property (nonatomic, strong, readonly) CALayer *handLayer;

@end

@interface MCStaticAnalogClock : NSView
{
    CALayer *_backgroundLayer;
    MCClockHand *_hourHand;
    MCClockHand *_minHand;
    MCClockHand *_secHand;
}

@property (nonatomic, strong) NSString * timeZoneName;

- (id)initWithFrame:(NSRect)frame;
- (void)setDateTime:(NSDateComponents *)dateComponents;
@end

@interface MCDynamicAnalogClock : MCStaticAnalogClock
{
    NSTimeZone *_timeZone;
    NSCalendar *_calendar;
    NSTimer *_clockTimer;
}

- (id)initWithFrame:(NSRect)frameRect timeZone:(NSTimeZone *)theTimeZone;
- (void)start;
- (void)stop;
@end
