//
//  NSString+YTEType.h
//  YouTuEr
//
//  Created by 苏一 on 2017/7/4.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YTEType)

- (BOOL)boolValueFromAuthen:(YTEAuthenModel *)authenModel;
// 订单状态
+ (instancetype)stringFromOrderParStatus:(NSInteger)perStatus;

// 商户类型 YTEBusinessType
+ (YTEBusinessType)businessTypeFromTitle:(NSString *)title;

// 商户类型
+ (instancetype)stringFromBusinessType:(YTEBusinessType)type;

// 交通工具类型
+ (instancetype)stringFromTransportType:(NSInteger)transportType;

- (NSInteger)stringToTransportType;

// 导游类型
+ (instancetype)stringFromGuideMerchantType:(NSInteger)merchantType;
- (NSInteger)stringToGuideMerchantType;

// 翻译类型
+ (instancetype)stringFromTranslateMerchantType:(NSInteger)merchantType;
- (NSInteger)stringToTranslateMerchantType;

// 接送类型
+ (instancetype)stringFromPickupMerchantType:(NSInteger)merchantType;
- (NSInteger)stringToPickupMerchantType;

// 翻译语言
+ (instancetype)stringFromTransLanguage:(NSInteger)transLanguage;
- (NSInteger)stringToTransLanguage;

// 翻译领域
+ (instancetype)stringFromTransArea:(NSInteger)transArea;
- (NSInteger)stringToTransArea;
@end
