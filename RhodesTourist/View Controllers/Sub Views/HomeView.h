//
//  HomeView.h
//  RhodesTourist
//
//  Created by Will Cobb on 1/27/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeView : UIView <UIScrollViewDelegate, UIPageViewControllerDelegate> {

}
@property id             delegate;
@property UIScrollView * verticalScrollView;
@property UIScrollView * featuredView;
@property UIPageControl* featuredViewControll;

- (id)initWithFrame:(CGRect)frame Delegate:(id) delegate;
- (void)presentBuildingInformationWithId:(NSInteger) buildingId;
@end

