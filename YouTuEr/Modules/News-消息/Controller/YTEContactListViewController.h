//
//  YTEContactListViewController.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/9/6.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <EaseUI/EaseUI.h>
#import "YTEGroupListViewController.h"

@interface YTEContactListViewController : EaseUsersListViewController

@property (strong, nonatomic) YTEGroupListViewController *groupController;

//好友请求变化时，更新好友请求未处理的个数
- (void)reloadApplyView;

//群组变化时，更新群组页面
- (void)reloadGroupView;

//好友个数变化时，重新获取数据
- (void)reloadDataSource;

//添加好友的操作被触发
- (void)addFriendAction;

@end
