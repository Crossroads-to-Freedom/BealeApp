//
//  AVCamPreviewView.h
//  EventBar
//
//  Created by Will Cobb on 7/29/14.
//  Copyright (c) 2014 Apprentice Media LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVCaptureSession;

@interface AVCamPreviewView : UIView

@property (nonatomic) AVCaptureSession *session;

@end
