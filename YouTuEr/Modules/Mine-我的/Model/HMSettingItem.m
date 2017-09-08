//
//  HMSettingItem.m
//  01-网易彩票
//
//  Created by SZSYKT_iOSBasic_2 on 16/2/20.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "HMSettingItem.h"

@implementation HMSettingItem
+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon {
    HMSettingItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title{
    return [self itemWithTitle:title icon:nil];
}

+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle {
    HMSettingItem *item = [[self alloc] init];
    item.title = title;
    item.subTitle = subTitle;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle  icon:(NSString *)icon {
    HMSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.subTitle = subTitle;
    return item;
}

@end
