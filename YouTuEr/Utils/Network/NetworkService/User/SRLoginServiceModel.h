//
//  SRLoginServiceModel.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRRequestModel.h"

/*
 请求url：${curServerUrl}/m/member/login
 请求方式： POST
 参数:
 {
 "account": "13428254@qq.com",
 "password": "123456"
 }
 返回：（登录成功后返回用户信息）
 {
 "code": 200,
 "msgCode": "10009",
 "msg": "登录成功",
 "clientId": 1,
 "hasProfile":false 表示未完善跟人资料，跳转到完善个人资料。true表示完善个人资料
 
 }
 登录失败：
 {
 "code": 300,
 "msgCode": "10002",     //错误码：10001 账号不存在；10002 密码错误
 "msg": "密码错误"
 
 }

 */

@interface SRLoginServiceModel : SRRequestModel

@property (copy, nonatomic) NSString *account;
@property (copy, nonatomic) NSString *password;

@end
