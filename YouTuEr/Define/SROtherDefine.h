//
//  SROtherDefine.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/2.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#ifndef SROtherDefine_h
#define SROtherDefine_h

#ifdef DEBUG
#define NSLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define NSLog(format, ...)
#endif

#define SR_IMGName(name) [UIImage imageNamed:name]

// 商户类型
typedef enum : NSInteger {
    YTEBusinessTypeBus  = 0,
    YTEBusinessTypeGuide = 1,
    YTEBusinessTypeTranslate = 2,
    YTEBusinessTypeGroup = 3,
    YTEBusinessTypePickup = 4,
    YTEBusinessTypeVIP = 5
} YTEBusinessType;

// 三种状态的订单
typedef enum : NSUInteger {
    YTEOrderStatusNormal = 0,
    YTEOrderStatuProcessing = 1,
    YTEOrderStatusHistory = 2
} YTEOrderStatus;

// 认证类型
typedef enum : NSUInteger {
    YTEMerchantAuthTypeDaoyou = 0,
    YTEMerchantAuthTypeFanyi = 1,
    YTEMerchantAuthTypeJieji = 2,
    YTEMerchantAuthTypeAgency = 3,
    YTEMerchantAuthTypeTravelagency = 4,
} YTEMerchantAuthType;

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#endif /* SROtherDefine_h */
