//
//  PointsOfInterestViewController.h
//  RhodesTourist
//
//  Created by Will Cobb on 1/23/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovingUIView.h"
//#import "ViewController.h"
@protocol POIDelegate;
@interface PointsOfInterestView : UIView {

    NSMutableArray * points;
    
}

@property id delegate;

-(void) returnPoint:(MovingUIView *) point;

@end
@protocol POIDelegate <NSObject>

@optional

-(void) animateInterestViewToAssetView:(UIButton *) sender;

@end