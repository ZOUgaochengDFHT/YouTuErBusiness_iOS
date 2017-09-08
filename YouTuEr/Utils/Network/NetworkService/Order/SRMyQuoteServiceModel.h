//
//  SRMyQuoteServiceModel.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRRequestModel.h"

/*
 请求url：${curServerUrl}/m/omerchart/myQuote
 请求方式：GET / POST
 请求参数：clientId          商家ID(必填)           int 整数
 orderId           订单ID(必填)           int 整数
 失败报文：{"code":300}
 成功报文：
 {
 "code": 200,
 "myQuote": {                              //报价信息
 "total": 84.62,                       //商家收入
 "bidTime": "Jul 2, 2017 10:47:12 PM", //投标时间
 "orderId": 19,                        //订单主键ID
 "merchantId": 1,                      //商家ID
 "fee": 14.88,                         //服务费
 "bidUsername": "张三",                //商家姓名
 "bidFee": 99.5,                       //投标价(即报价)
 "orderNum": "2017070216414225799",    //订单号
 "currency": "￥",                     //货币
 "id": 8,                              //订单投标主键ID
 "message": "好好好"                   //报价留言
 }
 }

 */

@interface SRMyQuoteServiceModel : SRRequestModel

@property (copy, nonatomic) NSString *clientId;
@property (copy, nonatomic) NSString *orderId;


@end
