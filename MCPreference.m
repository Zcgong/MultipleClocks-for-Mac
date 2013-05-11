//
//  MCPreference.m
//  MultipleClocks
//
//  Created by tonyzhou on 5/10/13.
//  Copyright (c) 2013 tonyzhou. All rights reserved.
//

#import "MCPreference.h"

NSString * const kLaunchAtLoginKey = @"LaunchAtLogin";
NSString * const kShortCutKey = @"ShortCut";
NSString * const kUse24HourKey = @"Use24Hour";
NSString * const kClocksKey= @"Clocks";
NSString * const kCurrentProfileKey = @"CurrentProfile";

@implementation MCClockConfigItem

@synthesize clockName = _clockName;
@synthesize clockTimezoneName = _clockTimezoneName;

- (id)initWithClockName:(NSString *)clockName Timezone:(NSString *)timeZone
{
    self = [super init];
    if(self)
    {
        self.clockName = clockName;
        self.clockTimezoneName = timeZone;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.clockName = [aDecoder decodeObjectForKey:@"clockName"];
        self.clockTimezoneName = [aDecoder decodeObjectForKey:@"clockTimezoneName"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.clockName forKey:@"clockName"];
    [aCoder encodeObject:self.clockTimezoneName forKey:@"clockTimezoneName"];
}

@end

@implementation MCPreference

+ (void)initialize
{
    NSMutableDictionary * defaultValues = [NSMutableDictionary dictionary];
    [defaultValues setObject:[NSNumber numberWithBool:NO] forKey:kLaunchAtLoginKey];
    [defaultValues setObject:@"" forKey:kShortCutKey];
    [defaultValues setObject:[NSNumber numberWithBool:NO] forKey:kUse24HourKey];
    [defaultValues setObject:[NSNumber numberWithInt:0] forKey:kCurrentProfileKey];
    
    NSMutableArray * clockConfigs = [NSMutableArray array];
    MCClockConfigItem * hostClockConfig = [[MCClockConfigItem alloc] initWithClockName:@"Hangzhou" Timezone:@"US/Pacific"];
    [clockConfigs addObject:hostClockConfig];
    
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:clockConfigs];
    
    
    [defaultValues setObject:data forKey:kClocksKey];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
}

+ (BOOL)launchAtLogon
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:kLaunchAtLoginKey];
}

+ (void)setLaunchAtLogon:(BOOL)launchAtLogon
{
    [[NSUserDefaults standardUserDefaults] setBool:launchAtLogon forKey:kLaunchAtLoginKey];
}

+ (NSString *)shortCut
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kShortCutKey];
}

+ (void)setShortCut:(NSString *)shortCut
{
    [[NSUserDefaults standardUserDefaults] setObject:shortCut forKey:kShortCutKey];
}

+ (BOOL)use24Hour
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:kUse24HourKey];
}

+ (void)setUse24Hour:(BOOL)use24Hour
{
    [[NSUserDefaults standardUserDefaults] setBool:use24Hour forKey:kUse24HourKey];
}


+ (NSMutableArray *)clocks
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [defaults objectForKey:kClocksKey];
    NSMutableArray * clockConfigs = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return clockConfigs;
}

+ (NSInteger)currentProfile
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:kCurrentProfileKey];
}

+ (void)setCurrentProfile:(NSInteger)profile
{
    [[NSUserDefaults standardUserDefaults] setInteger:profile forKey:kCurrentProfileKey];
}

@end
