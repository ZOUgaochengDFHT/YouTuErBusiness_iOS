//
//  YTEPickupBidModel.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/12.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 
 //需求列表 - 接机
 {
 "nextId": 20,                                 //下一页ID
 "code": 200,
 "pageSize": 5,                                //每页显示记录数
 "orders": [                                   //接机需求列表
 {
 "classify": 0,                        //分类:0需求1订单
 "amount": 100,                        //订单金额
 "parStatus": 0,                       //支付状态:0待支付;1支付成功
 "bidFee": 100,                        //投标价
 "arriveDate": "2017-08-01",           //开始日期
 "toCity": "伦敦",                     //送达城市
 "orderNum": "2017070216430665373",    //订单号
 "remark": "BA22458",                  //航班号
 "type": 4,                            //订单类型:0大巴1导游2翻译3美食4接机5VIP
 "merchantType": 1,                    //接机类型:1接机;2送机
 "luggageNum": 3,                      //行李数量
 "toAddress": "华布伦街252号",        //送达地址
 "arriveCity": "伦敦",                 //接载城市
 "arriveTime": "12:50",                //接载时间
 "createTime": "2017-07-02",           //订单创建时间
 "arriveCountry": "英国",              //目的地国家
 "guestNum": 3,                        //游客人数
 "finishDate": "2017-07-25",           //接载日期
 "id": 21,                             //订单主键ID
 "toPostcode": "0012352",              //邮编
 "memberId": 1,                        //客户主键ID
 "status": 0                           //状态:0正常1取消
 },
 ... ...
 ]
 }

 amount = 1500;
 arriveCity = "\U4f26\U6566";
 arriveCountry = "\U82f1\U56fd";
 arriveDate = "2017-08-25";
 arriveTime = "17:13";
 bidFee = 1200;
 classify = 1;
 createTime = "2017-08-02";
 finishDate = "2017-08-27";
 flightNum = 5682NT;
 guestNum = 33;
 id = 178;
 luggageNum = 66;
 memberId = 0;
 merchantType = 1;
 nickName = "\U5143\U5b9d";
 orderNum = 2017080217140482150;
 parStatus = 0;
 photo = "abc.png";
 pickAddress = "\U6076\U9b54";
 remark = "\U54c7\U554a\U4e0d low \U4e00\U76f4\U5c0f\U5fc3\U7ffc\U7ffc\U5c0f\U5fc3\U7ffc\U7ffc\U54c7\U554a\U4e0d low \U4e00\U76f4\U5c0f\U5fc3\U7ffc\U7ffc\U5c0f\U5fc3\U7ffc\U7ffc\U54c7\U554a\U4e0d low \U4e00\U76f4\U5c0f\U5fc3\U7ffc\U7ffc\U5c0f\U5fc3\U7ffc\U7ffc";
 status = 0;
 toAddress = "\U55ef\U55ef\U6709";
 type = 4;
 
 */

@interface YTEPickupBidModel : NSObject

@property (copy, nonatomic) NSString *classify;
@property (copy, nonatomic) NSString *amount;
@property (copy, nonatomic) NSString *parStatus;
@property (copy, nonatomic) NSString *bidFee;
@property (copy, nonatomic) NSString *arriveDate;
@property (copy, nonatomic) NSString *toCity;
@property (copy, nonatomic) NSString *orderNum;
@property (copy, nonatomic) NSString *remark;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *merchantType;
@property (copy, nonatomic) NSString *luggageNum;
@property (copy, nonatomic) NSString *toAddress;
@property (copy, nonatomic) NSString *arriveCity;
@property (copy, nonatomic) NSString *arriveTime;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *arriveCountry;
@property (copy, nonatomic) NSString *guestNum;
@property (copy, nonatomic) NSString *finishDate;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *toPostcode;
@property (copy, nonatomic) NSString *memberId;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *pickAddress;
@property (copy, nonatomic) NSString *flightNum;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *photo;

+ (NSMutableArray *)getModels:(NSArray *)modelsDicArr;

@end
