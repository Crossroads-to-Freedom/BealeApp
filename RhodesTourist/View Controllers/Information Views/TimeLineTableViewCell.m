//
//  TimeLineTableViewCell.m
//  BealeApp
//
//  Created by Will Cobb on 3/8/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import "TimeLineTableViewCell.h"

@implementation TimeLineTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Direction:(int) d
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    direction = d;
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //Link
    NSArray *colors = @[[UIColor colorWithRed:175/255.0 green:42/255.0  blue:109/255.0 alpha:1],
                        [UIColor colorWithRed:25/255.0  green:100/255.0 blue:106/255.0 alpha:1],
                        [UIColor colorWithRed:137/255.0 green:73/255.0  blue:174/255.0 alpha:1],
                        [UIColor colorWithRed:171/255.0 green:131/255.0 blue:31/255.0  alpha:1],
                        [UIColor colorWithRed:175/255.0 green:42/255.0  blue:109/255.0 alpha:1],
                        [UIColor colorWithRed:70/255.0  green:148/255.0 blue:41/255.0  alpha:1],
                        [UIColor colorWithRed:27/255.0  green:100/255.0 blue:108/255.0 alpha:1]
                        ];
    NSUInteger random = arc4random_uniform((u_int32_t)colors.count);
    [colors[random] setStroke];
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    CGPoint start = CGPointMake(self.frame.size.width/2, self.frame.size.height - 8);
    CGPoint middle;
    CGPoint end;
    if (direction == 1) {
        middle = CGPointMake(self.frame.size.width/4, self.frame.size.height/2 + 100 - arc4random_uniform(200));
        end = CGPointMake(self.frame.size.width/6, self.frame.size.height/2);
    } else {
        middle = CGPointMake((self.frame.size.width/4) * 3, self.frame.size.height/2 + 100 - arc4random_uniform(200));
        end = CGPointMake((self.frame.size.width/6) * 5, self.frame.size.height/2);
    }
    [aPath moveToPoint:start];
    [aPath addCurveToPoint:end controlPoint1:start controlPoint2:middle]; //Cubic
    //[aPath addQuadCurveToPoint:end  controlPoint:middle];
    aPath.lineWidth = 8;
    //[aPath fill];
    [aPath stroke];
    //Line
    [colors[0] setStroke];
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    [bPath moveToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height)];
    [bPath addLineToPoint:CGPointMake(self.frame.size.width/2, 0)];
    bPath.lineWidth = 8;
    [bPath stroke];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
