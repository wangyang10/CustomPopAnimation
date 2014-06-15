//
//  WYPageTransitionAnimator.m
//  CustomPopAnimation
//
//  Created by wangyang on 6/12/14.
//  Copyright (c) 2014 wangyang. All rights reserved.
//

#import "WYPageTransitionAnimator.h"
#import "WYTabBarController.h"
#import "UIViewControllerAdditions.h"

@implementation WYPageTransitionAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UITabBarController *tabBarController = [WYTabBarController instance];
    UIView *tabbarView = tabBarController.tabBar;
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *toView = toViewController.view;
    UIView *fromView = fromViewController.view;
    
    CGRect toFrame = toView.frame;
    CGRect tabbarFrame = tabbarView.frame;
    CGRect fromFrame = fromView.frame;
    BOOL toNavigationBarHidden = [toViewController hasNavigationBar];
    BOOL fromNavigationBarHidden = [fromViewController hasNavigationBar];
    if (toNavigationBarHidden != fromNavigationBarHidden) {
        if (toNavigationBarHidden) {
            toFrame.origin.y += 64;
            toFrame.size.height -= 64;
            toView.frame = toFrame;
        } else {
            toFrame.origin.y -= 64;
            toFrame.size.height += 64;
            toView.frame = toFrame;
        }
    }
    toFrame.origin.x = -SCREEN_WIDTH*1/4;
    toView.frame = toFrame;
    
    tabbarView.frame = CGRectMake(toFrame.origin.x, tabbarFrame.origin.y, tabbarFrame.size.width, tabbarFrame.size.height);
    [[transitionContext containerView] addSubview:toView];
    [[transitionContext containerView] addSubview:tabbarView];
    [[transitionContext containerView] addSubview:fromView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = CGRectMake(0, toFrame.origin.y, toFrame.size.width, toFrame.size.height);
        fromView.frame = CGRectMake(SCREEN_WIDTH, fromFrame.origin.y, fromFrame.size.width, fromFrame.size.height);
        tabbarView.frame = CGRectMake(0, tabbarFrame.origin.y, tabbarFrame.size.width, tabbarFrame.size.height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        tabbarView.frame = CGRectMake(0, tabbarFrame.origin.y, tabbarFrame.size.width, tabbarFrame.size.height);
        [tabBarController.view addSubview:tabbarView];
    }];
}

@end
