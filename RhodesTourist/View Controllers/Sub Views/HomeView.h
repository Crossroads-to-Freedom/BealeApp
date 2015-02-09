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
@property UIScrollView * verticalScrollView;
@property UIScrollView * featuredView;
@property UIPageControl* featuredViewControll;

@end

