//
//  NetworkParamDefinition.h
//
//  Created by GaoCheng.Zou on 2017/4/14.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#ifndef NetworkParamDefinition_h
#define NetworkParamDefinition_h

#import "NetworkDefinition.h"

typedef NS_ENUM(NSInteger, NetworkRequestType) {
    NetworkRequestGet    = 0,
    NetworkRequestPost   = 1
};

/**
 请求成功的回调
 
 @param returnData 回调的对象
 @param task       请求的task
 */
typedef void (^NetworkRequestSuccessBlock)(NSDictionary* returnData, NSURLSessionTask *task);

/**
 失败成功的回调
 
 @param error 错误回调的对象
 @param task  请求的task
 */
typedef void (^NetworkRequestFailureBlock)(NetworkErrorStatus error, NSURLSessionTask *task);

#endif /* NetworkParamDefinition_h */
