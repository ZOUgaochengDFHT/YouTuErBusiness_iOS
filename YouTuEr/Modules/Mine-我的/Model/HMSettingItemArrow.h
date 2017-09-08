//
//  HMSettingItemArrow.h
//  01-网易彩票
//
//  Created by SZSYKT_iOSBasic_2 on 16/2/20.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "HMSettingItem.h"

@interface HMSettingItemArrow : HMSettingItem
/**
 *  目标控制器
 */
@property (nonatomic, assign) Class destVc;

+ (instancetype)itemWithTitle:(NSString *)title destVc:(Class)destVc;
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon destVc:(Class)destVc;
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle icon:(NSString *)icon destVc:(Class)destVc;

@end
