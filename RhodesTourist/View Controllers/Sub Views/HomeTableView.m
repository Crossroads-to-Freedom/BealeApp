//
//  HomeTableView.m
//  BealeApp
//
//  Created by Will Cobb on 2/24/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import "HomeTableView.h"
@implementation HomeTableView


-(id) initWithFrame:(CGRect)frame Delegate:(id) delegate Database:(SQLiteManager *) database;
{
    self = [super initWithFrame:frame];
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:self.frame];
    backgroundView.image = [UIImage imageNamed:@"CreamBG.png"];
    self.backgroundView=backgroundView;
    self.backgroundColor = [UIColor clearColor];
    self.viewControllerDelegate = delegate;
    self.database = database;
    
    self.dataSource = self;
    self.delegate = self;
    
    
    self.featuredView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 130)];
    self.featuredView.backgroundColor = [UIColor blueColor];
    self.featuredView.bounces = NO;
    self.featuredView.pagingEnabled = YES;
    self.featuredView.showsHorizontalScrollIndicator = NO;
    self.featuredView.delegate = self;
    
    //NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
    NSArray * featuredSiteIds = @[@1, @2, @4, @6, @1, @2]; //first 2 == last 2
    for (int i = 0; i < featuredSiteIds.count; i++) {
        CGRect frame;
        frame.origin.x = self.featuredView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.featuredView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        subview.tag = [featuredSiteIds[i] integerValue]; //Building Id
        //subview.backgroundColor = colors[i];
        UITapGestureRecognizer * oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedView:)];
        [subview addGestureRecognizer:oneTap];
        
        Building * building = [self.database buildingWithId:[featuredSiteIds[i] intValue]];
        NSLog(@"Namee: %@", building.name);
        UIImageView * banner = [building.banner assetImageViewWithSize:frame.size];
        banner.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        NSLog(@"Banner %@", banner);
        //NSLog(@"Banner %@", banner.frame);
        [subview addSubview:banner];
        
        [self.featuredView addSubview:subview];
        
    }
    
    self.featuredView.contentSize = CGSizeMake(self.featuredView.frame.size.width * featuredSiteIds.count, self.featuredView.frame.size.height);
    self.featuredView.contentOffset = CGPointMake(self.featuredView.frame.size.width, 0);
    
    self.tableHeaderView = self.featuredView;
    
    
    return self;
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.frame = CGRectMake(0, 0, self.frame.size.width, 180);
        
        [cell setSelectedBackgroundView:[[UIView alloc] init]];
        
    }
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width, 30)];
    title.font = [UIFont boldSystemFontOfSize:16];
    [cell addSubview:title];
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [UIView new];
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, 150, 150)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.bounces = NO;
    //scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.clipsToBounds = NO;
    scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    scrollView.delegate = self;
    [cell addSubview:scrollView];
    
    NSArray * siteIds;
    
    if (indexPath.row == 0) {
        title.text = @"Near Me";
        siteIds = @[@1, @2, @1, @4, @6, @4, @1, @2, @1, @2];
    } else if (indexPath.row == 1) {
        title.text = @"Recent";
        [cell addSubview:title];
    } else if (indexPath.row == 2) {
        title.text = @"Favorites";
        [cell addSubview:title];
    } else if (indexPath.row == 3) {
        title.text = @"3";
        [cell addSubview:title];
    } else if (indexPath.row == 4) {
        title.text = @"4";
        [cell addSubview:title];
    }
    else if (indexPath.row == 4) {
        title.text = @"5";
        [cell addSubview:title];
    }
    
    for (int i = 0; i < siteIds.count; i++) {
        CGRect frame;
        frame.origin.x = scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = scrollView.frame.size;
        
        Building * building = [self.database buildingWithId:[siteIds[i] intValue]];
        UIImageView * banner = [building.banner assetImageViewWithSize:frame.size];
        banner.layer.cornerRadius = 10;
        banner.clipsToBounds = YES;
        banner.tag = [siteIds[i] integerValue]; //Building Id
        banner.frame = CGRectMake(5 + frame.origin.x, 0, frame.size.width-10, frame.size.height);
        banner.backgroundColor = [UIColor greenColor];
        UITapGestureRecognizer * oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedView:)];
        [banner addGestureRecognizer:oneTap];
        [scrollView addSubview:banner];
        
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * siteIds.count, scrollView.frame.size.height);
    scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
    ClipView *subview = [[ClipView alloc] initWithFrame:cell.frame];
    subview.backgroundColor = [UIColor clearColor];
    subview.clipsToBounds = NO;
    subview.scrollView= scrollView;
    [subview addSubview:scrollView];
    [cell addSubview:subview];
    
    return cell;
}
- (void) scrollViewDidScroll:(UIScrollView *)scroll
{
    if ([scroll isEqual:self.featuredView])
    {
        if (scroll.contentOffset.x == scroll.contentSize.width - scroll.frame.size.width)
        {
            scroll.contentOffset = CGPointMake(scroll.frame.size.width, scroll.contentOffset.y);
        }
        else if (scroll.contentOffset.x == 0)
        {
            scroll.contentOffset = CGPointMake(scroll.contentSize.width - scroll.frame.size.width * 2, scroll.contentOffset.y);
            //NSLog(@"Offset: %lu", (unsigned long)(scroll.contentOffset.x / scroll.bounds.size.width + 0.5f));
        }
    }
    else if (![scroll isEqual:self])
    {
        if (scroll.contentOffset.x >= scroll.contentSize.width - scroll.frame.size.width * 3)
        {
            scroll.contentOffset = CGPointMake(scroll.frame.size.width, scroll.contentOffset.y);
        }
        else if (scroll.contentOffset.x == 0)
        {
            scroll.contentOffset = CGPointMake(scroll.contentSize.width - scroll.frame.size.width * 4, scroll.contentOffset.y);
            //NSLog(@"Offset: %lu", (unsigned long)(scroll.contentOffset.x / scroll.bounds.size.width + 0.5f));
        }
    }
}

- (void) scrollViewWillEndDragging:(UIScrollView *)scroll withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if ([scroll isEqual:self.featuredView])
    {
        
    }
    else
    {
        //This is the index of the "page" that we will be landing at
        NSUInteger nearestIndex = (NSUInteger)(targetContentOffset->x / scroll.bounds.size.width + 0.5f);
        nearestIndex = MAX( MIN( nearestIndex, scroll.contentSize.width/scroll.frame.size.width ), 0 ); //yourPagesArray.count - 1 ~ 5
        
        //This is the actual x position in the scroll view
        CGFloat xOffset = nearestIndex * scroll.bounds.size.width;
        
        //Prevent Stick
        xOffset = xOffset==0?1:xOffset; //Sets it to 1 if 0
        
        *targetContentOffset = CGPointMake(xOffset, targetContentOffset->y);
    }
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if( !decelerate )
    {
        NSUInteger currentIndex = (NSUInteger)(scrollView.contentOffset.x / scrollView.bounds.size.width);
        
        [scrollView setContentOffset:CGPointMake(scrollView.bounds.size.width * currentIndex, 0) animated:YES];
    }
}

- (void)tappedView:(UITapGestureRecognizer *) tap
{
    [self.viewControllerDelegate presentBuildingInformationWithId:0];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self.drawerController drawerInWithView:indexPath.row];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}




@end

