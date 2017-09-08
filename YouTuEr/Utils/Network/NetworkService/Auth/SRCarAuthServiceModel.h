//
//  SRCarAuthServiceModel.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRRequestModel.h"

/**
 请求url：${curServerUrl}/m/authen/car
 请求方式： POST
 参数:
 {
 "member_id": 1, /商家ID
 "brand": "奔馳",//品牌
 "car_type":"320L",//车辆型号
 "guest_num:8,//最大载客数
 "luggage_num":8,//最多行李数
 "car_age":3,//车龄
 "driving_years":3,//驾龄
 "car_image": "http://img.izhuti.cn/public/picture/20140506014/1378086832789.jpg", //车辆照片
 "driving_license`": "http://img.izhuti.cn/public/picture/20140506014/1378086832789.jpg" //驾驶证
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

@interface SRCarAuthServiceModel : SRRequestModel


@property (assign, nonatomic) NSInteger member_id;
@property (copy, nonatomic) NSString *brand;
@property (copy, nonatomic) NSString *car_type;
@property (copy, nonatomic) NSString *guest_num;
@property (copy, nonatomic) NSString *luggage_num;
@property (copy, nonatomic) NSString *car_age;
@property (copy, nonatomic) NSString *driving_years;
@property (copy, nonatomic) NSString *car_image;
@property (copy, nonatomic) NSString *driving_license;


@end
