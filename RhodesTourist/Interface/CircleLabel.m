//
//  CircleLabel.m
//  BealeApp
//
//  Created by Will Cobb on 3/2/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import "CircleLabel.h"

@implementation CircleLabel

- (id)initWithFrame:(CGRect)frame radius:(CGFloat)aRadius color:(UIColor*) aColor {
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        
        [self setRadius:aRadius];
        [self setColor:aColor];
        
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:18];
        _label.textColor = [UIColor whiteColor];
        _label.text = @"1";
        [_label sizeToFit];
        [self addSubview:_label];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize mySize = self.bounds.size;
    _label.center = CGPointMake(mySize.width * 0.5f, mySize.height * 0.5f);
}

- (void)drawRect:(CGRect)rect {
    [self.color setFill];
    CGSize mySize = self.bounds.size;
    CGFloat radius = self.radius;
    [[UIBezierPath bezierPathWithOvalInRect:CGRectMake(mySize.width * 0.5f, mySize.height * 0.5f, self.radius, self.radius)] fill];
}

@end
