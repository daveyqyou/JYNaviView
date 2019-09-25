//
//  FourViewController.m
//  JYNaviView
//
//  Created by DaveYou on 2019/9/25.
//  Copyright © 2019 DaveYou. All rights reserved.
//

#import "FourViewController.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseNaviView.titleString = @"第四个控制器";
    self.baseNaviView.jy_hiddenBackBtn = YES;
    self.baseNaviView.rightString = @"share_icon";
    self.baseNaviView.rightBtnClickedBlock = ^{
        NSLog(@"点击按钮");
    };
    self.baseNaviView.rightBtnEnabled = NO;
}

- (IBAction)rightEnable:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.baseNaviView.rightBtnEnabled = sender.selected;
}
@end
