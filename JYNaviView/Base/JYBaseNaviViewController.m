//
//  JYBaseNaviViewController.m
//  JYNaviView
//
//  Created by DaveYou on 2019/9/25.
//  Copyright © 2019 DaveYou. All rights reserved.
//

#import "JYBaseNaviViewController.h"

@interface JYBaseNaviViewController ()<UINavigationBarDelegate,UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation JYBaseNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    NSLog(@"跳转:%@", NSStringFromClass([viewController class]));
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        //开启iOS7的滑动返回效果
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.delegate = self;
            /** 放开pop手势*/
            self.interactivePopGestureRecognizer.enabled = YES;
        }else{
            self.interactivePopGestureRecognizer.enabled = NO;
        }
    }
    [super pushViewController:viewController animated:animated];
}


#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ( gestureRecognizer == self.interactivePopGestureRecognizer ) {
        if ( self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0] ){
            return NO;
        }
    }
    return YES;
}

@end
