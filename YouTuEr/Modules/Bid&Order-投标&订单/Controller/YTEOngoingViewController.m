//
//  YTEOngoingViewController.m
//  YouTuEr
//
//  Created by 苏一 on 2017/4/19.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEOngoingDetailController.h"
#import "YTEOngoingViewController.h"
#import "SRBidsServiceModel.h"
#import "YTEB&OLeftCell.h"
#import "YTEOngoingCell.h"
#import "SROrderService.h"

#import "YTEBusBidModel.h"
#import "YTEGuideBidModel.h"
#import "YTETranslateBidModel.h"
#import "YTEPickupBidModel.h"
#import "YTEVipBidModel.h"
#import "YTEGroupBidModel.h"
#import "SRCancelBidServiceModel.h"

#import "YTEOrderDetailView.h"

#define OrderLeftTableViewHEI 40

@interface YTEOngoingViewController ()

@property (nonatomic, strong) NSMutableArray *guideBidModelArr;
@property (nonatomic, strong) NSMutableArray *pickupBidModelArr;
@property (nonatomic, strong) NSMutableArray *translateBidModelArr;
@property (nonatomic, strong) NSMutableArray *busBidModelArr;
@property (nonatomic, strong) NSMutableArray *vipBidModelArr;
@property (nonatomic, strong) NSMutableArray *groupBidModelArr;
@property (nonatomic, assign) NSInteger nextId;
@property (nonatomic, strong) SRBidsServiceModel *serviceModel;
@property (nonatomic, strong) MJRefreshNormalHeader *mjHeader;
@property (nonatomic, strong) MJRefreshAutoNormalFooter *mjFooter;

@end

@implementation YTEOngoingViewController


#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
    [self omerchartMyBidProcessingRequest];
}


#pragma mark - Initializer

- (void)config {
    self.serviceModel = [SRBidsServiceModel new];
    self.serviceModel.pageSize = 5;
    self.serviceModel.nextId = 10000;
    self.rightTableView.mj_header = self.mjHeader;
    self.rightTableView.mj_footer = self.mjFooter;
}

#pragma mark - Request

- (void)loadNewData {
    [[self arrayBySeletedIndex:self.selectIndex] removeAllObjects];
    self.serviceModel.nextId = 10000;
    [self omerchartMyBidProcessingRequest];
}

- (void)loadMoreData {
    if (!self.nextId) {
        [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    self.serviceModel.nextId = self.nextId;
    [self omerchartMyBidProcessingRequest];
}

- (void)stopLoading {
    [self hideProgressView];
    [self.rightTableView.mj_header endRefreshing];
    [self.rightTableView.mj_footer endRefreshing];
}
#pragma mark - Request
- (void)omerchartMyBidProcessingRequest {
    self.serviceModel.clientId = [[SRAppManager sharedManager].member_id integerValue];
    self.serviceModel.type = self.selectIndex;
    if (![SRReachabilityManager networkIsReachable]) {
        [self stopLoading];
        return;
    }
    [self showProgressView];
    @weakify(self);
    [[SROrderService sharedService] omerchartMyBidProcessingRequestWithModel:self.serviceModel successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
        [self stopLoading];
        self.nextId = [returnData[@"nextId"] integerValue];
        NSArray *titleArr =  [self arrayFromAuthenValue];
        if ([titleArr[self.selectIndex] isEqual:@"大巴"]) {
            [self.busBidModelArr addObjectsFromArray:[YTEBusBidModel getModels:returnData[@"orders"]]];
        } else if ([titleArr[self.selectIndex] isEqual:@"导游"]) {
            [self.guideBidModelArr addObjectsFromArray:[YTEGuideBidModel getModels:returnData[@"orders"]]];
        } else if ([titleArr[self.selectIndex] isEqual:@"翻译"]) {
            [self.translateBidModelArr addObjectsFromArray:[YTETranslateBidModel getModels:returnData[@"orders"]]];
        } else if ([titleArr[self.selectIndex] isEqual:@"团餐"]) {
            [self.groupBidModelArr addObjectsFromArray:[YTEGroupBidModel getModels:returnData[@"orders"]]];
        } else if ([titleArr[self.selectIndex] isEqual:@"接送机"]) {
            [self.pickupBidModelArr addObjectsFromArray:[YTEPickupBidModel getModels:returnData[@"orders"]]];
        } else {
            [self.vipBidModelArr addObjectsFromArray:[YTEVipBidModel getModels:returnData[@"orders"]]];
        }
        [self.rightTableView reloadData];
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        @strongify(self);
        [self stopLoading];
    }];
}


#pragma mark - Table view data source & delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return self.leftDataArray.count;
    } else {
        return [self arrayBySeletedIndex:self.selectIndex].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTableView) {
        YTEB_OLeftCell *cell = [YTEB_OLeftCell cellWithTableView:tableView];
        cell.textLabel.text = self.leftDataArray[indexPath.row];
        return cell;
    } else {
        YTEOngoingCell *cell = [YTEOngoingCell cellWithTableView:tableView];
        self.rightTableView.estimatedRowHeight = 100;//很重要保障滑动流畅性
        cell.model = [self arrayBySeletedIndex:self.selectIndex][indexPath.row];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        return 40;
    } else {
        return self.selectIndex == 1 ? 169 : 152;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {        
        if (indexPath.row == self.selectIndex) return;
        self.selectIndex = indexPath.row;
        YTEB_OLeftCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.highlighted = YES;
        [self loadNewData];
    } else if (tableView == self.rightTableView) {
        [YTEOrderDetailView detailtView:[self arrayBySeletedIndex:self.selectIndex][indexPath.row] orderStatus:YTEOrderStatuProcessing];
    }
}

- (NSMutableArray *)arrayBySeletedIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return self.busBidModelArr;
            break;
        case 1:
            return self.guideBidModelArr;
            break;
        case 2:
            return self.translateBidModelArr;
            break;
        case 3:
            return self.groupBidModelArr;
            break;
        case 4:
            return self.pickupBidModelArr;
            break;
        default:
            return self.vipBidModelArr;
            break;
    }
}

#pragma mark - Getter & Setter

- (MJRefreshNormalHeader *)mjHeader {
    if (!_mjHeader) {
        _mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _mjHeader.ignoredScrollViewContentInsetTop = -35;
        _mjHeader.stateLabel.font = _mjHeader.lastUpdatedTimeLabel.font = YTEFont(10.0);
    }
    return _mjHeader;
}

- (MJRefreshAutoNormalFooter *)mjFooter {
    if (!_mjFooter) {
        _mjFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        _mjFooter.stateLabel.font = YTEFont(13.0);
        _mjFooter.ignoredScrollViewContentInsetBottom = 35;
    }
    return _mjFooter;
}

- (NSMutableArray *)guideBidModelArr {
    if (!_guideBidModelArr) _guideBidModelArr = [NSMutableArray new];
    return _guideBidModelArr;
}

- (NSMutableArray *)pickupBidModelArr {
    if (!_pickupBidModelArr) _pickupBidModelArr = [NSMutableArray new];
    return _pickupBidModelArr;
}

- (NSMutableArray *)translateBidModelArr {
    if (!_translateBidModelArr) _translateBidModelArr = [NSMutableArray new];
    return _translateBidModelArr;
}

- (NSMutableArray *)busBidModelArr {
    if (!_busBidModelArr) _busBidModelArr = [NSMutableArray new];
    return _busBidModelArr;
}

- (NSMutableArray *)vipBidModelArr {
    if (!_vipBidModelArr) _vipBidModelArr = [NSMutableArray new];
    return _vipBidModelArr;
}

- (NSMutableArray *)groupBidModelArr {
    if (!_groupBidModelArr) _groupBidModelArr = [NSMutableArray new];
    return _groupBidModelArr;
}

@end
