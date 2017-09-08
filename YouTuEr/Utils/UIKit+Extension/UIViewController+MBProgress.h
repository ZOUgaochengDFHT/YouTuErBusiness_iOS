//
//  UIViewController+MBProgress.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/2.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MBProgress)

@property (assign, nonatomic) BOOL enableAutorotate;

- (void)showProgressView;

- (void)showProgressView:(BOOL)animated;

- (void)showProgressViewWithTimeout:(NSTimeInterval)timeout;

- (void)hideProgressView;

- (void)hideProgressView:(BOOL)animated;


@end
