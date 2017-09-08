//
//  YTEMailRegisterView.m
//  YouTuEr
//
//  Created by 苏一 on 2017/6/6.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEMailRegisterView.h"
#import "NSString+Verify.h"

@interface YTEMailRegisterView ()
@property (weak, nonatomic) IBOutlet UITextField *emailNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwdTextField;
@property (weak, nonatomic) IBOutlet UIImageView *correctPwdImageView;
@property (weak, nonatomic) IBOutlet UIImageView *correctComfirmPwdImageView;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation YTEMailRegisterView

- (void)awakeFromNib {
    [super awakeFromNib];
}

// 构造函数
+ (instancetype)mainRegisterView {
    return [[[NSBundle mainBundle] loadNibNamed:@"YTEMailRegisterView"
                                          owner:self
                                        options:nil] lastObject];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}


#pragma mark - Action

- (IBAction)registerBtn:(UIButton *)sender {
    [self endEditing:YES];
    NSString *phoneNumber = self.emailNumTextField.text;
    NSString *pswText = self.passwordTextField.text;
    BOOL pswState = self.correctComfirmPwdImageView.highlighted;
    if (self.registerBtnBlock) {
        self.registerBtnBlock(phoneNumber, pswText, pswState);
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
