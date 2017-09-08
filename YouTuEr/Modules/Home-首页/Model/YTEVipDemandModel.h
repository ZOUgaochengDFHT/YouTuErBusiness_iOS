//
//  YTEVipDemandModel.h
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
 "orderNum": "2017070216414225799",    //订单号
 "remark": "伦敦天主教堂,华布伦街,欢乐天地,生地海滩",       //具体需求
 "type": 5,                            //订单类型:0大巴1导游2翻译3美食4接机5VIP
 "luggageNum": 3,                      //行李数量
 "arriveCity": "伦敦",                 //到达城市
 "createTime": "2017-07-02",           //订单创建时间
 "arriveCountry": "英国",              //到达国家
 "guestNum": 3,                        //游客人数
 "finishDate": "2017-07-25",           //结束日期
 "id": 19,                             //订单表主键ID
 "memberId": 1,                        //客户主键ID
 "status": 0                           //状态:0正常1取消

 */

@interface YTEVipDemandModel : NSObject

@property (copy, nonatomic) NSString *classify;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *photo;
@property (copy, nonatomic) NSString *arriveDate;
@property (copy, nonatomic) NSString *orderNum;
@property (copy, nonatomic) NSString *remark;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *luggageNum;
@property (copy, nonatomic) NSString *arriveCity;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *arriveCountry;
@property (copy, nonatomic) NSString *guestNum;
@property (copy, nonatomic) NSString *finishDate;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *memberId;
@property (copy, nonatomic) NSString *status;

+ (NSMutableArray *)getModels:(NSArray *)modelsDicArr;

@end
