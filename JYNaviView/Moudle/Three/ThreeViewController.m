//
//  ThreeViewController.m
//  JYNaviView
//
//  Created by DaveYou on 2019/9/25.
//  Copyright © 2019 DaveYou. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseNaviView.titleString = @"第三个控制器";
    //self.baseNaviView.jy_hiddenBackBtn = YES;
    self.baseNaviView.rightImage = @"share_icon";
    self.baseNaviView.rightBtnClickedBlock = ^{
        NSLog(@"点击分享");
    };
}

@end
