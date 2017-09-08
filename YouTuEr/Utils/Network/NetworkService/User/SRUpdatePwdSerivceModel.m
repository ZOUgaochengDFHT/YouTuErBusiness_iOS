//
//  SRUpdatePwdSerivceModel.m
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRUpdatePwdSerivceModel.h"

@implementation SRUpdatePwdSerivceModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"sr_newPwd" : @"newPwd"};
}

@end
