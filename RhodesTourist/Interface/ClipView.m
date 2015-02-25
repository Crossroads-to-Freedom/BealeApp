//
//  ClipView.m
//  BealeApp
//
//  Created by Will Cobb on 2/24/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import "ClipView.h"

@implementation ClipView

-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    UIView* child = nil;
    if ((child = [super hitTest:point withEvent:event]) == self)
        return self.scrollView;
    return child;
}

@end
