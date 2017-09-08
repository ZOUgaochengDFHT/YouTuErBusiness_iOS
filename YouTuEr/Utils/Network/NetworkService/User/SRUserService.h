//
//  SRUserService.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+SafeBlock.h"
#import "SRLoginServiceModel.h"
#import "SRAmountServiceModel.h"
#import "SRGetInfoServiceModel.h"
#import "SRSaveInfoServiceModel.h"
#import "SRRegisterServiceModel.h"
#import "SRWithdrawServiceModel.h"
#import "SRUpdatePwdSerivceModel.h"
#import "YTEFindPwdServiceModel.h"


@interface SRUserService : NSObject

+ (SRUserService *)sharedService;

// 登录
- (NSURLSessionTask *)memberLoginRequestWithModel:(SRLoginServiceModel *)serviceModel
                                     successBlock:(NetworkRequestSuccessBlock)successBlock
                                     failureBlock:(NetworkRequestFailureBlock)failureBlock;

// 注册
- (NSURLSessionTask *)memberRegistRequestWithModel:(SRRegisterServiceModel *)serviceModel
                                      successBlock:(NetworkRequestSuccessBlock)successBlock
                                      failureBlock:(NetworkRequestFailureBlock)failureBlock;
// 修改密码
- (NSURLSessionTask *)memberUpdatePwdRequestWithModel:(SRUpdatePwdSerivceModel *)serviceModel
                                         successBlock:(NetworkRequestSuccessBlock)successBlock
                                         failureBlock:(NetworkRequestFailureBlock)failureBlock;

// 获取用户信息
- (NSURLSessionTask *)memberGetInfoRequestWithModel:(SRGetInfoServiceModel *)serviceModel
                                       successBlock:(NetworkRequestSuccessBlock)successBlock
                                       failureBlock:(NetworkRequestFailureBlock)failureBlock;
// 保存用户信息
- (NSURLSessionTask *)memberSaveInfoRequestWithModel:(SRSaveInfoServiceModel *)serviceModel
                                        successBlock:(NetworkRequestSuccessBlock)successBlock
                                        failureBlock:(NetworkRequestFailureBlock)failureBlock;

// 查询余额
- (NSURLSessionTask *)memberGetAmountRequestWithModel:(SRAmountServiceModel *)serviceModel
                                         successBlock:(NetworkRequestSuccessBlock)successBlock
                                         failureBlock:(NetworkRequestFailureBlock)failureBlock;

// 商家提现
- (NSURLSessionTask *)memberWithdrawRequestWithModel:(SRWithdrawServiceModel *)serviceModel
                                        successBlock:(NetworkRequestSuccessBlock)successBlock
                                        failureBlock:(NetworkRequestFailureBlock)failureBlock;

// 找回密码 – 1).发送验证码
- (NSURLSessionTask *)memberGetPwdCaptchaRequestWithModel:(YTEFindPwdServiceModel *)serviceModel
                                             successBlock:(NetworkRequestSuccessBlock)successBlock
                                             failureBlock:(NetworkRequestFailureBlock)failureBlock;

// 找回密码 – 2).下一步
- (NSURLSessionTask *)memberGetPwdNextRequestWithModel:(YTEFindPwdServiceModel *)serviceModel
                                          successBlock:(NetworkRequestSuccessBlock)successBlock
                                          failureBlock:(NetworkRequestFailureBlock)failureBlock;

// 找回密码 – 3).设置新密码
- (NSURLSessionTask *)memberSetNewPwdRequestWithModel:(YTEFindPwdServiceModel *)serviceModel
                                         successBlock:(NetworkRequestSuccessBlock)successBlock
                                         failureBlock:(NetworkRequestFailureBlock)failureBlock;

@end
