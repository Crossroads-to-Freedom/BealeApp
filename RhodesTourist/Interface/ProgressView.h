//
//  ProgressView.h
//  CrossRoads
//
//  Created by Will Cobb on 10/7/14.
//  Copyright (c) 2014 Apprentice Media LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

@property CGPoint circleCenter;
@property CGFloat progress;
@property CGFloat progressStartTime;
@property BOOL    ticking;
@property id      delegate;
- (id) initAtLocation:(CGPoint)location Progress:(CGFloat)progress Delegate:(id) delegate;
- (void) beginProgress;
- (void) stopProgress;
- (void) progressDone;
@end
