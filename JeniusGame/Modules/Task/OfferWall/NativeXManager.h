//
//  NativeXManager.h
//  iFun
//
//  Created by Mayqiyue on 10/28/15.
//  Copyright © 2015 AppFinder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NativeXManager : NSObject

+ (instancetype)sharedInstance;

- (void)start;
- (void)showOfferwall;

@end
