//
//  OneDetailViewController.m
//  JYNaviView
//
//  Created by YouYQ on 2019/9/25.
//  Copyright © 2019 DaveYou. All rights reserved.
//

#import "OneDetailViewController.h"

@interface OneDetailViewController ()

@end

@implementation OneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseNaviView.titleString = self.titleString;
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *greenView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.baseNaviView.frame), ScreenWidth, 100)];
    greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:greenView];
}


@end
