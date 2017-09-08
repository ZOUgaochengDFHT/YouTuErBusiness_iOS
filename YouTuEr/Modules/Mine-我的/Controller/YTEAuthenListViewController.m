//
//  YTEAuthenListViewController.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/20.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEMerchantAuthenViewController.h"
#import "YTEAuthenListViewController.h"
#import "YTEAuthenModel.h"
#import "SRAuthService.h"

static const NSString *YTEAuthValue = @"1";

@interface YTEAuthenListViewController ()

@property (strong, nonatomic) YTEAuthenModel *authenModel;

@end

@implementation YTEAuthenListViewController


#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setGroups];
    [self memberAuthenRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Request

- (void)memberAuthenRequest {
    if (![SRReachabilityManager networkIsReachable]) return;
    [self showProgressView];
    @weakify(self);
    [[SRAuthService sharedService] memberAuthenRequestWithModel:[SRRequestModel new] successBlock:^(NSDictionary * returnData, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
        self.authenModel = [YTEAuthenModel yy_modelWithJSON:returnData[@"authen"]];
        [self setGroups];
        [self.tableView reloadData];
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
    }];
}

#pragma mark - Initializer

- (void)setGroups {
    HMSettingItem *item1 = [self.authenModel.daoyou isEqual:YTEAuthValue] ? [HMSettingItemLabel itemWithTitle:@"导游认证" defaultValue:[self stringFromAuthen:self.authenModel.daoyou]] : [HMSettingItemArrow itemWithTitle:@"导游认证" subTitle:[self stringFromAuthen:self.authenModel.daoyou] icon:nil destVc:nil];
    HMSettingItem *item2 = [self.authenModel.fanyi isEqual:YTEAuthValue] ? [HMSettingItemLabel itemWithTitle:@"翻译认证" defaultValue:[self stringFromAuthen:self.authenModel.fanyi]] : [HMSettingItemArrow itemWithTitle:@"翻译认证" subTitle:[self stringFromAuthen:self.authenModel.fanyi] icon:nil destVc:nil];
    HMSettingItem *item3 = [self.authenModel.jieji isEqual:YTEAuthValue] ? [HMSettingItemLabel itemWithTitle:@"车辆认证" defaultValue:[self stringFromAuthen:self.authenModel.jieji]] : [HMSettingItemArrow itemWithTitle:@"车辆认证" subTitle:[self stringFromAuthen:self.authenModel.jieji] icon:nil destVc:nil];
    HMSettingItem *item4 = [self.authenModel.travelagency isEqual:YTEAuthValue] ? [HMSettingItemLabel itemWithTitle:@"旅游公司认证" defaultValue:[self stringFromAuthen:self.authenModel.travelagency]] : [HMSettingItemArrow itemWithTitle:@"旅游公司认证" subTitle:[self stringFromAuthen:self.authenModel.travelagency] icon:nil destVc:nil];
    HMSettingItem *item5 = [self.authenModel.agency isEqual:YTEAuthValue] ? [HMSettingItemLabel itemWithTitle:@"大巴公司认证" defaultValue:[self stringFromAuthen:self.authenModel.agency]] : [HMSettingItemArrow itemWithTitle:@"大巴公司认证" subTitle:[self stringFromAuthen:self.authenModel.agency] icon:nil destVc:nil];
    @weakify(self);
    item1.operationBlock = ^{
        @strongify(self);
        if (![self.authenModel.daoyou isEqual:YTEAuthValue]) [self gotoAuthViewController:YTEMerchantAuthTypeDaoyou];
    };
    item2.operationBlock = ^{
        @strongify(self);
        if (![self.authenModel.fanyi isEqual:YTEAuthValue])[self gotoAuthViewController:YTEMerchantAuthTypeFanyi];
    };
    item3.operationBlock = ^{
        @strongify(self);
        if (![self.authenModel.jieji isEqual:YTEAuthValue])[self gotoAuthViewController:YTEMerchantAuthTypeJieji];
    };
    item4.operationBlock = ^{
        @strongify(self);
        if (![self.authenModel.travelagency isEqual:YTEAuthValue])[self gotoAuthViewController:YTEMerchantAuthTypeTravelagency];
    };
    item5.operationBlock = ^{
        @strongify(self);
       if (![self.authenModel.agency isEqual:YTEAuthValue]) [self gotoAuthViewController:YTEMerchantAuthTypeAgency];
    };
    HMSettingGroup *group1 = [HMSettingGroup groupWithItems:@[item1, item2, item3, item4, item5]];
    self.groups = [NSArray arrayWithObjects:group1, nil];
}

#pragma mark - Private
- (NSString *)stringFromAuthen:(NSString *)authen {
    return [authen isEqual:YTEAuthValue] ? @"已认证" : @"未认证";
}


- (void)gotoAuthViewController:(YTEMerchantAuthType)authType {
    YTEMerchantAuthenViewController *authenViewController = [[YTEMerchantAuthenViewController alloc] init];
    authenViewController.authType = authType;
    [self.navigationController pushViewController:authenViewController animated:YES];
}

#pragma mark - Setter


@end
