//
//  SSTaskModel.h
//  JeniusGame
//
//  Created by CIZ on 2017/7/14.
//  Copyright © 2017年 CIZ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SSTaskHandler)();

@interface SSTaskModel : NSObject

@property (nonatomic, strong) NSString          *iconName;
@property (nonatomic, strong) NSString          *titleText;
@property (nonatomic, strong) NSString          *subtitleText;
@property (nonatomic, strong) UIColor           *textHighlightColor;
@property (nonatomic, strong) SSTaskHandler     taskHandler;

@end
