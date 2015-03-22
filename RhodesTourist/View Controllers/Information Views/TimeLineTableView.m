//
//  TimeLineTableView.m
//  BealeApp
//
//  Created by Will Cobb on 3/8/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import "TimeLineTableView.h"

@implementation TimeLineTableView

-(id) initWithFrame:(CGRect)frame Assets:(NSMutableArray*) assets;
{
    self = [super initWithFrame:frame];
    
    
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
    
    return cell;
}


- (void) scrollViewWillEndDragging:(UIScrollView *)scroll withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
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
    //[self.viewControllerDelegate presentBuildingInformationWithId:0];
    
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
