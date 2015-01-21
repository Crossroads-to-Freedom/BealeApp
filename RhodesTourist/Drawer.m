//
//  Drawer.m
//  BealeApp
//
//  Created by Will Cobb on 1/14/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import "Drawer.h"

@implementation Drawer

- (id)initWithMenuView:(UIView *) menu contentViews:(NSMutableArray *) views {
    if ((self = [super init])) {
        drawerIn = YES;
        menuView = menu;
        contentViews = views;
    }
    return self;
}

-(void) drawerInWithView:(NSUInteger) viewNumber
{
    drawerIn = YES;
    UIView * view = [contentViews objectAtIndex:viewNumber];
    [UIView animateWithDuration:0.2 animations:^{
        for (UIView * view in contentViews)
        {
            view.center = CGPointMake(view.frame.size.width/2, view.center.y);
        }
    }];
            
}

-(void) drawerOut
{
    drawerIn = NO;
    [UIView animateWithDuration:0.2 animations:^{
        
        for (UIView * view in contentViews)
        {
            view.center = CGPointMake(view.frame.size.width/2, view.center.y);
        }
    }];
            
}
     

- (void)drawerToggle
{
    drawerIn ? [self drawerOut] : [self drawerInWithView:0];
}

@end
