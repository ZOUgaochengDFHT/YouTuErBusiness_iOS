//
//  YTEPhoneRegisterView.h
//  YouTuEr
//
//  Created by 苏一 on 2017/6/6.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTEPhoneRegisterView : UIView

@property (nonatomic, copy) void (^registerBtnBlock)(NSString *phoneNum,NSString *verifyNum, NSString *pswText, BOOL pswState);
@property (nonatomic, copy) BOOL (^verifyBtnBlock)(NSString *phoneNum);

@property (nonatomic, copy) void (^successGetVerifyCodeBlock)();

+ (instancetype)phoneRegisterView;
@end
