//
//  SRSaveInfoServiceModel.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRRequestModel.h"
/*
 请求url：${curServerUrl}/m/member/saveInfo
 请求方式： POST
 参数:
 {
 "clientId": 1,     //用户ID，登录之后，每个请求都需要带上 clientId
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
 "sign":"无敌寂寞"//个性签名
 }
 返回：
 {
 "code":200,
 "msgCode":"10008",
 "msg":"保存成功"
 }
 失败：
 {
 "code": 300
 }

 */
@interface SRSaveInfoServiceModel : SRRequestModel

@property (copy, nonatomic) NSString *clientId;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *photo;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *gender;
@property (copy, nonatomic) NSString *birthday;
@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *province;
@property (copy, nonatomic) NSString *location;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *area;
@property (copy, nonatomic) NSString *postcode;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *sign;


@end
