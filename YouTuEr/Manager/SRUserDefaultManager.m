//
//  SRUserDefaultManager.m
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/2.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRUserDefaultManager.h"

@implementation SRUserDefaultManager

+ (SRUserDefaultManager *_Nullable)sharedManager {
    static SRUserDefaultManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [SRUserDefaultManager new];
    });
    return manager;
}

- (void)setObject:(nullable id)value forKey:(NSString *_Nullable)defaultName {
    [SR_USER_DEFAULT setObject:value forKey:defaultName];
    [SR_USER_DEFAULT synchronize];
}

- (void)removeObjectForKey:(NSString *_Nullable)defaultName {
    [SR_USER_DEFAULT removeObjectForKey:defaultName];
    [SR_USER_DEFAULT synchronize];
}

- (nullable id)objectForKey:(NSString *)defaultName {
    return [SR_USER_DEFAULT objectForKey:defaultName];
}


@end
