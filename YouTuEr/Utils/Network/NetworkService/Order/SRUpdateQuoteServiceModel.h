//
//  SRUpdateQuoteServiceModel.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRRequestModel.h"

/*
 请求url：${curServerUrl}/m/omerchart/updateQuote
 请求方式：GET / POST
 请求参数：orderId           订单ID(必填)           int 整数
 merchantId        投标商家ID(必填)       int 整数
 bidFee            投标价(必填)            double浮点小数(支持小数点后两位)
 fee               服务费(必填)            double浮点小数(支持小数点后两位)
 total             商家收入(必填)          double浮点小数(支持小数点后两位)
 message           报价留言                String字符串
 失败报文：{"code":300}
 成功报文：{"code":200}

 */

@interface SRUpdateQuoteServiceModel : SRRequestModel

@property (assign, nonatomic) NSInteger orderId;
@property (assign, nonatomic) NSInteger merchantId;
@property (strong, nonatomic) NSDecimalNumber *bidFee;
@property (strong, nonatomic) NSDecimalNumber *fee;
@property (strong, nonatomic) NSDecimalNumber *total;
@property (copy, nonatomic) NSString *message;


@end
