//
//  YTEMyQuoteModel.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/16.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 bidFee = 300;
 bidTime = "Jul 9, 2017 12:08:54 AM";
 bidUsername = "\U5f20\U5c0f\U4e09";
 currency = "\Uffe5";
 fee = 45;
 id = 11;
 merchantId = 2;
 message = "\U7852\U9f13\U6625\U6811\U66ae\U4e91 \U50bb\U5927\U4e2a\U4e00";
 orderId = 26;
 orderNum = 2017070216454691522;
 total = 255;
 */

@interface YTEMyQuoteModel : NSObject

@property (copy, nonatomic) NSString *bidFee;
@property (copy, nonatomic) NSString *bidTime;
@property (copy, nonatomic) NSString *bidUsername;
@property (copy, nonatomic) NSString *currency;
@property (copy, nonatomic) NSString *fee;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *merchantId;
@property (copy, nonatomic) NSString *message;
@property (copy, nonatomic) NSString *orderId;
@property (copy ,nonatomic) NSString *orderNum;
@property (copy, nonatomic) NSString *total;


@end
