//
//  WYNavigationController.m
//  CustomPopAnimation
//
//  Created by wangyang on 6/11/14.
//  Copyright (c) 2014 wangyang. All rights reserved.
//

#import "WYNavigationController.h"
#import "WYPageTransitionAnimator.h"
#import "UIViewControllerAdditions.h"

@interface WYNavigationController ()

@property (nonatomic, strong)WYPageTransitionAnimator *animator;
@property (nonatomic, strong)UIPercentDrivenInteractiveTransition* interactionController;
@property (nonatomic, strong)UIPanGestureRecognizer* panRecognizer;

@end

@implementation WYNavigationController

- (id)init {
    self = [super init];
    if (self) {
        self.delegate = self;
    }
    return self;
}
- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    self.delegate = self;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    _panRecognizer.delegate = self;
    [self.view addGestureRecognizer:_panRecognizer];
    self.animator = [[WYPageTransitionAnimator alloc] init];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count==1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - Actions

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (self.viewControllers.count > 1) {
                self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
                [self popViewControllerAnimated:YES];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:self.view];
            CGFloat percent = fabs(MAX(0, translation.x) / CGRectGetWidth(self.view.bounds));
            [self.interactionController updateInteractiveTransition:percent];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGPoint translation = [recognizer translationInView:self.view];
            CGFloat speed = [recognizer velocityInView:self.view].x;
            if (translation.x > self.view.frame.size.width/2 || speed > 100) {
                [self.interactionController finishInteractiveTransition];
            } else {
                [self.interactionController cancelInteractiveTransition];
            }
            self.interactionController = nil;
        }
            break;
            
        case UIGestureRecognizerStateCancelled:
        {
            [self.interactionController cancelInteractiveTransition];
            self.interactionController = nil;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    CAGradientLayer *shadow = [CAGradientLayer layer];
    shadow.frame = CGRectMake(-6, 0, 6, viewController.view.frame.size.height);
    shadow.startPoint = CGPointMake(1.0, 0.5);
    shadow.endPoint = CGPointMake(0, 0.5);
    shadow.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0.0 alpha:0.2f] CGColor], (id)[[UIColor clearColor] CGColor], nil];
    [viewController.view.layer addSublayer:shadow];
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    return self.interactionController;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        return self.animator;
    }
    return nil;
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.viewControllers.count > 1 && [self.topViewController popTransitionSupport];
}

@end
