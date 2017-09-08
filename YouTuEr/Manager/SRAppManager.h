//
//  SRAppManager.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/7/28.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTEAuthenModel.h"

@interface SRAppManager : NSObject

+ (SRAppManager *)sharedManager;


/**
 app版本
 */
- (NSString *)appVersion;
- (NSInteger)appVersionNumber;

- (NSString *)bidUsername;

/**
 来源
 */
- (NSString *)source;
/**
 tokenid
 */
- (void)saveToken:(NSString *)token;
- (void)removeToken;
- (NSString *)tokenid;

- (NSString *)member_id;

- (void)changeDoneBarButtonItemText;

- (BOOL)isLogin;

- (YTEAuthenModel *)authenModel;

- (BOOL)hasProfile;

@end
