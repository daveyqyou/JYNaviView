//
//  AppDelegate.m
//  JYNaviView
//
//  Created by DaveYou on 2019/9/24.
//  Copyright © 2019 DaveYou. All rights reserved.
//

#import "AppDelegate.h"
#import "JYBaseTabBarViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    JYBaseTabBarViewController *rootVC = [[JYBaseTabBarViewController alloc]init];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
