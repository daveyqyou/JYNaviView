//
//  JYBaseViewController.m
//  JYNaviView
//
//  Created by DaveYou on 2019/9/25.
//  Copyright © 2019 DaveYou. All rights reserved.
//

/*
 设置父类的导航代理，隐藏导航，并添加自定义导航
 */
#import "JYBaseViewController.h"

@interface JYBaseViewController ()<UINavigationControllerDelegate>

@end

@implementation JYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.baseNaviView = [[JYNaviView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, k_Height_NavBar)];
    [self.view addSubview:self.baseNaviView];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - dealloc
- (void)dealloc{
    NSLog(@"%@--dealloc", [self className]);
}
@end
