//
//  SRUpdatePwdSerivceModel.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRRequestModel.h"

/*
 请求方式： POST
 请求url：${curServerUrl} /m/member/updatePwd
 参数:
 {
 "newPwd": "202CB962AC59075B964B07152D234B70",//新密码
 "oldPwd": "E10ADC3949BA59ABBE56E057F20F883E",//旧密码
 "clientId": "97" //用户ID
 }
 返回明文：
 {"code":200}
 失败：
 {"code": 300}

 */

@interface SRUpdatePwdSerivceModel : SRRequestModel

@property (copy, nonatomic) NSString *sr_newPwd;
@property (copy, nonatomic) NSString *oldPwd;
@property (copy, nonatomic) NSString *clientId;


@end
