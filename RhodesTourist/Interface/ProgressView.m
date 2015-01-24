//
//  ProgressView.m
//  CrossRoads
//
//  Created by Will Cobb on 10/7/14.
//  Copyright (c) 2014 Apprentice Media LLC. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initAtLocation:(CGPoint)location Progress:(CGFloat)progress Delegate:(id) delegate
{
    self = [super initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor clearColor];
    if ((self = [super init])) {
        self.delegate = delegate;
        self.circleCenter = location;
        self.progress = progress;
        
    }
    return self;
}
- (void) beginProgress
{
    self.progressStartTime = CACurrentMediaTime();
    self.ticking = YES;
    [self setNeedsDisplay];
}

- (void) stopProgress
{
    self.progress = 0;
    self.ticking = NO;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIBezierPath *processPath;
    if (self.ticking) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [[UIColor colorWithRed:12.0/256 green:167.0/256 blue:222.0/256 alpha:1] setStroke];
        CGFloat lineWidth = 12.f;
        CGFloat radius = (self.bounds.size.width - lineWidth)/2;
        CGFloat startAngle = - ((float)M_PI / 2);
        CGFloat endAngle = (2 * (float)M_PI) + startAngle;
        self.progress = (CACurrentMediaTime() - self.progressStartTime)*sin(CACurrentMediaTime() - self.progressStartTime + 0.0) * 8;

        processPath = [UIBezierPath bezierPath];
        processPath.lineCapStyle = kCGLineCapRound;
        processPath.lineWidth = lineWidth;
        endAngle = (self.progress * 2 * (float)M_PI) + startAngle;
        [processPath addArcWithCenter:CGPointMake(50, 50) radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        [processPath stroke];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setNeedsDisplay];  
        });
    }
    if (self.progress > 1.7) {
        NSLog(@"Done");
        self.ticking = NO;
        self.progress = 0;
        self.progressStartTime = CACurrentMediaTime()+1;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setNeedsDisplay];  
        });
        [processPath removeAllPoints];
        [processPath stroke];
        [self.delegate progressDone];
    }
}


@end
