//
//  HMSettingItemLabel.h
//  01-网易彩票
//
//  Created by SZSYKT_iOSBasic_2 on 16/2/20.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "HMSettingItem.h"

@interface HMSettingItemLabel : HMSettingItem
// 文本标签要显示的内容
@property (nonatomic, copy) NSString *text;

+ (instancetype)itemWithTitle:(NSString *)title defaultValue:(NSString *)defaultValue;
@end
