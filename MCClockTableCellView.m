//
//  MCClockTableCellView.m
//  MultipleClocks
//
//  Created by tonyzhou on 11/21/12.
//  Copyright (c) 2012 tonyzhou. All rights reserved.
//

#import "MCClockTableCellView.h"

@implementation MCClockTableCellView

@synthesize clockView = _clockView;
@synthesize clockContainer = _clockContainer;
@synthesize clockNameField = _clockNameField;
@synthesize clockTimeField = _clockTimeField;
@synthesize clockDateField = _clockDateField;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

@end
