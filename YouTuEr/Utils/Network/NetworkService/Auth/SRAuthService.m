//
//  SRAuthService.m
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRAuthService.h"
#import "NSObject+SafeBlock.h"
#import "SRCarAuthServiceModel.h"
#import "SRGuideAuthServiceModel.h"
#import "SRTranslateServiceModel.h"
#import "SRCompanyAuthServiceModel.h"

@implementation SRAuthService

+ (SRAuthService *)sharedService {
    static SRAuthService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [SRAuthService new];
    });
    return instance;
}


- (NSURLSessionTask *)authenBusRequestWithModel:(SRCompanyAuthServiceModel *)serviceModel
                                   successBlock:(NetworkRequestSuccessBlock)successBlock
                                   failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_AUTHENBUS;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

- (NSURLSessionTask *)authenTravelagencyRequestWithModel:(SRCompanyAuthServiceModel *)serviceModel
                                            successBlock:(NetworkRequestSuccessBlock)successBlock
                                            failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_AUTHENTRAVELAGENCY;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

- (NSURLSessionTask *)authenCarRequestWithModel:(SRCarAuthServiceModel *)serviceModel
                                   successBlock:(NetworkRequestSuccessBlock)successBlock
                                   failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_AUTHENCAR;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

- (NSURLSessionTask *)authenCiceroneRequestWithModel:(SRGuideAuthServiceModel *)serviceModel
                                        successBlock:(NetworkRequestSuccessBlock)successBlock
                                        failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_AUTHENCICERONE;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

- (NSURLSessionTask *)authenTranslateRequestWithModel:(SRTranslateServiceModel *)serviceModel
                                         successBlock:(NetworkRequestSuccessBlock)successBlock
                                         failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_AUTHENTRANSLATE;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

- (NSURLSessionTask *)memberAuthenRequestWithModel:(SRRequestModel *)serviceModel
                                      successBlock:(NetworkRequestSuccessBlock)successBlock
                                      failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_MEMBERAUTHEN;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

@end
