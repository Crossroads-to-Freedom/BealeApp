//
//  Alert.m
//  BealeApp
//
//  Created by Will Cobb on 1/15/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import "Alert.h"

@implementation Alert

-(id) initWithSUperView:(UIView *) newSuperView
{
    if ((self = [super init])) {
        showingAlert = NO;
        superView = newSuperView;
        alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, newSuperView.frame.size.width, 64)];
    }
    return self;
}

-(void) alert:(NSString *)alertMessage
{
    //Puts alerts into a Que to show one at a time
    if (!showingAlert)
    {
        showingAlert = YES;
        alertView.backgroundColor = [UIColor redColor];
        alertView.layer.zPosition = 11;
        [superView addSubview:alertView];
        
        UILabel * alertText = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, alertView.frame.size.width-15, alertView.frame.size.height-10)];
        alertText.textAlignment = NSTextAlignmentCenter;
        alertText.numberOfLines = 2;
        alertText.minimumFontSize = 8.;
        alertText.adjustsFontSizeToFitWidth = YES;
        alertText.font = [UIFont boldSystemFontOfSize:14];
        alertText.textColor = [UIColor whiteColor];
        alertText.text = alertMessage;
        [alertView addSubview:alertText];
        
        [UIView animateWithDuration:0.2 delay:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
                alertView.frame = CGRectMake(0, 0, alertView.frame.size.width, alertView.frame.size.height);
            } completion:nil];
        
        [UIView animateWithDuration:0.2 delay:4.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
                alertView.frame = CGRectMake(0, -alertView.frame.size.height, alertView.frame.size.width, alertView.frame.size.height);
         } completion:^(BOOL finished){
                [alertView removeFromSuperview];
                if (alertQue && [alertQue count])
                {
                    NSString * next = alertQue[0];
                    [alertQue removeObjectAtIndex:0];
                    showingAlert = NO;
                    [alertText removeFromSuperview];
                    [self alert:next];
                }
         }];
    }
    else
    {
        if (!alertQue)
            alertQue = [NSMutableArray new];
        [alertQue addObject:alertMessage];
    }
    
    
}
@end
