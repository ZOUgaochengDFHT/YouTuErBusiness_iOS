//
//  SRAmountServiceModel.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRRequestModel.h"
/*
 请求url：${curServerUrl}/m/member/getAmount
 请求方式：GET / POST
 请求参数：member_id             商家用户ID(必填)         int整数
 失败报文：{"code":300}
 成功报文：
 {
 "msg": "",
 "code": 200,
 "member": {
 "amount": 2536.52,       //商家余额
 "nickName": "张小三",    //商家姓名
 "id": 2                  //商家主键ID
 },
 "msgCode": ""
 }

 */
@interface SRAmountServiceModel : SRRequestModel

@property (assign, nonatomic) NSInteger member_id;

@end
