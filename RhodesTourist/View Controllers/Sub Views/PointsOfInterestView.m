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
    UIImageView * backgroungImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    NSString *thePath = [[NSBundle mainBundle] pathForResource:@"BG1" ofType:@"png"];
    backgroungImage.image = [[UIImage alloc] initWithContentsOfFile:thePath];
    [self addSubview:backgroungImage];
    
    points = [NSMutableArray array];
    for (int i=1; i<7; i++) {
        MovingUIView * pointView = [[MovingUIView alloc] initWithFrame:CGRectMake([self centerForBubbleNumber:i].x - 50, [self centerForBubbleNumber:i].y -50, 100, 120)];
        UIButton     * pointButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        pointButton.backgroundColor = [UIColor redColor];
        pointButton.tag = i;
        pointButton.layer.cornerRadius = pointButton.frame.size.height /2;
        pointButton.layer.masksToBounds = YES;
        pointButton.layer.borderWidth = 0;
        [pointView addSubview:pointButton];
        [self addSubview:pointView];
        [points addObject:pointView];
    }
}

- (void) movePoints
{
    
}

- (CGPoint) centerForBubbleNumber:(NSInteger) number
{
    int x = ((int)(number/4)) * 6 + 3; //3, 3, 3, 9, 9, 9
    int y = (number-1)%3 * 2 +1; //1, 3, 5, 1, 3, 5
    //NSLog(@"%i %i %i", number, x, y);
    return  CGPointMake(self.frame.size.width/12 * x, 30 + self.frame.size.height/7 * y);
}

@end