//
//  YTERegisterViewController.m
//  YouTuEr
//
//  Created by 苏一 on 2017/6/1.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTERegisterViewController.h"
#import "YTEB&OSegmentView.h"
#import "YTEPhoneRegisterView.h"
#import "YTEMailRegisterView.h"
#import "NSString+Verify.h"
#import <SMS_SDK/SMSSDK.h>
#import "YTENetworkTool.h"
#import "SRUserService.h"
#import "SRLoginServiceModel.h"
#import "SRRegisterServiceModel.h"

@interface YTERegisterViewController ()<UIScrollViewDelegate, YTEB_OSegmentViewDelegate>
@property (nonatomic, strong) UIAlertController *alertC;// 提示框
@property (nonatomic, strong) YTEB_OSegmentView *segmentView;
@property (nonatomic, assign) NSInteger selectIndex;// 头部按钮选择顺序
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YTEPhoneRegisterView *phoneRegisterView;
@property (nonatomic, strong) YTEMailRegisterView *mailRegisterView;

@end

@implementation YTERegisterViewController

#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configView];
}

#pragma mark - Initializer

- (void)configView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"注册";
    self.segmentView = [YTEB_OSegmentView segmentViewWithTitles:@[@"手机注册",@"邮箱注册"]];
    self.segmentView.delegate = self;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.segmentView];
    [self addChildViews];
}

- (void)addChildViews {
    [self.scrollView addSubview:self.phoneRegisterView];
    [self.scrollView addSubview:self.mailRegisterView];
    CGFloat contentX = self.segmentView.titles.count * YTEScreenBoundsWidth;
    self.scrollView.contentSize = CGSizeMake(contentX, 0);
}

#pragma mark - Request
// 验证验证码是否正确
- (void)commitVerificationCode:(NSString *)phoneNumber verifyNum:(NSString *)verifyNum pswText:(NSString *)pswText pswState:(BOOL)pswState {
    @weakify(self);
    if (![phoneNumber isPhone]) {
        [[SRMessage sharedMessage] showMessage:@"请输入有效手机号" withType:MessageTypeNotice];
        return;
    }else if (!(verifyNum.length == 4)) {
        [[SRMessage sharedMessage] showMessage:@"请确认验证码正确" withType:MessageTypeNotice];
        return;
    }else if (![pswText checkPassword]) {
        [[SRMessage sharedMessage] showMessage:@"请设置有效密码" withType:MessageTypeNotice];
        return;
    }else if (!pswState) {
        [[SRMessage sharedMessage] showMessage:@"请确认密码正确" withType:MessageTypeNotice];
        return;
    }
    
    if (![SRReachabilityManager networkIsReachable]) return;
    [self showProgressView];
    //将验证码发送到服务器,判断验证码是否正确
    [SMSSDK commitVerificationCode:verifyNum phoneNumber:phoneNumber zone:@"86" result:^(NSError *error){
        @strongify(self);
        [self hideProgressView];
        if (error) {
            [[SRMessage sharedMessage] showMessage:@"验证码错误" withType:MessageTypeNotice];
        } else {
            NSLog(@"验证成功");
            [self memberRegistRequest:phoneNumber pswText:pswText];
        }
    }];
}

// 获取验证码
- (BOOL)getVerificationCodeByMethod:(NSString *)phoneNumber {
    if (![phoneNumber isPhone]) {
        [[SRMessage sharedMessage] showMessage:@"请输入有效手机号" withType:MessageTypeNotice];
        return NO;
    }
    if (![SRReachabilityManager networkIsReachable]) return NO;
    [self showProgressView];
    @weakify(self);
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneNumber zone:@"86" result:^(NSError *error) {
        @strongify(self);
        [self hideProgressView];
        if (error) {
            [[SRMessage sharedMessage] showMessage:@"请检查手机号码是否正确" withType:MessageTypeNotice];
        } else {
            if (self.phoneRegisterView.successGetVerifyCodeBlock) self.phoneRegisterView.successGetVerifyCodeBlock();
            [[SRMessage sharedMessage] showMessage:@"验证码已发送" withType:MessageTypeNotice];
        }
    }];
    return YES;
}

// 注册
- (void)memberRegistRequest:(NSString *)phoneNumber pswText:(NSString *)pswText {
    SRRegisterServiceModel *serviceModel = [SRRegisterServiceModel new];
    serviceModel.account = phoneNumber;
    serviceModel.password = pswText;
    if (![SRReachabilityManager networkIsReachable]) return;
    [self showProgressView];
    @weakify(self);
    [[SRUserService sharedService] memberRegistRequestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
        [self.navigationController popViewControllerAnimated:YES];
        [[SRMessage sharedMessage] showMessage:@"注册成功，请登陆！" withType:MessageTypeNotice];
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
    }];
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self.segmentView setButtonSelectedWithTag:index + 100];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //1、滑动到当前page的处理
    CGFloat pageRate = scrollView.contentOffset.x / scrollView.yte_width;
    if (((int)(pageRate*1000))%1000<1) {
        int page = (int)pageRate;//当前滑动到的page
        if (_selectIndex != page) {
            _selectIndex = page;
            //            [self tabItemSelected:_currentIndex];
        }
    }
    //2、YXCommonUITabsTopViewTypeForNoScroll模式下面 对于maskView的处理
    CGFloat rate = scrollView.contentOffset.x/scrollView.contentSize.width;
    [self.segmentView maskViewScrollToPositionX:rate * self.view.yte_width];
}



#pragma mark - YTEB_OSegmentViewDelegate
- (void)segmentView:(YTEB_OSegmentView *)segmentView didClickButtonAtIndex:(NSInteger)index {
    if (_selectIndex == index) {
        return;
    }
    _selectIndex = index;
    CGPoint contentOff = self.scrollView.contentOffset;
    contentOff.x = YTEScreenBoundsWidth * index;
    [self.scrollView setContentOffset:contentOff animated:YES];
}

#pragma mark - Setter
- (UIScrollView *)scrollView{
    if(_scrollView == nil){
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, self.segmentView.yte_bottom, YTEScreenBoundsWidth, YTEScreenBoundsHeight - self.segmentView.yte_bottom);
        _scrollView.delegate = self;
        _scrollView.backgroundColor = YTEGlobalBGColor;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollsToTop = NO;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    if(_selectIndex != selectIndex){
        _selectIndex = selectIndex;
        CGPoint contentOff = self.scrollView.contentOffset;
        contentOff.x = YTEScreenBoundsWidth * selectIndex;
        self.scrollView.contentOffset = contentOff;
    }else{
        //刷新
    }
}
- (YTEPhoneRegisterView *)phoneRegisterView {
    if (!_phoneRegisterView) {
        YTEPhoneRegisterView *phoneRegisterView = [YTEPhoneRegisterView phoneRegisterView];
        phoneRegisterView.frame = CGRectMake(0, 0, YTEScreenBoundsWidth, YTEScreenBoundsHeight);
        _phoneRegisterView = phoneRegisterView;
        @weakify(self);
        phoneRegisterView.registerBtnBlock = ^(NSString *phoneNumber, NSString *verifyNum, NSString *pswText, BOOL pswState){
            @strongify(self);
            [self commitVerificationCode:phoneNumber verifyNum:verifyNum pswText:pswText pswState:pswState];
        };
        phoneRegisterView.verifyBtnBlock = ^(NSString *phoneNumber){
            @strongify(self);
            return [self getVerificationCodeByMethod:phoneNumber];
        };
    }
    return _phoneRegisterView;
}

- (YTEMailRegisterView *)mailRegisterView {
    if (!_mailRegisterView) {
        YTEMailRegisterView *mailRegisterView = [YTEMailRegisterView mainRegisterView];
        mailRegisterView.frame = CGRectMake(YTEScreenBoundsWidth * 1, 0, YTEScreenBoundsWidth, YTEScreenBoundsHeight);
        _mailRegisterView = mailRegisterView;
        @weakify(self);
        mailRegisterView.registerBtnBlock = ^(NSString *phoneNum, NSString *pswText, BOOL pswState) {
            @strongify(self);
            if (![phoneNum isEmail]) {
                [[SRMessage sharedMessage] showMessage:@"请输入有效邮箱号" withType:MessageTypeNotice];
                return;
            }else if (![pswText checkPassword]) {
                [[SRMessage sharedMessage] showMessage:@"请设置有效密码" withType:MessageTypeNotice];
                return;
            }else if (!pswState) {
                [[SRMessage sharedMessage] showMessage:@"请确认密码正确" withType:MessageTypeNotice];
                return;
            }
            [self memberRegistRequest:phoneNum pswText:pswText];
        };
    }
    return _mailRegisterView;
}

@end
