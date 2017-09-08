//
//  YTEGroupDemandModel.h
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
 "orderNum": "2017070216384980656",    //订单号
 "remark": "红烧狮子头,鱼菱麦菜,烧鸡公,水煮活鱼,清炒小吓",    //餐单
 "type": 3,                            //订单类型:0大巴1导游2翻译3美食4接机5VIP
 "arriveCity": "伦敦",                 //进餐城市
 "arriveTime": "18:30",                //进餐时间
 "createTime": "2017-07-02",           //订单创建时间
 "arriveCountry": "英国",              //进餐国家
 "guestNum": 3,                        //进餐人数
 "finishDate": "2017-08-02",           //进餐日期
 "id": 17,                             //订单主键ID
 "merchantType": 1,                    //团餐:1是0否
 "memberId": 1,                        //客户主键ID
 "status": 0                           //状态:0正常1取消

 */
@interface YTEGroupDemandModel : NSObject

@property (copy, nonatomic) NSString *classify;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *photo;
@property (copy, nonatomic) NSString *arriveDate;
@property (copy, nonatomic) NSString *orderNum;
@property (copy, nonatomic) NSString *remark;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *arriveCity;
@property (copy ,nonatomic) NSString *arriveTime;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *arriveCountry;
@property (copy, nonatomic) NSString *guestNum;
@property (copy, nonatomic) NSString *finishDate;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *merchantType;
@property (copy, nonatomic) NSString *memberId;
@property (copy, nonatomic) NSString *status;

+ (NSMutableArray *)getModels:(NSArray *)modelsDicArr;

@end
