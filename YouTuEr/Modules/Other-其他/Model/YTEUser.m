//
//  YTEUser.m
//  YouTuEr
//
//  Created by 苏一 on 2017/6/1.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEUser.h"

@implementation YTEUser



+ (instancetype)shareInstance {
    static YTEUser *singleInstance = nil;
    static dispatch_once_t once_token = 0;
    dispatch_once(&once_token, ^{
        singleInstance = [[self alloc] init];
        [singleInstance setupBaseData];
    });
    
    return singleInstance;
}



- (void)setupBaseData {
    _nickName = [SAMKeychain nickName];
    _clientId = [SAMKeychain clientId].integerValue;
    _phone = @"";
    _photo = @"";
    _gender = @"";
    _birthday = @"";
    _country = @"";
    _province = @"";
    _location = @"";
    _city = @"";
    _area = @"";
    _postcode = @"";
    _address = @"";
    _sign = @"";
}

- (void)deployWithLogInResponse:(NSDictionary *)data {
    if ([data[@"code"] integerValue] != 200) {
        return;
    }
    [SAMKeychain setClientId:data[@"clientId"]];
    self.clientId = (NSInteger)data[@"clientId"];
}

- (void)deployUserinfoInResponse:(NSDictionary *)data {
    _phone = @"";
    _photo = @"";
    _gender = @"";
    _birthday = @"";
    _country = @"";
    _province = @"";
    _location = @"";
    _city = @"";
    _area = @"";
    _postcode = @"";
    _address = @"";
    _sign = @"";
}
@end
