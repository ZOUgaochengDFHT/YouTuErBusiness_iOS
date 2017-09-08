//
//  SRTranslateServiceModel.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRRequestModel.h"
/*
 请求url：${curServerUrl}/m/authen/translate
 请求方式： POST
 参数:
 {
 "member_id": 1, /商家ID
 "working_years": 3,//从业时间
 "translation_type":"英文",//翻译类型
 "passport_image": "http://img.izhuti.cn/public/picture/20140506014/1378086832789.jpg", //护照照片
 "visa_image": "http://img.izhuti.cn/public/picture/20140506014/1378086832789.jpg" ,//签证照片
 "certificate_image": "http://img.izhuti.cn/public/picture/20140506014/1378086832789.jpg", //从业资格证照片
 "passport_validtime":"2011.11.11 - 2018.11.11 ",//护照有效时间
 "visa_validtime":"2011.11.11 - 2018.11.11"//签证有效时间
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
@interface SRTranslateServiceModel : SRRequestModel

@property (assign, nonatomic) NSInteger member_id;
@property (copy, nonatomic) NSString *working_years;
@property (copy, nonatomic) NSString *translation_type;
@property (copy, nonatomic) NSString *passport_image;
@property (copy, nonatomic) NSString *visa_image;
@property (copy, nonatomic) NSString *certificate_image;
@property (copy, nonatomic) NSString *passport_validtime;
@property (copy, nonatomic) NSString *visa_validtime;

@end
