//
//  MapAnnotation.h
//  EventBar
//
//  Created by Will Cobb on 7/3/14.
//  Copyright (c) 2014 Apprentice Media LLC. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>  
  
  
@interface MapAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;  
    NSString *subtitletext;  
    NSString *titletext;
    NSInteger tag;
}
@property NSInteger tag;
@property BOOL selected;
@property  (nonatomic) CLLocationCoordinate2D coordinate;
@property  NSString *titletext;
@property  NSString *subtitletext;
-(id) initWithTitle:(NSString *) title AndCoordinate:(CLLocationCoordinate2D) newCoordinate;
-(id)initWithCoordinate:(CLLocationCoordinate2D) coordinate;  
- (NSString *)subtitle;  
- (NSString *)title;  
-(void)setTitle:(NSString*)strTitle;  
-(void)setSubTitle:(NSString*)strSubTitle;  
  
@end  

