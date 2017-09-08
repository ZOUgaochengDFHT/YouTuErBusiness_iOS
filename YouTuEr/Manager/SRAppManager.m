//
//  SRAppManager.m
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/7/28.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRAppManager.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@implementation SRAppManager

+ (SRAppManager *)sharedManager {
    static SRAppManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SRAppManager alloc] init];
    });
    return manager;
}

- (NSString *)member_id {
    return [[SRUserDefaultManager sharedManager] objectForKey:SR_CLINETID] ? :@"";
}

- (NSString *)bidUsername {
    return [[SRUserDefaultManager sharedManager] objectForKey:@"bidUsername"] ? :@"";
}

- (void)changeDoneBarButtonItemText {
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
}

- (BOOL)isLogin {
    return [[SRUserDefaultManager sharedManager] objectForKey:SR_CLINETID];
}

- (YTEAuthenModel *)authenModel {
    return [YTEAuthenModel yy_modelWithJSON:[[SRUserDefaultManager sharedManager] objectForKey:SR_AUTHEN]];
}

- (BOOL)hasProfile {
    return [[[SRUserDefaultManager sharedManager] objectForKey:SR_HASPROFILE] isEqual:@"true"] ? YES : NO;
}

@end
