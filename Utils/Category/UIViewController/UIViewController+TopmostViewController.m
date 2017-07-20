//
//  UIViewController+TopmostViewController.m
//  iFun
//
//  Created by Mayqiyue on 10/28/15.
//  Copyright © 2015 AppFinder. All rights reserved.
//

#import "UIViewController+TopmostViewController.h"

@implementation UIViewController (TopmostViewController)

+ (UIViewController *)topmostViewController
{
    return [self _topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController*)_topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self _topViewControllerWithRootViewController:tabBarController.selectedViewController];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        return [self _topViewControllerWithRootViewController:navigationController.visibleViewController];
    }
    else if (rootViewController.presentedViewController) {
        UIViewController *presentedViewController = rootViewController.presentedViewController;
        return [self _topViewControllerWithRootViewController:presentedViewController];
    }
    else {
        return rootViewController;
    }
}

@end
