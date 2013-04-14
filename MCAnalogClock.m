//
//  CTClockView.m
//  ClockTest
//
//  Created by tonyzhou on 11/20/12.
//  Copyright (c) 2012 tonyzhou. All rights reserved.
//

#import "MCAnalogClock.h"

@implementation MCClockHand

@synthesize handLayer = _handLayer;

- (id)initWithImage:(NSImage *)image clockFrame:(NSRect)frame zoomRatio:(float)ratio
{
    self = [super init];
    if(self)
    {
        _handLayer = [CALayer layer];
        
        _handLayer.contents = image;
        _handLayer.anchorPoint = CGPointMake(0.5, 0);
        _handLayer.position = CGPointMake(frame.size.width/2, frame.size.height/2);
        _handLayer.bounds = CGRectMake(0, 0, image.size.width*ratio, image.size.height*ratio);
    }
    
    return self;
}

- (NSImage *)handImage
{
    return _handLayer.contents;
}

@end


@implementation MCStaticAnalogClock

@synthesize timeZoneName;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer = [CALayer layer];
        [self setWantsLayer:YES];
        
        
        NSImage *backgroundImage = [NSImage imageNamed:@"clock-background.png"];
        
        //Initialize the background layer
        _backgroundLayer = [CALayer layer];
        _backgroundLayer.contents = backgroundImage;
        _backgroundLayer.anchorPoint = CGPointZero;
        _backgroundLayer.position = CGPointMake(0, 0);
        CGFloat backgroundWidth = backgroundImage.size.width;
        CGFloat backgroundHeight = backgroundImage.size.height;
        float zoomRatio = frame.size.height/backgroundImage.size.height;
        _backgroundLayer.bounds = CGRectMake(0, 0, backgroundWidth*zoomRatio, backgroundHeight*zoomRatio);
        [self.layer addSublayer:_backgroundLayer];
        
        //Initialize the clock hands
        NSImage *hourImage = [NSImage imageNamed:@"clock-hour-background.png"];
        _hourHand = [[MCClockHand alloc] initWithImage:hourImage clockFrame:_backgroundLayer.frame zoomRatio:zoomRatio];
        [_backgroundLayer addSublayer:_hourHand.handLayer];
        
        
        NSImage *minImage = [NSImage imageNamed:@"clock-min-background.png"];
        _minHand = [[MCClockHand alloc] initWithImage:minImage clockFrame:_backgroundLayer.frame zoomRatio:zoomRatio];
        [_backgroundLayer addSublayer:_minHand.handLayer];
        
        NSImage *secImage = [NSImage imageNamed:@"clock-sec-background.png"];
        _secHand = [[MCClockHand alloc] initWithImage:secImage clockFrame:_backgroundLayer.frame zoomRatio:zoomRatio];
        [_backgroundLayer addSublayer:_secHand.handLayer];
        
    }
    
    return self;
}

float Degrees2Radians(float degrees) { return degrees * M_PI / 180; }

- (void)setDateTime:(NSDateComponents *)dateComponents
{
    NSInteger seconds = [dateComponents second];
	NSInteger minutes = [dateComponents minute];
	NSInteger hours = [dateComponents hour];
	if (hours > 12) hours -=12; //PM
    
	//set angles for each of the hands
	CGFloat secAngle = Degrees2Radians(seconds/60.0*360);
	CGFloat minAngle = Degrees2Radians(minutes/60.0*360);
	CGFloat hourAngle = Degrees2Radians(hours/12.0*360) + minAngle/12.0;
	
	_secHand.handLayer.transform = CATransform3DMakeRotation (-secAngle, 0, 0, 1);
	_minHand.handLayer.transform = CATransform3DMakeRotation (-minAngle, 0, 0, 1);
	_hourHand.handLayer.transform = CATransform3DMakeRotation (-hourAngle, 0, 0, 1);
}

@end

@implementation MCDynamicAnalogClock

- (id)initWithFrame:(NSRect)frame timeZone:(NSTimeZone *)theTimeZone
{
    self = [super initWithFrame:frame];
    if (self) {
        _timeZone = theTimeZone;
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [_calendar setTimeZone:_timeZone];
        
    }
    
    return self;
}

- (void)updateClock:(NSTimer *)theTimer
{
    NSDateComponents *dateComponents = [_calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date]];
    
    [self setDateTime:dateComponents];
    
}

- (void)start
{
	_clockTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateClock:) userInfo:nil repeats:YES];
}

- (void)stop
{
	[_clockTimer invalidate];
	_clockTimer = nil;
}

@end
