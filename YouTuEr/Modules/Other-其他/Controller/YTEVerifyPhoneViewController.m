//
//  YTEVerifyPhoneViewController.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/25.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEVerifyPhoneViewController.h"
#import "YTESetNewPwdViewController.h"
#import "YTEFindPwdServiceModel.h"
#import "JKCountDownButton.h"
#import "NSString+Verify.h"
#import <SMS_SDK/SMSSDK.h>
#import "SRUserService.h"

@interface YTEVerifyPhoneViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet JKCountDownButton *verifyCodeButton;

@end

@implementation YTEVerifyPhoneViewController

#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"验证手机/邮箱";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma mark - Request

- (void)memberGetPwdCaptchaRequest:(void (^)())callback {
    if (![SRReachabilityManager networkIsReachable]) return;
    [self showProgressView];
    @weakify(self);
    if ([self.usernameTextField.text isPhone]) {
        // 手机号-获取验证码
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.usernameTextField.text zone:@"86" result:^(NSError *error) {
            @strongify(self);
            [self hideProgressView];
            if (error) {
                [[SRMessage sharedMessage] showMessage:@"请检查手机号码是否正确" withType:MessageTypeNotice];
            } else {
                callback();
                [[SRMessage sharedMessage] showMessage:@"验证码已发送至手机！" withType:MessageTypeNotice];
            }
        }];
    } else {
        // 邮箱号-获取验证码
        YTEFindPwdServiceModel *serviceModel = [YTEFindPwdServiceModel new];
        serviceModel.account = self.usernameTextField.text;
        [[SRUserService sharedService] memberGetPwdCaptchaRequestWithModel:serviceModel successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
            @strongify(self);
            [self hideProgressView];
            callback();
            [[SRMessage sharedMessage] showMessage:@"验证码已发送至邮箱！" withType:MessageTypeNotice];
        } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
            @strongify(self);
            [self hideProgressView];
        }];
    }
}



- (void)memberGetPwdNextRequest {
    if (![SRReachabilityManager networkIsReachable]) return;
    [self showProgressView];
    @weakify(self);
    if ([self.usernameTextField.text isPhone]) {
        // 手机号-验证验证码
        [SMSSDK commitVerificationCode:self.codeTextField.text phoneNumber:self.usernameTextField.text zone:@"86" result:^(NSError *error){
            @strongify(self);
            [self hideProgressView];
            if (error) {
                [[SRMessage sharedMessage] showMessage:@"验证码错误" withType:MessageTypeNotice];
            } else {
                [self gotoSetNewPwdVC];
            }
        }];
    } else {
        // 邮箱号-验证验证码
        YTEFindPwdServiceModel *serviceModel = [YTEFindPwdServiceModel new];
        serviceModel.account = self.usernameTextField.text;
        serviceModel.code = self.codeTextField.text;
        [[SRUserService sharedService] memberGetPwdNextRequestWithModel:serviceModel successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
            @strongify(self);
            [self hideProgressView];
            [self gotoSetNewPwdVC];
        } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
            @strongify(self);
            [self hideProgressView];
        }];
    }
}

#pragma mark - Action
- (void)gotoSetNewPwdVC {
    YTESetNewPwdViewController *setNewPwdVC = [[YTESetNewPwdViewController alloc] init];
    setNewPwdVC.account = self.usernameTextField.text;
    [self.navigationController pushViewController:setNewPwdVC animated:YES];
}

- (IBAction)getCode:(JKCountDownButton *)sender {
    [self.view endEditing:YES];
    if (![self.usernameTextField.text isPhone] && ![self.usernameTextField.text isEmail]) {
        [[SRMessage sharedMessage] showMessage:@"请输入有效的手机号或邮箱号" withType:MessageTypeNotice];
        return;
    }
    [self memberGetPwdCaptchaRequest:^{
        sender.enabled = NO;
        [sender startWithSecond:60];
        [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
            NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
            return title;
        }];
        [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
            countDownButton.enabled = YES;
            return @"点击重新获取";
        }];
    }];

}

- (IBAction)verifyAction:(UIButton *)sender {
    [self.view endEditing:YES];
    if (![self.usernameTextField.text isPhone] && ![self.usernameTextField.text isEmail]) {
        [[SRMessage sharedMessage] showMessage:@"请输入有效的手机号或邮箱号" withType:MessageTypeNotice];
        return;
    }
    [self memberGetPwdNextRequest];
}


@end
