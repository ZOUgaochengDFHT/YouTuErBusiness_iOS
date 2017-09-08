//
//  YTENavigationController.m
//  YouTuEr
//
//  Created by ss on 17/2/18.
//  Copyright © 2017年 ss. All rights reserved.
//


// 0,223.172
// 0,223,172    244,209,0
// 204,230,0   255,35,118
// 255,28,46    0,241,135
// 0,192,153
#import "YTENavigationController.h"

@interface YTENavigationController ()

@end

@implementation YTENavigationController

+ (void)initialize {
    if (self == [YTENavigationController class]) {
        // 取得navBar
        UINavigationBar *navBar = [UINavigationBar appearance];
        // 设置navBar背景颜色
        [navBar setBarTintColor:YTEDominantColor];
        // 设置导航栏图标颜色
        [navBar setTintColor:[UIColor whiteColor]];
        // 设置导航栏返回图标文字位置偏移
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -100) forBarMetrics:UIBarMetricsDefault];
        // 用于设置标题文字属性的字典
        NSMutableDictionary *titleDic = [NSMutableDictionary dictionary];
        titleDic[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
        titleDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
        [navBar setTitleTextAttributes:titleDic];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏返回图标
    
    // Do any additional setup after loading the view.
}
// 隐藏将要被push出来的控制器的bottomBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
