//
//  WYViewController.m
//  CustomPopAnimation
//
//  Created by wangyang on 6/11/14.
//  Copyright (c) 2014 wangyang. All rights reserved.
//

#import "WYViewController.h"
#import "UIViewControllerAdditions.h"

@interface WYViewController ()

@property (nonatomic, assign) BOOL navigationBarHidden;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;

@end

@implementation WYViewController

+ (WYViewController *)controller:(BOOL)navigationBarHidden {
    WYViewController *controller = [[WYViewController alloc] init];
    controller.navigationBarHidden = navigationBarHidden;
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    self.view.backgroundColor = [UIColor lightGrayColor];
    _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button1.backgroundColor = [UIColor blueColor];
    _button1.frame = CGRectMake(110, 100, 100, 50);
    [_button1 setTitle:@"Push1" forState:UIControlStateNormal];
    [_button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button1];
    
    _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button2.backgroundColor = [UIColor redColor];
    _button2.frame = CGRectMake(110, 200, 100, 50);
    [_button2 setTitle:@"Push2" forState:UIControlStateNormal];
    [_button2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button2];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:_navigationBarHidden];
}

- (BOOL)hasNavigationBar {
    return !_navigationBarHidden;
}

- (void)buttonClicked:(UIButton *)button {
    if (button == _button1) {
        [self.navigationController pushViewController:[WYViewController controller:YES] animated:YES];
    } else {
        [self.navigationController pushViewController:[WYViewController controller:NO] animated:YES];
    }
}

@end
