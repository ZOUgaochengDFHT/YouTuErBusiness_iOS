//
//  NSDate+YTEExtension.h
//  YouTuEr
//
//  Created by 苏一 on 2017/3/16.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YTEExtension)
/**
 *  将date转换成字符串
 *
 *  @param dateFormat 时间格式
 */
- (NSString *)stringFromDateFormat:(NSString *)dateFormat;

/**
 *  将字符串转换成date
 *
 *  @param string 时间字符串
 *
 *  @param dateFormat 时间格式
 */
+ (NSDate *)dateFromString:(NSString *)string dateFormat:(NSString *)dateFormat;

/**
 *  返回两个date之间对比有多少天
 *
 *  @param endDate 结束时间
 */
- (NSUInteger)calcDaysToEndDate:(NSDate *)endDate;

//传入今天的时间，返回明天的时间
- (NSDate *)getTomorrowDay;

/**
 比较两个日期的大小
 日期格式为:yyyy-MM-dd HH-mm
 */
- (int)compareDate:(NSString*)date;
@end
