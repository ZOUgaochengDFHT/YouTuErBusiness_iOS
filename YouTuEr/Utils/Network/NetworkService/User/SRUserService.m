//
//  SRUserService.m
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRUserService.h"

@implementation SRUserService

+ (SRUserService *)sharedService {
    static SRUserService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [SRUserService new];
    });
    return instance;
}


- (NSURLSessionTask *)memberLoginRequestWithModel:(SRLoginServiceModel *)serviceModel
                                     successBlock:(NetworkRequestSuccessBlock)successBlock
                                     failureBlock:(NetworkRequestFailureBlock)failureBlock{
    serviceModel.url = SR_MEMBERLOGIN;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}


- (NSURLSessionTask *)memberRegistRequestWithModel:(SRRegisterServiceModel *)serviceModel
                                      successBlock:(NetworkRequestSuccessBlock)successBlock
                                      failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_MEMBERREGIST;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

- (NSURLSessionTask *)memberUpdatePwdRequestWithModel:(SRUpdatePwdSerivceModel *)serviceModel
                                         successBlock:(NetworkRequestSuccessBlock)successBlock
                                         failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_MEMBERUPDATEPWD;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

- (NSURLSessionTask *)memberGetInfoRequestWithModel:(SRGetInfoServiceModel *)serviceModel
                                       successBlock:(NetworkRequestSuccessBlock)successBlock
                                       failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_MEMBERGETINFO;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

- (NSURLSessionTask *)memberSaveInfoRequestWithModel:(SRSaveInfoServiceModel *)serviceModel
                                        successBlock:(NetworkRequestSuccessBlock)successBlock
                                        failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_MEMBERSAVEINFO;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}


- (NSURLSessionTask *)memberGetAmountRequestWithModel:(SRAmountServiceModel *)serviceModel
                                         successBlock:(NetworkRequestSuccessBlock)successBlock
                                         failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_MEMBERGETAMOUNT;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

- (NSURLSessionTask *)memberWithdrawRequestWithModel:(SRWithdrawServiceModel *)serviceModel
                                        successBlock:(NetworkRequestSuccessBlock)successBlock
                                        failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_MEMBERWITHDRAW;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

- (NSURLSessionTask *)memberGetPwdCaptchaRequestWithModel:(YTEFindPwdServiceModel *)serviceModel
                                             successBlock:(NetworkRequestSuccessBlock)successBlock
                                             failureBlock:(NetworkRequestFailureBlock)failureBlock{
    serviceModel.url = SR_MEMBERGETPWDCAPTCHA;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

- (NSURLSessionTask *)memberGetPwdNextRequestWithModel:(YTEFindPwdServiceModel *)serviceModel
                                          successBlock:(NetworkRequestSuccessBlock)successBlock
                                          failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_MEMBERGETPWDNEXT;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

- (NSURLSessionTask *)memberSetNewPwdRequestWithModel:(YTEFindPwdServiceModel *)serviceModel
                                         successBlock:(NetworkRequestSuccessBlock)successBlock
                                         failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_MEMBERSETNEWPWD;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

@end
