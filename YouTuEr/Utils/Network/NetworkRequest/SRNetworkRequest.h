//
//  NetworkRequest.h
//
//  Created by GaoCheng.Zou on 2017/4/14.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkParamDefinition.h"

@interface SRNetworkRequest : NSObject

@property (nonatomic, strong) NSDictionary *commonParams;

+ (SRNetworkRequest *)sharedNetworkRequest;

#pragma mark - 网络请求相应方法

/**
 网络请求
 
 @param requestModel model类型
 @param successBlock 成功block
 @param failureBlock 失败block
 
 @urn 请求task
 */
- (NSURLSessionDataTask *)requestWithModel:(SRRequestModel *)requestModel
                              successBlock:(NetworkRequestSuccessBlock)successBlock
                              failureBlock:(NetworkRequestFailureBlock)failureBlock;



/**
 上传
 
 @param requestModel model类型
 @param fileData     上传数据
 @param successBlock 成功block
 @param failureBlock 失败block
 
 @urn 请求task
 */
- (NSURLSessionDataTask *)uploadRequestWithModel:(SRRequestModel *)requestModel
                                        fileData:(NSData *)fileData
                                    successBlock:(NetworkRequestSuccessBlock)successBlock
                                    failureBlock:(NetworkRequestFailureBlock)failureBlock;

#pragma mark - 取消网络请求的方法
/**
 取消所有网络请求
 */
- (void)cancelAllNetworkRequest;

/**
 取消单个网络请求
 
 @param task 需要被取消请求的task
 */
- (void)cancelNetworkRequestWithTask:(NSURLSessionTask *)task;

@end
