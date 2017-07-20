//
//  UILabel+HighlightWhenSelect.m
//  JeniusGame
//
//  Created by CIZ on 2017/7/14.
//  Copyright © 2017年 CIZ. All rights reserved.
//

#import "UILabel+HighlightWhenSelect.h"

@implementation UILabel (HighlightWhenSelect)

- (void)highlightWhenSelect:(BOOL)selected {
    if (selected) {
        [UIView transitionWithView:self duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.highlighted = YES;
        } completion:^(BOOL finished) {
            self.highlighted = NO;
        }];
    } else {
        self.highlighted = NO;
    }
}

@end
