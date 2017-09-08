//
//  SRRegisterServiceModel.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRRequestModel.h"

/*
 请求url：${curServerUrl}/m/member/regist
 请求方式： POST
 参数:
 {
 "account": "13428254@qq.com",   //账号：手机号
 "password": "123456"
 }
 返回：
 {
 "code": 200,        //200：成功；300：失败
 "msg": "注册成功"
 }


 */

@interface SRRegisterServiceModel : SRRequestModel

@property (copy, nonatomic) NSString *account;
@property (copy, nonatomic) NSString *password;

@end
