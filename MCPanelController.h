//
//  MCPanelController.h
//  MultipleClocks
//
//  Created by tonyzhou on 11/15/12.
//  Copyright (c) 2012 tonyzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCStatusItemView.h"
#import "MCBackgroundView.h"

@class MCPanelController;

@protocol PanelControllerDelegate <NSObject>
- (MCStatusItemView *)statusItemViewForPanelController:(MCPanelController *)controller;
- (void)openPreferencePanel:(MCPanelController *)controller;
@end

@interface MCPanelController : NSWindowController<NSWindowDelegate, NSTableViewDelegate, NSTableViewDataSource>
{
    NSMutableArray *_clockList;
    NSTimer *_timer;
    
    BOOL _isActive;
}

@property (nonatomic) BOOL isActive;
@property (nonatomic, weak, readonly) id<PanelControllerDelegate> delegate;
@property (nonatomic, weak) IBOutlet MCBackgroundView *backgroundView;
@property (nonatomic, weak) IBOutlet NSTableView *clockTable;
@property (nonatomic, weak) IBOutlet NSScrollView *tableContainer;


- (id)initWithDelegate:(id<PanelControllerDelegate>)d;
- (void)openPanel;
- (void)closePanel;
- (IBAction)EditPreference:(id)sender;
- (void)startClock;
- (void)stopClock;

@end
