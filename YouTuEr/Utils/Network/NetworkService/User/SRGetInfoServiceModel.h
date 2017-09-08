//
//  SRGetInfoServiceModel.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRRequestModel.h"

/*
 请求url：${curServerUrl}/m/member/getInfo
 请求方式： POST
 参数:
 {
 "clientId ": "122"     //用户ID，登录之后，每个请求都需要带上 clientId
 }
 返回：
 {
 "code": 200,
 "user": {
 "clientId ": 1,     //用户id
 "account": "134287902@qq.com",   //用户账号
 "nickName": "Mark007",    //昵称
 "phone": "134747474747",//联系方式
 "photo": "http://img.izhuti.cn/public/picture/20140506014/1378086832789.jpg" //头像，URL格式
 "nickName": "Mak007",    //昵称
 "gender": "M",    //性别：M 男；F 女
 "birthday":"2015-10-23"//生日
 "country":"中国",//国家
 "province":"广东",//省
 "location":"深圳南山",//定位
 "city":"深圳",//城市
 "area":"南山区",//区域
 "postcode":"831000",//邮编
 "address":"深圳市南山区科技高新中一道9号",//地址
 "sign":"无敌寂寞"//个性签        "createTime": "2015-10-23 10:00:00"      //注册时间
 }
 }

 */

@interface SRGetInfoServiceModel : SRRequestModel

@property (copy, nonatomic) NSString *member_id;

@end
