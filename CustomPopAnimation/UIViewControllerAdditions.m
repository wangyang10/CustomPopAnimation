//
//  UIViewControllerAdditions.m
//  CustomPopAnimation
//
//  Created by wangyang on 6/11/14.
//  Copyright (c) 2014 wangyang. All rights reserved.
//

#import "UIViewControllerAdditions.h"
#import "WYNavigationController.h"

@implementation UIViewController (Addtions)

- (WYNavigationController *)defaultNavigationController {
    if ([self isKindOfClass:[UINavigationController class]]) {
        return (WYNavigationController *)self;
    }else if (self.navigationController) {
        return (WYNavigationController *)self.navigationController;
    }
    
    WYNavigationController *navController = [[WYNavigationController alloc] initWithRootViewController:self];
    
    return navController;
}

- (BOOL)hasNavigationBar {
    return YES;
}

- (BOOL)popTransitionSupport {
    return YES;
}

@end
