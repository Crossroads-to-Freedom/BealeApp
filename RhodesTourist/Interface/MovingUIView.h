//
//  MovingUIView.h
//  RhodesTourist
//
//  Created by Will Cobb on 1/24/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovingUIView : UIView


@property CGPoint originalPosition;
@property CGPoint movingTo;
@property BOOL    isMoving;
@end
