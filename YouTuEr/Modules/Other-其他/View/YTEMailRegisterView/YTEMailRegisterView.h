//
//  YTEMailRegisterView.h
//  YouTuEr
//
//  Created by 苏一 on 2017/6/6.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTEMailRegisterView : UIView

@property (nonatomic, copy) void (^registerBtnBlock)(NSString *phoneNum, NSString *pswText, BOOL pswState);
// 构造函数
+ (instancetype)mainRegisterView;

@end
