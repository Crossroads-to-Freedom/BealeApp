//
//  AssetCollectionViewController.h
//  CrossRoads
//
//  Created by Will Cobb on 9/25/14.
//  Copyright (c) 2014 Apprentice Media LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Building.h"
#import "Asset.h"
@interface AssetCollectionViewController : UICollectionViewController {
    NSInteger selectedAsset;
}


@property Building * buildingData;
@end
