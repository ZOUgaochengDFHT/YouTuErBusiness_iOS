//
//  SRCompanyAuthServiceModel.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRRequestModel.h"

/*
 请求url：${curServerUrl}/m/authen/bus
 请求方式： POST
 参数:
 {
 "member_id": 1,     //商家ID
 "company_number": "dn134747474747",//营业执照号
 "company_certificate": "http://img.izhuti.cn/public/picture/20140506014/1378086832789.jpg" //营业执照
 "address": "南山區高新中一道9号",    //公司地址
 "city": "深圳市",    //城市
 "country":"中国",    //国家
 "validity":"2018-01-01",    //有效期
 "isvalidity":1             //是否有效: 1是；2否
 }
 返回：
 {
 "code":200,
 "msgCode":"10100",
 "msg":"商家认证成功"
 }
 失败：
 {
 "code": 300
 "msgCode":"10101",
 "msg":"商家认证失敗"
 }
 
 */

@interface SRCompanyAuthServiceModel : SRRequestModel

@property (assign, nonatomic) NSInteger member_id;
@property (copy, nonatomic) NSString *company_number;
@property (copy, nonatomic) NSString *company_certificate;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *validity;
@property (copy, nonatomic) NSString *isvalidity;

@end

