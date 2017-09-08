//
//  YTEAccountModel.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/7.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEAccountModel.h"

@implementation YTEAccountModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"accountid" : @"id"};
}

@end
