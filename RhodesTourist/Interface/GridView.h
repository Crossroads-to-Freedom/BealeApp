//
//  GridView.h
//  BealeApp
//
//  Created by Will Cobb on 2/12/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GridViewDelegate;

@interface GridView : UITableView <UITableViewDataSource, UITableViewDelegate> {
    CGFloat sideLength;
}


@property id delegateView;

@end

@protocol GridViewDelegate <NSObject>

@required
- (void) selectedGridNumber:(NSInteger) number;
@end
