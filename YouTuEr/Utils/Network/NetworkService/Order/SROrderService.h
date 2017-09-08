//
//  SROrderService.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SRBidsServiceModel;
@class SRMyQuoteServiceModel;
@class SRCancelBidServiceModel;
@class SRQuoteOrderServiceModel;
@class SRUpdateQuoteServiceModel;

@interface SROrderService : NSObject

+ (SROrderService *)sharedService;

// 需求列表(可投标列表)
- (NSURLSessionTask *)omerchartDemandRequestWithModel:(SRBidsServiceModel *)serviceModel
                                         successBlock:(NetworkRequestSuccessBlock)successBlock
                                         failureBlock:(NetworkRequestFailureBlock)failureBlock;

// 抢单(报价)
- (NSURLSessionTask *)omerchartQuoteOrderRequestWithModel:(SRQuoteOrderServiceModel *)serviceModel
                                             successBlock:(NetworkRequestSuccessBlock)successBlock
                                             failureBlock:(NetworkRequestFailureBlock)failureBlock;

// 我的报价(到修改报价页面也调用该接口)
- (NSURLSessionTask *)omerchartMyQuoteRequestWithModel:(SRMyQuoteServiceModel *)serviceModel
                                             successBlock:(NetworkRequestSuccessBlock)successBlock
                                             failureBlock:(NetworkRequestFailureBlock)failureBlock;


// 修改报价
- (NSURLSessionTask *)omerchartUpdateQuoteRequestWithModel:(SRUpdateQuoteServiceModel *)serviceModel
                                              successBlock:(NetworkRequestSuccessBlock)successBlock
                                              failureBlock:(NetworkRequestFailureBlock)failureBlock;

// 取消投标
- (NSURLSessionTask *)omerchartCancelBidRequestWithModel:(SRCancelBidServiceModel *)serviceModel
                                            successBlock:(NetworkRequestSuccessBlock)successBlock
                                            failureBlock:(NetworkRequestFailureBlock)failureBlock;
// 我的投标 -- 需求列表
- (NSURLSessionTask *)omerchartMyBidRequestWithModel:(SRBidsServiceModel *)serviceModel
                                        successBlock:(NetworkRequestSuccessBlock)successBlock
                                        failureBlock:(NetworkRequestFailureBlock)failureBlock;

// 我的投标 - 正在进行
- (NSURLSessionTask *)omerchartMyBidProcessingRequestWithModel:(SRBidsServiceModel *)serviceModel
                                                  successBlock:(NetworkRequestSuccessBlock)successBlock
                                                  failureBlock:(NetworkRequestFailureBlock)failureBlock;

// 我的投标 - 历史订单
- (NSURLSessionTask *)omerchartMyBidHistoryRequestWithModel:(SRBidsServiceModel *)serviceModel
                                               successBlock:(NetworkRequestSuccessBlock)successBlock
                                               failureBlock:(NetworkRequestFailureBlock)failureBlock;
@end
