//
//  YTEFillInDataViewController.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/23.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEFillInDataViewController.h"
#import "SRSaveInfoServiceModel.h"
#import "YTETabBarController.h"
#import "SRUserService.h"

@interface YTEFillInDataViewController ()

@property (strong, nonatomic) SRSaveInfoServiceModel *serviceModel;
@property (strong, nonatomic) RETextItem *nickNameItem;
@property (strong, nonatomic) RETextItem *countryItem;
@property (strong, nonatomic) RETextItem *cityItem;

@end

@implementation YTEFillInDataViewController

#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"填写资料";
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
    [self addButtonSectionWithTitle:@"保存"];
    @weakify(self);
    self.buttonItem.selectionHandler = ^(RETableViewItem *item) {
        @strongify(self);
        [self memberSaveInfoRequest];
    };
}

- (RETableViewSection *)addBasicControls {
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@""];
    [self.manager addSection:section];
    // Add items to this section
    self.nickNameItem = [RETextItem itemWithTitle:@"昵称" value:nil placeholder:@"请输入昵称"];
    @weakify(self);
    self.nickNameItem.onChange = ^(RETextItem *item) {
        @strongify(self);
        self.serviceModel.nickName = item.value;
    };
    
    self.countryItem = [RETextItem itemWithTitle:@"国家" value:nil placeholder:@"请输入国家"];
    self.countryItem.onChange = ^(RETextItem *item) {
        @strongify(self);
        self.serviceModel.country = item.value;
    };
    
    self.cityItem = [RETextItem itemWithTitle:@"城市" value:nil placeholder:@"请输入城市"];
    self.cityItem.onChange = ^(RETextItem *item) {
        @strongify(self);
        self.serviceModel.city = item.value;
    };
    
    [section addItemsFromArray:@[self.nickNameItem, self.countryItem, self.cityItem]];
    return section;
}

#pragma mark - Requests

- (void)memberSaveInfoRequest {
    [self.tableView reloadData];
    if (!self.serviceModel.nickName || [self.serviceModel.nickName isEqual:@""]) {
        [[SRMessage sharedMessage] showMessage:@"昵称不能为空" withType:MessageTypeNotice];
        return;
    }
    if (!self.serviceModel.country || [self.serviceModel.country isEqual:@""]) {
        [[SRMessage sharedMessage] showMessage:@"国家不能为空" withType:MessageTypeNotice];
        return;
    }
    if (!self.serviceModel.city || [self.serviceModel.city isEqual:@""]) {
        [[SRMessage sharedMessage] showMessage:@"城市不能为空" withType:MessageTypeNotice];
        return;
    }
    self.serviceModel.clientId = [SRAppManager sharedManager].member_id;
    if (![SRReachabilityManager networkIsReachable]) return;
    [self showProgressView];
    @weakify(self);
    [[SRUserService sharedService] memberSaveInfoRequestWithModel:self.serviceModel successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
        [[SRUserDefaultManager sharedManager] setObject:@"true" forKey:SR_HASPROFILE];
        self.view.window.rootViewController = [[YTETabBarController alloc] init];
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
    }];
}

#pragma mark - Getter
- (SRSaveInfoServiceModel *)serviceModel {
    if (!_serviceModel) _serviceModel = [SRSaveInfoServiceModel new];
    return _serviceModel;
}

@end
