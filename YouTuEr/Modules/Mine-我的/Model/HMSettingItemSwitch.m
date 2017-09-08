//
//  HMSettingItemSwitch.m
//  01-网易彩票
//
//  Created by SZSYKT_iOSBasic_2 on 16/2/20.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "HMSettingItemSwitch.h"
#import "HMSaveDataTool.h"
@implementation HMSettingItemSwitch

- (void)setOn:(BOOL)on {
    _on = on;
//    // 开关状态保存到 偏好设置
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:on forKey:self.title];
    
    [HMSaveDataTool setBool:on forKey:self.title];
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
//    NSLog(@"title = %@",title);
    // 加载开关状态
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    _on = [defaults boolForKey:title];
    
    _on = [HMSaveDataTool boolForKey:title];
}
@end
