//
//  SRApiDefine.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/7/30.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#ifndef SRApiDefine_h
#define SRApiDefine_h



#define SR_BASEURL @"http://120.76.40.19:8080/youtuer-app/m/"


// 登录
#define SR_MEMBERLOGIN @"" SR_BASEURL"member/login"
// 注册
#define SR_MEMBERREGIST @"" SR_BASEURL"member/regist"
// 获取用户信息
#define SR_MEMBERGETINFO @"" SR_BASEURL"member/getInfo"
// 保存用户信息
#define SR_MEMBERSAVEINFO @"" SR_BASEURL"member/saveInfo"
// 修改密码
#define SR_MEMBERUPDATEPWD @"" SR_BASEURL"member/updatePwd"
// 上传(通用，可上传头像、护照、营业执照、驾驶证、签证、从业资格证等)
#define SR_MEMBERPICUPLOAD @"" SR_BASEURL"member/picupload"
// 找回密码 – 1).发送验证码
#define SR_MEMBERGETPWDCAPTCHA @"" SR_BASEURL"member/getPwdCaptcha"
// 找回密码 – 2).下一步
#define SR_MEMBERGETPWDNEXT @"" SR_BASEURL"member/getPwdNext"
// 找回密码 – 3).设置新密码
#define SR_MEMBERSETNEWPWD @"" SR_BASEURL"member/setNewPwd"
// 认证信息
#define SR_MEMBERAUTHEN @"" SR_BASEURL"member/authen"
// 大巴公司认证
#define SR_AUTHENBUS @"" SR_BASEURL"authen/bus"
// 旅游公司认证
#define SR_AUTHENTRAVELAGENCY @"" SR_BASEURL"authen/travelagency"
// 车辆认证
#define SR_AUTHENCAR @"" SR_BASEURL"authen/car"
// 导游认证
#define SR_AUTHENCICERONE @"" SR_BASEURL"authen/cicerone"
// 翻译认证
#define SR_AUTHENTRANSLATE @"" SR_BASEURL"authen/translate"
// 查询余额
#define SR_MEMBERGETAMOUNT @"" SR_BASEURL"member/getAmount"
// 商家提现
#define SR_MEMBERWITHDRAW @"" SR_BASEURL"member/withdraw"
// 需求列表(可投标列表)
#define SR_OMERCHARTDEMAND @"" SR_BASEURL"omerchart/demand"
// 抢单(报价)
#define SR_OMERCHARTQUOTEORDER @"" SR_BASEURL"omerchart/quoteOrder"
// 我的报价(到修改报价页面也调用该接口)
#define SR_OMERCHARTMYQUOTE @"" SR_BASEURL"omerchart/myQuote"
// 修改报价
#define SR_OMERCHARTUPDATEORDER @"" SR_BASEURL"omerchart/updateQuote"
// 取消投标
#define SR_OMERCHARTCANCELBID @"" SR_BASEURL"omerchart/cancelBid"
// 我的投标 -- 需求列表
#define SR_OMERCHARTMYBID @"" SR_BASEURL"omerchart/myBid"
// 我的投标 - 正在进行
#define SR_OMERCHARTMYBIDPROCESSING @"" SR_BASEURL"omerchart/myBidProcessing"
// 我的投标 - 历史订单
#define SR_OMERCHARTMYBIDHISTORY @"" SR_BASEURL"omerchart/myBidHistory"


#endif /* SRApiDefine_h */
