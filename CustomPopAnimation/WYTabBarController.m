//
//  WYTabBarController.m
//  CustomPopAnimation
//
//  Created by wangyang on 6/11/14.
//  Copyright (c) 2014 wangyang. All rights reserved.
//

#import "WYTabBarController.h"
#import "AppDelegate.h"
#import "WYViewController.h"
#import "UIViewControllerAdditions.h"

@implementation WYTabBarController

+ (WYTabBarController *)instance {
    WYTabBarController *instace = ((AppDelegate *)[UIApplication sharedApplication].delegate).tabBarController;
    return instace;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WYViewController *viewController1 = [[WYViewController alloc] init];
    viewController1.title = @"ONE";
    WYViewController *viewController2 = [[WYViewController alloc] init];
    viewController2.title = @"TWO";
    WYViewController *viewController3 = [[WYViewController alloc] init];
    viewController3.title = @"THREE";
    WYViewController *viewController4 = [[WYViewController alloc] init];
    viewController4.title = @"FOUR";
    self.viewControllers = @[viewController1.defaultNavigationController,
                             viewController2.defaultNavigationController,
                             viewController3.defaultNavigationController,
                             viewController4.defaultNavigationController
                             ];
}

@end
