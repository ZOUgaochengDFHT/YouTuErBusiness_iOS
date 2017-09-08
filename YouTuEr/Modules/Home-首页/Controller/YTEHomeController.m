//
//  YTEHomeController.m
//  YouTuEr
//
//  Created by ss on 17/2/18.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEDemandViewController.h"
#import "YTEHomeController.h"
#import "YTEAuthenModel.h"
#import "SRAuthService.h"
#import "YTEHomeView.h"

@interface YTEHomeController ()<YTEHomeViewDelegate>

@property (strong, nonatomic) YTEAuthenModel *authenModel;

@end

@implementation YTEHomeController
#pragma mark - View Cycle

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.navigationController.childViewControllers.count > 1) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    YTEHomeView *homeView = [YTEHomeView homeView];
    self.view = homeView;
    homeView.homeViewDelegate = self;
    [self memberAuthenRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - YTEHomeViewDelegate

- (void)homeViewButtonDidClicked:(UIButton *)button destVCName:(NSString *)destVCName{
    Class destVCClass = NSClassFromString(destVCName);
    UIViewController *destVC = [[destVCClass alloc] init];
    destVC.title = button.titleLabel.text;
    if (![destVC.title boolValueFromAuthen:self.authenModel]) {
        [[SRMessage sharedMessage] showMessage:@"请先进行商家认证!" withType:MessageTypeNotice];
        return;
    }
    ((YTEDemandViewController *)destVC).businessType = [NSString businessTypeFromTitle:destVC.title];
    [self.navigationController pushViewController:destVC animated:YES];
    
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
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
    }];
}

@end
