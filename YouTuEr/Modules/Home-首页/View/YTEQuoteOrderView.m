//
//  YTEQuoteOrderView.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/10.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEQuoteOrderView.h"

@interface YTEQuoteOrderView ()

@property (weak, nonatomic) IBOutlet TTTAttributedLabel *countDownLabel;

@end

@implementation YTEQuoteOrderView

#pragma mark - View Cycle
- (void)awakeFromNib {
    [super awakeFromNib];
    [self startTimer];
}

#pragma mark - Actions
- (IBAction)quoteOrder:(UIButton *)sender {
    if (self.quoteOrderHandle) self.quoteOrderHandle(self.tag);
}


#pragma mark - Setetr
- (void)setArriveDate:(NSString *)arriveDate {
    _arriveDate = arriveDate;
    [self setAttributedText:_arriveDate];
}

#pragma mark - Private

- (void)startTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)countDown {
    if (!_arriveDate) return;
    [self setAttributedText:_arriveDate];
}

- (void)setAttributedText:(NSString *)arriveDate {
    [self.countDownLabel setText:[[self class] intervalSinceNow:_arriveDate] afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)YTEFont(14.0).fontName, YTEFont(14.0).pointSize, NULL);
        [@[@"您还剩下", @"天", @"小时", @"分" ,@"秒"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange firstRange = [[mutableAttributedString string] rangeOfString:obj options:NSCaseInsensitiveSearch];
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[YTELabelBoldColor CGColor] range:firstRange];
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:firstRange];
        }];
        CFRelease(font);
        return mutableAttributedString;
    }];
}

+ (NSString *)intervalSinceNow:(NSString *)theDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //然后创建日期对象
    NSDate *date1 = [dateFormatter dateFromString:[theDate stringByAppendingString:@" 00:00:00"]];
    NSDate *date = [NSDate date];
    //计算时间间隔（单位是秒）
    NSTimeInterval time = [date1 timeIntervalSinceDate:date];
    //计算天数、时、分、秒
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minutes = ((int)time)%(3600*24)%3600/60;
    int seconds = ((int)time)%(3600*24)%3600%60;
    NSString *dateContent = [[NSString alloc] initWithFormat:@"您还剩下%i天%i小时%i分%i秒",days,hours,minutes,seconds];
    return dateContent;
}

@end
