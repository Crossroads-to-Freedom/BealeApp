//
//  MovingUIView.m
//  RhodesTourist
//
//  Created by Will Cobb on 1/24/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//



#import "MovingUIView.h"

@implementation MovingUIView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.originalPosition = self.center;
        [self move];
    }
    return self;
}

- (void) move
{
    self.movingTo = CGPointMake(self.originalPosition.x + 7 - arc4random_uniform(15), self.originalPosition.y + 7 - arc4random_uniform(15));
    [UIView animateWithDuration:arc4random_uniform(3) + 7 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.center = self.movingTo;
    }completion:^(BOOL finished) {
        [self move];
    }];
    
    
}

@end
