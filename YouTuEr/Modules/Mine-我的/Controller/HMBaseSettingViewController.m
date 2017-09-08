//
//  HMBaseSettingViewController.m
//  01-网易彩票
//
//  Created by SZSYKT_iOSBasic_2 on 16/2/20.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "HMBaseSettingViewController.h"
@implementation HMBaseSettingViewController

- (instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景颜色
    self.tableView.backgroundColor = YTEGlobalBGColor;
    // 设置内边距
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 24, 0);
    // 隐藏系统分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 根据组号获得组模型
    HMSettingGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建cell
    HMSettingCell *cell = [HMSettingCell cellWithTableView:tableView];
    // 根据组号获得组模型
    HMSettingGroup *group = self.groups[indexPath.section];
    // 传递item模型
    cell.item = group.items[indexPath.row];
    // 设置是否显示分割线
    cell.hideLineView = (group.items.count -1) == indexPath.row;
    return cell;
}

#pragma mark - tableView 代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // 根据组号获得组模型
    HMSettingGroup *group = self.groups[section];
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    // 根据组号获得组模型
    HMSettingGroup *group = self.groups[section];
    return group.footer;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.00000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.groups.count > 1 ? 15 : 0.00000001;
}

/**
 *  监听cell的点击
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 根据组号获得组模型
    HMSettingGroup *group = self.groups[indexPath.section];
    // 根据行号获得item
    HMSettingItem *item = group.items[indexPath.row];
    // 根据item获得要执行的block
    if (item.operationBlock) {
        // 执行block
        item.operationBlock();
        return;
    }
    // 判断是否是箭头模型
    if([item isKindOfClass:[HMSettingItemArrow class]]) {
        HMSettingItemArrow *itemArrow = (HMSettingItemArrow *)item;
        // 获得目标控制器的名字
        UIViewController *destVc = [[itemArrow.destVc alloc] init];
        // 设置目标控制器的标题
        destVc.title = itemArrow.title;
        // 进栈
        [self.navigationController pushViewController:destVc animated:YES];
    }
}

@end
