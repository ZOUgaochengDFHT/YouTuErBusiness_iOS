//
//  YTEGroupBidModel.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/12.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 amount = 500;
 arriveCity = "\U4f26\U6566";
 arriveCountry = "\U82f1\U56fd";
 arriveDate = "2017-08-17";
 arriveTime = "18:30";
 bidFee = 500;
 classify = 1;
 createTime = "2017-07-02";
 finishDate = "2017-08-20";
 guestNum = 3;
 id = 17;
 memberId = 0;
 merchantType = 1;
 nickName = "\U5143\U5b9d";
 orderNum = 2017070216384980656;
 parStatus = 0;
 photo = "abc.png";
 remark = "\U7ea2\U70e7\U72ee\U5b50\U5934,\U9c7c\U83f1\U9ea6\U83dc,\U70e7\U9e21\U516c,\U6c34\U716e\U6d3b\U9c7c,\U6e05\U7092\U5c0f\U5413";
 status = 0;
 type = 3;
 */

@interface YTEGroupBidModel : NSObject

@property (copy, nonatomic) NSString *classify;
@property (copy, nonatomic) NSString *amount;
@property (copy, nonatomic) NSString *parStatus;
@property (copy, nonatomic) NSString *bidFee;
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
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *photo;

+ (NSMutableArray *)getModels:(NSArray *)modelsDicArr;

@end
