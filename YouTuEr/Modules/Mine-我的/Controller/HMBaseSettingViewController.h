//
//  HMBaseSettingViewController.h
//  01-网易彩票
//
//  Created by SZSYKT_iOSBasic_2 on 16/2/20.
//  Copyright © 2016年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSettingGroup.h"
#import "HMSettingItem.h"
#import "HMSettingItemArrow.h"
#import "HMSettingItemSwitch.h"
#import "HMSettingCell.h"
#import "HMSettingItemLabel.h"
#import "HMSettingItemMiddleLabel.h"
@interface HMBaseSettingViewController : UITableViewController
// 装所有的组模型
@property (nonatomic, strong) NSArray *groups;
@end
