//
//  Asset.h
//  RhodesTourist
//
//  Created by Will Cobb on 9/17/14.
//  Copyright (c) 2014 Apprentice Media LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
@interface Asset : NSObject

@property NSInteger     rds;
@property UIImageView * thumbnail;
@property NSInteger     assetType;
@property NSMutableDictionary * assetData;

- (id)initWithArticle:(NSInteger) rds;
- (id)initWithInterview:(NSInteger) rds Segments:(NSArray *) segments;
- (void) loadThumbnail;

@end
