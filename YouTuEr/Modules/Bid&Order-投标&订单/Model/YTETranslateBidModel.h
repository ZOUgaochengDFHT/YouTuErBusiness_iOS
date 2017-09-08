//
//  YTETranslateBidModel.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/12.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 //需求列表 - 翻译
 {
 "nextId": 22,                                 //下一页ID
 "code": 200,
 "pageSize": 5,                                //每页显示记录数
 "orders": [                                   //翻译需求列表
 {
 "classify": 0,                        //分类:0需求1订单
 "amount": 100,                        //订单金额
 "parStatus": 0,                       //支付状态:0待支付;1支付成功
 "bidFee": 100,                        //投标价
 "arriveDate": "2017-07-09",           //开始日期
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
 },
 ... ...
 ]
 }

 */


@interface YTETranslateBidModel : NSObject


@property (copy, nonatomic) NSString *classify;
@property (copy, nonatomic) NSString *amount;
@property (copy, nonatomic) NSString *parStatus;
@property (copy, nonatomic) NSString *bidFee;
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
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *photo;

+ (NSMutableArray *)getModels:(NSArray *)modelsDicArr;


@end
