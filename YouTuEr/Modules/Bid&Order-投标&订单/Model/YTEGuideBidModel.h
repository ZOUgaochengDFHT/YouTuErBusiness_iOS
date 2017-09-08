//
//  YTEGuideBidModel.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/12.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 {
 //需求列表 - 导游
 {
 "nextId": 24,                                 //下一页ID
 "code": 200,
 "pageSize": 5,                                //每页显示记录数
 "orders": [                                   //导游需求列表
 {
 "classify": 0,                        //分类:0需求1订单
 "amount": 100,                        //订单金额
 "parStatus": 0,                       //支付状态:0待支付;1支付成功
 "bidFee": 100,                        //投标价
 "arriveDate": "2017-07-28",           //开始日期
 "orderNum": "2017070216445668748",    //订单号
 "type": 1,                            //订单类型:0大巴1导游2翻译3美食4接机5VIP
 "luggageNum": 2,                      //行李数量
 "arriveCity": "伦敦",                 //到达城市
 "createTime": "2017-07-02",           //订单创建时间
 "arriveCountry": "英国",              //到达国家
 "guestNum": 3,                        //游客人数
 "finishDate": "2017-07-30",           //结束日期
 "id": 25,                             //订单主键ID
 "merchantType": 1,                    //导游类型:1资深;2专业;3当地知客
 "memberId": 1,                        //客户主键ID
 "remark": "行程描述",                 //行程描述
 "transportType": 3,                   //交通工具:1经济型;2舒适型;3行政型;4豪华型;5自备车辆;6公共交通;7徒步
 "status": 0                           //状态:0正常1取消
 },
 ... ...
 ]
 }

 amount = 900;
 arriveCity = "\U4f26\U6566";
 arriveCountry = "\U82f1\U56fd";
 arriveDate = "2017-08-16";
 bidFee = 900;
 classify = 1;
 createTime = "2017-08-02";
 finishDate = "2017-08-18";
 guestNum = 66;
 id = 182;
 luggageNum = 6;
 memberId = 0;
 merchantType = 1;
 nickName = "\U5143\U5b9d";
 orderNum = 2017080217245951575;
 parStatus = 0;
 photo = "abc.png";
 remark = "\U54c7\U554a\U4e0d low \U4e00\U76f4\U5c0f\U5fc3\U7ffc\U7ffc\U5c0f\U5fc3\U7ffc\U7ffc\U54c7\U554a\U4e0d low \U4e00\U76f4\U5c0f\U5fc3\U7ffc\U7ffc\U5c0f\U5fc3\U7ffc\U7ffc\U54c7\U554a\U4e0d low \U4e00\U76f4\U5c0f\U5fc3\U7ffc\U7ffc\U5c0f\U5fc3\U7ffc\U7ffc";
 status = 0;
 transportType = 1;
 type = 1;

 */

@interface YTEGuideBidModel : NSObject

@property (copy, nonatomic) NSString *classify;
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
@property (copy, nonatomic) NSString *merchantType;
@property (copy, nonatomic) NSString *memberId;
@property (copy, nonatomic) NSString *remark;
@property (copy, nonatomic) NSString *transportType;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *photo;

+ (NSMutableArray *)getModels:(NSArray *)modelsDicArr;

@end
