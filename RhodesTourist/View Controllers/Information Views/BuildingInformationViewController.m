//
//  BuildingInformationView.m
//  RhodesTourist
//
//  Created by Will Cobb on 1/27/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
// 37.4304

#import "BuildingInformationViewController.h"
#define AC_RED  0.933//0.0468
#define AC_GREEN  0.2//0.6523
#define AC_BLUE  0.133//0.8672

@implementation BuildingInformationViewController {
    CGFloat firstAngle;
    UIImageView * wheelImage;
    CGFloat wheelRotation;
}

-(void) viewDidLoad
{
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = self.buildingData.name;
    self.view.clipsToBounds = YES;
    UIPanGestureRecognizer * wheelDrag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:wheelDrag];
    
    wheelImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Wheel.png"]];
    wheelImage.frame = CGRectMake(-11, 69, 342, 342);
    wheelRotation = 0;
    [self.view addSubview:wheelImage];
    
    UIImage * dialImage = [UIImage imageNamed:@"DialBG.png"];
    //UIImageView * backgroundView =[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4 - backgroundView.image.size.width/4, 20, backgroundView.image.size.width/2, backgroundView.image.size.height/2)];
    UIImageView * backgroundView =[[UIImageView alloc] initWithFrame:CGRectMake(-40, 20, 400, 600)];
    backgroundView.image = dialImage;
    [self.view addSubview:backgroundView];
    
    UIImageView * testRing = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 342, 342)];
    testRing.image = [self createMenuRingWithFrame:testRing.frame];
    [wheelImage addSubview:testRing];
    //[self runSpinAnimationOnView:wheelImage duration:5 rotations:0.5];
    
    timeline = [[TimeLineTableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300) Assets:self.buildingData.assets];
    timeline.layer.cornerRadius = 8;
    [self.view addSubview:timeline];
}

- (void) viewDidAppear:(BOOL)animated
{
    
}



- (void) pan:(UIPanGestureRecognizer *) sender
{
    CGPoint center = CGPointMake(self.view.frame.size.width/2, 240);
    CGPoint touch = CGPointMake([sender locationInView:self.view].x, [sender locationInView:self.view].y);
    CGFloat distance = sqrtf(powf((touch.x - center.x), 2) + powf((touch.y - center.y), 2));
    CGFloat angle = [self pointPairToBearingDegrees:center secondPoint:touch];
    if ((!firstAngle || firstAngle == 0) && distance < 175 && distance > 25){
        firstAngle = angle;
    } else {
        if (sender.state == UIGestureRecognizerStateEnded || distance > 175 || distance < 25) {
            firstAngle = 0;
        } else {
            //NSLog(@"%f", firstAngle - angle);
            [self rotateWheelRadians:(angle-firstAngle) * 0.01745]; //degrees to radians
            firstAngle = angle;
        }
    }
}

- (CGFloat) pointPairToBearingDegrees:(CGPoint)startingPoint secondPoint:(CGPoint) endingPoint
{
    CGPoint originPoint = CGPointMake(endingPoint.x - startingPoint.x, endingPoint.y - startingPoint.y); // get origin point to origin by subtracting end from start
    float bearingRadians = atan2f(originPoint.y, originPoint.x); // get bearing in radians
    float bearingDegrees = bearingRadians * (180.0 / M_PI); // convert to degrees
    bearingDegrees = (bearingDegrees > 0.0 ? bearingDegrees : (360.0 + bearingDegrees)); // correct discontinuity
    return bearingDegrees;
}

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations
{
    [UIView animateWithDuration:duration animations:^{
        view.transform = CGAffineTransformMakeRotation(M_PI * 2 * rotations);
    }];
}

- (void) rotateWheelRadians:(CGFloat) radians
{
    wheelImage.transform = CGAffineTransformMakeRotation(wheelRotation + radians);
    wheelRotation += radians;
    NSLog(@"%f", wheelRotation/(M_PI * 2));
    if (wheelRotation < 0)
        wheelRotation = 0;
    else if (wheelRotation > M_PI * 2)
        wheelRotation = M_PI * 2;
    //wheelRotation = fmod(wheelRotation, M_PI * 2);
    //timeline.contentOffset = CGPointMake(0, (timeline.frame.size.width/((M_PI * 2) * wheelRotation)));
}

- (UIImage *) image:(UIImage *) image croppedToSize:(CGSize) size
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, 0, size.width * 2, MIN(size.height * 2 , image.size.height)));
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return cropped;
}

- (void) drawStringAtContext:(CGContextRef) context string:(NSString*) text atAngle:(float) angle withRadius:(float) radius
{
    CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:16]];
    
    float perimeter = 2 * M_PI * radius;
    float textAngle = textSize.width / perimeter * 2 * M_PI;
    
    angle += textAngle / 2;
    
    for (int index = 0; index < [text length]; index++)
    {
        NSRange range = {index, 1};
        NSString* letter = [text substringWithRange:range];
        char* c = (char*)[letter cStringUsingEncoding:NSASCIIStringEncoding];
        CGSize charSize = [letter sizeWithFont:[UIFont systemFontOfSize:16]];
        
        //NSLog(@"Char %@ with size: %f x %f", letter, charSize.width, charSize.height);
        
        float x = radius * cos(angle);
        float y = radius * sin(angle);
        
        float letterAngle = (charSize.width / perimeter * -2 * M_PI);
        
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, x, y);
        CGContextRotateCTM(context, (angle - 0.5 * M_PI));
        CGContextShowTextAtPoint(context, 0, 0, c, strlen(c));
        CGContextRestoreGState(context);
        
        angle += letterAngle;
    }
}

- (UIImage*) createMenuRingWithFrame:(CGRect)frame
{
    CGFloat ringWidth = 5.0;
    CGFloat textRadius = 121;
    NSArray *sections = @[@"1860", @"1880", @"1900", @"1920", @"1940", @"1960", @"1980", @"2000"];
    
    CGPoint centerPoint = CGPointMake((frame.size.width + frame.origin.x) / 2, (frame.size.height + frame.origin.y) / 2);
    char* fontName = (char*)[[UIFont systemFontOfSize:16].fontName cStringUsingEncoding:NSASCIIStringEncoding];
    
    CGFloat* ringColorComponents = (float*)CGColorGetComponents([UIColor blackColor].CGColor);
    CGFloat* textColorComponents = (float*)CGColorGetComponents([UIColor blackColor].CGColor);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, frame.size.width, frame.size.height, 8, 4 * frame.size.width, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    CGContextSelectFont(context, fontName, 18, kCGEncodingMacRoman);
    CGContextSetRGBStrokeColor(context, ringColorComponents[0], ringColorComponents[1], ringColorComponents[2], 0);
    CGContextSetLineWidth(context, ringWidth);
    
    CGContextStrokeEllipseInRect(context, CGRectMake(ringWidth, ringWidth, frame.size.width - (ringWidth * 2), frame.size.height - (ringWidth * 2)));
    CGContextSetRGBFillColor(context, 0,0,0, 1);
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, centerPoint.x, centerPoint.y);
    
    float angleStep = 2 * M_PI / [sections count];
    float angle = 90 * 0.01745;
    
    textRadius = textRadius - 12;
    
    for (NSString* text in sections)
    {
        [self drawStringAtContext:context string:text atAngle:angle withRadius:textRadius];
        angle -= angleStep;
    }
    
    CGContextRestoreGState(context);
    
    CGImageRef contextImage = CGBitmapContextCreateImage(context);
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    //[self saveImage:[UIImage imageWithCGImage:contextImage] withName:@"test.png"];
    return [UIImage imageWithCGImage:contextImage];
    
}

- (void) selectedGridNumber:(NSInteger) number;
{
    
}
@end











