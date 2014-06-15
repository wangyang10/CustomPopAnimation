//
//  UIViewControllerAdditions.h
//  CustomPopAnimation
//
//  Created by wangyang on 6/11/14.
//  Copyright (c) 2014 wangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYNavigationController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface UIViewController (Addtions)

- (WYNavigationController *)defaultNavigationController;
- (BOOL)hasNavigationBar;
- (BOOL)popTransitionSupport;

@end
