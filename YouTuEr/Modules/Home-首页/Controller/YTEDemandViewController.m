//
//  YTEDemandViewController.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/11.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEDemandViewController.h"
#import "SROrderService.h"
#import "YTEOrderDetailView.h"
#import "SRBidsServiceModel.h"
#import "YTEGuideDemandModel.h"
#import "YTEBusDemandModel.h"
#import "YTEGroupDemandModel.h"
#import "YTEPickupDemandModel.h"
#import "YTETranslateDemandModel.h"
#import "YTEVipDemandModel.h"

#import "YTEDemandTableViewCell.h"
#import "YTEQuotedPriceViewController.h"


@interface YTEDemandViewController ()

@property (strong, nonatomic) NSMutableArray *demandModelArr;
@property (strong, nonatomic) SRBidsServiceModel *serviceModel;
@end

@implementation YTEDemandViewController

#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configuration];
    [self configurationTableViewMJRefresh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initializer

- (void)configuration {
    [self.navigationItem setTitle:[NSString stringFromBusinessType:self.businessType]];
    [self.tableView setTableFooterView:[UIView new]];
    [self.tableView registerNib:[UINib nibWithNibName:@"YTEDemandTableViewCell" bundle:nil] forCellReuseIdentifier:@"YTEDemandTableViewCell"];
    self.serviceModel = [SRBidsServiceModel new];
    self.serviceModel.pageSize = 5;
    self.demandModelArr = [NSMutableArray new];
}

- (void)configurationTableViewMJRefresh {
    [self.tableView setMj_header:[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)]];
    [self.tableView setMj_footer:[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)]];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - Requests

- (void)loadNewData {
    self.serviceModel.nextId = 2000;
    [self.demandModelArr removeAllObjects];
    [self omerchartDemandRequest];
}

- (void)loadMoreData {
    if (!self.serviceModel.nextId) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    [self omerchartDemandRequest];
}

- (void)stopLoading {
    [self hideProgressView];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

/**
 列表数据
 */
- (void)omerchartDemandRequest {
    
    self.serviceModel.clientId = [[SRAppManager sharedManager].member_id integerValue];
    self.serviceModel.type = self.businessType;
    if (![SRReachabilityManager networkIsReachable]) {
        [self stopLoading];
         return;
    }
    [self showProgressView];
    @weakify(self);
    [[SROrderService sharedService] omerchartDemandRequestWithModel:self.serviceModel successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
        @strongify(self);
        self.serviceModel.nextId = [returnData[@"nextId"] integerValue];
        [self stopLoading];
        switch (self.businessType) {
            case YTEBusinessTypeBus:
                [self.demandModelArr addObjectsFromArray:[YTEBusDemandModel getModels:returnData[@"orders"]]];
                break;
            case YTEBusinessTypeGuide:
                [self.demandModelArr addObjectsFromArray:[YTEGuideDemandModel getModels:returnData[@"orders"]]];
                break;
            case YTEBusinessTypeTranslate:
                [self.demandModelArr addObjectsFromArray:[YTETranslateDemandModel getModels:returnData[@"orders"]]];
                break;
            case YTEBusinessTypePickup:
                [self.demandModelArr addObjectsFromArray:[YTEPickupDemandModel getModels:returnData[@"orders"]]];
                break;
            case YTEBusinessTypeGroup:
                [self.demandModelArr addObjectsFromArray:[YTEGroupDemandModel getModels:returnData[@"orders"]]];
                break;
            default:
                [self.demandModelArr addObjectsFromArray:[YTEVipDemandModel getModels:returnData[@"orders"]]];
                break;
        }
          [self.tableView reloadData];
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        @strongify(self);
        [self stopLoading];
    }];
    
}


#pragma mark - Table view data source & delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.demandModelArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 422;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YTEDemandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YTEDemandTableViewCell" forIndexPath:indexPath];
    cell.tag = indexPath.section;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.demandModel = self.demandModelArr[indexPath.section];
    // Configure the cell...
    @weakify(self);
    cell.quoteOrderQuest = ^(NSInteger tag) {
        @strongify(self);
        YTEQuotedPriceViewController *quotedPriceVC = [[YTEQuotedPriceViewController alloc] init];
        quotedPriceVC.quotedPriceWay = 0;
        quotedPriceVC.guideDemandeModel = self.demandModelArr[indexPath.section];
        [self.navigationController pushViewController:quotedPriceVC animated:YES];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    [YTEOrderDetailView detailtView:self.demandModelArr[indexPath.section] orderStatus:YTEOrderStatusNormal];
}

@end
