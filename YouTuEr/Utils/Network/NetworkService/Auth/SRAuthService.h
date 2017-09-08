//
//  SRAuthService.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SRCompanyAuthServiceModel;
@class SRCarAuthServiceModel;
@class SRGuideAuthServiceModel;
@class SRTranslateServiceModel;

@interface SRAuthService : NSObject

+ (SRAuthService *)sharedService;

// 大巴公司认证
- (NSURLSessionTask *)authenBusRequestWithModel:(SRCompanyAuthServiceModel *)serviceModel
                                   successBlock:(NetworkRequestSuccessBlock)successBlock
                                   failureBlock:(NetworkRequestFailureBlock)failureBlock;


// 旅游公司认证
- (NSURLSessionTask *)authenTravelagencyRequestWithModel:(SRCompanyAuthServiceModel *)serviceModel
                                            successBlock:(NetworkRequestSuccessBlock)successBlock
                                            failureBlock:(NetworkRequestFailureBlock)failureBlock;


// 车辆认证
- (NSURLSessionTask *)authenCarRequestWithModel:(SRCarAuthServiceModel *)serviceModel
                                   successBlock:(NetworkRequestSuccessBlock)successBlock
                                   failureBlock:(NetworkRequestFailureBlock)failureBlock;

// 导游认证
- (NSURLSessionTask *)authenCiceroneRequestWithModel:(SRGuideAuthServiceModel *)serviceModel
                                        successBlock:(NetworkRequestSuccessBlock)successBlock
                                        failureBlock:(NetworkRequestFailureBlock)failureBlock;

// 翻译认证
- (NSURLSessionTask *)authenTranslateRequestWithModel:(SRTranslateServiceModel *)serviceModel
                                         successBlock:(NetworkRequestSuccessBlock)successBlock
                                         failureBlock:(NetworkRequestFailureBlock)failureBlock;

// 认证信息
- (NSURLSessionTask *)memberAuthenRequestWithModel:(SRRequestModel *)serviceModel
                                      successBlock:(NetworkRequestSuccessBlock)successBlock
                                      failureBlock:(NetworkRequestFailureBlock)failureBlock;

@end
