//
//  SRCancelBidServiceModel.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRRequestModel.h"

/*
 请求url：${curServerUrl}/m/omerchart/cancelBid
 请求方式：GET / POST
 请求参数：clientId          商家ID(必填)           int 整数
 orderId           订单ID(必填)           int 整数
 失败报文：{"code":300}
 成功报文：{"code":200}

 */

@interface SRCancelBidServiceModel : SRRequestModel

@property (copy, nonatomic) NSString *clientId;
@property (copy, nonatomic) NSString *orderId;

@end
