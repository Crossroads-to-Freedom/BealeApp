//
//  PointsOfInterestViewController.m
//  RhodesTourist
//
//  Created by Will Cobb on 1/23/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import "PointsOfInterestView.h"

@implementation PointsOfInterestView

-(id) initWithFrame:(CGRect)frame
{
    return [super initWithFrame:frame];
}

-(void) willMoveToSuperview:(UIView *)newSuperview
{
    
    for (int i = 3; i < 12; i+=6) {
        for (int j = 1; j < 4; j++) {
            int x;
            if (i==1) x=3;
            else      x=9;
            UIButton * pointButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/12 * i - 50, self.frame.size.height/4 * j -50, 100, 100)];
            pointButton.backgroundColor = [UIColor redColor];
            pointButton.tag = 3 * i + j;
            pointButton.layer.cornerRadius = pointButton.frame.size.height /2;
            pointButton.layer.masksToBounds = YES;
            pointButton.layer.borderWidth = 0;
            [self addSubview:pointButton];
        }
    }
}

@end
