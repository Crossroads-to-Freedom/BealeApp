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
    //self.backgroundColor = [UIColor colorWithRed:60.0/256 green:61.0/256 blue:66.0/256 alpha:1];
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
    NSArray * featuredSiteIds = @[@2, @2];
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
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, 150, 150)];
    //scrollView.backgroundColor = [UIColor blueColor];
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.clipsToBounds = NO;
    [cell addSubview:scrollView];
    if (indexPath.row == 0) {
        title.text = @"Near Me";
        
        
        NSArray * featuredSiteIds = @[@1, @2, @2, @2];
        for (int i = 0; i < featuredSiteIds.count; i++) {
            CGRect frame;
            frame.origin.x = scrollView.frame.size.width * i;
            frame.origin.y = 0;
            frame.size = scrollView.frame.size;
            
            Building * building = [self.database buildingWithId:[featuredSiteIds[i] intValue]];
            UIImageView * banner = [building.banner assetImageViewWithSize:frame.size];
            banner.tag = [featuredSiteIds[i] integerValue]; //Building Id
            banner.frame = CGRectMake(5 + frame.origin.x, 0, frame.size.width-10, frame.size.height);
            banner.backgroundColor = [UIColor greenColor];
            UITapGestureRecognizer * oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedView:)];
            [banner addGestureRecognizer:oneTap];
            [scrollView addSubview:banner];
            
        }
        
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * featuredSiteIds.count, scrollView.frame.size.height);
        ClipView *subview = [[ClipView alloc] initWithFrame:cell.frame];
        subview.clipsToBounds = NO;
        subview.scrollView= scrollView;
        [subview addSubview:scrollView];
        [cell addSubview:subview];
        
    } else if (indexPath.row == 1) {
        title.text = @"Recent";
        [cell addSubview:title];
    } else if (indexPath.row == 2) {
        title.text = @"Favorites";
        [cell addSubview:title];
    }
    return cell;
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


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /*CGRect rect = self.tableHeaderView.frame;
    rect.origin.y = MAX(0, self.contentOffset.y);
    self.tableHeaderView.frame = rect;
    NSLog(@"%f", self.tableHeaderView.frame.origin.y);*/
}

@end

