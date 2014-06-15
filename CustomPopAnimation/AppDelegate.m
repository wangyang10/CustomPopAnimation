//
//  AppDelegate.m
//  CustomPopAnimation
//
//  Created by wangyang on 6/11/14.
//  Copyright (c) 2014 wangyang. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = self.tabBarController;
    return YES;
}

- (WYTabBarController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [[WYTabBarController alloc] init];
    }
    return _tabBarController;
}

@end
