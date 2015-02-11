//
//  GridView.m
//  RhodesTourist
//
//  Created by Will Cobb on 2/9/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import "GridView.h"

@implementation GridView

- (instancetype)initWithFrame:(CGRect)frame Images:(NSArray *) images {
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
}

@end
