//
//  MapAnnotation.m
//  EventBar
//
//  Created by Will Cobb on 7/3/14.
//  Copyright (c) 2014 Apprentice Media LLC. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation
@synthesize coordinate, titletext, subtitletext;  
  
- (NSString *)subtitle{  
    return subtitletext;  
}  
- (NSString *)title{  
    return titletext;  
}  
-(id) initWithTitle:(NSString *) title AndCoordinate:(CLLocationCoordinate2D) newCoordinate

{
    self = [super init];
    self.titletext = title;
    self.coordinate = newCoordinate;
    self.selected=NO;
    return self;
}
-(void)setTitle:(NSString*)strTitle {
    self.titletext = strTitle;  
}  
  
-(void)setSubTitle:(NSString*)strSubTitle {  
    self.subtitletext = strSubTitle;  
}  
  
-(id)initWithCoordinate:(CLLocationCoordinate2D) c{  
    coordinate=c;  
    return self;  
}  
@end 
