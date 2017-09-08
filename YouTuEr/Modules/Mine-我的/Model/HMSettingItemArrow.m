//
//  HMSettingItemArrow.m
//  01-网易彩票
//
//  Created by SZSYKT_iOSBasic_2 on 16/2/20.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "HMSettingItemArrow.h"

@implementation HMSettingItemArrow
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle icon:(NSString *)icon destVc:(Class)destVc {
    HMSettingItemArrow *item = [self itemWithTitle:title subTitle:subTitle icon:icon];
    item.destVc = destVc;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon destVc:(Class)destVc {
    HMSettingItemArrow *item = [self itemWithTitle:title icon:icon];
    item.destVc = destVc;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title  destVc:(Class)destVc {
    return [self itemWithTitle:title icon:nil destVc:destVc];
}
@end
