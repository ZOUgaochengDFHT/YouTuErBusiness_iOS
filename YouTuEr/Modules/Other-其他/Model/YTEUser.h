//
//  YTEUser.h
//  YouTuEr
//
//  Created by 苏一 on 2017/6/1.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAMKeychain.h"
@interface YTEUser : NSObject
@property (nonatomic, copy) NSString *nickName; //昵称
@property (nonatomic, assign) NSInteger clientId; //用户ID，登录之后，每个请求都需要带上 clientId
@property (nonatomic, copy) NSString *phone; //联系方式
@property (nonatomic, copy) NSString *photo; //头像，URL格式
@property (nonatomic, copy) NSString *gender; //性别：M 男；F 女
@property (nonatomic, copy) NSString *birthday; //生日
@property (nonatomic, copy) NSString *country; //国家
@property (nonatomic, copy) NSString *province; //省
@property (nonatomic, copy) NSString *location; //定位
@property (nonatomic, copy) NSString *city; //城市
@property (nonatomic, copy) NSString *area; //区域
@property (nonatomic, copy) NSString *postcode; //邮编
@property (nonatomic, copy) NSString *address; //地址
@property (nonatomic, copy) NSString *sign; //个性签名


+ (instancetype)shareInstance;
- (void)deployWithLogInResponse:(NSDictionary *)data;
- (void)deployUserinfoInResponse:(NSDictionary *)data;
@end
