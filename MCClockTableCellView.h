//
//  MCClockTableCellView.h
//  MultipleClocks
//
//  Created by tonyzhou on 11/21/12.
//  Copyright (c) 2012 tonyzhou. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MCAnalogClock.h"

@interface MCClockTableCellView : NSTableCellView

@property (nonatomic) MCStaticAnalogClock *clockView;
@property (nonatomic, weak)IBOutlet NSView *clockContainer;
@property (nonatomic, weak)IBOutlet NSTextField *clockNameField;
@property (nonatomic, weak)IBOutlet NSTextField *clockDateField;
@property (nonatomic, weak)IBOutlet NSTextField *clockTimeField;

@end
