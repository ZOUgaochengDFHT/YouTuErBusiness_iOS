//
//  YTEOngoingCell.m
//  YouTuEr
//
//  Created by 苏一 on 2017/6/19.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEOngoingCell.h"
#import "YTEGuideBidModel.h"
#import "YTEPickupBidModel.h"
#import "YTETranslateBidModel.h"
#import "YTEBusBidModel.h"
#import "YTEVipBidModel.h"
#import "YTEGroupBidModel.h"
#import "NSString+YTEType.h"
#import <YYWebImage/YYWebImage.h>

@interface YTEOngoingCell()

@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomCenterLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomRightLabel;
@property (weak, nonatomic) IBOutlet UIView *backgrounView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation YTEOngoingCell

#pragma mark - Initializer
/**
 *  快速创建cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"ongoingCell";
    YTEOngoingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"YTEOngoingCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
    
}

#pragma mark - View Cycle

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.bottomLeftLabel.text) {
        self.yte_height = self.backgrounView.yte_bottom + 5;
    }else {
        self.yte_height = self.backgrounView.yte_bottom - 10;
    }
}

#pragma mark - Getter & Setter

- (void)setModel:(NSObject *)model {
    _model = model;
    self.timeLabel.text = self.dataLabel.text = self.typeLabel.text = self.bottomLeftLabel.text = self.bottomCenterLabel.text = self.bottomRightLabel.text = @"";
    if ([model isKindOfClass:[YTEBusBidModel class]]) {
        YTEBusBidModel *busBidModel = (YTEBusBidModel *)model;
        [self.orderNumberLabel setText:busBidModel.orderNum];
        [self.nameLabel setText:busBidModel.nickName];
        [self.paymentStatusLabel setText:[NSString stringFromOrderParStatus:[busBidModel.parStatus integerValue]]];
        [self.costLabel setText:[@"¥ " stringByAppendingString:busBidModel.bidFee]];
        [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:busBidModel.photo] placeholder:SR_IMGName(@"bg_login")];
    } else if ([model isKindOfClass:[YTEGuideBidModel class]]) {
        YTEGuideBidModel *guideBidModel = (YTEGuideBidModel *)model;
        [self.orderNumberLabel setText:guideBidModel.orderNum];
        [self.nameLabel setText:guideBidModel.nickName];
        [self.paymentStatusLabel setText:[NSString stringFromOrderParStatus:[guideBidModel.parStatus integerValue]]];
        [self.costLabel setText:[@"¥ " stringByAppendingString:guideBidModel.bidFee]];
        [self.typeLabel setText:[NSString stringFromGuideMerchantType:[guideBidModel.merchantType integerValue]]];
        [self.bottomLeftLabel setText:[NSString stringWithFormat:@"游客：%@人",guideBidModel.guestNum]];
        [self.bottomCenterLabel setText:[NSString stringWithFormat:@"行李：%@件",guideBidModel.luggageNum]];
        [self.bottomRightLabel setText:[NSString stringWithFormat:@"交通工具：%@",
                                        [NSString stringFromTransportType:[guideBidModel.transportType integerValue]]]];
        [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:guideBidModel.photo] placeholder:SR_IMGName(@"bg_login")];
    } else if ([model isKindOfClass:[YTETranslateBidModel class]]) {
        YTETranslateBidModel *translateBidModel = (YTETranslateBidModel *)model;
        [self.orderNumberLabel setText:translateBidModel.orderNum];
        [self.timeLabel setText:translateBidModel.createTime];
        [self.nameLabel setText:translateBidModel.nickName];
        [self.paymentStatusLabel setText:[NSString stringFromOrderParStatus:[translateBidModel.parStatus integerValue]]];
        [self.costLabel setText:[@"¥ " stringByAppendingString:translateBidModel.bidFee]];
        [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:translateBidModel.photo] placeholder:SR_IMGName(@"bg_login")];
    } else if ([model isKindOfClass:[YTEGroupBidModel class]]) {
        YTEGroupBidModel *groupBidModel = (YTEGroupBidModel *)model;
        [self.orderNumberLabel setText:groupBidModel.orderNum];
        [self.timeLabel setText:groupBidModel.createTime];
        [self.nameLabel setText:groupBidModel.nickName];
        [self.paymentStatusLabel setText:[NSString stringFromOrderParStatus:[groupBidModel.parStatus integerValue]]];
        [self.costLabel setText:[@"¥ " stringByAppendingString:groupBidModel.bidFee]];
        [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:groupBidModel.photo] placeholder:SR_IMGName(@"bg_login")];
    } else if ([model isKindOfClass:[YTEPickupBidModel class]]) {
        YTEPickupBidModel *pickupBidModel = (YTEPickupBidModel *)model;
        [self.orderNumberLabel setText:pickupBidModel.orderNum];
        [self.timeLabel setText:pickupBidModel.createTime];
        [self.nameLabel setText:pickupBidModel.nickName];
        [self.paymentStatusLabel setText:[NSString stringFromOrderParStatus:[pickupBidModel.parStatus integerValue]]];
        [self.costLabel setText:[@"¥ " stringByAppendingString:pickupBidModel.bidFee]];
        [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:pickupBidModel.photo] placeholder:SR_IMGName(@"bg_login")];
    } else if ([model isKindOfClass:[YTEVipBidModel class]]) {
        YTEVipBidModel *vipBidModel = (YTEVipBidModel *)model;
        [self.orderNumberLabel setText:vipBidModel.orderNum];
        [self.timeLabel setText:vipBidModel.createTime];
        [self.nameLabel setText:vipBidModel.nickName];
        [self.paymentStatusLabel setText:[NSString stringFromOrderParStatus:[vipBidModel.parStatus integerValue]]];
        [self.costLabel setText:[@"¥ " stringByAppendingString:vipBidModel.bidFee]];
        [self.iconImageView yy_setImageWithURL:[NSURL URLWithString:vipBidModel.photo] placeholder:SR_IMGName(@"bg_login")];
    }
}

@end
