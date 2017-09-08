//
//  YTEAccountModel.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/7.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 member =     {
 account = "223355@qq.com";
 accountType = 2;
 address = "\U4eba\U6c11\U5927\U4f1a\U5802";
 area = "\U671d\U9633\U533a";
 city = "\U5317\U4eac\U5e02";
 country = "\U4e2d\U56fd";
 gender = M;
 id = 2;
 lastLoginTime = "Aug 9, 2017 11:50:26 AM";
 location = "\U5317\U4eac\U5317\U4eac\U5e02";
 nickName = "\U5f20\U5c0f\U56db";
 photo = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502206538329&di=94cceb6cd06ffe468e139a677c575a00&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201408%2F02%2F20140802045903_Jziky.thumb.700_0.jpeg";
 postcode = 414100;
 province = "\U5317\U4eac\U5e02";
 sign = "\U6211\U6b32\U6210\U4ed9\Uff0c\U5feb\U4e50\U9f50\U5929";
 };
 */

@interface YTEAccountModel : NSObject

@property (copy, nonatomic) NSString *account;
@property (copy, nonatomic) NSString *accountType;
@property (copy, nonatomic) NSString *birthday;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *gender;
@property (copy, nonatomic) NSString *accountid;
@property (copy, nonatomic) NSString *lastLoginTime;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *otExpenses;
@property (copy, nonatomic) NSString *photo;
@property (copy, nonatomic) NSString *postcode;
@property (copy, nonatomic) NSString *province;
@property (copy, nonatomic) NSString *sign;
@property (copy, nonatomic) NSString *address;



@end
