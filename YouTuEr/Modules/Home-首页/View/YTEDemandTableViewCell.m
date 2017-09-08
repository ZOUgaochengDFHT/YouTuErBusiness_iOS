//
//  YTEDemandTableViewCell.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/10.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEDemandTableViewCell.h"
#import "YTEQuoteOrderView.h"
#import "YTEGuideDemandModel.h"
#import "YTEBusDemandModel.h"
#import "YTEGroupDemandModel.h"
#import "YTEPickupDemandModel.h"
#import "YTETranslateDemandModel.h"
#import "YTEVipDemandModel.h"

@interface YTEDemandTableViewCell ()

@property (strong, nonatomic) YTEQuoteOrderView *quoteOrderView;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *orderNumLabel1;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *dateLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *label11;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *label21;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *label31;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *label41;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *remarkPreLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *label32;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *label12;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *label22;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *label42;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *bidCountLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *label111;
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;

@end

@implementation YTEDemandTableViewCell

#pragma mark - View Cycle

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.quoteOrderView = [[[NSBundle mainBundle] loadNibNamed:@"YTEQuoteOrderView"
                                                         owner:self
                                                       options:nil] lastObject];
    [self.contentView addSubview:self.quoteOrderView];
    @weakify(self);
    self.quoteOrderView.quoteOrderHandle = ^(NSInteger tag) {
        @strongify(self);
        if (self.quoteOrderQuest) self.quoteOrderQuest(tag);
    };
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Setter

- (void)setDemandModel:(NSObject *)demandModel {
    _demandModel = demandModel;
    self.quoteOrderView.tag = self.tag;
    self.quoteOrderView.frame = CGRectMake(5, 222, YTEScreenBoundsWidth - 10, 190);
    if ([_demandModel isKindOfClass:[YTEGuideDemandModel class]]) {
        YTEGuideDemandModel *guideDemandModel = (YTEGuideDemandModel *)demandModel;
        self.quoteOrderView.arriveDate = guideDemandModel.arriveDate;
        self.orderNumLabel1.text = [@"订单号：" stringByAppendingString:guideDemandModel.orderNum];
        self.orderNumLabel.text = @"";
        self.dateLabel.text = @" ";
        [self setAttributedText:self.label111 preText:@"日期：" boldText:[[guideDemandModel.arriveDate stringByAppendingString:@" 至 "] stringByAppendingString:guideDemandModel.finishDate]];
        self.label11.text = @" ";
        self.label12.text = @" ";
        [self setAttributedText:self.label21 preText:@"导游类型：" boldText:[NSString stringFromGuideMerchantType:guideDemandModel.merchantType.integerValue]];
        [self setAttributedText:self.label22 preText:@"人数：" boldText:guideDemandModel.guestNum];
        [self setAttributedText:self.label31 preText:@"国家：" boldText:guideDemandModel.arriveCountry];
        [self setAttributedText:self.label32 preText:@"行李数：" boldText:guideDemandModel.luggageNum];
        [self setAttributedText:self.label41 preText:@"城市：" boldText:guideDemandModel.arriveCity];
        [self setAttributedText:self.label42 preText:@"交通工具：" boldText:[NSString stringFromTransportType:[guideDemandModel.transportType integerValue]]];
        self.remarkPreLabel.text = @"详细行程";
        self.remarkTextView.text = guideDemandModel.remark;
    } else if ([_demandModel isKindOfClass:[YTEBusDemandModel class]]) {
        YTEBusDemandModel *busDemandModel = (YTEBusDemandModel *)demandModel;
        self.quoteOrderView.arriveDate = busDemandModel.arriveDate;
        self.orderNumLabel1.text = [@"订单号：" stringByAppendingString:busDemandModel.orderNum];
        self.orderNumLabel.text = @"";
        self.dateLabel.text = @"   ";
        [self setAttributedText:self.label111 preText:@"日期：" boldText:[busDemandModel.arriveDate stringByAppendingString:[@" 至 " stringByAppendingString:busDemandModel.finishDate]]];
        self.label11.text = @"  ";
        self.label12.text = @"  ";
        [self setAttributedText:self.label21 preText:@"国家：" boldText:busDemandModel.arriveCountry];
        [self setAttributedText:self.label22 preText:@"租用天数：" boldText:busDemandModel.rentDays];
        [self setAttributedText:self.label31 preText:@"城市：" boldText:busDemandModel.arriveCity];
        self.remarkPreLabel.text = @"具体需求";
        self.label41.text = @"";
        [self setAttributedText:self.label32 preText:@"人数：" boldText:busDemandModel.guestNum];
        self.label42.text = @"";
        self.remarkTextView.text = busDemandModel.remark;
    } else if ([_demandModel isKindOfClass:[YTETranslateDemandModel class]]) {
        
        YTETranslateDemandModel *translateDemandModel = (YTETranslateDemandModel *)demandModel;
        self.quoteOrderView.arriveDate = translateDemandModel.arriveDate;

        [self setAttributedText:self.orderNumLabel1 preText:@"订单号：" boldText:translateDemandModel.orderNum];
        self.orderNumLabel.text = @"";
        self.dateLabel.text = @"   ";
        [self setAttributedText:self.label111 preText:@"日期：" boldText:[[translateDemandModel.arriveDate stringByAppendingString:@" 至 "] stringByAppendingString:translateDemandModel.finishDate]];
        self.label12.text = @"   ";
        [self setAttributedText:self.label21 preText:@"翻译类型：" boldText:[NSString stringFromTranslateMerchantType:translateDemandModel.merchantType.integerValue]];
        [self setAttributedText:self.label22 preText:@"翻译领域：" boldText:[NSString stringFromTransArea:[translateDemandModel.transArea integerValue]]];
        [self setAttributedText:self.label31 preText:@"国家：" boldText:translateDemandModel.arriveCountry];
        [self setAttributedText:self.label32 preText:@"翻译语种：" boldText:[NSString stringFromTransLanguage:[translateDemandModel.transLanguage integerValue]]];
        self.label41.text = @"";
        self.label42.text = @"";
        self.remarkPreLabel.text = @"具体需求";
        self.remarkTextView.text = translateDemandModel.remark;
    } else if ([_demandModel isKindOfClass:[YTEGroupDemandModel class]]) {
        YTEGroupDemandModel *groupDemandModel = (YTEGroupDemandModel *)demandModel;
        self.quoteOrderView.arriveDate = groupDemandModel.arriveDate;
        [self setAttributedText:self.orderNumLabel1 preText:@"订单号：" boldText:groupDemandModel.orderNum];
        self.dateLabel.text = @"   ";
        [self setAttributedText:self.label11 preText:@"国家：" boldText:groupDemandModel.arriveCountry];
        [self setAttributedText:self.label12 preText:@"城市：" boldText:groupDemandModel.arriveCity];
        [self setAttributedText:self.label21 preText:@"日期：" boldText:groupDemandModel.finishDate];
        [self setAttributedText:self.label22 preText:@"时间：" boldText:groupDemandModel.arriveTime];
        [self setAttributedText:self.label31 preText:@"人数：" boldText:groupDemandModel.guestNum];
        self.remarkPreLabel.text = @"具体需求";
        self.remarkTextView.text = groupDemandModel.remark;
        self.label32.text = @"";
        self.label41.text = @"";
        self.label42.text = @"";
    } else if ([_demandModel isKindOfClass:[YTEPickupDemandModel class]]) {
        YTEPickupDemandModel *pickupDemandModel = (YTEPickupDemandModel *)demandModel;
        self.quoteOrderView.arriveDate = pickupDemandModel.arriveDate;
        [self setAttributedText:self.orderNumLabel1 preText:@"订单号：" boldText:pickupDemandModel.orderNum];
        [self setAttributedText:self.dateLabel preText:@"日期：" boldText:pickupDemandModel.finishDate];
        [self setAttributedText:self.label11 preText:@"接送类型：" boldText:[NSString stringFromPickupMerchantType:pickupDemandModel.merchantType.integerValue]];
        [self setAttributedText:self.label12 preText:@"接机时间：" boldText:pickupDemandModel.arriveTime];
        [self setAttributedText:self.label21 preText:@"国家：" boldText:pickupDemandModel.arriveCountry];
        [self setAttributedText:self.label22 preText:@"城市：" boldText:pickupDemandModel.arriveCity];
        [self setAttributedText:self.label31 preText:@"航班号：" boldText:pickupDemandModel.flightNum];
        [self setAttributedText:self.label32 preText:@"人数：" boldText:pickupDemandModel.guestNum];
        [self setAttributedText:self.label41 preText:@"接送机场：" boldText:pickupDemandModel.pickAddress];
        [self setAttributedText:self.label42 preText:@"行李数：" boldText:pickupDemandModel.luggageNum];
        self.remarkPreLabel.text = @"送达地址";
        self.remarkTextView.text = pickupDemandModel.remark;
    } else {
        YTEVipDemandModel *vipDemandModel = (YTEVipDemandModel *)demandModel;
        self.quoteOrderView.arriveDate = vipDemandModel.arriveDate;
        [self setAttributedText:self.orderNumLabel1 preText:@"订单号：" boldText:vipDemandModel.orderNum];
        self.dateLabel.text = @" ";
        [self setAttributedText:self.label111 preText:@"日期：" boldText:[[vipDemandModel.arriveDate stringByAppendingString:@" 至 "] stringByAppendingString:vipDemandModel.finishDate]];
        self.label12.text = @" ";
        [self setAttributedText:self.label21 preText:@"国家：" boldText:vipDemandModel.arriveCountry];
        [self setAttributedText:self.label22 preText:@"城市：" boldText:vipDemandModel.arriveCity];
        [self setAttributedText:self.label31 preText:@"人数：" boldText:vipDemandModel.guestNum];
        [self setAttributedText:self.label32 preText:@"行李数：" boldText:vipDemandModel.luggageNum];
        self.remarkPreLabel.text = @"具体需求";
        self.label41.text = @"";
        self.label42.text = @"";
        self.remarkTextView.text = vipDemandModel.remark;
    }
}

#pragma mark - Private

- (void)setAttributedText:(TTTAttributedLabel *)label preText:(NSString *)preText boldText:(NSString *)boldText {
    [label setText:[preText stringByAppendingString:boldText] afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange firstRange = [[mutableAttributedString string] rangeOfString:boldText options:NSCaseInsensitiveSearch];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[YTELabelBoldColor CGColor] range:firstRange];
        return mutableAttributedString;
    }];
}

@end
