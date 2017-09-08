//
//  YTELoginView.h
//  YouTuEr
//
//  Created by 苏一 on 2017/6/13.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTELoginView : UIView
@property (nonatomic, copy) void (^loginBtnBlock)(NSString *phoneNum, NSString *pswText);
@property (nonatomic, copy) void (^cancleBtnBlock)();
@property (nonatomic, copy) void (^registerBtnBlock)();
@property (nonatomic, copy) void (^forgetBtnBlock)();

+ (instancetype)loginView;
@end
