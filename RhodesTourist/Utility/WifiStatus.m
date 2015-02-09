#import <Foundation/Foundation.h>
 
#import <ifaddrs.h>
#import <net/if.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "WifiStatus.h"
 
@implementation WifiStatus
 
- (BOOL) isWiFiEnabled {
    NSCountedSet * cset = [NSCountedSet new];
    struct ifaddrs *interfaces;
    if( ! getifaddrs(&interfaces) ) {
        for( struct ifaddrs *interface = interfaces; interface; interface = interface->ifa_next) {
            if ( (interface->ifa_flags & IFF_UP) == IFF_UP ) {
                [cset addObject:[NSString stringWithUTF8String:interface->ifa_name]];
            }
        }
    }
    return [cset countForObject:@"awdl0"] > 1 ? YES : NO;
}
 
- (NSDictionary *) wifiDetails {
    return
    (__bridge NSDictionary *) CNCopyCurrentNetworkInfo(
        CFArrayGetValueAtIndex( CNCopySupportedInterfaces(), 0)
    );
}
 
- (BOOL) isWiFiConnected {
    return [self wifiDetails] == nil ? NO : YES;
}
 
- (NSString *) BSSID {
    return [self wifiDetails][@"BSSID"];
}
 
- (NSString *) SSID {
    return [self wifiDetails][@"SSID"];
}
 
@end