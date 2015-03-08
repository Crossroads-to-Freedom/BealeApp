//
//  Asset.m
//  RhodesTourist
//
//  Created by Will Cobb on 9/16/14.
//  Copyright (c) 2014 Apprentice Media LLC. All rights reserved.
//

#import "Asset.h"

@implementation Asset

- (id)initWithArticle:(NSInteger) rds {
    if ((self = [super init])) {
        self.rds = rds;
        self.assetType = 1;
    }
    return self;
}

- (id)initWithImageUrl:(NSString*) url{
    if ((self = [super init])) {
        imageUrl = url;
        imageUrl = [imageUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        self.assetType = 2;
    }
    return self;
}

- (id)initWithInterview:(NSInteger) rds Segments:(NSArray *) segments{
    if ((self = [super init])) {  
        self.rds = rds;
        self.assetType = 3;
    }
    return self;
}

- (UIImageView *) assetImageViewWithSize:(CGSize) size
{
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor blueColor];
    if (!assetImage)
    {
        NSString * fullUrl = [NSString stringWithFormat:@"http://%@", imageUrl];
        NSLog(@"Loading %@", fullUrl);
        NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:fullUrl]];
        AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            //NSLog(@"Response: %@", responseObject);
            assetImage = (UIImage *)responseObject;
            imageView.image = [self image:assetImage.copy toSize:size];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Image error: %@", error);
        }];
        [requestOperation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            NSLog(@"Progress: %lld/%lld", totalBytesWritten, totalBytesExpectedToWrite);
        }];
        [requestOperation start];
        
        
    }
    else
    {
        imageView.image = [self image:assetImage.copy toSize:size];
    }
    //imageView.size = imageView.image.size;
    return imageView; 
}



- (UIImage *) image:(UIImage *) image toSize:(CGSize) size
{
    //NSLog(@"Coverting %f, %f to %f, %f", image.size.width, image.size.height, size.width, size.height);
    float ratio;
    if (fabs(size.height/image.size.height - 1) < fabs(size.width/image.size.width - 1))
        ratio = size.height/image.size.height;
        //ratio = size.width/image.size.width;
    else
        ratio = size.width/image.size.width;
        //ratio = size.height/image.size.height;
    //NSLog(@"Ratio %f", ratio);
    //Resize
    CGSize newSize = CGSizeMake(image.size.width * ratio, image.size.height * ratio);
    //NSLog(@"%f %f", newSize.width, newSize.height);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 1.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //Crop
    CGImageRef imageRef = CGImageCreateWithImageInRect([newImage CGImage], CGRectMake(0, 0, size.width, size.height));
    //CGRectMake((newSize.width-size.width)/2
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return cropped;
}

- (void) loadThumbnail
{
    NSLog(@"Loading");
    NSURL * photourl = [NSURL URLWithString:[NSString stringWithFormat:@"http://crossroads.rhodes.edu:9090/fedora/get/rds:%ld/thumbnail_280x210.jpg", (long)self.rds]];
    self.thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 140, 105)];
    [self.thumbnail setImageWithURL:photourl];
    
}

- (void) parseHeader:(NSString *) header Type:(NSString *)type
{
    NSString *searchedString = @"domain-name.tld.tld2";
    NSRange   searchedRange = NSMakeRange(0, [searchedString length]);
    NSString *pattern = @"(?:www\\.)?((?!-)[a-zA-Z0-9-]{2,63}(?<!-))\\.?((?:[a-zA-Z0-9]{2,})?(?:\\.[a-zA-Z0-9]{2,})?)";
    NSError  *error = nil;

    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
    NSArray* matches = [regex matchesInString:searchedString options:0 range: searchedRange];
    for (NSTextCheckingResult* match in matches) {
        NSString* matchText = [searchedString substringWithRange:[match range]];
        NSLog(@"match: %@", matchText);
        NSRange group1 = [match rangeAtIndex:1];
        NSRange group2 = [match rangeAtIndex:2];
        NSLog(@"group1: %@", [searchedString substringWithRange:group1]);
        NSLog(@"group2: %@", [searchedString substringWithRange:group2]);
    }
}

- (void) render
{

}

@end
