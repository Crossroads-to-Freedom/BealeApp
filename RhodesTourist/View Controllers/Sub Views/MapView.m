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
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(35.139637, -90.052273), 1000, 1000);
    [self.map setRegion:region animated:NO];
    self.map.delegate = self;
    
    for (Building * b in self.database.buildingList) {
        MapAnnotation *annotation = [[MapAnnotation alloc]initWithTitle:b.name AndCoordinate:b.location.coordinate];
        annotation.tag = b.Id;
        [self.map addAnnotation:annotation];
    }
    
    return self;
}

- (void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MapAnnotation *)view
{
    [self.delegate presentBuildingInformationWithId:view.tag];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    static NSString *const kAnnotationReuseIdentifier = @"MapAnnotationView";
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:kAnnotationReuseIdentifier];
    MapAnnotation * myAnnotation = (MapAnnotation *)annotation;
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kAnnotationReuseIdentifier];
        //annotationView = myAnnotation;
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.tag = myAnnotation.tag;
        //annotationView.image = [UIImage imageNamed:@"MapAnnotation.png"];
        
        //annotationView.image
        Building * building = self.database.buildingList[myAnnotation.tag];
        [annotationView addSubview:[building.icon assetImageViewWithSize:CGSizeMake(20, 20)]];
        [annotationView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", building.icon.imageUrl]]];
        
    }
    return annotationView;
}

- (void)removeAllPinsButUserLocation
{
    id userLocation = [self.map userLocation];
    NSMutableArray *pins = [[NSMutableArray alloc] initWithArray:[self.map annotations]];
    if ( userLocation != nil ) {
        [pins removeObject:userLocation]; // avoid removing user location off the map
    }
    
    [self.map removeAnnotations:pins];
}



@end
