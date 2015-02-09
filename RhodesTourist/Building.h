//
//  Building.h
//  RhodesTourist
//
//  Created by Will Cobb on 9/4/14.
//  Copyright (c) 2014 Apprentice Media LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import "CLLocation+Utils.h"
#import "Asset.h"
@interface Building : NSObject {
    
}
- (id)initWithData:(NSMutableDictionary *) data;
- (BOOL) isInViewOfHeading:(CGFloat) heading Location:(CLLocation *) location;
- (BOOL) isInside:(CLLocation *) location;
-(BOOL) isBehind:(Building *) other Location:(CLLocation *) location;
- (CGFloat) bearingToBuilding:(CGFloat) heading Location:(CLLocation *) location;
- (void) updateBuildingLabelWithUserLocation:(CLLocation *) userLocation Heading:(CGFloat) heading Motion: (CMDeviceMotion *) deviceMotion;

@property CLLocation * location;
@property NSString   * name;
@property CGFloat      buildingId;
@property NSMutableArray * assets;
@property NSMutableArray * bounds;
@property UILabel    * buildingLabel;
@property UILabel       * distanceLabel;

@end
