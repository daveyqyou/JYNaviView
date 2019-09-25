//
//  OneViewController.m
//  JYNaviView
//
//  Created by DaveYou on 2019/9/25.
//  Copyright © 2019 DaveYou. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseNaviView.titleString = @"第一个控制器";
    self.baseNaviView.jy_hiddenBackBtn = YES; //不展示返回按钮
}


@end
