//
//  TwoViewController.m
//  JYNaviView
//
//  Created by DaveYou on 2019/9/25.
//  Copyright © 2019 DaveYou. All rights reserved.
//

#import "TwoViewController.h"
#import "TwoDetailViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.baseNaviView.titleString = @"第二个控制器";
//    self.baseNaviView.jy_hiddenBackBtn = YES;
    self.baseNaviView.hidden = YES;
}

- (IBAction)go2Detail:(id)sender {
    [self.navigationController pushViewController:[TwoDetailViewController new] animated:YES];
}


@end
