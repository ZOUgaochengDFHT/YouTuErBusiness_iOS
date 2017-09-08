//
//  YTEMyOrderViewController.m
//  YouTuEr
//
//  Created by 苏一 on 2017/4/19.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEMyOrderViewController.h"
#import "YTEB&OLeftCell.h"
#import "YTEOrderRightCell.h"
#import "YTEOrderDetailView.h"
#import "YTEBiddersController.h"
#import "YTEQuotedPriceViewController.h"

#import "SROrderService.h"
#import "SRBidsServiceModel.h"
#import "YTEBusBidModel.h"
#import "YTEGuideBidModel.h"
#import "YTETranslateBidModel.h"
#import "YTEPickupBidModel.h"
#import "YTEVipBidModel.h"
#import "YTEGroupBidModel.h"
#import "SRCancelBidServiceModel.h"
#import "SRMyQuoteServiceModel.h"
#import "YTEMyQuoteModel.h"

@interface YTEMyOrderViewController ()

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
@property (nonatomic, strong) NSString *selectedId;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath ;
@property (nonatomic, strong) YTEMyQuoteModel *myQuoteModel;

@end

@implementation YTEMyOrderViewController

#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
    [self omerchartMyBidRequest];
}

- (void)dealloc {
    [YTENotifiCenter removeObserver:self name:YTEMODIFYPRICESUCCESSNOTIFICATION object:nil];
}

#pragma mark - Initializer
- (void)config {
    self.serviceModel = [SRBidsServiceModel new];
    self.serviceModel.pageSize = 5;
    self.serviceModel.nextId = 10000;
    self.rightTableView.mj_header = self.mjHeader;
    self.rightTableView.mj_footer = self.mjFooter;
    
    [YTENotifiCenter addObserver:self
                        selector:@selector(omerchartMyQuoteRequest)
                            name:YTEMODIFYPRICESUCCESSNOTIFICATION
                          object:nil];
}


#pragma mark - Request

- (void)loadNewData {
    [[self arrayBySeletedIndex:self.selectIndex] removeAllObjects];
    self.serviceModel.nextId = 10000;
    [self omerchartMyBidRequest];
}

- (void)loadMoreData {
    if (!self.nextId) {
        [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    self.serviceModel.nextId = self.nextId;
    [self omerchartMyBidRequest];
}

- (void)stopLoading {
    [self hideProgressView];
    [self.rightTableView.mj_header endRefreshing];
    [self.rightTableView.mj_footer endRefreshing];
}

/**
 查询报价
 */
- (void)omerchartMyQuoteRequest {
    if (![SRReachabilityManager networkIsReachable]) return;
    [self showProgressView];
    @weakify(self);
    SRMyQuoteServiceModel *serviceModel = [SRMyQuoteServiceModel new];
    serviceModel.orderId = self.selectedId;
    serviceModel.clientId = [SRAppManager sharedManager].member_id;
    [[SROrderService sharedService] omerchartMyQuoteRequestWithModel:serviceModel successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
        self.myQuoteModel = [YTEMyQuoteModel yy_modelWithDictionary:returnData[@"myQuote"]];
        [[self arrayBySeletedIndex:self.selectIndex][self.selectedIndexPath.section] setValue:self.myQuoteModel.bidFee forKey:@"bidFee"];
        [self.rightTableView reloadRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
    }];
}

/**
 我的投标
 */
- (void)omerchartMyBidRequest {
    self.serviceModel.clientId = [[SRAppManager sharedManager].member_id integerValue];
    self.serviceModel.type = self.selectIndex;
    if (![SRReachabilityManager networkIsReachable]) {
        [self stopLoading];
        return;
    }
    [self showProgressView];
    @weakify(self);
    [[SROrderService sharedService] omerchartMyBidRequestWithModel:self.serviceModel successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
        @strongify(self);
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

- (void)arrayFromTitle:(NSDictionary *)returnData {
  
}

/**
 取消投标
 */
- (void)merchartCancelBidRequest:(NSString *)Id indexPath:(NSIndexPath *)indexPath {
    @weakify(self);
    SRCancelBidServiceModel *serviceModel = [SRCancelBidServiceModel new];
    serviceModel.orderId = Id;
    serviceModel.clientId = [SRAppManager sharedManager].member_id;
    if (![SRReachabilityManager networkIsReachable]) return;
    [self showProgressView];
    [[SROrderService sharedService] omerchartCancelBidRequestWithModel:serviceModel successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
        [[self arrayBySeletedIndex:self.selectIndex] removeObjectAtIndex:indexPath.row];
        [self.rightTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.rightTableView reloadData];
        [[SRMessage sharedMessage] showMessage:@"取消成功！" withType:MessageTypeNotice];
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
    }];
}


#pragma mark - UITableViewDelegate & UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.leftTableView) {
        YTEB_OLeftCell *cell = [YTEB_OLeftCell cellWithTableView:tableView];
        cell.textLabel.text = self.leftDataArray[indexPath.row];
        return cell;
    }else{
        YTEOrderRightCell *cell = [self.rightTableView cellForRowAtIndexPath:indexPath];
        if (!cell) cell = [[NSBundle mainBundle] loadNibNamed:@"YTEOrderRightCell" owner:nil options:nil].lastObject;
        @weakify(self);
        cell.orderStatus = YTEOrderStatusNormal;
        cell.modifyQuotedPriceHandle = ^(NSString *Id) {
            @strongify(self);
            YTEQuotedPriceViewController *modifyQuotedPriceVC = [[YTEQuotedPriceViewController alloc] init];
            modifyQuotedPriceVC.orderId = self.selectedId = Id;
            modifyQuotedPriceVC.quotedPriceWay = 1;
            self.selectedIndexPath = indexPath;
            [self.navigationController pushViewController:modifyQuotedPriceVC animated:YES];;
        };
        
        cell.cancelBidHandle = ^(NSString *Id) {
            @strongify(self);
            [self merchartCancelBidRequest:Id indexPath:indexPath];
        };
        cell.model = [self arrayBySeletedIndex:self.selectIndex][indexPath.row];
        return cell;
        
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        if (indexPath.row == self.selectIndex) return;
        self.selectIndex = indexPath.row;
        YTEB_OLeftCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.highlighted = YES;
        [self loadNewData];
    } else if (tableView == self.rightTableView){
        [YTEOrderDetailView detailtView:[self arrayBySeletedIndex:self.selectIndex][indexPath.section] orderStatus:YTEOrderStatusNormal];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        self.selectIndex = indexPath.row;
        YTEB_OLeftCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.highlighted = NO;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return self.leftDataArray.count;
    } else {
        return [self arrayBySeletedIndex:self.selectIndex].count;
    }
    return 0;
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
