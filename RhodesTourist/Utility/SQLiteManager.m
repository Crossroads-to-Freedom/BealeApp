//
//  SQLite.m
//  BealeApp
//
//  Created by Will Cobb on 2/11/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import "SQLiteManager.h"

@implementation SQLiteManager


- (id)init {
    if ((self = [super init])) {
        NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"app"
            ofType:@"sqlite"];
 
        if (sqlite3_open([sqLiteDb UTF8String], &_database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        }
        self.buildingList = [NSMutableArray new];
    }
    return self;
}
  
- (Building *) buildingWithId:(int) Id
{
    return [self.buildingList objectAtIndex:Id];
}

- (void) loadBuildings {
 
    NSString *query = @"SELECT * FROM buildings";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int uniqueId = sqlite3_column_int(statement, 0);
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            char *descriptionChars = (char *) sqlite3_column_text(statement, 2);
            char *iconChars = (char *) sqlite3_column_text(statement, 3);
            char *latitudeChars = (char *) sqlite3_column_text(statement, 4);
            char *longitudeChars = (char *) sqlite3_column_text(statement, 5);
            char *boundsChars = (char *) sqlite3_column_text(statement, 6);
            
            NSNumber *Id = [[NSNumber alloc] initWithInt:uniqueId];
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            NSString *description = [[NSString alloc] initWithUTF8String:descriptionChars];
            NSString *icon = [[NSString alloc] initWithUTF8String:iconChars];
            NSString *latitude = [[NSString alloc] initWithUTF8String:latitudeChars];
            NSString *longitude= [[NSString alloc] initWithUTF8String:longitudeChars];
            NSString *bounds = [[NSString alloc] initWithUTF8String:boundsChars];
            
            NSDictionary * dict = [[NSDictionary alloc] initWithObjects:@[  Id,   name,   description,   icon,   latitude,   longitude,   bounds]
                                                                forKeys:@[@"id",@"name",@"description",@"icon",@"latitude",@"longitude",@"bounds"]];
            
            [self.buildingList addObject:dict];

        }
        sqlite3_finalize(statement);
    }
 
}


- (void)dealloc {
    sqlite3_close(_database);
}



@end
