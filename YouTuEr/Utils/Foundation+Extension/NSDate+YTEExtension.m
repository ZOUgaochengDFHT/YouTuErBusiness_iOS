//
//  NSDate+YTEExtension.m
//  YouTuEr
//
//  Created by 苏一 on 2017/3/16.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "NSDate+YTEExtension.h"

@implementation NSDate (YTEExtension)

- (NSString *)stringFromDateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    return [formatter stringFromDate:self];
}

+ (NSDate *)dateFromString:(NSString *)string dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    return [formatter dateFromString:string];
}

- (NSUInteger)calcDaysToEndDate:(NSDate *)endDate {
    
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[endDate timeIntervalSinceDate:self];
    
    float days = (time)/(3600*24);
    //int hours=((int)time)%(3600*24)/3600;
    //NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    return ceil(days - 0.001) + 1;
}

//传入今天的时间，返回明天的时间
- (NSDate *)getTomorrowDay {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
//    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
//    [dateday setDateFormat:@"yyyy-MM-dd"];
    return beginningOfWeek;
}

/**
 比较两个日期的大小
 日期格式为:yyyy-MM-dd HH-mm
 */
- (int)compareDate:(NSString*)date {
    int ci = 0;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *dt2 = [[NSDate alloc] init];
    dt2 = [df dateFromString:date];
    NSComparisonResult result = [self compare:dt2];
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending: ci = 1; break;
            //date02比date01小
        case NSOrderedDescending: ci = -1; break;
            //date02=date01
            //        case NSOrderedSame: ci=0; break;
        case NSOrderedSame: ci = 0; break;
    }
    return ci;
}

@end
