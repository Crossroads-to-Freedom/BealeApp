//
//  BuildingInformationView.m
//  RhodesTourist
//
//  Created by Will Cobb on 1/27/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import "BuildingInformationView.h"

@implementation BuildingInformationView


-(id) initWithFrame:(CGRect)frame AndBuilding:(Building *) building
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    int buttonHeight = frame.size.width/3;
    int imageViewHeight = (frame.size.height - buttonHeight*2) * (3/5.0);
    int descriptionViewHeight = self.frame.size.height - buttonHeight*2 - imageViewHeight;
    
    NSLog(@"asljk %i", imageViewHeight);
    self.mainImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, imageViewHeight)];
    self.mainImage.image = [UIImage imageNamed:@"BG1.png"];
    [self addSubview:self.mainImage];
    
    self.descriptionView = [[UIView alloc] initWithFrame:CGRectMake(0, imageViewHeight, self.frame.size.width, descriptionViewHeight)];
    UILabel * descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.descriptionView.frame.size.width, self.descriptionView.frame.size.height)];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    [descriptionLabel sizeToFit];
    [self.descriptionView addSubview:descriptionLabel];
    [self addSubview:self.descriptionView];
    
    self.choicesView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - buttonHeight*2, self.frame.size.width, buttonHeight*2)];
    self.choicesView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.choicesView];
    
    
    for (int i = 0; i < 2; i++)
    {
        for (int j = 0; i <3; i++)
        {
            UIButton * tileButton = [[UIButton alloc] initWithFrame:CGRectMake(j * buttonHeight, i * buttonHeight, buttonHeight, buttonHeight)];
            
        }
    }
    
    
    return self;
}

@end
