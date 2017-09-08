//
//  NSString+CO.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/7/28.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CO)

/**
 替换字符串
 */
- (NSString *)replaceAll:(NSString*)origin with:(NSString*)replacement;
- (NSString *)trim;
- (NSArray *)split:(NSString*) separator;

/**
 MD5加密
 @return 加密后的字符串
 */
- (NSString *)MD5String;

/**
 登录注册MD5加密
 @return 加密后的字符串
 */
-(NSString *)registerMD5String;
/**
 正则匹配手机号
 */
- (BOOL)checkTelNumber;

/**
 是否全为数字
 */
- (BOOL)isNumbers;

/**
 正则匹配邮箱格式
 */
- (BOOL)isValidateEmail;


/**
 正则匹配用户身份证号15或18位
 */
- (BOOL)checkUserIdCard;


/**
 #pragma 正则匹配用户姓名,20位的中文或英文
 */
- (BOOL)checkUserName;

/**
 正则登录密码：
 数字、字母、符号至少两种
 */
-(BOOL)checkPassWord;
/**
 获取字体宽度
 
 @param retHeight   字体高度
 @param retFontSize 字体大小
 
 @return 宽度
 */
//- (CGFloat)sizeToWidth:(CGFloat)retHeight retFontSize:(CGFloat)retFontSize;
//
///**
// 高度
// */
//- (CGFloat)sizeToHeight:(CGFloat)width fontSize:(CGFloat)fontSize;
//
////根据字符串的字体和size(此处size设置为字符串宽和MAXFLOAT)返回多行显示时的字符串size
//- (CGSize)stringSizeWithFont:(UIFont *)font Size:(CGSize)size;
- (NSString *)addSuffixDoubleZero;

- (NSString *)stringFromFormatterDate:(NSDate *)replaceDate index:(NSUInteger)index;
@end
