//
//  NSObject+SafeBlock.m
//
//  Created by GaoCheng.Zou on 2017/4/14.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "NSObject+SafeBlock.h"
#import "NetworkWrongStatusHandle.h"

@implementation NSObject (SafeBlock)

- (void)successBlock:(NetworkRequestSuccessBlock)success
          returnData:(id)returnData
                task:(NSURLSessionTask *)task {
    if (success) {
        success(returnData, task);
    }
}

- (void)failureBlock:(NetworkRequestFailureBlock)failure
         errorStatus:(NetworkErrorStatus)errorStatus
                task:(NSURLSessionTask *)task {
    if (failure) {
        failure(errorStatus, task);
    }
}

- (void)successBlock:(NetworkRequestSuccessBlock)success
          returnData:(id)returnData
                 cls:(Class)cls
                task:(NSURLSessionTask *)task {
    if (success) {
        if (cls) {
            success([cls yy_modelWithDictionary:returnData], task);
        }else {
            success(returnData, task);
        }
    }
}

- (void)failureBlock:(NetworkRequestFailureBlock)failure
            errorMsg:(NSString *)errorMsg
         errorStatus:(NetworkErrorStatus)errorStatus
        hideErroeTip:(BOOL)hide
                task:(NSURLSessionTask *)task {
    // 错误处理
    [NetworkWrongStatusHandle checkNetworkCode:errorStatus errorMsg:errorMsg hideErrorTip:hide];
    if (failure) {
        failure(errorStatus, task);
    }
}

@end
