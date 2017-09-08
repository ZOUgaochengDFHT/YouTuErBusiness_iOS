//
//  HMSettingCell.h
//  01-网易彩票
//
//  Created by SZSYKT_iOSBasic_2 on 16/2/20.
//  Copyright © 2016年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMSettingItem;
@interface HMSettingCell : UITableViewCell
/**
 *  快速创建cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**
 *  接收外界传人的item模型
 */
@property (nonatomic, strong) HMSettingItem *item;
/**
 *  是否显示分割线 YES:隐藏  NO:不隐藏
 */
@property (nonatomic, assign) BOOL hideLineView;
@end
