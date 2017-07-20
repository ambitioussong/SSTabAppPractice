//
//  SSTaskHomeDataController.m
//  JeniusGame
//
//  Created by CIZ on 2017/7/14.
//  Copyright © 2017年 CIZ. All rights reserved.
//

#import "SSTaskHomeDataController.h"
#import "NativeXManager.h"

@interface SSTaskHomeDataController ()

@property (nonatomic, strong) NSMutableArray<SSTaskModel *> *mTaskItems;

@end


@implementation SSTaskHomeDataController

+ (instancetype)sharedInstance {
    static SSTaskHomeDataController *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[SSTaskHomeDataController alloc] init];
    });
    
    return _instance;
}

- (void)loadTaskData {
    SSTaskModel *taskModel = [[SSTaskModel alloc] init];
    taskModel.iconName = @"image_task_nx";
    taskModel.titleText = @"Native X";
    taskModel.subtitleText = @"Many tasks inside";
    taskModel.textHighlightColor = [UIColor redColor];
    taskModel.taskHandler = ^(){
        [[NativeXManager sharedInstance] showOfferwall];
    };
    [self.mTaskItems addObject:taskModel];
}

#pragma mark - Getters

- (NSMutableArray<SSTaskModel *> *)mTaskItems {
    if (!_mTaskItems) {
        _mTaskItems = [NSMutableArray<SSTaskModel *> new];
    }
    return _mTaskItems;
}

- (NSArray<SSTaskModel *> *)taskItems {
    return [NSArray arrayWithArray:self.mTaskItems];
}

@end
