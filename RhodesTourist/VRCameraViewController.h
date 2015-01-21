//
//  VRCameraViewController.h
//  BealeApp
//
//  Created by Will Cobb on 1/14/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import "Building.h"
#import "CLLocation+Utils.h"

#import "AssetCollectionViewController.h"
#import "ProgressView.h"
#import "AVCamPreviewView.h"
#import "AVCamViewController.h"

@interface VRCameraViewController : UIViewController {
    UIViewController  * cameraViewController;
        UIView        * buildingNameView;
        UIVisualEffectView *blurView;
        ProgressView * progressCircle;
            CGFloat progress;
    
    Building * currentBuilding;
        BOOL alertedCurrentBuilding;
    Building * viewedBuilding;
    
        CGFloat currentHeading;
}

-(void) loadedNewBuildings;
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading;

@property id delegate;
@property NSMutableArray    * locations;
@property CLLocationManager * locationManager;
@property CMMotionManager   * motionManager;
@end
