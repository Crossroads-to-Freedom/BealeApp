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
        NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"app" ofType:@"sqlite"];
 
        if (sqlite3_open([sqLiteDb UTF8String], &_database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        }
        self.buildingList = [NSMutableArray new];
    }
    return self;
}
  
- (Building *) buildingWithId:(int) Id
{
    return [self.buildingList objectAtIndex:Id - 1];
}

- (void) loadBuildings {
    NSLog(@"A");
    NSString *query = @"SELECT * FROM building";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int Id = sqlite3_column_int(statement, 0);
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            char *descriptionChars = (char *) sqlite3_column_text(statement, 2);
            int iconAssetId = sqlite3_column_int(statement, 3);
            float latitude = sqlite3_column_double(statement, 4);
            float longitude = sqlite3_column_double(statement, 5);
            char *boundsChars = (char *) sqlite3_column_text(statement, 6);
            int bannerAssetId = sqlite3_column_int(statement, 7);
            
            NSString * bounds = [[NSString alloc] initWithUTF8String:boundsChars];
            
            NSLog(@"Loading Building: %@", [[NSString alloc] initWithUTF8String:nameChars]);
            
            Building * newBuilding = [[Building alloc] init];
            newBuilding.name = [[NSString alloc] initWithUTF8String:nameChars];
            newBuilding.Id = Id;
            newBuilding.descriptionInfo = [[NSString alloc] initWithUTF8String:descriptionChars];
            newBuilding.location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
            newBuilding.bounds = [bounds componentsSeparatedByString:@"!"];
            
            NSString *query = [NSString stringWithFormat:@"SELECT * FROM asset WHERE buildingId = %d", Id];
            
            NSMutableArray * assets = [NSMutableArray new];
            
            sqlite3_stmt *statement2;
            if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement2, nil) == SQLITE_OK) {
                while (sqlite3_step(statement2) == SQLITE_ROW) {
                    int assetId = sqlite3_column_int(statement2, 0);
                    int buildingId = sqlite3_column_int(statement2, 1);
                    int type = sqlite3_column_int(statement2, 2);
                    char *filePathChars = (char *) sqlite3_column_text(statement2, 3);
                    
                    NSString * filePath = [[NSString alloc] initWithUTF8String:filePathChars];
                    
                    //NSLog(@"Asset: %@", filePath);
                    if (type == 1) {
                        
                    } else if (type == 2) {
                        Asset * newAsset = [[Asset alloc] initWithImageUrl:filePath];
                        [assets addObject:newAsset];
                    }
                    if (iconAssetId == assetId) {
                        newBuilding.icon = [[Asset alloc] initWithImageUrl:filePath];
                    } else if (bannerAssetId == assetId) {
                        //NSLog(@"Banner %@", [[NSString alloc] initWithUTF8String:filePathChars]);
                        newBuilding.banner = [[Asset alloc] initWithImageUrl:filePath];
                    }
                }
            }
            [self.buildingList addObject:newBuilding];
        }
        
        sqlite3_finalize(statement);
    }
    NSLog(@"B %@", [self buildingWithId:1].name);
}


- (void)dealloc {
    sqlite3_close(_database);
}



@end