//
//  Drawer.m
//  BealeApp
//
//  Created by Will Cobb on 1/14/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import "Drawer.h"

@implementation Drawer

- (id)initWithMenuView:(UIView *) menu contentViews:(NSArray *) views {
    if ((self = [super init])) {
        drawerIn = YES;
        menuView = menu;
        contentViews = views;
        topViewNumber = 0;
    }
    return self;
}

- (void)drawerInWithView:(NSUInteger) viewNumber
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DrawerIn" object:nil userInfo:@{@"view" : [contentViews objectAtIndex:viewNumber]}];
    topViewNumber = viewNumber;
    drawerIn = YES;
    UIView * topView = [contentViews objectAtIndex:viewNumber];
    [[topView superview] bringSubviewToFront:topView];
    [UIView animateWithDuration:0.2 animations:^{
        for (UIView * view in contentViews) {
            view.center = CGPointMake(view.frame.size.width/2, view.center.y);
            if (view != topView)
                view.alpha = 0;
            else
                view.alpha = 1;
        }
        
        if (self.extraViewsToMove) {
            for (UIView * view in self.extraViewsToMove) {
                view.center = CGPointMake(view.frame.size.width/2, view.center.y);
            }
        }
    }];
    
            
}

- (void)drawerOut
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DrawerOut" object:nil];
    drawerIn = NO;
    [UIView animateWithDuration:0.2 animations:^{
        
        for (UIView * view in contentViews) {
            view.center = CGPointMake(view.frame.size.width/2 + 100, view.center.y);
        }
        if (self.extraViewsToMove) {
            for (UIView * view in self.extraViewsToMove) {
                view.center = CGPointMake(view.frame.size.width/2 + 100, view.center.y);
            }
        }
    }];
            
}
     

- (void)drawerToggle
{
    if (drawerIn)
        [self drawerOut];
    else {
        drawerIn = YES;
        [UIView animateWithDuration:0.2 animations:^{
            for (UIView * view in contentViews) {
                view.center = CGPointMake(view.frame.size.width/2, view.center.y);
            }
            
            if (self.extraViewsToMove) {
                for (UIView * view in self.extraViewsToMove) {
                    view.center = CGPointMake(view.frame.size.width/2, view.center.y);
                }
            }
        }];
    }
}

@end
