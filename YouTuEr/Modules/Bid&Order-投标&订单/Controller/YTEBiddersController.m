//
//  YTEBiddersController.m
//  YouTuEr
//
//  Created by 苏一 on 2017/6/19.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEBiddersController.h"
#import "YTEBidderCell.h"

@interface YTEBiddersController ()

@end

@implementation YTEBiddersController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [NSThread sleepForTimeInterval:1];
        [self.tableView.mj_header endRefreshing];
    }];
    self.view.backgroundColor = YTEGlobalBGColor;
    self.navigationItem.title = @"投标列表";
    self.tableView.separatorStyle = UIAccessibilityTraitNone;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.estimatedRowHeight = 100;//很重要保障滑动流畅性
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    YTEBidderCell *cell = [YTEBidderCell cellWithTableView:tableView];
    
    cell.model = cell;
    //        switch (self.selectIndex) {
    //            case 0:
    //                cell.model = self.getGuideArr[indexPath.row];
    //                break;
    //            case 1:
    //                cell.model = self.pickupArr[indexPath.row];
    //                break;
    //            case 2:
    //                cell.model = self.getTranslatorArr[indexPath.row];
    //                break;
    //            case 3:
    //                cell.model = self.rentBusArr[indexPath.row];
    //                break;
    //            case 4:
    //                cell.model = self.VIPArr[indexPath.row];
    //                break;
    //            case 5:
    //                cell.model = self.orderMealArr[indexPath.row];
    //                break;
    //
    //            default:
    //                break;
    //        }
    
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UITableViewCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
//    [cell layoutIfNeeded];
//    [cell setNeedsLayout];
    return 200;
    
    
}

@end
