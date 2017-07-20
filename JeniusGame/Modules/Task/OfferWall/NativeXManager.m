//
//  NativeXManager.m
//  iFun
//
//  Created by Mayqiyue on 10/28/15.
//  Copyright © 2015 AppFinder. All rights reserved.
//

#import "NativeXManager.h"
#import <NativeXSDK.h>
#import "UIViewController+TopmostViewController.h"
#import "DeviceInfoFetcher.h"
#import "NSString+md5.h"
#import "UIView+PinToast.h"

#define kViewBackgroundColor ([UIColor colorWithRed:218.0f/255.0f green:220.0f/255.0f blue:224.0f/255.0f alpha:1.0f])
#define kFakeNavigationColor ([UIColor hexStringToColor:@"07070A" alpha:0.7f])

@interface NativeXManager() <NativeXSDKDelegate, NativeXAdEventDelegate, NativeXRewardDelegate>

@property (nonatomic, assign) BOOL isInstantFetchingToShow;

@end


@implementation NativeXManager

#pragma mark - Public Method

+ (instancetype)sharedInstance {
    static NativeXManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[NativeXManager alloc] init];
    });
    
    return _instance;
}

#pragma mark - Public

- (void)start {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *appid = @"125258";
        NSString *user_id = @"shuai_song";
        NSString *device_id = [DeviceInfoFetcher wrappedIDFV];
        NSString *advertise_id = [DeviceInfoFetcher wrappedIDFA];
        NSString *client_name = @"iOS_InstaGift";
        // Add verify params
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *launchTimestamp = [dateFormatter stringFromDate:date];
        NSString *composedString = [NSString stringWithFormat:@"%@%@%@", user_id, appid, launchTimestamp];
        NSString *verifyString = [composedString md5];
        NSString *publisherUserId = [NSString stringWithFormat:@"%@-%@-%@-%@-%@-%@", user_id, device_id, advertise_id, client_name, verifyString, launchTimestamp];
        
        [NativeXSDK initializeWithAppId:appid andPublisherUserId:publisherUserId andSDKDelegate:self andRewardDelegate:self];
        
#ifdef DEBUG
        [NativeXSDK enableDebugLog:YES];
#endif
    });
}

- (void)showOfferwall {
    if (![NativeXSDK isAdFetchedWithPlacement:kAdPlacementStoreOpen]) {
        self.isInstantFetchingToShow = YES;
        [NativeXSDK fetchAdWithPlacement:kAdPlacementStoreOpen andFetchDelegate:self];
    } else {
        self.isInstantFetchingToShow = NO;
        [NativeXSDK showAdWithPlacement:kAdPlacementStoreOpen andShowDelegate:self];
    }
}

- (void)setIsInstantFetchingToShow:(BOOL)isInstantFetchingToShow {
    _isInstantFetchingToShow = isInstantFetchingToShow;
    
    if (_isInstantFetchingToShow) {
        [[UIViewController topmostViewController].view makeToastActivity:CSToastPositionCenter];
        [UIViewController topmostViewController].view.userInteractionEnabled = NO;
    } else {
        [[UIViewController topmostViewController].view hideToastActivity];
        [UIViewController topmostViewController].view.userInteractionEnabled = YES;
    }
}

#pragma mark - <NativeXSDKDelegate>

- (void)nativeXSDKInitialized {
    NSLog(@"【NativeX】Wahoo! SDK is initialized; Ads that were set to fetch automatically should now be fetched!");
    
    [NativeXSDK fetchAdWithPlacement:kAdPlacementStoreOpen andFetchDelegate:self];
}

- (void)nativeXSDKFailedToInitializeWithError:(NSError *)error {
    NSLog(@"【NativeX】Oh no! Something isn't set up correctly - re-read the documentation or ask customer support for help https://selfservice.nativex.com/Help \n Error: %@", error);
}

#pragma mark - <NativeXAdEventDelegate> - Fetch delegate callbacks

- (void)adFetched:(NSString *)placementName {
    NSLog(@"【NativeX】Placement '%@': Ad is fetched, and is ready to be shown!", placementName);
    
    if (self.isInstantFetchingToShow) {
        self.isInstantFetchingToShow = NO;
        [NativeXSDK showAdWithPlacement:kAdPlacementStoreOpen andShowDelegate:self];
    }
}

- (void)noAdAvailable:(NSString *)placementName {
    NSLog(@"【NativeX】Placement '%@': No ad is available to be shown at this time.", placementName);
   
    if (self.isInstantFetchingToShow) {
        self.isInstantFetchingToShow = NO;
        [[UIViewController topmostViewController].view makePinToast:@"No ad is available now"];
    }
}

- (void)adFetchFailed:(NSString *)placementName withError:(NSError *)error {
    NSLog(@"【NativeX】Uh Oh, something happened with the ad fetch for placement '%@'.. \nError: %@", placementName, error);
   
    if (self.isInstantFetchingToShow) {
        self.isInstantFetchingToShow = NO;
        [[UIViewController topmostViewController].view makePinToast:@"Failed to load, try again later"];
    }
}

- (void)adExpired:(NSString*)placementName {
    NSLog(@"【NativeX】ad expired, need refetch");
    
    [NativeXSDK fetchAdWithPlacement:kAdPlacementStoreOpen andFetchDelegate:self];
}

#pragma mark - <NativeXAdEventDelegate> - Show delegate callbacks

- (void)adShown:(NSString *)placementName {
    NSLog(@"【NativeX】ad shown with placement name: %@", placementName);
}

// called when the ad fails to show
- (void)adFailedToShow:(NSString *)placementName withError:(NSError *)error {
    NSLog(@"【NativeX】ad failed to show with placement name: %@", placementName);
}

// called after the ad has dismissed
- (void)adDismissed:(NSString *)placementName converted:(BOOL)converted {
    [NativeXSDK fetchAdWithPlacement:kAdPlacementStoreOpen andFetchDelegate:self];
}

#pragma mark - <NativeXRewardDelegate> protocol implementation

- (void)rewardAvailable:(NativeXRewardInfo *)rewardInfo {
    NSLog(@"【NativeX】has get nativex reward %@", rewardInfo);
}

@end
