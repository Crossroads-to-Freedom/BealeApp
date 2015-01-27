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
//Sig Nu    35.155997, -89.990289
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
#define AC_RED  0.0468
#define AC_GREEN  0.6523
#define AC_BLUE  0.8672
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
    
    locations = [NSMutableArray new];
    
    
    statusBarBackground.layer.zPosition = 101;
    
    
    //<============== Create Views
    drawerView = [[DrawerTableView alloc] initWithFrame:CGRectMake(0, 20, 100, self.view.frame.size.height - 20)];
    [drawerView selectRowAtIndexPath:0 animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self.view addSubview:drawerView];
    
    UIScreenEdgePanGestureRecognizer *edgeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgeSwipe:)];
    [self.view addGestureRecognizer:edgeGesture];
    //Black Background view used for animations
    UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height)];
    backgroundView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backgroundView];
    //VRCameraView -- this is the view that overlays building and people
    cameraView = [[VRCameraViewController alloc] init];
    cameraView.view.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
    cameraView.motionManager = self.motionManager;
    cameraView.locationManager = self.locationManager;
    cameraView.locations = locations;
    [cameraView.view addGestureRecognizer:edgeGesture];
    //[self.view addSubview:cameraView.view];
    
    //PointsOfInterestView
    pointsOfInterestView = [[PointsOfInterestView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60)];
    [pointsOfInterestView addGestureRecognizer:edgeGesture];
    pointsOfInterestView.delegate = self;
    [self.view addSubview:pointsOfInterestView];
    
    //Nav Bar
    navBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    navBarView.backgroundColor = [UIColor colorWithRed:AC_RED green:AC_GREEN blue:AC_BLUE alpha:1];
    navBarView.layer.zPosition = 100;
    navBarView.layer.shadowRadius = 5;
    navBarView.layer.shadowOpacity = 0.5;
    navBarView.layer.shadowOffset = CGSizeMake(-5, 3);
    
    locationName = [[UILabel alloc] initWithFrame:CGRectMake(20, 9, 280, 21)];
    locationName.textAlignment = NSTextAlignmentCenter;
    [locationName setTextColor:[UIColor whiteColor]];
    //locationName.text = @"Nothing";
    [navBarView addSubview:locationName];
    
    
    
    NSArray * contentViews = @[pointsOfInterestView, cameraView.view];
    NSArray * extraViews   = @[navBarView, backgroundView];
    drawer = [[Drawer alloc] initWithMenuView:drawerView contentViews:contentViews];
    drawer.extraViewsToMove = extraViews;
    drawerView.drawerController = drawer;
    
    drawerButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
    [drawerButton setImage:[UIImage imageNamed:@"Drawer.png"] forState:UIControlStateNormal];
    [drawerButton addTarget:drawer action:@selector(drawerToggle) forControlEvents:UIControlEventTouchUpInside];
    [navBarView addSubview:drawerButton];
    [self.view addSubview:navBarView];
    
    //Utilities
    wifiStatus = [WifiStatus new];
    alertManager = [[Alert alloc] initWithSUperView:self.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(drawerOut:)
        name:@"DrawerOut"
        object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(drawerIn:)
        name:@"DrawerIn"
        object:nil];
    
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
    if (!wifiStatus.isWiFiEnabled)
        [alertManager alert:@"Enable wifi to increase location accuracy"];
    
    [self loadNearbyBuildings];

}

//Function to show a generic alert

- (void) animateInterestViewToAssetView:(UIButton *) sender
{
    MovingUIView * topView = (MovingUIView* )[sender superview];
    navBarIcon = topView;
    topView.isMoving = NO;
    [topView.layer removeAllAnimations];
    [topView removeFromSuperview];
    [navBarView addSubview:topView];
    topView.frame = CGRectMake(topView.frame.origin.x, topView.frame.origin.y + 40, topView.frame.size.width, topView.frame.size.height);
    topView.layer.zPosition = 102;
    topView.isMoving = NO;
    NSLog(@"%ld", (long)sender.tag);
    
    [UIView animateWithDuration:0.3 animations:^{
        [topView viewWithTag:100].alpha = 0;
    }];
    [UIView animateWithDuration:0.5 animations:^{
        topView.frame = CGRectMake(self.view.frame.size.width-60, 5, 30, 30);
        sender.frame = CGRectMake(0, 0, 30, 30);
        pointsOfInterestView.alpha=0;
    }];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = [NSNumber numberWithFloat:50.0f];
    animation.toValue = [NSNumber numberWithFloat:15.0f];
    animation.duration = 0.5;
    [topView.layer addAnimation:animation forKey:@"cornerRadius"];
    [topView.layer setCornerRadius:15.0];
    [sender.layer addAnimation:animation forKey:@"cornerRadius"];
    [sender.layer setCornerRadius:15.0];
}

-(void) drawerOut:(NSNotification *)notification
{
    
}

-(void) drawerIn:(NSNotification *)notification
{
    UIView * newView = [[notification userInfo] objectForKey:@"view"];
    if (newView != cameraView) {
        [cameraView viewDidDisappear:NO];
    }
    if (navBarIcon) {
        [navBarIcon removeFromSuperview];
        [pointsOfInterestView returnPoint:navBarIcon];
    }
        
}

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager{
    return NO; // Prevents annoying calculation window while testing
    if (!self.currentHeading) return YES; // Got nothing, We can assume we got to calibrate.
    else if (self.currentHeading.headingAccuracy <= 0) return YES; // 0 means invalid heading and needs to be calibrated
    else if (self.currentHeading.headingAccuracy > 5)return YES; // over 5 degrees needs to be recalculated
    else return NO; // All is good. Compass is precise enough.
}

/*- (void)drawer
{
    if (drawerIsIn) {
        drawerIsIn = NO;
        [UIView animateWithDuration:0.2 animations:^{
            statusBarBackground.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        
            cameraView.view.center = CGPointMake(cameraView.view.frame.size.width/2+100, cameraView.view.center.y);
            //blurView.alpha = 1;
            
            navBarView.center = CGPointMake(navBarView.frame.size.width/2+100, navBarView.center.y);
        } completion:^(BOOL finished) {
           
        }];
    } else {
        drawerIsIn = YES;
        [UIView animateWithDuration:0.2 animations:^{
            statusBarBackground.backgroundColor = [UIColor colorWithRed:12.0/256 green:167.0/256 blue:222.0/256 alpha:1];
            //blurView.alpha = 0;
            cameraView.view.center = CGPointMake(cameraView.view.frame.size.width/2, cameraView.view.center.y);
            navBarView.center = CGPointMake(navBarView.frame.size.width/2, navBarView.center.y);
        } completion:^(BOOL finished) {
            
        }];
    }
}*/

- (void) loadNearbyBuildings
{
    //Code to load from server
    /*AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:@"/api/myEvents"] parameters:@{@"rds" : [NSNumber numberWithInteger:self.rds]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
       
        
    }];*/
    //Sample Response
    //This is an example of a json response that would be returned from the server
    //For the Beale street app we will probably switch to a sqlite database
    
    NSArray * responseObject = @[@{@"id" : [NSNumber numberWithInteger:1],
                                    @"name" : @"Levitt Shell",
                                    @"lat" : [NSNumber numberWithFloat:35.145766],
                                    @"lon" : [NSNumber numberWithFloat:-89.994836],
                                   @"assets" : @[@{@"rds" : [NSNumber numberWithInt:56588], @"type" : [NSNumber numberWithInt:1]},
                                                 @{@"rds" : [NSNumber numberWithInt:43083], @"type" : [NSNumber numberWithInt:1]},
                                                 @{@"rds" : [NSNumber numberWithInt:60089], @"type" : [NSNumber numberWithInt:1]},
                                                 @{@"rds" : [NSNumber numberWithInt:61259], @"type" : [NSNumber numberWithInt:1]},
                                                 @{@"rds" : [NSNumber numberWithInt:1183019], @"type" : [NSNumber numberWithInt:2], @"segments" : @[[NSNumber numberWithInteger:6]]},
                                                 @{@"rds" : [NSNumber numberWithInt:39576], @"type" : [NSNumber numberWithInt:1]}
                                                 ],
                                   @"bounds" : @[@"35.145698,-89.994940", @"35.145800,-89.994640", @"35.145686,-89.994580", @"35.145584, -89.994882"]
                                   },
                                   
                                 @{@"id" : [NSNumber numberWithInteger:2],
                                 @"name" : @"The Zoo",
                                 @"lat" : [NSNumber numberWithFloat:35.150863],
                                 @"lon" : [NSNumber numberWithFloat:-89.992622],
                                 @"assets" :  @[@{@"rds" : [NSNumber numberWithInt:91358], @"type" : [NSNumber numberWithInt:1]},
                                                 @{@"rds" : [NSNumber numberWithInt:71179], @"type" : [NSNumber numberWithInt:1]},
                                                 @{@"rds" : [NSNumber numberWithInt:76187], @"type" : [NSNumber numberWithInt:1]},
                                                 @{@"rds" : [NSNumber numberWithInt:55351], @"type" : [NSNumber numberWithInt:1]},
                                                 @{@"rds" : [NSNumber numberWithInt:60818], @"type" : [NSNumber numberWithInt:1]},
                                                 @{@"rds" : [NSNumber numberWithInt:117516],@"type" : [NSNumber numberWithInt:2], @"segments" : @[[NSNumber numberWithInteger:6]]},
                                                 @{@"rds" : [NSNumber numberWithInt:88919], @"type" : [NSNumber numberWithInt:1]},
                                                 @{@"rds" : [NSNumber numberWithInt:86964], @"type" : [NSNumber numberWithInt:1]}
                                                 ],
                                   @"bounds" : @[@"35.150240,-89.997791", @"35.152406,-89.997474", @"35.151406,-89.987813", @"35.149240, -89.988027"]
                                   },/*
                                 
                                  @{@"id" : [NSNumber numberWithInteger:3], @"name" : @"Rhodes", @"lat" : [NSNumber numberWithFloat:35.155469], @"lon" : [NSNumber numberWithFloat:-89.989096],
                                  @"assets" :  @[@{@"rds" : [NSNumber numberWithInt:91358], @"type" : [NSNumber numberWithInt:1]},
                                                 @{@"rds" : [NSNumber numberWithInt:71179], @"type" : [NSNumber numberWithInt:1]},
                                                 @{@"rds" : [NSNumber numberWithInt:76187], @"type" : [NSNumber numberWithInt:1]},
                                                 @{@"rds" : [NSNumber numberWithInt:55351], @"type" : [NSNumber numberWithInt:1]},
                                                 @{@"rds" : [NSNumber numberWithInt:117516],@"type" : [NSNumber numberWithInt:2], @"segments" : @[[NSNumber numberWithInteger:6]]}
                                                 ],
                                   @"bounds" : @[@"35.159530,-89.990769", @"35.159127,-89.985791", @"35.151653,-89.986853", @"35.152153,-89.991971"]
                                   }*/
                                   // Rhodes
                                @{@"id" : [NSNumber numberWithInteger:2],
                                @"name" : @"Blount",
                                @"lat" : [NSNumber numberWithFloat:35.154782],
                                @"lon" : [NSNumber numberWithFloat:-89.987785],
                                @"assets" :  @[@{@"rds" : [NSNumber numberWithInt:91358], @"type" : [NSNumber numberWithInt:1]},
                                                 @{@"rds" : [NSNumber numberWithInt:71179], @"type" : [NSNumber numberWithInt:1]}
                                                ],
                                @"bounds" : @[@"35.154860, -89.987949", @"35.154849, -89.987806", @"35.154963, -89.987780", @"35.154933, -89.987660", @"35.154707, -89.987683", @"35.154733, -89.987967"]
                                   },
                                @{@"id" : [NSNumber numberWithInteger:2],
                                @"name" : @"Rat",
                                @"lat" : [NSNumber numberWithFloat:35.154313],
                                @"lon" : [NSNumber numberWithFloat:-89.990657],
                                @"assets" :  @[@{@"rds" : [NSNumber numberWithInt:91358], @"type" : [NSNumber numberWithInt:1]},
                                                 @{@"rds" : [NSNumber numberWithInt:71179], @"type" : [NSNumber numberWithInt:1]}
                                                ],
                                @"bounds" : @[@"35.154116, -89.991048", @"35.154326, -89.991005", @"35.154318, -89.990793", @"35.154511, -89.990737", @"35.154469, -89.990445", @"35.154103, -89.990541"]
                                   },
                                 
                                @{@"id" : [NSNumber numberWithInteger:2],
                                @"name" : @"Book Store",
                                @"lat" : [NSNumber numberWithFloat:35.154890],
                                @"lon" : [NSNumber numberWithFloat:-89.989085],
                                @"assets" :  @[@{@"rds" : [NSNumber numberWithInt:91358], @"type" : [NSNumber numberWithInt:1]},
                                                @{@"rds" : [NSNumber numberWithInt:71179], @"type" : [NSNumber numberWithInt:1]}
                                                ],
                                @"bounds" : @[@"35.154822, -89.989321", @"35.155037, -89.989298", @"35.155013, -89.988965", @"35.154887, -89.988800", @"35.154759, -89.988820"]
                                   }
                                
                                ];
    //takes the json data and creates the respective objects for each building
    //Then puts each building into a list "locations"
    for (NSMutableDictionary * buildingData in responseObject) {
        Building * newBuilding = [[Building alloc] initWithData:buildingData];
        [locations addObject: newBuilding];
    }
    NSLog(@"1");
    [cameraView loadedNewBuildings];
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
    
    if (!currentBuilding || ![currentBuilding isInside:self.locationManager.location]) { //If this is true then the user is still in the same building
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

- (IBAction)edgeSwipe:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"Test");
}

- (void) progressDone {
    //[self performSegueWithIdentifier:@"RootToBuilding" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"RootToBuilding"]) {
        NSArray *temp = [[segue destinationViewController] childViewControllers];
        AssetCollectionViewController * assetCollectionViewController = (AssetCollectionViewController *)[temp objectAtIndex:0];
        assetCollectionViewController.buildingData = viewedBuilding;
    }
}


- (void)myTouch:(NSSet *)touches withEvent:(UIEvent *)event
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
}

- (IBAction)presentBuildingAssets:(id)sender
{
    
}
@end























