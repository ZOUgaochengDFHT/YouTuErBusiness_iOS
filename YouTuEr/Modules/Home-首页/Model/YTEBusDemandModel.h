//
//  YTEBusDemandModel.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/10.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 "classify": 0,                        //分类:0需求1订单
 "rentDays": 2,                        //租用天数
 "nickName": "李白",                   //客户姓名
 "photo": "xxx.png",                   //客户头像
 "arriveDate": "2017-07-09",           //开始日期(可根据该日期计算剩余天数时分秒)
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

 */

@interface YTEBusDemandModel : NSObject

@property (copy, nonatomic) NSString *classify;
@property (copy, nonatomic) NSString *rentDays;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *photo;
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

+ (NSMutableArray *)getModels:(NSArray *)modelsDicArr;

@end
