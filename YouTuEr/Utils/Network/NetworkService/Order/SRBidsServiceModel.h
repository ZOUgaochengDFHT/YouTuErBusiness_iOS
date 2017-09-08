//
//  SRDemandServiceModel.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/8/1.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRRequestModel.h"

/*
 请求url：${curServerUrl}/m/omerchart/demand
 请求方式：GET / POST
 请求参数：clientId             商家ID(必填)         int整数
 type                 订单类型(必填)        int整数
 类型:0大巴1导游2翻译3美食4接机5VIP
 pageSize             每页记录数            int 整数
 注：pageSize默认每页显示5条,该参数可不传,当需要改变每页显示数时才传该参数
 nextId               下一页ID              int 整数
 注：下一页ID用于分页使用, 当有下一页ID时, 必须传.该参数值后台报文会返回.

 */

/*
 请求url：${curServerUrl}/m/omerchart/myBid
 请求方式：GET / POST
 请求参数：clientId          商家ID(必填)           int 整数
 type              订单类型                int整数
 类型:0大巴1导游2翻译3美食4接机5VIP
 pageSize          每页记录数              int 整数
 注：pageSize默认每页显示5条,该参数可不传,当需要改变每页显示数时才传该参数
 nextId            下一页ID               int 整数
 注：下一页ID用于分页使用, 当有下一页ID时, 必须传.该参数值后台报文会返回.
 失败报文：{"code":300}
 
 */

@interface SRBidsServiceModel : SRRequestModel

@property (assign, nonatomic) NSInteger clientId;
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) NSInteger pageSize;
@property (assign, nonatomic) NSInteger nextId;


@end
