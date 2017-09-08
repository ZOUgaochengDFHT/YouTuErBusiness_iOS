//
//  YTEModifyPSWViewController.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/23.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEModifyPSWViewController.h"
#import "SRUpdatePwdSerivceModel.h"
#import "SRUserService.h"

@interface YTEModifyPSWViewController ()

@property (strong, nonatomic) SRUpdatePwdSerivceModel *serviceModel;

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *yteNewPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *yteNewPasswordConfirmTextField;
@property (weak, nonatomic) IBOutlet UIImageView *oldCorrectImageView;
@property (weak, nonatomic) IBOutlet UIImageView *yteNewCorrectImageView;
@property (weak, nonatomic) IBOutlet UIImageView *yteNewCorrectConfirmImageView;


@end

@implementation YTEModifyPSWViewController

#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Request

- (void)memberUpdatePwdRequest {
    self.serviceModel.oldPwd = self.oldPasswordTextField.text;
    self.serviceModel.sr_newPwd = self.yteNewPasswordTextField.text;
    if (![SRReachabilityManager networkIsReachable]) return;
    [self showProgressView];
    @weakify(self);
    [[SRUserService sharedService] memberUpdatePwdRequestWithModel:self.serviceModel successBlock:^(NSDictionary *returnData, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
        [self.navigationController popViewControllerAnimated:YES];
        [[SRMessage sharedMessage] showMessage:@"密码修改成功" withType:MessageTypeNotice];
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
    }];
}

#pragma mark - Action

- (IBAction)textFieldEditingChanged:(UITextField *)sender {
    if ([sender isEqual:self.oldPasswordTextField]) {
        self.oldCorrectImageView.highlighted = [self.oldPasswordTextField.text checkPassWord] ? YES : NO;
    } else if ([sender isEqual:self.yteNewPasswordTextField]) {
        BOOL isValid = [self.yteNewPasswordTextField.text checkPassWord];
        self.yteNewCorrectConfirmImageView.highlighted = (isValid && [sender.text isEqual:self.yteNewPasswordConfirmTextField.text])? YES : NO;
        self.yteNewCorrectImageView.highlighted = isValid ? YES : NO;
    } else {
        self.yteNewCorrectConfirmImageView.highlighted = ([self.yteNewPasswordTextField.text isEqual:self.yteNewPasswordConfirmTextField.text] && self.yteNewCorrectImageView.highlighted) ? YES : NO;
    }
}

- (IBAction)submit:(UIButton *)sender {
    [self.view endEditing:YES];
    if (![self.yteNewPasswordTextField.text checkPassWord]) {
        [[SRMessage sharedMessage] showMessage:@"请设置有效密码" withType:MessageTypeNotice];
        return;
    }else if (!self.yteNewCorrectConfirmImageView.highlighted) {
        [[SRMessage sharedMessage] showMessage:@"请确认密码正确" withType:MessageTypeNotice];
        return;
    }
    [self memberUpdatePwdRequest];
}
#pragma mark - Getter

- (SRUpdatePwdSerivceModel *)serviceModel {
    if (!_serviceModel) _serviceModel = [SRUpdatePwdSerivceModel new];
    return _serviceModel;
}


@end
