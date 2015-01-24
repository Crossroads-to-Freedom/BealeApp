//
//  DrawerTableViewController.h
//  CrossRoads
//
//  Created by Will Cobb on 10/8/14.
//  Copyright (c) 2014 Apprentice Media LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drawer.h"
@interface DrawerTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property Drawer * drawerController;

@end
