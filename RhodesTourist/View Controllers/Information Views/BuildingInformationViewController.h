//
//  BuildingInformationView.h
//  RhodesTourist
//
//  Created by Will Cobb on 1/27/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Building.h"
@interface BuildingInformationViewController : UIViewController {
    
    UIView * navBarView;
    
}

@property Building * buildingData;
@property UIImageView * mainImage;
@property UIView      * descriptionView;
@property UIView      * choicesView;

@end
