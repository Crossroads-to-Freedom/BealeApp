//
//  SocialMediaTableView.h
//  BealeApp
//
//  Created by Will Cobb on 2/27/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLiteManager.h"
@interface SocialMediaTableView : UITableView <UITableViewDataSource, UITableViewDelegate> {
    
}
@property id             viewControllerDelegate;
@property SQLiteManager* database;

-(id) initWithFrame:(CGRect)frame Delegate:(id) delegate Database:(SQLiteManager *) database;
- (void)presentBuildingInformationWithId:(NSInteger) buildingId;@end
