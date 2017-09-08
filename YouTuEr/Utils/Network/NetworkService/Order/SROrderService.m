//
//  SROrderService.m
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SROrderService.h"
#import "NSObject+SafeBlock.h"
#import "SRBidsServiceModel.h"
#import "SRMyQuoteServiceModel.h"
#import "SRCancelBidServiceModel.h"
#import "SRQuoteOrderServiceModel.h"
#import "SRUpdateQuoteServiceModel.h"


@implementation SROrderService

+ (SROrderService *)sharedService {
    static SROrderService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [SROrderService new];
    });
    return instance;
}

// 需求列表(可投标列表)
- (NSURLSessionTask *)omerchartDemandRequestWithModel:(SRBidsServiceModel *)serviceModel
                                         successBlock:(NetworkRequestSuccessBlock)successBlock
                                         failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_OMERCHARTDEMAND;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

// 抢单(报价)
- (NSURLSessionTask *)omerchartQuoteOrderRequestWithModel:(SRQuoteOrderServiceModel *)serviceModel
                                             successBlock:(NetworkRequestSuccessBlock)successBlock
                                             failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_OMERCHARTQUOTEORDER;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

// 我的报价(到修改报价页面也调用该接口)
- (NSURLSessionTask *)omerchartMyQuoteRequestWithModel:(SRMyQuoteServiceModel *)serviceModel
                                          successBlock:(NetworkRequestSuccessBlock)successBlock
                                          failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_OMERCHARTMYQUOTE;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}


// 修改报价
- (NSURLSessionTask *)omerchartUpdateQuoteRequestWithModel:(SRUpdateQuoteServiceModel *)serviceModel
                                              successBlock:(NetworkRequestSuccessBlock)successBlock
                                              failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_OMERCHARTUPDATEORDER;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

// 取消投标
- (NSURLSessionTask *)omerchartCancelBidRequestWithModel:(SRCancelBidServiceModel *)serviceModel
                                            successBlock:(NetworkRequestSuccessBlock)successBlock
                                            failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_OMERCHARTCANCELBID;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}
// 我的投标 -- 需求列表
- (NSURLSessionTask *)omerchartMyBidRequestWithModel:(SRBidsServiceModel *)serviceModel
                                        successBlock:(NetworkRequestSuccessBlock)successBlock
                                        failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_OMERCHARTMYBID;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

// 我的投标 - 正在进行
- (NSURLSessionTask *)omerchartMyBidProcessingRequestWithModel:(SRBidsServiceModel *)serviceModel
                                                  successBlock:(NetworkRequestSuccessBlock)successBlock
                                                  failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_OMERCHARTMYBIDPROCESSING;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

// 我的投标 - 历史订单
- (NSURLSessionTask *)omerchartMyBidHistoryRequestWithModel:(SRBidsServiceModel *)serviceModel
                                               successBlock:(NetworkRequestSuccessBlock)successBlock
                                               failureBlock:(NetworkRequestFailureBlock)failureBlock {
    serviceModel.url = SR_OMERCHARTMYBIDHISTORY;
    serviceModel.requestType = 1;
    
    NSURLSessionTask *sessionTask = [[SRNetworkRequest sharedNetworkRequest] requestWithModel:serviceModel successBlock:^(NSDictionary* returnData, NSURLSessionTask *task) {
        [self successBlock:successBlock returnData:returnData task:task];
        
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        [self failureBlock:failureBlock errorStatus:error task:task];
    }];
    return sessionTask;
}

@end
