//
//  YTESetNewPwdViewController.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/25.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTESetNewPwdViewController.h"
#import "YTEFindPwdServiceModel.h"
#import "NSString+Verify.h"
#import "SRUserService.h"


@interface YTESetNewPwdViewController () 
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwdTextField;
@property (weak, nonatomic) IBOutlet UIImageView *correctPwdImageView;
@property (weak, nonatomic) IBOutlet UIImageView *correctComfirmPwdImageView;

@end

@implementation YTESetNewPwdViewController

#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - Initializer
- (void)configureView {
    self.navigationItem.title = @"设置新密码";
}

#pragma mark - Request
- (void)memberSetNewPwdRequest {
    YTEFindPwdServiceModel *serviceModel = [YTEFindPwdServiceModel new];
    serviceModel.account = self.account;
    serviceModel.password = self.passwordTextField.text;
    if (![SRReachabilityManager networkIsReachable]) return;
    [self showProgressView];
    @weakify(self);
    [[SRUserService sharedService] memberSetNewPwdRequestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[SRMessage sharedMessage] showMessage:@"密码找回成功，请登陆！" withType:MessageTypeNotice];
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
    }];
}

#pragma mark - Action
- (IBAction)textFieldTextEditingChanged:(UITextField *)sender {
    if (self.passwordTextField == sender) {
        BOOL isValid = [self.passwordTextField.text checkPassWord];
        self.correctComfirmPwdImageView.highlighted = (isValid && [sender.text isEqual:self.confirmPwdTextField.text])? YES : NO;
        self.correctPwdImageView.highlighted = isValid ? YES : NO;
    }else {
        self.correctComfirmPwdImageView.highlighted = ([self.passwordTextField.text isEqual:self.confirmPwdTextField.text] && self.correctPwdImageView.highlighted) ? YES : NO;
    }
}



- (IBAction)submit:(UIButton *)sender {
    [self.view endEditing:YES];
    if (![self.passwordTextField.text checkPassword]) {
        [[SRMessage sharedMessage] showMessage:@"请设置有效密码" withType:MessageTypeNotice];
        return;
    }else if (!self.correctComfirmPwdImageView.highlighted) {
        [[SRMessage sharedMessage] showMessage:@"请确认密码正确" withType:MessageTypeNotice];
        return;
    }
    [self memberSetNewPwdRequest];
}


@end
