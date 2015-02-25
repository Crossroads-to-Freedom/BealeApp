//
//  ViewController.m
//  RhodesTourist
//
//  Created by Will Cobb on 9/4/14.
//  Copyright (c) 2014 Apprentice Media LLC. All rights reserved.
//

//Mail Room 35.154886, -89.989075
//BCLC      35.156410, -89.988989
//kappa Sig 35.155525, -89.990377
//KA        35.155751, -89.990309
//Sig Nu    35.155997, -89.990289x  
//SAE       35.155564, -89.990677
//ATO       35.155619, -89.991002
//Pike      35.155626, -89.991281
//West Village 35.155067, -89.990597
//Frat Lot  35.156211, -89.990805
//Williford 35.154204, -89.987851
//Football  35.157083, -89.989739
//The Rat   35.154275, -89.990734
//Blount    35.154782, -89.987785
//Robinson  35.154672, -89.988150
//Tri Delt  35.154875, -89.986645
//KD        35.154921, -89.987002
//KA        35.154803, -89.987273
//AO PI     35.154574, -89.987437
#import "ViewController.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define AC_RED  0.933//0.0468
#define AC_GREEN  0.2//0.6523
#define AC_BLUE  0.133//0.8672
@interface ViewController ()

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if(IS_OS_8_OR_LATER) {
        [self.locationManager requestWhenInUseAuthorization];
    }

    [self.locationManager startUpdatingLocation];
    self.motionManager = [[CMMotionManager alloc] init];
    
    
    database = [[SQLiteManager alloc] init];
    //[NSThread detachNewThreadSelector:@selector(loadBuildings) toTarget:database withObject:nil];
    [database loadBuildings];
    //<============== Create Views
    
    
    //VRCameraView -- this is the view that overlays buildings and people
    cameraView = [[VRCameraViewController alloc] init];
    cameraView.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    cameraView.motionManager = self.motionManager;
    cameraView.locationManager = self.locationManager;
    cameraView.locations = database.buildingList;
    [cameraView loadedNewBuildings];
    [cameraView viewWillAppear:YES];
    [cameraView viewDidAppear:YES];
    [self.view addSubview:cameraView.view];
    
    //MapView
    mapView = [[MapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-40) Delegate:self LocationManager:self.locationManager Database:database];
    [self.view addSubview:mapView];
    
    //HomeView
    homeView = [[HomeTableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-104) Delegate:self Database:database];
    [self.view addSubview:homeView];
    
    
    
    for (UITabBarItem * item in tabBar.items) {
        if      (item.tag == 1)
            item.image = [self imageWithImage:[UIImage imageNamed:@"home-75.png"] scaledToSize:CGSizeMake(30, 30)];
        else if (item.tag == 2)
            item.image = [self imageWithImage:[UIImage imageNamed:@"map_marker-256.png"] scaledToSize:CGSizeMake(30, 30)];
        else if (item.tag == 3)
            item.image = [self imageWithImage:[UIImage imageNamed:@"slr_camera2-75.png"] scaledToSize:CGSizeMake(30, 30)];
        else if (item.tag == 5)
            item.image = [self imageWithImage:[UIImage imageNamed:@"settings-75.png"] scaledToSize:CGSizeMake(30, 30)];
        
    }
    
    [self.view bringSubviewToFront:tabBar];
    //Utilities
    wifiStatus = [WifiStatus new];
    if (!wifiStatus.isWiFiEnabled)
        [alertManager alert:@"Enable wifi to increase location accuracy"];
    alertManager = [[Alert alloc] initWithSUperView:self.view];
    
    
    
}

- (UIStatusBarStyle) preferredStatusBarStyle {
     return UIStatusBarStyleLightContent;
}

- (void) viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    //Check For Wifi
    

}

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)presentBuildingInformationWithId:(NSInteger) buildingId
{
    [self performSegueWithIdentifier:@"RootToBuilding" sender:self];
}

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager{
    //return NO; // Prevents annoying calculation window while testing
    if (!self.currentHeading) return YES; // Got nothing, We can assume we got to calibrate.
    else if (self.currentHeading.headingAccuracy <= 0) return YES; // 0 means invalid heading and needs to be calibrated
    else if (self.currentHeading.headingAccuracy > 5)return YES; // over 5 degrees needs to be recalculated
    else return NO; // All is good. Compass is precise enough.
}

- (void) tabBar:(UITabBar *)ltabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"%ld", (long)item.tag);
    if (item.tag == 1) {
        [self.view bringSubviewToFront:homeView];
        [self.view bringSubviewToFront:tabBar];
    } else if (item.tag == 2) {
        [self.view bringSubviewToFront:mapView];
        [self.view bringSubviewToFront:tabBar];
    } else if (item.tag == 3) {
        [self.view bringSubviewToFront:cameraView.view];
        [self.view bringSubviewToFront:tabBar];
    } else if (item.tag == 4) {
        [self.view bringSubviewToFront:homeView];
        [self.view bringSubviewToFront:tabBar];
    } else if (item.tag == 5) {
        [self.view bringSubviewToFront:homeView];
        [self.view bringSubviewToFront:tabBar];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{       
    NSLog(@"Error while getting core location : %@",[error localizedFailureReason]);
    if ([error code] == kCLErrorDenied) {
        //User has denied to show location
    }
    [manager stopUpdatingLocation];
}



-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)theLocations {
    
    if (!currentBuilding || ![currentBuilding isInside:self.locationManager.location]) { //If this is false then the user is still in the same building
                                                                                         //This check just saves some CPU time
        Building * oldBuilding = currentBuilding;
        currentBuilding = nil;
        for (Building * building in locations) {
            if ([building isInside:self.locationManager.location]) {
                currentBuilding = building;
                break;
            }
        }
        
        if (currentBuilding && !alertedCurrentBuilding) {
            [alertManager alert:[NSString stringWithFormat:@"Entered: %@", currentBuilding.name]];
            alertedCurrentBuilding = YES;
        } else if (!currentBuilding && alertedCurrentBuilding) {
            [alertManager alert:[NSString stringWithFormat:@"Left: %@", oldBuilding.name]];
            alertedCurrentBuilding = NO;
        }
    }
}


-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    [cameraView locationManager:manager didUpdateHeading:newHeading];
}


#pragma mark -
#pragma mark Movement

- (void) progressDone {
    //[self performSegueWithIdentifier:@"RootToBuilding" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"RootToBuilding"]) {
        BuildingInformationViewController * buildingViewController = [segue destinationViewController];
        buildingViewController.buildingData = viewedBuilding;
    }
}


/*- (void)myTouch:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location;
    for (UITouch *touch in touches)
    {
        location = [touch locationInView:touch.view];
    }
    
    if (drawerIsIn){
        NSLog(@"%f %f", location.x, location.y);
        NSMutableArray * activeBuildings = [NSMutableArray new];
        //Loop through all buildings on screen
        for (Building * building in locations) {
            BOOL behind = NO;
            for (Building * buildingBehind in locations) {
                if (building != buildingBehind && [building isBehind:buildingBehind Location:self.locationManager.location]) {
                    behind = YES;
                    //NSLog(@"%@ behind %@", building.name, buildingBehind.name);
                    break;
                }
            }
            [activeBuildings addObject:building];
        }
        CGFloat angle = -(atan2(self.motionManager.deviceMotion.gravity.y, self.motionManager.deviceMotion.gravity.x) + M_PI_2);
        for (Building * building in locations) {
            CGFloat width = self.view.frame.size.width;
            CGFloat offset = [building bearingToBuilding:self.locationManager.heading.trueHeading Location:self.locationManager.location] - self.locationManager.heading.trueHeading;
            if (!currentAjustedHeading)
                currentAjustedHeading = self.locationManager.heading.trueHeading;
            if (fabs(offset) > 180)
                offset = 360 - fabs(offset);
            CGFloat x = 500 + (offset - 90 * sin(angle)) * (width/27); //54 = fov of most cameras (27 is half of 54 because all coordinates are halfed
            if (fabs(location.x - x) < 250/powf([self.locationManager.location distanceFromLocation:building.location], 0.35)) {
                //progressCircle.center = location;
                NSLog(@"%@", building.name);
            }
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location;
    for (UITouch *touch in touches)
    {
        location = [touch locationInView:touch.view];
    }
    if (drawerIsIn){
        //[progressCircle beginProgress];
    }   else if (!drawerIsIn) {
        //[drawer drawerToggle];
    }
    
    [self myTouch:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self myTouch:touches withEvent:event];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    sideSwiping = NO;
    //[progressCircle stopProgress];
}*/

- (IBAction)presentBuildingAssets:(id)sender
{
    
}
@end























