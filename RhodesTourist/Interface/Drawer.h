//
//  Drawer.h
//  BealeApp
//
//  Created by Will Cobb on 1/14/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//
//  Not Yet Implemented
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Drawer : NSObject {
    UIView         * menuView;
    
    NSMutableArray * contentViews;
    
    BOOL drawerIn;
    
    NSInteger topViewNumber;
    
    //Constants
}
@property NSArray * extraViewsToMove;

- (id)initWithMenuView:(UIView *) menu contentViews:(NSArray *) views;
- (void)drawerInWithView:(NSUInteger) viewNumber;
- (void)drawerOut;
- (void)drawerToggle;
@end
