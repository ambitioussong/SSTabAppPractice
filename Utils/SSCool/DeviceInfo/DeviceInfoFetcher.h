//
//  DeviceInfoFetcher.h
//  GaomobiBox
//
//  Created by Ruozi on 11/16/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceInfoFetcher : NSObject

+ (NSString *)currentIDFV;
+ (NSString *)wrappedIDFV;
+ (NSString *)currentIDFA;
+ (NSString *)wrappedIDFA;
+ (NSString *)currentLanguage;
+ (NSString *)currentTimezone;
+ (NSString *)currentMCCMNC;
+ (NSString *)currentCarrierName;
+ (NSString *)currentCountryCode;
+ (NSString *)currentSystemVersion;
+ (NSString *)currentResolution;
+ (NSString *)currentVPNStatus;
+ (NSString *)currentDeviceName;

@end
