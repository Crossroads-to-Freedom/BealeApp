//
//  CircleLabel.h
//  BealeApp
//
//  Created by Will Cobb on 3/2/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleLabel : UILabel {
    UILabel * _label;
}

@property CGFloat   radius;
@property UIColor * color;

- (id)initWithFrame:(CGRect)frame radius:(CGFloat)aRadius color:(UIColor*) aColor;

@end
