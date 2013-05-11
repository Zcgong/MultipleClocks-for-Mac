//
//  MCPreference.h
//  MultipleClocks
//
//  Created by tonyzhou on 5/10/13.
//  Copyright (c) 2013 tonyzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark UserDefaultKeys

extern NSString * const kLaunchAtLoginKey;
extern NSString * const kShortCutKey;
extern NSString * const kUse24HourKey;
extern NSString * const kClocksKey;
extern NSString * const kCurrentProfileKey;

@interface MCClockConfigItem : NSObject<NSCoding>

@property (nonatomic,strong) NSString * clockName;
@property (nonatomic,strong) NSString * clockTimezoneName;

- (id)initWithClockName:(NSString *)clockName Timezone:(NSString *)timeZone;
- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

@end

@interface MCPreference : NSObject

+ (void)initialize;

+ (BOOL)launchAtLogon;
+ (void)setLaunchAtLogon:(BOOL)launchAtLogon;
+ (NSString *) shortCut;
+ (void)setShortCut:(NSString *)shortCut;
+ (BOOL)use24Hour;
+ (void)setUse24Hour:(BOOL)use24Hour;
+ (NSMutableArray *)clocks;
//+ (void)setClocks:(NSString *)clocks;
+ (NSInteger)currentProfile;
+ (void)setCurrentProfile:(NSInteger)profile;

@end
