//
//  YTEAuthenModel.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/20.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 "authen": {               //认证信息
 "travelagency": 1,     //旅游公司认证：1表示已认证;0表示未认证或者认证已过有效期
 "daoyou": 1,         //导游公司认证：1表示已认证;0表示未认证或者认证已过有效期
 "jieji": 1,            //车辆公司认证：1表示已认证;0表示未认证或者认证已过有效期
 "agency": 1,         //大巴公司认证：1表示已认证;0表示未认证或者认证已过有效期
 "fanyi": 1           //翻译公司认证：1表示已认证;0表示未认证或者认证已过有效期
 },

 */

@interface YTEAuthenModel : NSObject

@property (copy, nonatomic) NSString *travelagency;
@property (copy, nonatomic) NSString *daoyou;
@property (copy, nonatomic) NSString *jieji;
@property (copy, nonatomic) NSString *agency;
@property (copy, nonatomic) NSString *fanyi;


@end
