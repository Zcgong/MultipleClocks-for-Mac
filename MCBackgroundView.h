//
//  BackgroundView.h
//  MultipleClocks
//
//  Created by tonyzhou on 11/15/12.
//  Copyright (c) 2012 tonyzhou. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define ARROW_WIDTH 12
#define ARROW_HEIGHT 8

@interface MCBackgroundView : NSView
{
    NSInteger _arrowX;
}

@property (nonatomic,assign, setter = setArrowX:) NSInteger arrowX;

@end
