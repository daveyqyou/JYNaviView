//
//  JYBaseTabBarViewController.m
//  JYNaviView
//
//  Created by DaveYou on 2019/9/25.
//  Copyright © 2019 DaveYou. All rights reserved.
//

#import "JYBaseTabBarViewController.h"

@interface JYBaseTabBarViewController ()

@end

@implementation JYBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIViewController *vc1 = [self instantiateVCWithSBName:@"One"];
    UIViewController *vc2 = [self instantiateVCWithSBName:@"Two"];
    UIViewController *vc3 = [self instantiateVCWithSBName:@"Three"];
    UIViewController *vc4 = [self instantiateVCWithSBName:@"Four"];
    
    [self addChildVC:vc1 title:@"首页" normalImage:@"home_n" selectedImage:@"home_s"];
    [self addChildVC:vc2 title:@"吃好" normalImage:@"home_n" selectedImage:@"home_s"];
    [self addChildVC:vc3 title:@"喝好" normalImage:@"home_n" selectedImage:@"home_s"];
    [self addChildVC:vc4 title:@"我的" normalImage:@"home_n" selectedImage:@"home_s"];

}

- (UIViewController *)instantiateVCWithSBName:(NSString *)sbName {
    UIStoryboard *sb1 = [UIStoryboard storyboardWithName:sbName bundle:nil];
    return sb1.instantiateInitialViewController;
}

- (void)addChildVC:(UIViewController *)vc title:(NSString *)title normalImage:(NSString *)image selectedImage:(NSString *)selectedImage{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:vc];
}

@end
