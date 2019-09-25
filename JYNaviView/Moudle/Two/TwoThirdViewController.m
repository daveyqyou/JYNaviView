//
//  TwoThirdViewController.m
//  JYNaviView
//
//  Created by DaveYou on 2019/9/25.
//  Copyright © 2019 DaveYou. All rights reserved.
//

#import "TwoThirdViewController.h"

@interface TwoThirdViewController ()

@end

@implementation TwoThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseNaviView.titleImageString = @"titleImageString";
    @weakify(self)
    self.baseNaviView.leftBtnClickedBlock = ^{
        @strongify(self)
        [self.navigationController popToRootViewControllerAnimated:YES];
    };
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //禁止返回手势，点击按钮返回root
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}


@end
