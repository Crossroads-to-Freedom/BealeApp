//
//  AVCamPreviewView.m
//  EventBar
//
//  Created by Will Cobb on 7/29/14.
//  Copyright (c) 2014 Apprentice Media LLC. All rights reserved.
//

#import "AVCamPreviewView.h"
#import <AVFoundation/AVFoundation.h>

@implementation AVCamPreviewView

+ (Class)layerClass
{
	return [AVCaptureVideoPreviewLayer class];
}

- (AVCaptureSession *)session
{
	return [(AVCaptureVideoPreviewLayer *)[self layer] session];
}

- (void)setSession:(AVCaptureSession *)session
{
	[(AVCaptureVideoPreviewLayer *)[self layer] setSession:session];
}

- (void) drawRect:(CGRect)rect
{
    NSLog(@"Hi");
    CGContextRef context = UIGraphicsGetCurrentContext(); // ...before this
       
    CGFloat lineWidth = 5.f;
    CGPoint center = CGPointMake(50, 100);
    CGFloat radius = 150;
    CGFloat startAngle = - ((float)M_PI / 2);
    
    UIBezierPath *processPath = [UIBezierPath bezierPath];
    processPath.lineCapStyle = kCGLineCapRound;
    processPath.lineWidth = lineWidth;
    //endAngle = (self.progress * 2 * (float)M_PI) + startAngle;
    CGFloat endAngle = (0.2 * 2 * (float)M_PI) + startAngle;
    [processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    //[appearance.progressTintColor set];
    [processPath stroke];
    //CGContextRestoreGState(context); // after this...
    //UIGraphicsEndImageContext(); // ADD THIS
    
    //LProgressAppearance *appearance = self.progressAppearance;

    CGRect allRect = CGRectMake(0, 0, 300, 300);

    UIFont *font = [UIFont systemFontOfSize:16];
    NSString *text = @"HEllo";
    
    CGSize textSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(30000, 13)];

    float x = floorf(allRect.size.width / 2) + 3 + 5;
    float y = floorf(allRect.size.height / 2) - 6 + 5;
    
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    [text drawAtPoint:CGPointMake(x - textSize.width / 2.0, y) withFont:font];
}
@end
