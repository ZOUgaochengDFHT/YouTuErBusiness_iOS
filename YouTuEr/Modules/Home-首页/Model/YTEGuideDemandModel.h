//
//  YTEGuideDemandModel.h
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
 "arriveDate": "2017-07-28",           //开始日期(可根据该日期计算剩余天数时分秒)
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

 */

@interface YTEGuideDemandModel : NSObject

@property (copy, nonatomic) NSString *classify;
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
@property (copy, nonatomic) NSString *merchantType;
@property (copy, nonatomic) NSString *memberId;
@property (copy, nonatomic) NSString *remark;
@property (copy, nonatomic) NSString *transportType;
@property (copy, nonatomic) NSString *status;

+ (NSMutableArray *)getModels:(NSArray *)modelsDicArr;

@end
