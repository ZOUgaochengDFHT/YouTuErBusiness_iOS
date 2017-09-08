//
//  NSString+CO.m
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/7/28.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "NSString+CO.h"
#import <CommonCrypto/CommonCrypto.h>

static NSString *_SRNSStringMD5(NSString *string) {
    if (!string) return nil;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],  result[1],  result[2],  result[3],
            result[4],  result[5],  result[6],  result[7],
            result[8],  result[9],  result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@implementation NSString (CO)

- (NSString *)replaceAll:(NSString*)origin with:(NSString*)replacement {
    return [self stringByReplacingOccurrencesOfString:origin withString:replacement];
}


- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


- (NSArray *)split:(NSString*)separator {
    return [self componentsSeparatedByString:separator];
}

- (NSString *)MD5String {
    return _SRNSStringMD5(self);
}
- (NSString *)registerMD5String
{
    NSString *str = [NSString stringWithFormat:@"&*()%@!@#$%%^",self];
    return [str MD5String];
}

- (BOOL)checkTelNumber {
    NSString *pattern = @"^(0|86)?1([358]\\d|7[678]|4[57])\\d{8}$";
    return [self matchWithPattern:pattern];
}

- (BOOL)checkPassWord
{
    //6-20位数字和字母组成
    NSString *passWordRegex = @"^(?!^[0-9]+$)(?!^[A-z]+$)(?!^[^A-z0-9]+$)^.{6,18}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
    return [pred evaluateWithObject:self];
}
- (BOOL)isNumbers {
    if([self length] <= 0)
        return NO;
    NSString *regex = @"[0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}


- (BOOL)isValidateEmail {
    NSString *pattern = @"^[a-z0-9]+([\\._\\-]*[a-z0-9])*@([a-z0-9]+\\-*[a-z0-9]+\\.){1,63}[a-z0-9]+$";
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

#pragma 正则匹配用户姓名,20位的中文或英文
- (BOOL)checkUserName
{
    if(self.length <= 0) return NO;
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
    
}

#pragma 正则匹配用户身份证号15或18位
- (BOOL)checkUserIdCard
{
    //判断是否为空
    if (self == nil || self.length <= 0) {
        return NO;
    }
    //判断是否是18位，末尾是否是x
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *selfPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if(![selfPredicate evaluateWithObject:self]){
        return NO;
    }
    //判断生日是否合法
    NSRange range = NSMakeRange(6,8);
    NSString *datestr = [self substringWithRange:range];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyyMMdd"];
    if([formatter dateFromString:datestr] == nil){
        return NO;
    }
    
    //判断校验位
    if(self.length == 18)
    {
        NSArray *idCardWi= @[ @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2" ]; //将前17位加权因子保存在数组里
        NSArray * idCardY=@[ @"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2" ]; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        int idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
        for(int i = 0; i < 17; i++){
            idCardWiSum += [[self substringWithRange:NSMakeRange(i,1)] intValue] * [idCardWi[i] intValue];
        }
        
        int idCardMod = idCardWiSum%11;//计算出校验码所在数组的位置
        NSString *idCardLast = [self substringWithRange:NSMakeRange(17,1)];//得到最后一位身份证号码
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod == 2){
            if([idCardLast isEqualToString:@"X"] || [idCardLast isEqualToString:@"x"]){
                return YES;
            }else{
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast intValue] == [idCardY[idCardMod] intValue]){
                return YES;
            }else{
                return NO;
            }
        }
    }
    return NO;
}

- (CGFloat)sizeToWidth:(CGFloat)retHeight retFontSize:(CGFloat)retFontSize {
    CGSize titleSize = [self boundingRectWithSize:CGSizeMake(100000, retHeight)
                                          options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:retFontSize]}
                                          context:nil].size;
    return titleSize.width + 1;
}

- (CGFloat)sizeToHeight:(CGFloat)width fontSize:(CGFloat)fontSize {
    CGSize titleSize = [self boundingRectWithSize:CGSizeMake(width, 1000000)
                                          options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}
                                          context:nil].size;
    return titleSize.height + 1;
}

- (CGSize)stringSizeWithFont:(UIFont *)font Size:(CGSize)size {
    
    CGSize resultSize;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
        //段落样式
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineBreakMode = NSLineBreakByWordWrapping;
        
        //字体大小，换行模式
        NSDictionary *attributes = @{NSFontAttributeName : font , NSParagraphStyleAttributeName : style};
        resultSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    } else {
        //计算正文的高度
        resultSize = [self boundingRectWithSize:size
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSLineBreakByWordWrapping
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil].size;
    }
    return resultSize;
}

- (NSString *)addSuffixDoubleZero {
    NSString *subffix = @".000001";
    if (![self containsString:@"."]) {
       return [self stringByAppendingString:subffix];
    }else {
        NSArray  *componentArr = [self componentsSeparatedByString:@"."];
        if ([componentArr.lastObject floatValue] > 0) {
            return self;
        } else {
            return [self replaceAll:componentArr.lastObject with:[subffix replaceAll:@"." with:@""]];
        }
    }
   
}


- (NSString *)stringFromFormatterDate:(NSDate *)replaceDate index:(NSUInteger)index {
    NSMutableArray *dayArr = [NSMutableArray new];
    [dayArr addObjectsFromArray:[self componentsSeparatedByString:@"-"]];
    [dayArr replaceObjectAtIndex:index withObject:[replaceDate stringFromDateFormat:@"yyyy.MM.dd"]];
    NSLog(@"%@", [dayArr componentsJoinedByString:@"-"]);
    return [dayArr componentsJoinedByString:@"-"];
}

@end
