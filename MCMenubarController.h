//
//  MCMenubarController.h
//  MultipleClocks
//
//  Created by tonyzhou on 11/15/12.
//  Copyright (c) 2012 tonyzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MCStatusItemView;

@interface MCMenubarController : NSObject

@property (nonatomic) BOOL isItemActive;
@property (nonatomic, strong, readonly) MCStatusItemView *statusItemView;
@property (nonatomic, strong, readonly) NSStatusItem *statusItem;

@end
