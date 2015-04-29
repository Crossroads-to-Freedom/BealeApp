//
//  TimeLineTableView.m
//  BealeApp
//
//  Created by Will Cobb on 3/8/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import "TimeLineTableView.h"

@implementation TimeLineTableView

-(id) initWithFrame:(CGRect)frame Assets:(NSArray*) assets
{
    self = [super initWithFrame:frame];
    
    self.delegate = self;
    self.dataSource = self;
    self.assets = assets;
    self.bounces = NO;
    self.backgroundColor = PURPLE;
    self.separatorColor = [UIColor clearColor];
    
    return self;
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimeLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell%ld", indexPath.row]];
    if (cell == nil) {
        NSLog(@"Cell");
        cell = [[TimeLineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell" Direction:indexPath.row%2];
        cell.frame = CGRectMake(0, 0, self.frame.size.width, 100);
        cell.backgroundColor = [UIColor colorWithRed:54/255.0 green:48/255.0 blue:64/255.0 alpha:1];
        cell.clipsToBounds = NO;
        [cell.contentView.superview setClipsToBounds:NO];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *colors = @[[UIColor colorWithRed:175/255.0 green:42/255.0  blue:109/255.0 alpha:1],
                            [UIColor colorWithRed:25/255.0  green:100/255.0 blue:106/255.0 alpha:1],
                            [UIColor colorWithRed:137/255.0 green:73/255.0  blue:174/255.0 alpha:1],
                            [UIColor colorWithRed:171/255.0 green:131/255.0 blue:31/255.0  alpha:1],
                            [UIColor colorWithRed:175/255.0 green:42/255.0  blue:109/255.0 alpha:1],
                            [UIColor colorWithRed:70/255.0  green:148/255.0 blue:41/255.0  alpha:1],
                            [UIColor colorWithRed:27/255.0  green:100/255.0 blue:108/255.0 alpha:1]
                            ];
        float xOffset = ((indexPath.row + 0) % 2) * self.frame.size.width/2;
        UIView * assetImageViewBg = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/4 - 200 + xOffset, -50, 100, 200)];
        assetImageViewBg.backgroundColor = colors[arc4random_uniform(colors.count)];
        UIImageView * assetImageView = [[UIImageView alloc] init];
        [cell addSubview:assetImageViewBg];
        [cell addSubview:assetImageView];
        Asset * asset = self.assets[indexPath.row];
        NSString * fullUrl = [NSString stringWithFormat:@"http://%@", asset.imageUrl];
        //NSLog(@"Loading %@", fullUrl);
        NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:fullUrl]];
        AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            assetImageView.image = (UIImage *)responseObject;
            float ratio1 = (self.frame.size.width/2 - 30) / assetImageView.image.size.width;
            float ratio2 = 270 / assetImageView.image.size.height;
            float ratio = ratio1 < ratio2 ? ratio1 : ratio2;
            
            float width = assetImageView.image.size.width * ratio;
            float height= assetImageView.image.size.height * ratio;
            
            assetImageView.frame = CGRectMake(self.frame.size.width/4 - width/2 + xOffset, 50 - height/2, assetImageView.image.size.width * ratio, assetImageView.image.size.height * ratio);
            assetImageViewBg.frame = CGRectMake(assetImageView.frame.origin.x - 5, assetImageView.frame.origin.y - 5, assetImageView.frame.size.width + 10, assetImageView.frame.size.height + 10);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Image error: %@", error);
        }];
        [requestOperation start];
        //[cell setSelectedBackgroundView:[[UIView alloc] init]];
        
    }
    
    return cell;
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
    return self.assets.count;
}

@end
