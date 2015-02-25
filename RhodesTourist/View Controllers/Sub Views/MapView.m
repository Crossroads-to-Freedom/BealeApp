//
//  MapView.m
//  BealeApp
//
//  Created by Will Cobb on 2/25/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import "MapView.h"

@implementation MapView

-(id) initWithFrame:(CGRect)frame Delegate:(id) delegate LocationManager:(CLLocationManager *) locationManager Database:(SQLiteManager *)database
{
    self = [super initWithFrame:frame];
    self.delegate = delegate;
    self.locationManager = locationManager;
    self.database = database;
    self.map = [[MKMapView alloc] initWithFrame:frame];
    [self addSubview:self.map];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.locationManager.location.coordinate, 5000, 5000);
    [self.map setRegion:region animated:NO];
    
    return self;
}
@end
