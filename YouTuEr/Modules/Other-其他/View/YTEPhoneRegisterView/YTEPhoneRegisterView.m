//
//  YTEPhoneRegisterView.m
//  YouTuEr
//
//  Created by 苏一 on 2017/6/6.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEPhoneRegisterView.h"
#import "JKCountDownButton.h"
#import "NSString+Verify.h"
@interface YTEPhoneRegisterView ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField; //手机
@property (weak, nonatomic) IBOutlet UITextField *verifyTextField; //验证码
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn; //验证码按钮
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField; //密码
@property (weak, nonatomic) IBOutlet UITextField *confirmPwdTextField; //确认密码

@property (weak, nonatomic) IBOutlet UIImageView *correctPwdImageView; //密码合适
@property (weak, nonatomic) IBOutlet UIImageView *correctComfirmPwdImageView; //确认密码合适

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@end

@implementation YTEPhoneRegisterView


- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}
// 构造函数
+ (instancetype)phoneRegisterView{
    return [[[NSBundle mainBundle] loadNibNamed:@"YTEPhoneRegisterView"
                                          owner:self
                                        options:nil] lastObject];
}


#pragma mark- Action
////获取验证码
- (IBAction)getVerifiers:(JKCountDownButton *)sender {
    [self endEditing:YES];
    NSString *phoneNumber = self.phoneNumTextField.text;
    if (self.verifyBtnBlock) {
        if (!self.verifyBtnBlock(phoneNumber)) {
            return;
        }
    }
    self.successGetVerifyCodeBlock = ^{
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
    };
}

- (IBAction)registerBtn:(UIButton *)sender {
    [self endEditing:YES];
    NSString *phoneNumber = self.phoneNumTextField.text;
    NSString *verifyNum = self.verifyTextField.text;
    NSString *pswText = self.passwordTextField.text;
    BOOL pswState = self.correctComfirmPwdImageView.highlighted;
    if (self.registerBtnBlock) {
        self.registerBtnBlock(phoneNumber, verifyNum, pswText, pswState);
    }
}

- (IBAction)textFieldTextEditingChanged:(UITextField *)sender {
    if (self.passwordTextField == sender) {
        BOOL isValid = [self.passwordTextField.text checkPassWord];
        self.correctComfirmPwdImageView.highlighted = (isValid && [sender.text isEqual:self.confirmPwdTextField.text])? YES : NO;
        self.correctPwdImageView.highlighted = isValid ? YES : NO;
    }else {
        self.correctComfirmPwdImageView.highlighted = ([self.passwordTextField.text isEqual:self.confirmPwdTextField.text] && self.correctPwdImageView.highlighted) ? YES : NO;
    }
}



@end
