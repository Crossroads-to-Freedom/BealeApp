//
//  HomeView.m
//  RhodesTourist
//
//  Created by Will Cobb on 1/27/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import "HomeView.h"

@implementation HomeView


-(id) initWithFrame:(CGRect)frame Delegate:(id) delegate Database:(SQLiteManager *) database
{
    self = [super initWithFrame:frame];
    self.delegate = delegate;
    self.database = database;
    
    
    self.backgroundColor = [UIColor colorWithRed:60.0/256 green:61.0/256 blue:66.0/256 alpha:1];
    
    self.verticalScrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.verticalScrollView.contentSize = CGSizeMake(frame.size.width, 1000);
    
    self.featuredView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 130)];
    self.featuredView.bounces = NO;
    self.featuredView.pagingEnabled = YES;
    self.featuredView.showsHorizontalScrollIndicator = NO;
    self.featuredView.delegate = self;
    
    //NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
    NSArray * featuredSiteIds = @[@1, @2];
    for (int i = 0; i < featuredSiteIds.count; i++) {
        CGRect frame;
        frame.origin.x = self.featuredView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.featuredView.frame.size;
 
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        //subview.backgroundColor = colors[i];
        UITapGestureRecognizer * oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedView:)];
        [subview addGestureRecognizer:oneTap];
        
        Building * building = [self.database buildingWithId:[featuredSiteIds[i] intValue]];
        NSLog(@"Namee: %@", building.name);
        UIImageView * banner = [building.banner assetImageViewWithSize:frame.size];
        banner.frame = frame;
        NSLog(@"Banner %@", banner);
        //NSLog(@"Banner %@", banner.frame);
        [subview addSubview:banner];
        
        [self.featuredView addSubview:subview];
        
    }
    
    self.featuredView.contentSize = CGSizeMake(self.featuredView.frame.size.width * featuredSiteIds.count, self.featuredView.frame.size.height);
    [self addSubview:self.featuredView];
    
    //self.featuredViewControll = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 163, frame.size.width, 37)];
    //self.featuredViewControll.numberOfPages=6;
    //self.featuredViewControll.userInteractionEnabled = NO;
    //[self addSubview:self.featuredViewControll];
    
    return self;
}



- (void)tappedView:(UITapGestureRecognizer *) tap
{
    //[self. presentBuildingInformationWithId:0];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.featuredView.frame.size.width;
    //int page = floor((self.featuredView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    //self.featuredViewControll.currentPage = page;
}



@end
