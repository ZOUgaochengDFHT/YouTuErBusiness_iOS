//
//  HMSettingGroup.h
//  01-网易彩票
//
//  Created by SZSYKT_iOSBasic_2 on 16/2/20.
//  Copyright © 2016年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMSettingGroup : NSObject
/**
 *  装该组所有的item（item是HMSettingItem类型的对象）
 */
@property (nonatomic, strong) NSArray *items;
/**
 *  该组对应的头部描述
 */
@property (nonatomic, copy) NSString *header;
/**
 *  该组对应的尾部描述
 */
@property (nonatomic, copy) NSString *footer;

/**
 *  根据items数组创建组模型
 */
+ (instancetype)groupWithItems:(NSArray *)items;


@end
