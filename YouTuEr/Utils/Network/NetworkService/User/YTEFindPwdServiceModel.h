//
//  YTEFindPwdServiceModel.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/25.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "SRRequestModel.h"

/**
 6. 找回密码 – 1).发送验证码
 请求url：${curServerUrl}/m/member/getPwdCaptcha
 请求方式：GET/POST
 请求参数：account       账号(必填)            String字符串
 失败报文：{"code":300}
 成功报文：{"code":200}
 
 7. 找回密码 – 2).下一步
 请求url：${curServerUrl}/m/member/getPwdNext
 请求方式：GET/POST
 请求参数：account       账号(必填)                  String字符串
 code          验证码(必填)                String字符串
 失败报文：{"code":300}
 验证码输入错误返回: {"msgCode":"300","code":300,"msg":"验证码输入错误，请重新输入！"}
 成功报文：{"code":200}

 8. 找回密码 – 3).设置新密码
 请求url：${curServerUrl}/m/member/setNewPwd
 请求方式：GET/POST
 请求参数：account       账号(必填)                  String字符串
 password      新密码(必填)                String字符串
 失败报文：{"code":300}
 成功报文：{"code":200}
 
 */


@interface YTEFindPwdServiceModel : SRRequestModel

@property (copy, nonatomic) NSString *account;
@property (copy, nonatomic) NSString *code;
@property (copy, nonatomic) NSString *password;

@end
