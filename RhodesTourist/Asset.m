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

- (id)initWithInterview:(NSInteger) rds Segments:(NSArray *) segments{
    if ((self = [super init])) {  
        self.rds = rds;
        self.assetType = 2;
    }
    return self;
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
