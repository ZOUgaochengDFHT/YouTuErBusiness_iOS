//
//  NSObject+ATExtension.h
//  Athena
//
//  Created by GaoCheng.Zou on 2017/4/26.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ATExtension)

/**
 判断对象是否为空
 对于字符串，判断长度是否为0；对于NSArray和NSDictionary，判断是否没有内容
 */
- (BOOL)isEmpty;

/**
 判断对象是否不为空
 对于字符串，判断长度是否大于0；对于NSArray和NSDictionary，判断是否有内容
 */
- (BOOL)isNotEmpty;

/**
 将对象转为Json字符串
 对象类型只支持NSArray和NSDictionary
 */
- (NSString *)jsonDescription;

/**
 延迟执行
 @param block 执行的代码
 @param delay 延迟的时间，单位为秒
 */
- (void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay;

- (NSString *)titleFromMerchantAuthenType:(YTEMerchantAuthType)authenType;
- (NSString *)itemTitle1FromMerchantAuthenType:(YTEMerchantAuthType)authenType;
- (NSString *)itemTitle2FromMerchantAuthenType:(YTEMerchantAuthType)authenType;
- (NSString *)itemTitle3FromMerchantAuthenType:(YTEMerchantAuthType)authenType;
- (NSString *)itemTitle4FromMerchantAuthenType:(YTEMerchantAuthType)authenType;
- (NSString *)itemTitle5FromMerchantAuthenType:(YTEMerchantAuthType)authenType;
- (NSString *)itemTitle6FromMerchantAuthenType:(YTEMerchantAuthType)authenType;
- (NSString *)itemTitle7FromMerchantAuthenType:(YTEMerchantAuthType)authenType;
- (NSString *)itemTitle8FromMerchantAuthenType:(YTEMerchantAuthType)authenType;
- (NSMutableArray *)arrayFromAuthenValue;
@end
