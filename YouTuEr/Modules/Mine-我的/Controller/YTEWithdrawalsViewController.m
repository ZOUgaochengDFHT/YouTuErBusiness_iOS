//
//  YTEWithdrawalsViewController.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/23.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEWithdrawalsViewController.h"
#import "SRWithdrawServiceModel.h"
#import "SRUserService.h"

@interface YTEWithdrawalsViewController ()

@property (strong, nonatomic) RETextItem *textItem1;
@property (strong, nonatomic) SRWithdrawServiceModel *serviceModel;

@end

@implementation YTEWithdrawalsViewController

#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"申请提现";
    [self initTableViewManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initializer

- (void)initTableViewManager {
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    [self setupManager:self.manager];
    [self addBasicControls];
    [self addButtonSectionWithTitle:@"提交"];
    @weakify(self);
    self.buttonItem.selectionHandler = ^(RETableViewItem *item) {
        @strongify(self);
        [self memberWithdrawRequest];
    };
}

- (RETableViewSection *)addBasicControls {
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@""];
    [self.manager addSection:section];
    self.textItem1 = [RETextItem itemWithTitle:@"提现金额" value:nil placeholder:@"请输入提现金额"];
    self.textItem1.keyboardType = UIKeyboardTypeDecimalPad;
    @weakify(self);
    self.textItem1.onChange = ^(RETextItem *item) {
        @strongify(self);
        self.serviceModel.amount = item.value;
    };
    [section addItemsFromArray:@[self.textItem1]];
    return section;
}

#pragma mark - Request

- (void)memberWithdrawRequest {
    [self.tableView reloadData];
    if (!self.serviceModel.amount || [self.serviceModel.amount isEqual:@""]) {
        [[SRMessage sharedMessage] showMessage:@"提现余额不大于0元，无法提现" withType:MessageTypeNotice];
        return;
    }
    if ([self.serviceModel.amount floatValue] > self.amount) {
        [[SRMessage sharedMessage] showMessage:@"账户余额不足，无法提现" withType:MessageTypeNotice];
        return;
    }
    self.serviceModel.clientId = [SRAppManager sharedManager].member_id;
    if (![SRReachabilityManager networkIsReachable]) return;
    [self showProgressView];
    @weakify(self);
    [[SRUserService sharedService] memberWithdrawRequestWithModel:self.serviceModel successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[SRMessage sharedMessage] showMessage:@"申请提现成功！" withType:MessageTypeNotice];
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];

    }];
}


#pragma mark - Getter
- (SRWithdrawServiceModel *)serviceModel {
    if (!_serviceModel) _serviceModel = [SRWithdrawServiceModel new];
    return _serviceModel;
}

@end
