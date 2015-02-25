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
        
        NSLog(@"Char %@ with size: %f x %f", letter, charSize.width, charSize.height);
        
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

/*- (UIImage*) createMenuRingWithFrame:(CGRect)frame
{
    CGPoint centerPoint = CGPointMake(frame.size.width / 2, frame.size.height / 2);
    char* fontName = (char*)[[UIFont systemFontOfSize:16].fontName cStringUsingEncoding:NSASCIIStringEncoding];
    
    CGFloat* ringColorComponents = (float*)CGColorGetComponents([UIColor blueColor].CGColor);
    CGFloat* textColorComponents = (float*)CGColorGetComponents([UIColor blackColor].CGColor);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, frame.size.width, frame.size.height, 8, 4 * frame.size.width, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    CGContextSelectFont(context, fontName, 18, kCGEncodingMacRoman);
    CGContextSetRGBStrokeColor(context, ringColorComponents[0], ringColorComponents[1], ringColorComponents[2], ringAlpha);
    CGContextSetLineWidth(context, ringWidth);
    
    CGContextStrokeEllipseInRect(context, CGRectMake(ringWidth, ringWidth, frame.size.width - (ringWidth * 2), frame.size.height - (ringWidth * 2)));
    CGContextSetRGBFillColor(context, textColorComponents[0], textColorComponents[1], textColorComponents[2], textAlpha);
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, centerPoint.x, centerPoint.y);
    
    float angleStep = 2 * M_PI / [sections count];
    float angle = degreesToRadians(90);
    
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
    
    [self saveImage:[UIImage imageWithCGImage:contextImage] withName:@"test.png"];
    return [UIImage imageWithCGImage:contextImage];
    
}*/

- (void) selectedGridNumber:(NSInteger) number;
{
    
}
@end











