//
//  TimeLineTableView.h
//  BealeApp
//
//  Created by Will Cobb on 3/8/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeLineTableViewCell.h"
#import "Asset.h"
#import "Global.h"
@interface TimeLineTableView : UITableView

@property NSMutableArray * assets;
-(id) initWithFrame:(CGRect)frame Assets:(NSArray*) assets;

@end
