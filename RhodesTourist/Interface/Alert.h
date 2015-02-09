//
//  Alert.h
//  BealeApp
//
//  Created by Will Cobb on 1/15/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Alert : NSObject {
    
    BOOL showingAlert;
    
    UIView * alertView;
    UIView * superView;
    NSMutableArray * alertQue;
}

-(id) initWithSUperView:(UIView *) superView;
-(void) alert:(NSString *) alertText;

@end
