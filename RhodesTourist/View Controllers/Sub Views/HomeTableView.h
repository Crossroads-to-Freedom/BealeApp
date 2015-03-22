//
//  HomeTableView.h
//  BealeApp
//
//  Created by Will Cobb on 2/24/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SQLiteManager.h"
#import "Building.h"
#import "Asset.h"
#import "ClipView.h"
@interface HomeTableView : UITableView <UITableViewDataSource, UITableViewDelegate> {
    
}
@property id             viewControllerDelegate;
@property SQLiteManager* database;
@property UIScrollView * verticalScrollView;
@property UIScrollView * featuredView;
@property UIPageControl* featuredViewControll;

-(id) initWithFrame:(CGRect)frame Delegate:(id) delegate Database:(SQLiteManager *) database;
-(void)presentBuildingInformationWithId:(NSInteger) buildingId;

@end
