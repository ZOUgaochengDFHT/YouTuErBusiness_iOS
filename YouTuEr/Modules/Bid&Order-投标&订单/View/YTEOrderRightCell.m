//
//  YTEOrderRightCell.m
//  YouTuEr
//
//  Created by 苏一 on 2017/5/11.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEOrderRightCell.h"
#import "UIView+AutoLayout.h"
#import "YTEGuideBidModel.h"
#import "YTEPickupBidModel.h"
#import "YTETranslateBidModel.h"
#import "YTEBusBidModel.h"
#import "YTEVipBidModel.h"
#import "YTEGroupBidModel.h"
#import "NSString+YTEType.h"
#import <MMPopupView/MMAlertView.h>



#define RightCellVerticalPad 7
#define RightCellFontSize 13

@interface YTEOrderRightCell()

@property (nonatomic, copy) NSString *Id;

@property (weak, nonatomic) IBOutlet TTTAttributedLabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *orderNumberLabel1;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *dataLabel;

@property (weak, nonatomic) IBOutlet TTTAttributedLabel *label111;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *label11;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *label12;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *label21;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *label22;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *label31;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *label32;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *label41;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *label42;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *bidCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *quotedPriceButton;

@property (strong, nonatomic) MMAlertView *alertView;
@property (nonatomic, strong) UIView *detailView;
@property (weak, nonatomic) IBOutlet UIButton *modifyPriceButtom;
@property (weak, nonatomic) IBOutlet UIButton *minePriceButtpn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBidButton;

@end

@implementation YTEOrderRightCell

#pragma mark - View Cycle

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Initializer

/**
 *  快速创建cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"rightCell";
    YTEOrderRightCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YTEOrderRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    return self;
}



- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = YTEGlobalBGColor;
}


#pragma mark - Action

- (IBAction)modifyQuotePrice:(id)sender {
    if (self.modifyQuotedPriceHandle) {
        self.modifyQuotedPriceHandle(self.Id);
    }

    
}

- (IBAction)cancelBid:(id)sender {
    [self.alertView show];
}


- (void)setAttributedText:(TTTAttributedLabel *)label preText:(NSString *)preText boldText:(NSString *)boldText {
    [label setText:[preText stringByAppendingString:boldText] afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange firstRange = [[mutableAttributedString string] rangeOfString:boldText options:NSCaseInsensitiveSearch];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[YTELabelBoldColor CGColor] range:firstRange];
        return mutableAttributedString;
    }];
}

#pragma mark - Getter & Setter

- (void)setOrderStatus:(YTEOrderStatus)orderStatus {
    _orderStatus = orderStatus;
    if (orderStatus == YTEOrderStatusHistory) self.quotedPriceButton.hidden = self.modifyPriceButtom.hidden = self.minePriceButtpn.hidden = self.cancelBidButton.hidden = YES;
}

- (void)setModel:(NSObject *)model {
    _model = model;
    if ([model isKindOfClass:[YTEGuideBidModel class]]) {
        YTEGuideBidModel *guideBidModel = (YTEGuideBidModel *)model;
        self.orderNumberLabel1.text = [@"订单号：" stringByAppendingString:guideBidModel.orderNum];
        self.orderNumberLabel.text = @"";
        self.dataLabel.text = @" ";
        [self setAttributedText:self.label111 preText:@"日期：" boldText:[[guideBidModel.arriveDate stringByAppendingString:@" 至 "] stringByAppendingString:guideBidModel.finishDate]];
        self.label11.text = @" ";
        self.label12.text = @" ";
        [self setAttributedText:self.label21 preText:@"导游类型：" boldText:[NSString stringFromGuideMerchantType:guideBidModel.merchantType.integerValue]];
        [self setAttributedText:self.label22 preText:@"人数：" boldText:guideBidModel.guestNum];
        [self setAttributedText:self.label31 preText:@"城市：" boldText:guideBidModel.arriveCity];
        [self setAttributedText:self.label32 preText:@"交通工具：" boldText:[NSString stringFromTransportType:[guideBidModel.transportType integerValue]]];
        self.orderLabel.text = @"详细行程";
        self.textView.text = guideBidModel.remark;
        [self.quotedPriceButton setTitle:[@"¥" stringByAppendingString:guideBidModel.bidFee] forState:UIControlStateNormal];
        self.Id = guideBidModel.Id;
    } else if ([model isKindOfClass:[YTEPickupBidModel class]]) {
        YTEPickupBidModel *pickupBidModel = (YTEPickupBidModel *)model;
        self.orderNumberLabel1.text = [@"订单号：" stringByAppendingString:pickupBidModel.orderNum];
        self.dataLabel.text = @" ";
        [self setAttributedText:self.label11 preText:@"接送类型：" boldText:[NSString stringFromPickupMerchantType:pickupBidModel.merchantType.integerValue]];
        [self setAttributedText:self.label12 preText:@"人数：" boldText:pickupBidModel.guestNum];
        [self setAttributedText:self.label21 preText:@"航班号：" boldText:pickupBidModel.flightNum];
        [self setAttributedText:self.label22 preText:@"行李数：" boldText:pickupBidModel.luggageNum];
        [self setAttributedText:self.label31 preText:@"送达城市：" boldText:pickupBidModel.arriveCity];
        [self setAttributedText:self.label32 preText:@"日期：" boldText:pickupBidModel.arriveDate];
        self.label41.text = self.label42.text = @"";
        self.orderLabel.text = @"送达地址";
        self.textView.text = pickupBidModel.remark;
        [self.quotedPriceButton setTitle:[@"¥" stringByAppendingString:pickupBidModel.bidFee] forState:UIControlStateNormal];
        self.Id = pickupBidModel.Id;
    } else if ([model isKindOfClass:[YTETranslateBidModel class]]) {
        YTETranslateBidModel *translateBidModel = (YTETranslateBidModel *)model;
        self.orderNumberLabel1.text = [@"订单号：" stringByAppendingString:translateBidModel.orderNum];
        self.orderNumberLabel.text = @"";
        self.dataLabel.text = @"   ";
        [self setAttributedText:self.label111 preText:@"日期：" boldText:[[translateBidModel.arriveDate stringByAppendingString:@" 至 "] stringByAppendingString:translateBidModel.finishDate]];
        self.label12.text = @"   ";
        [self setAttributedText:self.label21 preText:@"国家：" boldText:translateBidModel.arriveCountry];
        [self setAttributedText:self.label22 preText:@"翻译领域：" boldText:[NSString stringFromTransArea:[translateBidModel.transArea integerValue]]];
        [self setAttributedText:self.label31 preText:@"翻译分类：" boldText:[NSString stringFromTranslateMerchantType:translateBidModel.merchantType.integerValue]];
        [self setAttributedText:self.label32 preText:@"翻译语种：" boldText:[NSString stringFromTransLanguage:[translateBidModel.transLanguage integerValue]]];
        self.orderLabel.text = @"具体需求";
        self.textView.text = translateBidModel.remark;
        [self.quotedPriceButton setTitle:[@"¥" stringByAppendingString:translateBidModel.bidFee] forState:UIControlStateNormal];
        self.Id = translateBidModel.Id;
    } else if ([model isKindOfClass:[YTEBusBidModel class]]) {
        YTEBusBidModel *busBidModel = (YTEBusBidModel *)model;
        self.orderNumberLabel1.text = [@"订单号：" stringByAppendingString:busBidModel.orderNum];
        self.orderNumberLabel.text = @"";
        self.dataLabel.text = @"   ";
        [self setAttributedText:self.label111 preText:@"日期：" boldText:[busBidModel.arriveDate stringByAppendingString:[@" 至 " stringByAppendingString:busBidModel.finishDate]]];
        self.label11.text = @"  ";
        self.label12.text = @"  ";
        [self setAttributedText:self.label21 preText:@"国家：" boldText:busBidModel.arriveCountry];
        [self setAttributedText:self.label22 preText:@"租用天数：" boldText:busBidModel.rentDays];
        [self setAttributedText:self.label31 preText:@"城市：" boldText:busBidModel.arriveCity];
        self.orderLabel.text = @"具体需求";
        [self setAttributedText:self.label32 preText:@"人数：" boldText:busBidModel.guestNum];
        self.textView.text = busBidModel.remark;
        [self.quotedPriceButton setTitle:[@"¥" stringByAppendingString:busBidModel.bidFee] forState:UIControlStateNormal];
        self.Id = busBidModel.Id;
    } else if ([model isKindOfClass:[YTEVipBidModel class]]) {
        YTEVipBidModel *vipBidModel = (YTEVipBidModel *)model;
        self.orderNumberLabel1.text = [@"订单号：" stringByAppendingString:vipBidModel.orderNum];
        self.dataLabel.text = @" ";
        [self setAttributedText:self.label111 preText:@"日期：" boldText:[[vipBidModel.arriveDate stringByAppendingString:@" 至 "] stringByAppendingString:vipBidModel.finishDate]];
        self.label12.text = @" ";
        [self setAttributedText:self.label21 preText:@"国家：" boldText:vipBidModel.arriveCountry];
        [self setAttributedText:self.label22 preText:@"城市：" boldText:vipBidModel.arriveCity];
        [self setAttributedText:self.label31 preText:@"人数：" boldText:vipBidModel.guestNum];
        [self setAttributedText:self.label32 preText:@"行李数：" boldText:vipBidModel.luggageNum];
        self.orderLabel.text = @"具体需求";
        self.textView.text = vipBidModel.remark;
        [self.quotedPriceButton setTitle:[@"¥" stringByAppendingString:vipBidModel.bidFee] forState:UIControlStateNormal];
        self.Id = vipBidModel.Id;
    } else {
        YTEGroupBidModel *groupBidModel = (YTEGroupBidModel *)model;
        self.orderNumberLabel1.text = [@"订单号：" stringByAppendingString:groupBidModel.orderNum];
        self.dataLabel.text = @"  ";
        [self setAttributedText:self.label11 preText:@"国家：" boldText:groupBidModel.arriveCountry];
        [self setAttributedText:self.label12 preText:@"城市：" boldText:groupBidModel.arriveCity];
        [self setAttributedText:self.label21 preText:@"日期：" boldText:groupBidModel.finishDate];
        [self setAttributedText:self.label22 preText:@"时间：" boldText:groupBidModel.arriveTime];
        [self setAttributedText:self.label31 preText:@"人数：" boldText:groupBidModel.guestNum];
        self.orderLabel.text = @"具体需求";
        self.textView.text = groupBidModel.remark;
        self.label32.text = @"";
        [self.quotedPriceButton setTitle:[@"¥" stringByAppendingString:groupBidModel.bidFee] forState:UIControlStateNormal];
        self.Id = groupBidModel.Id;
    }
    self.label41.text = self.label42.text = @"";
}

- (MMAlertView *)alertView {
    if (!_alertView) {
        MMAlertViewConfig *config = [MMAlertViewConfig globalConfig];
        [config setButtonFontSize:15];
        [config setItemNormalColor:YTELabelBoldColor];
        [config setWidth:242];
        [config setItemHighlightColor:YTEDominantColor];
        [config setDetailColor:YTELabelBoldColor];
        [config setTitleFontSize:0];
        [config setDetailFontSize:15];
        [config setButtonHeight:51.5];
        [config setSplitColor:YTEARGBColor(211, 211, 211)];
        [config setItemPressedColor:YTEARGBColor(248, 248, 248)];
        [config setInnerMargin:30];
        
        @weakify(self);
        MMPopupItemHandler block = ^(NSInteger index) {
            @strongify(self);
            if (index == 0 && self.cancelBidHandle) self.cancelBidHandle(self.Id);
        };
        
        NSArray *items = @[MMItemMake(@"是", MMItemTypeNormal, block),
                           MMItemMake(@"否", MMItemTypeHighlight, block)];
        _alertView = [[MMAlertView alloc]initWithTitle:@" " detail:@"取消投标？" items:items];
        [_alertView.attachedView setMm_dimBackgroundBlurEnabled:NO];
        [_alertView.attachedView setMm_dimBackgroundBlurEffectStyle:UIBlurEffectStyleLight];
    }
    return _alertView;
}

@end
