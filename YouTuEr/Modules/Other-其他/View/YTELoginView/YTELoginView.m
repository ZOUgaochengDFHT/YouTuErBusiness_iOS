//
//  YTELoginView.m
//  YouTuEr
//
//  Created by 苏一 on 2017/6/13.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTELoginView.h"

@interface YTELoginView()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation YTELoginView
#pragma mark - View Cycle

- (void)awakeFromNib{
    [super awakeFromNib];
}
// 构造函数
+ (instancetype)loginView{
    return [[[NSBundle mainBundle] loadNibNamed:@"YTELoginView" owner:self options:nil] lastObject];
}

#pragma mark - Action

- (IBAction)cancleBtnClick:(id)sender {
    [self dismissKeyboard];
    if (self.cancleBtnBlock) {
        self.cancleBtnBlock();
    }
}

- (IBAction)registerBtnClick:(id)sender {
    [self dismissKeyboard];
    if (self.registerBtnBlock) {
        self.registerBtnBlock();
    }
}
- (IBAction)forgetBtnClick:(id)sender {
    [self dismissKeyboard];
    if (self.forgetBtnBlock) self.forgetBtnBlock();
}

- (IBAction)loginBtnClick:(id)sender {
    [self dismissKeyboard];
    NSString *accountText = self.accountTextField.text;
    NSString *pswText = self.passwordTextField.text;
    if (self.loginBtnBlock) {
        self.loginBtnBlock(accountText, pswText);
    }
}

#pragma mark - Private
- (void)dismissKeyboard {
    [self endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissKeyboard];
}

@end
