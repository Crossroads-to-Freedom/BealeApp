//
//  SQLite.h
//  BealeApp
//
//  Created by Will Cobb on 2/11/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Building.h"
#import "Asset.h"
@interface SQLiteManager : NSObject {
    sqlite3 *_database;
    
}

@property NSMutableArray * buildingList;

- (void) loadBuildings;
- (Building *) buildingWithId:(int) Id;
@end
