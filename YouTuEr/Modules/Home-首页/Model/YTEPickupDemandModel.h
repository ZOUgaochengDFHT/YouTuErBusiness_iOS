//
//  YTEPickupDemandModel.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/10.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 "classify": 0,                        //分类:0需求1订单
 "nickName": "李白",                   //客户姓名
 "photo": "xxx.png",                   //客户头像
 "arriveDate": "2017-08-01",           //开始日期(可根据该日期计算剩余天数时分秒)
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
 "status": 0
 
 arriveCity = "\U4f26\U6566";
 arriveCountry = "\U82f1\U56fd";
 arriveDate = "2017-08-31";
 arriveTime = "17:09";
 classify = 0;
 createTime = "2017-08-02";
 finishDate = "2017-09-02";
 flightNum = 555555;
 guestNum = 6;
 id = 172;
 luggageNum = 33;
 memberId = 0;
 merchantType = 1;
 nickName = "\U5143\U5b9d";
 orderNum = 2017080217092780423;
 photo = "abc.png";
 pickAddress = "\U54c8\U54c8";
 remark = "\U54c7\U554a\U4e0d low \U4e00\U76f4\U5c0f\U5fc3\U7ffc\U7ffc\U5c0f\U5fc3\U7ffc\U7ffc\U54c7\U554a\U4e0d low \U4e00\U76f4\U5c0f\U5fc3\U7ffc\U7ffc\U5c0f\U5fc3\U7ffc\U7ffc\U54c7\U554a\U4e0d low \U4e00\U76f4\U5c0f\U5fc3\U7ffc\U7ffc\U5c0f\U5fc3\U7ffc\U7ffc";
 status = 0;
 toAddress = "\U597d";
 type = 4;

 */
@interface YTEPickupDemandModel : NSObject

@property (copy, nonatomic) NSString *classify;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *photo;
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

+ (NSMutableArray *)getModels:(NSArray *)modelsDicArr;

@end
