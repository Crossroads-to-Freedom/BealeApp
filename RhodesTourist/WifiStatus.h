//
//  WifiStatus.h
//  CrossRoads
//
//  Created by Will Cobb on 12/13/14.
//  Copyright (c) 2014 Apprentice Media LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WifiStatus : NSObject

- (BOOL) isWiFiEnabled;
- (BOOL) isWiFiConnected;
- (NSString *) BSSID;
- (NSString *) SSID;
@end
