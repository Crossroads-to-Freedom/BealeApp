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
    backgroungImage.image = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"BG1" ofType:@"png"]];
    [self addSubview:backgroungImage];
    
    points = [NSMutableArray array];
    for (int i=1; i<7; i++) {
        MovingUIView * pointView = [[MovingUIView alloc] initWithFrame:CGRectMake([self centerForBubbleNumber:i].x - 50, [self centerForBubbleNumber:i].y -50, 100, 100)];
        pointView.backgroundColor = [UIColor redColor];
        pointView.autoresizesSubviews = YES;
        pointView.layer.cornerRadius = 50;
        pointView.tag = i;
        pointView.layer.shadowRadius = 5;
        pointView.layer.shadowOpacity = 0.9;
        pointView.layer.shadowOffset = CGSizeMake(0, 0);
        pointView.layer.borderWidth = 0;
        
        UIButton     * pointButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        pointButton.layer.cornerRadius = 50;
        pointButton.layer.masksToBounds = YES;
        pointButton.tag = 101;
        [pointButton addTarget:nil action:@selector(selectedPoint:  ) forControlEvents:UIControlEventTouchUpInside];
        [pointView addSubview:pointButton];
        [self addSubview:pointView];
        [points addObject:pointView];
        
        UILabel     * POILable = [[UILabel alloc] initWithFrame:CGRectMake(-50, 93, 200, 29)];
        POILable.textAlignment = NSTextAlignmentCenter;
        POILable.font = [UIFont boldSystemFontOfSize:15];
        POILable.textColor = [UIColor whiteColor];
        POILable.layer.shadowRadius = 5;
        POILable.layer.shadowOpacity = 0.9;
        POILable.layer.shadowOffset = CGSizeMake(0, 0);
        POILable.tag = 100;
        [pointView addSubview:POILable];
        
        if (i==1) {
            [pointButton setImage:[UIImage imageNamed:[[NSBundle mainBundle] pathForResource:@"Withers Gallery" ofType:@"png"]] forState:UIControlStateNormal];
            POILable.text = @"Withers Gallery";
        } else if (i==2) {
            
        }
        
    }
}

- (void) returnPoint:(MovingUIView *)point
{
    UIButton * button = [point viewWithTag:101];
    point.frame = CGRectMake([self centerForBubbleNumber:point.tag].x - 50, [self centerForBubbleNumber:point.tag].y -50, 100, 100);
    point.layer.cornerRadius = 50;
    
    button.layer.cornerRadius = 50;
    button.frame = CGRectMake(0, 0, 100, 100);
    
    [point viewWithTag:100].alpha = 1;
    point.isMoving = YES;
    [self addSubview:point];
}

- (void) selectedPoint:(UIButton *)sender
{
    [self.delegate animateInterestViewToAssetView:sender];
}

- (CGPoint) centerForBubbleNumber:(NSInteger) number
{
    int x = ((int)(number/4)) * 6 + 3; //3, 3, 3, 9, 9, 9
    int y = (number-1)%3 * 2 +1; //1, 3, 5, 1, 3, 5
    //NSLog(@"%i %i %i", number, x, y);
    return  CGPointMake(self.frame.size.width/12 * x, 30 + self.frame.size.height/7 * y);
}

@end