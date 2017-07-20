//
//  SSTaskTableViewCell.h
//  JeniusGame
//
//  Created by CIZ on 2017/7/14.
//  Copyright © 2017年 CIZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSTaskModel.h"

@interface SSTaskTableViewCell : UITableViewCell

- (void)renderWithTaskModel:(SSTaskModel *)taskModel;

@end
