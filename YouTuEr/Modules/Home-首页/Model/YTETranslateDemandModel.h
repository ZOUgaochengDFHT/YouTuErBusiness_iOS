//
//  YTETranslateDemandModel.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/10.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "classify": 0,                        //分类:0需求1订单
 "nickName": "李白",                   //客户姓名
 "photo": "xxx.png",                   //客户头像
 "arriveDate": "2017-07-09",           //开始日期(可根据该日期计算剩余天数时分秒)
 "orderNum": "2017070216441536114",    //订单号
 "remark": "我要找一个漂亮的美女翻译", //翻译备注
 "type": 2,                            //订单类型:0大巴1导游2翻译3美食4接机5VIP
 "createTime": "2017-07-02",           //订单创建时间
 "arriveCountry": "英国",              //翻译所在国家
 "transArea": 10,                      //翻译领域:1电影;2音乐;3时尚;4奢侈品;5工业;6化学;7生物;8政治;9金融;10文化;11教育;12其他
 "finishDate": "2017-07-11",           //结束日期
 "id": 23,                             //订单主键ID
 "transLanguage": 1,                   //翻译语种:1中英;2中法
 "merchantType": 1,                    //翻译分类:1陪同;2交替传译;3同声传译
 "memberId": 1,                        //客户主键ID
 "status": 0                           //状态:0正常1取消

 */

@interface YTETranslateDemandModel : NSObject

@property (copy, nonatomic) NSString *classify;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *photo;
@property (copy, nonatomic) NSString *arriveDate;
@property (copy, nonatomic) NSString *orderNum;
@property (copy, nonatomic) NSString *remark;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *arriveCountry;
@property (copy, nonatomic) NSString *transArea;
@property (copy, nonatomic) NSString *finishDate;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *transLanguage;
@property (copy, nonatomic) NSString *merchantType;
@property (copy, nonatomic) NSString *memberId;
@property (copy, nonatomic) NSString *status;

+ (NSMutableArray *)getModels:(NSArray *)modelsDicArr;

@end
