//
//  NSString+YTEType.m
//  YouTuEr
//
//  Created by 苏一 on 2017/7/4.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "NSString+YTEType.h"
#import "YTEAuthenModel.h"

@implementation NSString (YTEType)

- (BOOL)boolValueFromAuthen:(YTEAuthenModel *)authenModel {
    if ([self isEqual:@"导游"]) {
        return [authenModel.daoyou isEqual:@"1"];
    }else if ([self isEqual:@"接送机"]) {
        return [authenModel.jieji isEqual:@"1"];
    }else if ([self isEqual:@"翻译"]) {
        return [authenModel.fanyi isEqual:@"1"];
    }else if ([self isEqual:@"大巴"]) {
        return [authenModel.agency isEqual:@"1"];
    }else if ([self isEqual:@"团餐"]) {
        return [authenModel.travelagency isEqual:@"1"];
    }else {
        return [authenModel.travelagency isEqual:@"1"];
    }
}

+ (YTEBusinessType)businessTypeFromTitle:(NSString *)title {
    YTEBusinessType type;
    if ([title isEqual:@"导游"]) {
        type = YTEBusinessTypeGuide;
    }else if ([title isEqual:@"接送机"]) {
        type = YTEBusinessTypePickup;
    }else if ([title isEqual:@"翻译"]) {
        type = YTEBusinessTypeTranslate;
    }else if ([title isEqual:@"大巴"]) {
        type = YTEBusinessTypeBus;
    }else if ([title isEqual:@"团餐"]) {
        type = YTEBusinessTypeGroup;
    }else {
        type = YTEBusinessTypeVIP;
    }
    return type;
}

+ (instancetype)stringFromBusinessType:(YTEBusinessType)type {
    switch (type) {
        case YTEBusinessTypeBus:
            return @"大巴待投标";
            break;
        case YTEBusinessTypeGuide:
            return @"导游待投标";
            break;
        case YTEBusinessTypeTranslate:
            return @"翻译待投标";
            break;
        case YTEBusinessTypeGroup:
            return @"团餐待投标";
            break;
        case YTEBusinessTypePickup:
            return @"接送机待投标";
            break;
        default:
            return @"VIP待投标";
            break;
    }
}

+ (instancetype)stringFromTransportType:(NSInteger)transportType {
    switch (transportType) {
        case 1:
            return @"经济型";
            break;
        case 2:
            return @"舒适型";
            break;
        case 3:
            return @"行政型";
            break;
        case 4:
            return @"豪华型";
            break;
        case 5:
            return @"自备车辆";
            break;
        case 6:
            return @"公共交通";
            break;
        case 7:
            return @"徒步";
            break;
        default:
            break;
    }
    return nil;
}

- (NSInteger)stringToTransportType {
    if ([self isEqualToString:@"经济型"]) {
        return 1;
    }else if ([self isEqualToString:@"舒适型"]) {
        return 2;
    }else if ([self isEqualToString:@"行政型"]) {
        return 3;
    }else if ([self isEqualToString:@"豪华型"]) {
        return 4;
    }else if ([self isEqualToString:@"自备车辆"]) {
        return 5;
    }else if ([self isEqualToString:@"公共交通"]) {
        return 6;
    }else{
        return 7;
    }
}

+ (instancetype)stringFromGuideMerchantType:(NSInteger)merchantType {
    switch (merchantType) {
        case 1:
            return @"资深导游";
            break;
        case 2:
            return @"专业导游";
            break;
        case 3:
            return @"当地知客";
            break;
        default:
            break;
    }
    return nil;
}

+ (instancetype)stringFromOrderParStatus:(NSInteger)perStatus {
    if (perStatus == 0) {
        return @"待支付";
    }
    return @"支付成功";
}


- (NSInteger)stringToGuideMerchantType {
    if ([self isEqualToString:@"资深"]) {
        return 1;
    }else if ([self isEqualToString:@"专业"]) {
        return 2;
    }else if ([self isEqualToString:@"当地知客"]) {
        return 3;
    }
    return 0;
}

+ (instancetype)stringFromTranslateMerchantType:(NSInteger)merchantType {
    switch (merchantType) {
        case 1:
            return @"陪同翻译";
            break;
        case 2:
            return @"交替传译";
            break;
        case 3:
            return @"同声传译";
            break;
        default:
            break;
    }
    return nil;
}

- (NSInteger)stringToTranslateMerchantType {
    if ([self isEqualToString:@"陪同翻译"]) {
        return 1;
    }else if ([self isEqualToString:@"交替传译"]) {
        return 2;
    }else if ([self isEqualToString:@"同声传译"]) {
        return 3;
    }
    return 0;
}



+ (instancetype)stringFromTransLanguage:(NSInteger)transLanguage {
    switch (transLanguage) {
        case 1:
            return @"中英互译";
            break;
        case 2:
            return @"中法互译";
            break;
        default:
            break;
    }
    return nil;
}

+ (instancetype)stringFromPickupMerchantType:(NSInteger)merchantType {
    switch (merchantType) {
        case 1:
            return @"接机";
            break;
        case 2:
            return @"送机";
            break;
        default:
            break;
    }
    return nil;
}

- (NSInteger)stringToPickupMerchantType {
    if ([self isEqualToString:@"接机"]) {
        return 1;
    }else if ([self isEqualToString:@"送机"]) {
        return 2;
    }
    return 0;
}

- (NSInteger)stringToTransLanguage {
    if ([self isEqualToString:@"中英"]) {
        return 1;
    }else if ([self isEqualToString:@"中法"]) {
        return 2;
    }
    return 0;
}

+ (instancetype)stringFromTransArea:(NSInteger)transArea {
    switch (transArea) {
        case 1:
            return @"电影";
            break;
        case 2:
            return @"音乐";
            break;
        case 3:
            return @"时尚";
            break;
        case 4:
            return @"奢侈品";
            break;
        case 5:
            return @"工业";
            break;
        case 6:
            return @"化学";
            break;
        case 7:
            return @"生物";
            break;
        case 8:
            return @"政治";
            break;
        case 9:
            return @"金融";
            break;
        case 10:
            return @"文化";
            break;
        case 11:
            return @"教育";
            break;
        case 12:
            return @"其他";
            break;
        default:
            break;
    }
    return nil;
}

- (NSInteger)stringToTransArea {
    if ([self isEqualToString:@"电影"]) {
        return 1;
    }else if ([self isEqualToString:@"音乐"]) {
        return 2;
    }else if ([self isEqualToString:@"时尚"]) {
        return 3;
    }else if ([self isEqualToString:@"奢侈品"]) {
        return 4;
    }else if ([self isEqualToString:@"工业"]) {
        return 5;
    }else if ([self isEqualToString:@"化学"]) {
        return 6;
    }else if ([self isEqualToString:@"生物"]) {
        return 7;
    }else if ([self isEqualToString:@"政治"]) {
        return 8;
    }else if ([self isEqualToString:@"金融"]) {
        return 9;
    }else if ([self isEqualToString:@"文化"]) {
        return 10;
    }else if ([self isEqualToString:@"教育"]) {
        return 11;
    }else if ([self isEqualToString:@"其他"]) {
        return 12;
    }
    return 0;
}


@end
