//
//  GridView.m
//  BealeApp
//
//  Created by Will Cobb on 2/12/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import "GridView.h"

@implementation GridView

/*- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.sideLength = frame.size.width/3;
    self.numberOfRows = ([images count] + 2)/3;
    
    for (int i=0; i < [images count]; i++)
    {
        int j = i % 3;
        int k = i / 3;
        UIButton * tileButton = [[UIButton alloc] initWithFrame:CGRectMake(j * self.sideLength, k * self.sideLength, self.sideLength, self.sideLength)];
        tileButton.tag = i;
        tileButton.layer.borderWidth = .5f;
        tileButton.layer.borderColor = [UIColor grayColor].CGColor;
        [self addSubview:tileButton];
    }
    
    return self;
}*/


- (id) initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    self.dataSource = self;
    self.delegate = self;
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.separatorColor = [UIColor clearColor];
    
    sideLength = frame.size.width/3;
    
    return self;
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"Cell%ld", (long)indexPath.row]];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"Cell%ld", (long)indexPath.row]];
        if (indexPath.row == 0) {
            for (int i=0; i < 3; i++)
            {
                UIButton * tileButton = [[UIButton alloc] initWithFrame:CGRectMake(i * sideLength, 0, sideLength, sideLength)];
                tileButton.tag = i;
                tileButton.layer.borderWidth = .5f;
                tileButton.layer.borderColor = [UIColor grayColor].CGColor;
                [cell addSubview:tileButton];
            }
            for (int i=3; i < 6; i++)
            {
                UIButton * tileButton = [[UIButton alloc] initWithFrame:CGRectMake(i * sideLength, 0, sideLength, sideLength)];
                tileButton.tag = i;
                tileButton.layer.borderWidth = .5f;
                tileButton.layer.borderColor = [UIColor grayColor].CGColor;
                [cell addSubview:tileButton];
            }
        } else if (indexPath.row == 1) {
            for (int i=0; i < 3; i++)
            {
                UIButton * tileButton = [[UIButton alloc] initWithFrame:CGRectMake(i * sideLength, 0, sideLength, sideLength)];
                tileButton.tag = i;
                tileButton.layer.borderWidth = .5f;
                tileButton.layer.borderColor = [UIColor grayColor].CGColor;
                [cell addSubview:tileButton];
            }
            for (int i=3; i < 6; i++)
            {
                UIButton * tileButton = [[UIButton alloc] initWithFrame:CGRectMake(i * sideLength, 0, sideLength, sideLength)];
                tileButton.tag = i;
                tileButton.layer.borderWidth = .5f;
                tileButton.layer.borderColor = [UIColor grayColor].CGColor;
                [cell addSubview:tileButton];
            }
        } else {
            for (int i=0; i < 3; i++)
            {
                UIButton * tileButton = [[UIButton alloc] initWithFrame:CGRectMake(i * sideLength, 0, sideLength, sideLength)];
                tileButton.tag = i;
                tileButton.layer.borderWidth = .5f;
                tileButton.layer.borderColor = [UIColor grayColor].CGColor;
                [cell addSubview:tileButton];
            }
        }
        
    }
    
    return cell;
}



- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

@end
