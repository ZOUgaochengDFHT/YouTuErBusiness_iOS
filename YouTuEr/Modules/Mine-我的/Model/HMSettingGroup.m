//
//  HMSettingGroup.m
//  01-网易彩票
//
//  Created by SZSYKT_iOSBasic_2 on 16/2/20.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "HMSettingGroup.h"

@implementation HMSettingGroup
/**
 *  根据items数组创建组模型
 */
+ (instancetype)groupWithItems:(NSArray *)items {
    HMSettingGroup *group = [[HMSettingGroup alloc] init];
    group.items = items;
    return group;
}
@end
