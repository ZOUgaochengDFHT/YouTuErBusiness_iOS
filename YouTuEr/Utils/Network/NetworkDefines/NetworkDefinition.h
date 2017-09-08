//
//  NetworkDefinition.h
//
//  Created by GaoCheng.Zou on 2017/4/14.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#ifndef NetworkDefinition_h
#define NetworkDefinition_h

/*
 网络错误状态码
 */
typedef NS_ENUM (NSUInteger, NetworkErrorStatus) {
    // 无网络或网络差
    Network_netless         = 1 << 0,
    // 数据解析错误
    Network_misdata         = 1 << 1,
    // 服务器数据返回错误，result不为1
    Network_badResult       = 1 << 2,
    // 从服务器返回的失败回调
    Network_requestFailed   = 1 << 3
};


static NSString *const kDataJSONKey_Msg             = @"msg";
static NSString *const kDataJSONKey_Code            = @"code";
static NSString *const kDataJSONKey_MsgCode         = @"msgCode";

static NSInteger const kSRRequestSuccessCode  = 200;
static NSInteger const kSRRequestFailureCode  = 300;
static NSInteger const kSRSystemExceptionCode = 500;




#define kNetErrorUnreachable 10086
#define kNetServiceError     10087

#define kErrorMsg @{@(kNetErrorUnreachable)     : @"网络瘫痪了，快检查一下",  \
                  @(kNetServiceError)           : @"服务器数据错误"}


#endif /* NetworkDefinition_h */
