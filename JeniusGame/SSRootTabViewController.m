//
//  SSRootTabViewController.m
//  JeniusGame
//
//  Created by CIZ on 2017/7/12.
//  Copyright © 2017年 CIZ. All rights reserved.
//

#import "SSRootTabViewController.h"
#import "SSProfileHomeViewController.h"
#import "SSTaskHomeViewController.h"
#import "SSRecordHomeViewController.h"

@interface SSRootTabViewController ()<UITabBarControllerDelegate>

@end

@implementation SSRootTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureViews {
    self.delegate = self;
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    SSProfileHomeViewController *profileHomeVC = [[SSProfileHomeViewController alloc] init];
    UINavigationController *profileRootVC = [[UINavigationController alloc] initWithRootViewController:profileHomeVC];
    // 设置了VC的title后，Tab中的title会被动变成与其一致
    profileRootVC.tabBarItem.title = @"Profile";
    
    SSTaskHomeViewController *taskHomeVC = [[SSTaskHomeViewController alloc] init];
    UINavigationController *taskRootVC = [[UINavigationController alloc] initWithRootViewController:taskHomeVC];
    taskRootVC.tabBarItem.title = @"Tasks";
    
    SSRecordHomeViewController *recordHomeVC = [[SSRecordHomeViewController alloc] init];
    UINavigationController *recordRootVC = [[UINavigationController alloc] initWithRootViewController:recordHomeVC];
    recordRootVC.tabBarItem.title = @"Records";
    
    self.viewControllers = @[profileRootVC, taskRootVC, recordRootVC];
    self.selectedIndex = 0;
    
//    [self.tabBar setTintColor:[UIColor redColor]];
//    [self.tabBar setBarTintColor:[UIColor greenColor]];
//    profileRootVC.tabBarItem.badgeValue = @"Tips";
}

- (void)animateTabBarController:(UITabBarController *)tabBarController switchFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    
    BOOL scrollToRight = toIndex > fromIndex;
    UIView *fromView = tabBarController.selectedViewController.view;
    UIView *toView = tabBarController.viewControllers[toIndex].view;
    [fromView.superview addSubview:toView];
    
    CGFloat xOffset = scrollToRight ? CGRectGetWidth(toView.bounds) : -CGRectGetWidth(toView.bounds);
    toView.transform = CGAffineTransformMakeTranslation(xOffset, 0);
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         CGFloat xOffset = scrollToRight ? -CGRectGetWidth(fromView.bounds) : CGRectGetWidth(fromView.bounds);
                         fromView.transform = CGAffineTransformMakeTranslation(xOffset, 0);
                         toView.transform = CGAffineTransformIdentity;
                     }
     
                     completion:^(BOOL finished) {
                         
                         if (finished) {
                             [fromView removeFromSuperview];
                             tabBarController.selectedIndex = toIndex;
                         }
                     }];
}

#pragma mark - <UITabBarControllerDelegate>

- (BOOL)tabBarController:(UITabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController {
    
    // http://stackoverflow.com/questions/5161730/iphone-how-to-switch-tabs-with-an-animation
    NSUInteger fromIndex = tabBarController.selectedIndex;
    NSUInteger toIndex = [tabBarController.viewControllers indexOfObject:viewController];
    [self animateTabBarController:tabBarController switchFromIndex:fromIndex toIndex:toIndex];
    
    return NO;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//    NSLog(@"Select tab index:%ld", tabBarController.selectedIndex);
}

@end
