//
//  SSTaskHomeDataController.h
//  JeniusGame
//
//  Created by CIZ on 2017/7/14.
//  Copyright © 2017年 CIZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSTaskModel.h"

@interface SSTaskHomeDataController : NSObject

@property (nonatomic, strong, readonly) NSArray<SSTaskModel *> *taskItems;

+ (instancetype)sharedInstance;
- (void)loadTaskData;

@end
