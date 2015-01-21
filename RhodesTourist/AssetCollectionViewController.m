//
//  AssetCollectionViewController.m
//  CrossRoads
//
//  Created by Will Cobb on 9/25/14.
//  Copyright (c) 2014 Apprentice Media LLC. All rights reserved.
//
// http://designmodo.com/wp-content/uploads/2013/07/MuscTube-Menu-by-Isaac-Sanchez.jpg

#import "AssetCollectionViewController.h"

@interface AssetCollectionViewController ()

@end

@implementation AssetCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //Load the assets
    NSLog(@"Yo %@", self.buildingData.assets);
    for (Asset * asset in self.buildingData.assets) {
        [asset loadThumbnail];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.buildingData.assets count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    Asset * asset = self.buildingData.assets[indexPath.row];
    UIImageView * thumbnail = asset.thumbnail;
    [cell addSubview:thumbnail];
    UILabel * test = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 105)];
    test.text = @"";
    [cell addSubview:test];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Clicked %ld", (long)indexPath.row);
}

#pragma mark <UICollectionViewDelegate>



@end
