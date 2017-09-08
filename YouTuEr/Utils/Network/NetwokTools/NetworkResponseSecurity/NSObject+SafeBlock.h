//
//  NSObject+SafeBlock.h
//
//  Created by GaoCheng.Zou on 2017/4/14.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkParamDefinition.h"

@interface NSObject (SafeBlock)

/**
 自定义service使用的block
 */
- (void)successBlock:(NetworkRequestSuccessBlock)success
          returnData:(id)returnData
                task:(NSURLSessionTask *)task;

- (void)failureBlock:(NetworkRequestFailureBlock)failure
         errorStatus:(NetworkErrorStatus)errorStatus
                task:(NSURLSessionTask *)task;

/**
 NetworkRequest使用的block
 */
- (void)successBlock:(NetworkRequestSuccessBlock)success
          returnData:(id)returnData
                 cls:(Class)cls
                task:(NSURLSessionTask *)task;

- (void)failureBlock:(NetworkRequestFailureBlock)failure
            errorMsg:(NSString *)errorMsg
         errorStatus:(NetworkErrorStatus)errorStatus
        hideErroeTip:(BOOL)hide
                task:(NSURLSessionTask *)task;

@end
