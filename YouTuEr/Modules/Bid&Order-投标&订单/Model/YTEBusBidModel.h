//
//  YTEBusBidModel.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/12.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 //需求列表 - 大巴
 {
 "nextId": 26,                                 //下一页ID
 "code": 200,
 "pageSize": 5,                                //每页显示记录数
 "orders": [                                   //大巴需求列表
 {
 "classify": 0,                        //分类:0需求1订单
 "rentDays": 2,                        //租用天数
 "amount": 100,                        //订单金额
 "parStatus": 0,                       //支付状态:0待支付;1支付成功
 "bidFee": 100,                        //投标价
 "arriveDate": "2017-07-09",           //开始日期
 "orderNum": "2017070216454691522",    //订单号
 "type": 0,                            //订单类型:0大巴1导游2翻译3美食4接机5VIP
 "luggageNum": 2,                      //行李数量
 "arriveCity": "伦敦",                 //到达城市
 "createTime": "2017-07-02",           //订单创建时间
 "arriveCountry": "英国",              //到达国家
 "guestNum": 3,                        //游客人数
 "finishDate": "2017-07-10",           //结束日期
 "id": 26,                             //订单主键ID
 "memberId": 1,                        //客户主键ID
 "remark": "行程描述",                 //行程描述
 "status": 0                           //状态:0正常1取消
 },
 ... ...
 ]
 }
 
 amount = 680;
 arriveCity = "\U4f26\U6566";
 arriveCountry = "\U82f1\U56fd";
 arriveDate = "2017-08-01";
 bidFee = 680;
 classify = 1;
 createTime = "2017-08-06";
 finishDate = "2017-08-07";
 guestNum = 3;
 id = 192;
 luggageNum = 2;
 memberId = 0;
 nickName = "\U5143\U5b9d";
 orderNum = 150198885084171;
 parStatus = 0;
 photo = "abc.png";
 remark = "\U968f\U4fbf\U901b\U901b";
 rentDays = 2;
 status = 0;
 type = 0;

 
 amount = 680;
 arriveCity = "\U4f26\U6566";
 arriveCountry = "\U82f1\U56fd";
 arriveDate = "2017-08-01";
 bidFee = 680;
 classify = 1;
 createTime = "2017-08-06";
 finishDate = "2017-08-07";
 guestNum = 3;
 id = 192;
 luggageNum = 2;
 memberId = 0;
 nickName = "\U5143\U5b9d";
 orderNum = 150198885084171;
 parStatus = 0;
 photo = "abc.png";
 remark = "\U968f\U4fbf\U901b\U901b";
 rentDays = 2;
 status = 0;
 type = 0;
 
 */

@interface YTEBusBidModel : NSObject


@property (copy, nonatomic) NSString *classify;
@property (copy, nonatomic) NSString *rentDays;
@property (copy, nonatomic) NSString *amount;
@property (copy, nonatomic) NSString *parStatus;
@property (copy, nonatomic) NSString *bidFee;
@property (copy, nonatomic) NSString *arriveDate;
@property (copy, nonatomic) NSString *orderNum;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *luggageNum;
@property (copy, nonatomic) NSString *arriveCity;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *arriveCountry;
@property (copy, nonatomic) NSString *guestNum;
@property (copy, nonatomic) NSString *finishDate;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *memberId;
@property (copy, nonatomic) NSString *remark;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *photo;

+ (NSMutableArray *)getModels:(NSArray *)modelsDicArr;

@end
