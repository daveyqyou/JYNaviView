//
//  TwoDetailViewController.m
//  JYNaviView
//
//  Created by DaveYou on 2019/9/25.
//  Copyright © 2019 DaveYou. All rights reserved.
//

#import "TwoDetailViewController.h"
#import "TwoThirdViewController.h"

@interface TwoDetailViewController ()

@end

@implementation TwoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.baseNaviView.titleString = @"第二详情";
    self.baseNaviView.rightString = @"保存";
    self.baseNaviView.rightBtnClickedBlock = ^{
        NSLog(@"点击保存");
    };
}

- (IBAction)go2TwoThirdVC:(id)sender {
    [self.navigationController pushViewController:[TwoThirdViewController new] animated:YES];
}

@end
