//
//  MCClockItem.h
//  MultipleClocks
//
//  Created by tonyzhou on 11/21/12.
//  Copyright (c) 2012 tonyzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCClockItem : NSObject

@property (nonatomic, strong, readwrite) NSString *clockName;
@property (nonatomic, strong, readwrite) NSTimeZone *timeZone;
@property (nonatomic, strong, readwrite) NSCalendar *calendar;

@end
