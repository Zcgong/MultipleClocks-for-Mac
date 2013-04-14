//
//  StatusItemView.h
//  MultipleClocks
//
//  Created by tonyzhou on 11/15/12.
//  Copyright (c) 2012 tonyzhou. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MCStatusItemView : NSView {
    NSImage *_normalImage;
    NSImage *_activeImage;
    NSStatusItem *_statusItem;
    BOOL _isActive;
    SEL _action;
    __unsafe_unretained id _target;
}

- (id)initWithStatusItem:(NSStatusItem *)statusItem;

@property (nonatomic, strong, readonly) NSStatusItem *statusItem;
@property (nonatomic, strong) NSImage *normalImage;
@property (nonatomic, strong) NSImage *activeImage;
@property (nonatomic, setter = setIsActive:) BOOL isActive;
@property (nonatomic) SEL action;
@property (nonatomic, unsafe_unretained) id target;
@property (nonatomic, readonly) NSRect globalRect;

@end
