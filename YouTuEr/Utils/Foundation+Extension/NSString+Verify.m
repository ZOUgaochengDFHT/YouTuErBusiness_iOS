//
//  NSString+Verify.m
//  02-正则表达式实战【掌握】
//
//  Created by shenzhenIOS on 16/3/28.
//  Copyright © 2016年 shenzhenIOS. All rights reserved.
//

#import "NSString+Verify.h"

// 这个分类类需要会使用。
@implementation NSString (Verify)


- (BOOL) isQQ {
//  QQ的匹配模式
    NSString *pattern = @"^[1-9]\\d{5,10}$";
    return [self matchWithPattern:pattern];
}

- (BOOL) isPhone {
    NSString *pattern = @"^(0|86)?1([358]\\d|7[678]|4[57])\\d{8}$";
    return [self matchWithPattern:pattern];
}

- (BOOL) isEmail{
    NSString  *pattern = @"^[a-z0-9]+([\\._\\-]*[a-z0-9])*@([a-z0-9]+\\-*[a-z0-9]+\\.){1,63}[a-z0-9]+$";
    return [self matchWithPattern:pattern];
}

/// 匹配字符串
/// @param pattern 匹配模式
- (BOOL) matchWithPattern:(NSString *) pattern {
    NSError *error = nil;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (error) {
        NSLog(@"创建正则表达式失败%@",error);
        return NO;
    }
    
    //  匹配
    NSTextCheckingResult *results  = [regularExpression firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    if (results) {
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)checkPassword {
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
    
}

@end
