//
//  AppDelegate+Config.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/9/13.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "AppDelegate+Config.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "YTENavigationController.h"
#import "YTEFillInDataViewController.h"
#import "YTELoginController.h"
#import "YTETabBarController.h"

@implementation AppDelegate (Config)

- (void)configDoneBarButtonItemText {
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
}

- (void)startNetworkStatusMonitor {
    [[SRReachabilityManager sharedManager] startMonitor];
}

- (void)configWindowRootVC {
    // 1.创建主窗口
    self.window = [[UIWindow alloc] init];
    self.window.bounds = [UIScreen mainScreen].bounds;
    // 2.设置主窗口的根控制器
    self.window.rootViewController = [SRAppManager sharedManager].isLogin ? ([SRAppManager sharedManager].hasProfile ? [[YTETabBarController alloc] init] : [[YTENavigationController alloc] initWithRootViewController:[[YTEFillInDataViewController alloc] init]]) : [[YTENavigationController alloc] initWithRootViewController:[[YTELoginController alloc] init]];
    // 3.显示主窗口
    [self.window makeKeyAndVisible];
}

- (void)configStatusBarStyle {
    // 设置状态栏颜色为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

@end
