//
//  BuildingInformationView.m
//  RhodesTourist
//
//  Created by Will Cobb on 1/27/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import "BuildingInformationViewController.h"
#define AC_RED  0.933//0.0468
#define AC_GREEN  0.2//0.6523
#define AC_BLUE  0.133//0.8672

@implementation BuildingInformationViewController


-(void) viewDidLoad
{
    
    
    float buttonHeight = self.view.frame.size.width/3.0;
    int imageViewHeight = (self.view.frame.size.height - buttonHeight*2) * (2/5.0);
    int descriptionViewHeight = self.view.frame.size.height - buttonHeight*2 - imageViewHeight;
    
    self.mainImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, imageViewHeight)];
    self.mainImage.image = [UIImage imageNamed:@"BG1.png"];
    [self.view addSubview:self.mainImage];
    
    self.descriptionView = [[UIView alloc] initWithFrame:CGRectMake(0, imageViewHeight, self.view.frame.size.width, descriptionViewHeight)];
    UILabel * descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, self.descriptionView.frame.size.width, self.descriptionView.frame.size.height)];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    [descriptionLabel sizeToFit];
    [self.descriptionView addSubview:descriptionLabel];
    [self.view addSubview:self.descriptionView];
    
    self.choicesView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - buttonHeight*2, self.view.frame.size.width, buttonHeight*2)];
    self.choicesView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.choicesView];
    
    
    for (int i = 0; i < 2; i++)
    {
        for (int j = 0; j <3; j++)
        {
            NSLog(@"%i %i", i, j);
            UIButton * tileButton = [[UIButton alloc] initWithFrame:CGRectMake(j * buttonHeight, i * buttonHeight, buttonHeight, buttonHeight)];
            //tileButton.backgroundColor = [UIColor blueColor];
            tileButton.layer.borderWidth = .5f;
            tileButton.layer.borderColor = [UIColor grayColor].CGColor; 
            int k = j + i * 3;
            if (k==0) {
                
            }
            //NSLog(@" %f %f %f %f", tileButton.frame.origin.x, tileButton.frame.origin.y, tileButton.frame.size.width, tileButton.frame.size.height);
            [self.choicesView addSubview:tileButton];
        }
    }
    
    
}





@end











