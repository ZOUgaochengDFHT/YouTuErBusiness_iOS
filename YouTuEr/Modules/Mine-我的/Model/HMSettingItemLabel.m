//
//  HMSettingItemLabel.m
//  01-网易彩票
//
//  Created by SZSYKT_iOSBasic_2 on 16/2/20.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "HMSettingItemLabel.h"
#import "HMSaveDataTool.h"
@implementation HMSettingItemLabel
+ (instancetype)itemWithTitle:(NSString *)title defaultValue:(NSString *)defaultValue {
    HMSettingItemLabel *item = [self itemWithTitle:title];
//    NSLog(@"text = %@",item.text);
    if (item.text.length == 0) { // 没有保存过时间
         item.text = defaultValue;
    }
    return item;
}

- (void)setText:(NSString *)text {
    _text = text;
    [HMSaveDataTool setValue:text forKey:self.title];
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    // 加载时间
    _text = [HMSaveDataTool valueForKey:title];
}

@end
