//
//  YTEOngoingDetailView.m
//  YouTuEr
//
//  Created by 苏一 on 2017/6/23.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEOngoingDetailView.h"

@interface YTEOngoingDetailView()

@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;

@property (weak, nonatomic) IBOutlet UILabel *leftLabel00;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel01;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel10;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel11;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel20;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel21;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel30;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel31;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel40;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel41;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel00;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel01;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel10;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel11;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel20;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel21;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel30;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel31;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel; //详细行程

@property (nonatomic, weak) IBOutlet UILabel *serviceNameLabel; //名字
@property (nonatomic, weak) IBOutlet UILabel *locationLabel; //所在国家
@property (nonatomic, weak) IBOutlet UILabel *originLabel; //籍贯
@property (nonatomic, weak) IBOutlet UILabel *typeLabel; //类型
@property (nonatomic, weak) IBOutlet UILabel *specialtyLabel; //专长
@property (nonatomic, weak) IBOutlet UILabel *workingHoursLabel; //工作时长
@property (nonatomic, weak) IBOutlet UILabel *overtimeFeeLabel; //加班费
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel; //评分
@property (nonatomic, weak) IBOutlet UILabel *costLabel; //费用
@property (nonatomic, weak) IBOutlet UILabel *messageLabel; //留言
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel1;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel2;
@property (weak, nonatomic) IBOutlet UIImageView *certifiedImage; //认证图标



@property (weak, nonatomic) IBOutlet UILabel *paymentStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *paidLabel;
@property (weak, nonatomic) IBOutlet UILabel *unpaidLabel;

@end

@implementation YTEOngoingDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)detailtView {
    YTEOngoingDetailView* messageAlertView = [[NSBundle mainBundle] loadNibNamed:@"YTEOngoingDetailView" owner:nil options:nil].lastObject;
    //设置属性
    
    //返回实例
    return messageAlertView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundView.yte_width = YTEScreenBoundsWidth;
}

@end
