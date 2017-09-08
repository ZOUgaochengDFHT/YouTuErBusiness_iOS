//
//  SRWithdrawServiceModel.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRRequestModel.h"
/*
 请求url：${curServerUrl}/m/member/withdraw
 请求方式：GET / POST
 请求参数：clientId             商家用户ID(必填)         int整数
 amount               提现金额(必填)           String字符串
 值为可带两位小数的浮点数或者整数
 失败报文：{"code":300}
 提现大于余额返回：{"msg":"提现余额不能大于账户余额","code":300,"msgCode":"300"}
 成功报文：{"code":200}

 */
@interface SRWithdrawServiceModel : SRRequestModel

@property (copy, nonatomic) NSString *clientId;
@property (copy, nonatomic) NSString *amount;

@end
