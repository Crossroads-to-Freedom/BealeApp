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
#import "Drawer.h"
#import "MovingUIView.h"
#import "BuildingInformationView.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate> {
    NSMutableArray * locations;

    IBOutlet UIView * statusBarBackground;
    
    UIView  * navBarView;
        UIButton * drawerButton;
        UILabel * locationName;
        MovingUIView  * navBarIcon;
    
    HomeView               * homeView;
    VRCameraViewController * cameraView;
    PointsOfInterestView * pointsOfInterestView;
        BuildingInformationView * buildingView;
    
    Building * currentBuilding;
        BOOL alertedCurrentBuilding;
    Building * viewedBuilding;
    
    
    CGFloat currentAjustedHeading;
    
    //<=========== Drawer
    Drawer * drawer;
    DrawerTableView * drawerView;
    BOOL drawerIsIn;
    BOOL sideSwiping;
    
    //<=========== Utility
    BOOL showingAlert;
    NSMutableArray * alertQue;
    Alert * alertManager;
    WifiStatus * wifiStatus;
}

- (IBAction)presentBuildingAssets:(id)sender;
- (void) progressDone;
@property CLLocationManager * locationManager;
@property CMMotionManager   * motionManager;
@property CLHeading * currentHeading;
@end

