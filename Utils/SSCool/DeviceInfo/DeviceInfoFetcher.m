//
//  DeviceInfoFetcher.m
//  GaomobiBox
//
//  Created by Ruozi on 11/16/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import "DeviceInfoFetcher.h"
#import <AdSupport/AdSupport.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#include <sys/cdefs.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#import <ifaddrs.h>
#import "NSString+md5.h"

@implementation DeviceInfoFetcher

+ (NSString *)currentIDFV {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (NSString *)wrappedIDFV {
    return [DeviceInfoFetcher currentIDFV].md5;
}

+ (NSString *)currentIDFA {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (NSString *)wrappedIDFA {
    return [DeviceInfoFetcher currentIDFA].md5;
}

+ (NSString *)currentLanguage {
#ifdef DEBUG
    return @"en";
#endif
    return [[NSLocale currentLocale] objectForKey: NSLocaleLanguageCode];
}

+ (NSString *)currentTimezone {
#ifdef DEBUG
    return @"-8";
#endif
    NSDate *sourceDate = [NSDate date];
    NSTimeZone *systemTimeZone = [NSTimeZone systemTimeZone];
    int timeZoneOffset = (int)[systemTimeZone secondsFromGMTForDate:sourceDate] / 3600;
    NSString *timeOffset = [NSString stringWithFormat:@"%d",timeZoneOffset];
    return timeOffset;
}

+ (NSString *)currentCarrierName {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;
    
    NSString *carrierName = carrier.carrierName;
    carrierName = (carrierName.length > 0) ? carrierName : @"empty";
    
    return carrierName;
}

+ (NSString *)currentMCCMNC {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;
    
    NSString *mobileCountryCode = [carrier mobileCountryCode];
    NSString *mobileNetworkCode = [carrier mobileNetworkCode];
    
    mobileCountryCode = (mobileCountryCode.length > 0) ? mobileCountryCode : @"empty";
    mobileNetworkCode = (mobileNetworkCode.length > 0) ? mobileNetworkCode : @"empty";
    
    NSString *MCCMNC = [NSString stringWithFormat:@"%@_%@", mobileCountryCode, mobileNetworkCode];
    return MCCMNC;
}

+ (NSString *)currentCountryCode {
    NSString *currentCountry = [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
    if(nil == currentCountry)
    {
        return @"Unknown";
    }
    return currentCountry;
}

+ (NSString *)currentSystemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)currentResolution {
    return [NSString stringWithFormat:@"%@*%@",
            @(CGRectGetWidth([UIScreen mainScreen].nativeBounds)),
            @(CGRectGetHeight([UIScreen mainScreen].nativeBounds))];
}

+ (NSString *)currentVPNStatus {
    if ([DeviceInfoFetcher throughThirdParty] && [DeviceInfoFetcher throughBroker]) {
        return @"VPN&proxy";
    } else if ([DeviceInfoFetcher throughThirdParty]) {
        return @"VPN";
    } else if ([DeviceInfoFetcher throughBroker]) {
        return @"proxy";
    } else {
        return @"no";
    }
}

+ (NSString *)currentDeviceName {
    return [[UIDevice currentDevice] name];
}

// Detect VPN
+ (BOOL)throughThirdParty
{
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0f)) {
        NSDictionary *dict = CFBridgingRelease(CFNetworkCopySystemProxySettings());
        NSArray *keys = [dict[@"__SCOPED__"]allKeys];
        for (NSString *key in keys) {
            if ([key rangeOfString:@"tap"].location != NSNotFound ||
                [key rangeOfString:@"tun"].location != NSNotFound ||
                [key rangeOfString:@"ppp"].location != NSNotFound) {
                return YES;
            }
        }
        return NO;
    } else {
        struct ifaddrs *interfaces = NULL;
        struct ifaddrs *temp_addr = NULL;
        int success = 0;
        
        // retrieve the current interfaces - returns 0 on success
        success = getifaddrs(&interfaces);
        if (success == 0) {
            // Loop through linked list of interfaces
            temp_addr = interfaces;
            while (temp_addr != NULL) {
                NSString *string = [NSString stringWithFormat:@"%s" , temp_addr->ifa_name];
                if ([string rangeOfString:@"tap"].location != NSNotFound ||
                    [string rangeOfString:@"tun"].location != NSNotFound ||
                    [string rangeOfString:@"ppp"].location != NSNotFound) {
                    freeifaddrs(interfaces);
                    return YES;
                }
                temp_addr = temp_addr->ifa_next;
            }
        }
        
        // Free memory
        freeifaddrs(interfaces);
        return NO;
    }
}

// Detect Proxy
+ (BOOL)throughBroker {
    CFDictionaryRef dictRef = CFNetworkCopySystemProxySettings();
    NSDictionary *dict = (__bridge NSDictionary*)dictRef;
    if ([dict objectForKey:@"HTTPSProxy"]) {
        return YES;
    } else {
        return NO;
    }
}

@end
