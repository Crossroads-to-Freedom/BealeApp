//
//  MapView.h
//  BealeApp
//
//  Created by Will Cobb on 2/25/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SQLiteManager.h"
#import "MapAnnotation.h"
#import "Building.h"
#import "MKAnnotationView+WebCache.h"
@interface MapView : UIView <MKMapViewDelegate>

@property id                  delegate;
@property MKMapView         * map;
@property CLLocationManager * locationManager;
@property SQLiteManager     * database;

-(id) initWithFrame:(CGRect)frame Delegate:(id) delegate LocationManager:(CLLocationManager *) locationManager Database:(SQLiteManager *) database;
-(void)presentBuildingInformationWithId:(NSInteger) buildingId;
@end
