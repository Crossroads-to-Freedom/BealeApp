//
//  ViewController.h
//  RhodesTourist
//
//  Created by Will Cobb on 9/4/14.
//  Copyright (c) 2014 Apprentice Media LLC. All rights reserved.
//

//  Top View Controller that holds each sub view and top layer functions suck as alerts

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import "Building.h"
#import "CLLocation+Utils.h"
#import "Alert.h"

#import "DrawerTableView.h"
#import "HomeView.h"
#import "VRCameraViewController.h"
#import "PointsOfInterestView.h"
#import "WifiStatus.h"
#import "SQLiteManager.h"
#import "Drawer.h"
#import "MovingUIView.h"
#import "BuildingInformationViewController.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate, UITabBarControllerDelegate, UITabBarDelegate> {
    NSMutableArray * locations;

    IBOutlet UIView * statusBarBackground;
    
    IBOutlet UITabBar * tabBar;
    
    HomeView               * homeView;
    VRCameraViewController * cameraView;
    PointsOfInterestView * pointsOfInterestView;
        
    
    Building * currentBuilding;
        BOOL alertedCurrentBuilding;
    Building * viewedBuilding;
    
    
    CGFloat currentAjustedHeading;
    
    
    //<=========== Utility
    SQLiteManager * database;
    BOOL showingAlert;
    NSMutableArray * alertQue;
    Alert * alertManager;
    WifiStatus * wifiStatus;
}

- (IBAction)presentBuildingAssets:(id)sender;
- (void) progressDone;
- (void)presentBuildingInformationWithId:(NSInteger) buildingId;

@property CLLocationManager * locationManager;
@property CMMotionManager   * motionManager;
@property CLHeading * currentHeading;
@end

