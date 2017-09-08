//
//  SRUserDefaultManager.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/2.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRUserDefaultManager : NSObject

+ (SRUserDefaultManager *_Nullable)sharedManager;

- (void)setObject:(nullable id)value forKey:(NSString *_Nullable)defaultName;

- (void)removeObjectForKey:(NSString *_Nullable)defaultName;

- (nullable id)objectForKey:(NSString *_Nullable)defaultName;

@end
