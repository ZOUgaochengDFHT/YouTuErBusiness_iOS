//
//  UIViewController+MBProgress.m
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/2.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "UIViewController+MBProgress.h"
#import "MBProgressHUD.h"

@interface UIViewController()
@property (strong, nonatomic) MBProgressHUD* loadingHUD;
@end

static const char kLoadingHUDKey = '\0';
static const char kEnableAutorotatekey = '\0';

@implementation UIViewController (MBProgress)

- (void)showProgressView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    });
}

- (void)showProgressView:(BOOL)animated {
    [MBProgressHUD showHUDAddedTo:self.view animated:animated];
}

- (void)showProgressViewWithTimeout:(NSTimeInterval)timeout {
    [self showProgressView];
    [self.loadingHUD hide:NO afterDelay:timeout];
}

- (void)hideProgressView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideProgressView:YES];
    });

}

- (void)hideProgressView:(BOOL)animated {
    [MBProgressHUD hideHUDForView:self.view animated:animated];
}


- (BOOL)shouldAutorotate {
    return self.enableAutorotate;
}

- (NSUInteger)supportedInterfaceOrientations {
    if (self.enableAutorotate) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)setLoadingHUD:(MBProgressHUD *)loadingHUD{
    objc_setAssociatedObject(self, &kLoadingHUDKey, loadingHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setEnableAutorotate:(BOOL)enableAutorotate{
    objc_setAssociatedObject(self, &kEnableAutorotatekey, @(enableAutorotate), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)enableAutorotate{
    return [objc_getAssociatedObject(self, &kEnableAutorotatekey) boolValue];
}

- (MBProgressHUD *)loadingHUD{
    return objc_getAssociatedObject(self, &kLoadingHUDKey);
}

@end

