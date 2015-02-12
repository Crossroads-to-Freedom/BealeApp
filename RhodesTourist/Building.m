//
//  Building.m
//  RhodesTourist
//
//  Created by Will Cobb on 9/4/14.
//  Copyright (c) 2014 Apprentice Media LLC. All rights reserved.
//
//http://alienryderflex.com/polygon/

//http://crossroadstofreedom.org/view.player?&pid=rds:76187

//http://theultralinx.com/2013/06/22-beautiful-ios-app-concepts-dribbble.html

#import "Building.h"

@implementation Building

- (id)initWithData:(NSMutableDictionary *) data {
    if ((self = [super init])) {
        self.location     = [[CLLocation alloc] initWithLatitude:[data[@"lat"] floatValue] longitude:[data[@"lon"] floatValue]];
        self.name         = data[@"name"];
        self.buildingId   = [data[@"id"] longValue];
        self.bounds       = data[@"bounds"];
        self.buildingLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 59)];
        self.buildingLabel.text = self.name;
        self.buildingLabel.textAlignment = NSTextAlignmentCenter;
        self.buildingLabel.textColor = [UIColor whiteColor];
        self.buildingLabel.clipsToBounds = NO;
        
        self.distanceLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 59)];
        self.distanceLabel.textAlignment = NSTextAlignmentCenter;
        self.distanceLabel.textColor = [UIColor whiteColor];
        self.distanceLabel.clipsToBounds = NO;
        
        self.assets = [NSMutableArray new];
        //Load assets
        for (NSDictionary * assetDict in data[@"assets"]) {
            if ([assetDict[@"type"] integerValue] == 1) { //Article
                [self.assets addObject:[[Asset alloc] initWithArticle:[assetDict[@"rds"] integerValue]]];
            } else if ([assetDict[@"type"] integerValue] == 2) { //Interview
                [self.assets addObject:[[Asset alloc] initWithInterview:[assetDict[@"rds"] integerValue] Segments:assetDict[@"segments"]]];
            }
            
        }
        
        
    }
    return self;
}

-(BOOL) isInViewOfHeading:(CGFloat) heading Location:(CLLocation *) location
{
    for (int i=0; i<[self.bounds count]+1; i++) {
        //NSLog(@"1 %d", (i ) % ((int)[building.bounds count]));
        //NSLog(@"2 %d", (i + 1) % ((int)[building.bounds count]));
        //NSLog(@" ");
        NSString * latlong1 = self.bounds[ i      % ((int)[self.bounds count])];
        NSString * latlong2 = self.bounds[(i + 1) % ((int)[self.bounds count])];
        
        NSArray * latlongArray1 = [latlong1 componentsSeparatedByString:@","];
        NSArray * latlongArray2 = [latlong2 componentsSeparatedByString:@","];
        
        //float bearing = [self.locationManager.location initialBearingToLocation:building.location];
        float bearingToLatlong1 = [location initialBearingToLocation:[[CLLocation alloc] initWithLatitude:[latlongArray1[0] floatValue]
                                                                                                                      longitude:[latlongArray1[1] floatValue]]];
        float bearingToLatlong2 = [location initialBearingToLocation:[[CLLocation alloc] initWithLatitude:[latlongArray2[0] floatValue]
                                                                                                                      longitude:[latlongArray2[1] floatValue]]];
        if ((heading < bearingToLatlong1 && heading > bearingToLatlong2) || (heading > bearingToLatlong1 && heading < bearingToLatlong2)) { //Needs Distance
            return YES;
        }
    }
    return NO;
}

-(CGFloat) bearingToBuilding:(CGFloat) heading Location:(CLLocation *) location
{
    float bearingToBuilding = [location initialBearingToLocation:self.location];
    return bearingToBuilding;
}

- (void) updateBuildingLabelWithUserLocation:(CLLocation *) userLocation Heading:(CGFloat) heading Motion: (CMDeviceMotion *) deviceMotion
{
    CGFloat width = 320; //!!!!!!Needs to be frame width... will break on iphone 6 and 6+
    CGFloat angle = -(atan2(deviceMotion.gravity.y, deviceMotion.gravity.x) + M_PI_2);
    //heading -= M_PI_2;
    CGFloat y = 200 + 590 * deviceMotion.gravity.z;
    
    CGFloat bearing = [self bearingToBuilding:heading Location:userLocation];
    if (bearing < 0)
        bearing += 360;
    if (heading < 0)
        heading += 360;
    CGFloat offset = bearing - heading;
    
    if (fabs(offset) > 180)
        offset = 360 - fabs(offset);
    
    
    CGFloat x = 160 + (offset - 90 * sin(angle)) * (width/30); //screen size/FoV
    if (fabs(x - self.buildingLabel.center.x)>1 || fabs(y - self.buildingLabel.center.y)>1) { //Offset enough to move
        /* Rotation to be added later maybe
        CALayer *layer = building.buildingLabel.layer;
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m34 = 1.0 / -500;
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, offset/10.0, 0.0f, 1.0f, 0.0f);
        NSLog(@"%f", motionManager.deviceMotion.gravity.z);
        layer.transform = rotationAndPerspectiveTransform;*/
        self.buildingLabel.font = [UIFont boldSystemFontOfSize:250/sqrt([userLocation distanceFromLocation:self.location])];
        self.distanceLabel.font = [UIFont systemFontOfSize:150/sqrt([userLocation distanceFromLocation:self.location])];
        [self.buildingLabel sizeToFit];
        
        CGFloat distance = [self.location distanceFromLocation:userLocation] * 3.28; //Meters to feet
        self.distanceLabel.text = [NSString stringWithFormat:@"%i Feet", (int)distance];
        self.buildingLabel.center = CGPointMake(x, y);
        //NSLog(@"%f %f", self.buildingLabel.center.x, self.buildingLabel.center.y);
        self.distanceLabel.center = CGPointMake(x, y + self.buildingLabel.frame.size.height);
        
    }
}

-(BOOL) isBehind:(Building *) other Location:(CLLocation *) location
{
    return fabs([self.location initialBearingToLocation:location] - [other.location initialBearingToLocation:location]) <5
        && [self.location distanceFromLocation:location] > [other.location distanceFromLocation:location];
}

-(BOOL) isInside:(CLLocation *) location
{
    int i, j=(int)[self.bounds count]-1;
    float x = location.coordinate.latitude;
    float y = location.coordinate.longitude;
    bool  oddNodes=NO;
    
    float polyY[(int)[self.bounds count]];
    float polyX[(int)[self.bounds count]];

    //Create lat and long arrays
    for (int k=0; k<[self.bounds count]; k++) {
        NSArray * latlong = [self.bounds[k] componentsSeparatedByString:@","];
        polyX[k] = [latlong[0] floatValue];
        polyY[k] = [latlong[1] floatValue];
        
    }
    
    for (i=0; i<[self.bounds count]; i++) {
        if ((polyY[i]<y && polyY[j]>=y) || (polyY[j]<y && polyY[i]>=y)) {
            if (polyX[i]+(y-polyY[i])/(polyY[j]-polyY[i])*(polyX[j]-polyX[i])<x) {
                oddNodes=!oddNodes;
            }
        }
        j=i;
    }

  return oddNodes;
  
}



@end
