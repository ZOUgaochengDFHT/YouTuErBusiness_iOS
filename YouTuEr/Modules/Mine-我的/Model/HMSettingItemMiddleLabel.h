//
//  HMSettingItemMiddleLabel.h
//  YouTuEr
//
//  Created by 苏一 on 2017/7/3.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "HMSettingItem.h"

@interface HMSettingItemMiddleLabel : HMSettingItem
// 文本标签要显示的内容
@property (nonatomic, copy) NSString *text;

+ (instancetype)itemWithTitle:(NSString *)title;
@end
