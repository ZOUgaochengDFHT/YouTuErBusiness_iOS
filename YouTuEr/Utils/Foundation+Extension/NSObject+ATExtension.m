//
//  NSObject+ATExtension.m
//  Athena
//
//  Created by GaoCheng.Zou on 2017/4/26.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "NSObject+ATExtension.h"

@implementation NSObject (ATExtension)

#pragma mark - Public

- (BOOL)isEmpty {
    return !self || ![self isNotEmpty];
}

- (BOOL)isNotEmpty {
    if ([self isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)self;
        return str && ![[str trim] isEqual:@""];
    }else if ([self isKindOfClass:[NSArray class]]){
        return ((NSArray *)self).count > 0;
    }else if ([self isKindOfClass:[NSDictionary class]]){
        NSDictionary *dict = (NSDictionary *)self;
        return dict.count > 0;
    }else{
        return self != nil;
    }
}

- (NSString *)jsonDescription {
    NSData *jsonData;
    if ([self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSDictionary class]]) {
        jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    } else {
        jsonData = [NSJSONSerialization dataWithJSONObject:[self dictionaryFromObject] options:0 error:nil];
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

#pragma mark - Private

- (NSDictionary*)dictionaryFromObject {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    unsigned int outCount, i;
    
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if (propName) {
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSValue *value = [self valueForKey:propertyName];
            
            if (value && (id)value != [NSNull null] && [value isJsonSupported]) {
                [dict setValue:value forKey:propertyName];
            }
        }
    }
    free(properties);
    
    return dict;
}

- (BOOL)isJsonSupported {
    return  [self isKindOfClass:[NSNumber class]]       ||
    [self isKindOfClass:[NSString class]]       ||
    [self isKindOfClass:[NSArray class]]        ||
    [self isKindOfClass:[NSDictionary class]];
}


- (NSString *)titleFromMerchantAuthenType:(YTEMerchantAuthType)authenType {
    switch (authenType) {
        case YTEMerchantAuthTypeDaoyou:
            return @"导游认证";
            break;
        case YTEMerchantAuthTypeFanyi:
            return @"翻译认证";
            break;
        case YTEMerchantAuthTypeJieji:
            return @"车辆认证";
            break;
        case YTEMerchantAuthTypeTravelagency:
            return @"旅游公司认证";
            break;
        default:
            return @"大巴公司认证";
            break;
    }
}

- (NSString *)itemTitle1FromMerchantAuthenType:(YTEMerchantAuthType)authenType {
    if (authenType == YTEMerchantAuthTypeDaoyou) return @"导游类型";
    return @"翻译类型";
}

- (NSString *)itemTitle2FromMerchantAuthenType:(YTEMerchantAuthType)authenType {
    if (authenType == YTEMerchantAuthTypeDaoyou) return @"导龄";
    if (authenType == YTEMerchantAuthTypeJieji) return @"驾龄";
    return @"从业时间";
}

- (NSString *)itemTitle3FromMerchantAuthenType:(YTEMerchantAuthType)authenType {
    if (authenType == YTEMerchantAuthTypeJieji) return @"车辆型号";
    return @"营业执照号";
}

- (NSString *)itemTitle4FromMerchantAuthenType:(YTEMerchantAuthType)authenType {
    if (authenType == YTEMerchantAuthTypeJieji) return @"品牌";
    return @"国家";
}

- (NSString *)itemTitle5FromMerchantAuthenType:(YTEMerchantAuthType)authenType {
    switch (authenType) {
        case YTEMerchantAuthTypeTravelagency:
            return @"营业执照照片上传";
            break;
        case YTEMerchantAuthTypeJieji:
            return @"车辆照片上传";
            break;
        case YTEMerchantAuthTypeAgency:
            return @"营业执照照片上传";
            break;
        default:
            return @"签证照片上传";
            break;
    }
}


- (NSString *)itemTitle6FromMerchantAuthenType:(YTEMerchantAuthType)authenType {
    switch (authenType) {
        case YTEMerchantAuthTypeJieji:
            return @"驾照照片上传";
            break;
        default:
            return @"护照照片上传";
            break;
    }
}

- (NSString *)itemTitle7FromMerchantAuthenType:(YTEMerchantAuthType)authenType {
    if (authenType == YTEMerchantAuthTypeJieji) return @"最大载客数";
    return @"城市";
}

- (NSString *)itemTitle8FromMerchantAuthenType:(YTEMerchantAuthType)authenType {
    if (authenType == YTEMerchantAuthTypeJieji) return @"最多行李数";
    return @"详细地址";
}


- (NSMutableArray *)arrayFromAuthenValue {
    NSMutableDictionary *authenDict = [[[SRUserDefaultManager sharedManager] objectForKey:SR_AUTHEN] mutableCopy];
    NSMutableArray *array = [NSMutableArray new];
    if ([authenDict[@"agency"] isEqual:@(1)]) {
        [array addObject:@"大巴"];
    }
    if ([authenDict[@"daoyou"] isEqual:@(1)]) {
        [array addObject:@"导游"];
    }
    if ([authenDict[@"fanyi"] isEqual:@(1)]) {
        [array addObject:@"翻译"];
    }
    if ([authenDict[@"group"] isEqual:@(1)]) {
        [array addObject:@"团餐"];
    }
    if ([authenDict[@"jieji"] isEqual:@(1)]) {
        [array addObject:@"接送机"];
    }
    if ([authenDict[@"travelagency"] isEqual:@(1)]) {
        [array addObject:@"VIP"];
    }
    return array;
}

@end
