//
//  SocialMediaTableView.m
//  BealeApp
//
//  Created by Will Cobb on 2/27/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//
//  https://dev.twitter.com/rest/public/search-by-place
//

#import "SocialMediaTableView.h"

@implementation SocialMediaTableView

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
