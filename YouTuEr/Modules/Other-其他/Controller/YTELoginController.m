//
//  YTELoginController.m
//  YouTuEr
//
//  Created by 苏一 on 2017/6/13.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEVerifyPhoneViewController.h"
#import "YTEFillInDataViewController.h"
#import "YTERegisterViewController.h"
#import "YTENavigationController.h"
#import "SRLoginServiceModel.h"
#import "YTETabBarController.h"
#import "YTELoginController.h"
#import "NSString+Verify.h"
#import "YTEAuthenModel.h"
#import "YTENetworkTool.h"
#import "SRUserService.h"
#import "YTELoginView.h"
#import "YTEUser.h"

static NSString *const emPassword = @"qq1111";

@interface YTELoginController ()
@property(nonatomic,strong)UIAlertController *alertC;//提示框

@end

@implementation YTELoginController

#pragma mark - View Cycle

// 隐藏navigationBar
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];
}
// 显示navigationBar
- (void)viewWillDisappear:(BOOL)animated
{
    if ( self.navigationController.childViewControllers.count > 1 ) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initializer

- (void)setupView {
    YTELoginView *loginView = [YTELoginView loginView];
    self.view = loginView;
    @weakify(self);
    loginView.cancleBtnBlock = ^(){
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    loginView.registerBtnBlock = ^(){
        @strongify(self);
        [self.navigationController pushViewController:[[YTERegisterViewController alloc] init] animated:YES];
    };
    loginView.forgetBtnBlock = ^{
        @strongify(self);
        [self.navigationController pushViewController:[[YTEVerifyPhoneViewController alloc] init] animated:YES];
    };
    
    loginView.loginBtnBlock = ^(NSString *phoneNum, NSString *pswText){
        @strongify(self);
        [self memberLoginRequest:phoneNum pswText:pswText];
    };
}

#pragma mark - Request

- (void)memberLoginRequest:(NSString *)phoneNum pswText:(NSString *)pswText {
    if (![SRReachabilityManager networkIsReachable]) return;
    [self showProgressView];
    SRLoginServiceModel *serviceModel = [SRLoginServiceModel new];
    serviceModel.account = phoneNum;
    serviceModel.password = pswText;
    @weakify(self);
    [[SRUserService sharedService] memberLoginRequestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        @strongify(self);
        
        [self emregisterWithUsername:phoneNum];
        [self hideProgressView];
        [self performBlock:^{
            [[SRMessage sharedMessage] showMessage:returnData[kDataJSONKey_Msg] withType:MessageTypeNotice];
        } afterDelay:0.5];
        [[SRUserDefaultManager sharedManager] setObject:returnData[SR_CLINETID] forKey:SR_CLINETID];
        [[SRUserDefaultManager sharedManager] setObject:returnData[SR_AUTHEN] forKey:SR_AUTHEN];
        [[SRUserDefaultManager sharedManager] setObject:returnData[SR_HASPROFILE] forKey:SR_HASPROFILE];
        self.view.window.rootViewController = [returnData[SR_HASPROFILE] isEqual:@"true"] ?  [[YTETabBarController alloc] init] : [[YTENavigationController alloc] initWithRootViewController:[[YTEFillInDataViewController alloc] init]];
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
    }];
}

- (void)emregisterWithUsername:(NSString *)username {
    username = [username componentsSeparatedByString:@"@"].firstObject;
    void (^emloginBlock)() = ^{
        EMError* (^loginActionBlock)() = ^{
            return [[EMClient sharedClient] loginWithUsername:username password:emPassword];
        };
        EMError *error = loginActionBlock();
        if (error) {
            loginActionBlock();
        } else {
            NSLog(@"登录成功");
        }
        [[EMClient sharedClient].options setIsAutoLogin:YES];
    };
    
    EMError *error = [[EMClient sharedClient] registerWithUsername:username password:emPassword];
    if (!error) {
        emloginBlock();
    } else {
        switch (error.code) {
            case EMErrorServerNotReachable:
                [[SRMessage sharedMessage] showMessage:NSLocalizedString(@"error.connectServerFail", @"Connect to the server failed!") withType:MessageTypeNotice];
                break;
            case EMErrorUserAlreadyExist:
                emloginBlock();
                break;
            case EMErrorNetworkUnavailable:
                [[SRMessage sharedMessage] showMessage:NSLocalizedString(@"error.connectNetworkFail", @"No network connection!") withType:MessageTypeNotice];
                break;
            case EMErrorServerTimeout:
                [[SRMessage sharedMessage] showMessage:NSLocalizedString(@"error.connectServerTimeout", @"Connect to the server timed out!") withType:MessageTypeNotice];
                break;
            case EMErrorServerServingForbidden:
                [[SRMessage sharedMessage] showMessage:NSLocalizedString(@"servingIsBanned", @"Serving is banned") withType:MessageTypeNotice];
                break;
            default:
                [[SRMessage sharedMessage] showMessage:NSLocalizedString(@"register.fail", @"Registration failed") withType:MessageTypeNotice];
                break;
               
        }
    }
}



@end
