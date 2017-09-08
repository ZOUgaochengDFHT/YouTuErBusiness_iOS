//
//  YTEOrderDetailView.m
//  YouTuEr
//
//  Created by 苏一 on 2017/5/26.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEOrderDetailView.h"

#import "NSString+YTEType.h"
#import "YTEGuideBidModel.h"
#import "YTEPickupBidModel.h"
#import "YTETranslateBidModel.h"
#import "YTEBusBidModel.h"
#import "YTEVipBidModel.h"
#import "YTEGroupBidModel.h"

#import "YTEGuideDemandModel.h"
#import "YTEPickupDemandModel.h"
#import "YTETranslateDemandModel.h"
#import "YTEBusDemandModel.h"
#import "YTEGroupDemandModel.h"
#import "YTEVipDemandModel.h"

@interface YTEOrderDetailView ()
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  信息展示view
 */
@property (weak, nonatomic) IBOutlet UIView *messageView;
/**
 *  订单号
 */
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
/**
 *  订单日期
 */
@property (weak, nonatomic) IBOutlet UILabel *label00;
@property (weak, nonatomic) IBOutlet UILabel *orderDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *label11;
@property (weak, nonatomic) IBOutlet UILabel *label12;
@property (weak, nonatomic) IBOutlet UILabel *label21;
@property (weak, nonatomic) IBOutlet UILabel *label22;
@property (weak, nonatomic) IBOutlet UILabel *label31;
@property (weak, nonatomic) IBOutlet UILabel *label32;
@property (weak, nonatomic) IBOutlet UILabel *label41;
@property (weak, nonatomic) IBOutlet UILabel *label42;
@property (weak, nonatomic) IBOutlet UILabel *label51;
@property (weak, nonatomic) IBOutlet UILabel *label52;
@property (weak, nonatomic) IBOutlet UILabel *label61;
@property (weak, nonatomic) IBOutlet UILabel *label62;

/**
 *  详细行程
 */
@property (weak, nonatomic) IBOutlet UIScrollView *descriptionScrollView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
/**
 *  回调block
 */
@property(nonatomic,copy) void(^detailtViewCallBack)(YTEOrderDetailView*,BOOL);
/**
 *  设置文本信息字典
 */
@property (strong, nonatomic) UIView *coverView;
@property (strong, nonatomic) YTEOrderDetailView *detailView;

@property (strong, nonatomic) NSObject *model;
@property (assign, nonatomic) YTEOrderStatus orderStatus;


@end

@implementation YTEOrderDetailView

#pragma mark - View Cycle

- (void)awakeFromNib{
    //裁剪圆角
    self.layer.cornerRadius = YTEAlertViewCornerRadius;
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.descriptionLabel.preferredMaxLayoutWidth = self.yte_width * 0.90;
}

#pragma mark - Initializer
/**
 *  信息提示框
 *
 *  @param model            信息提示框显示信息的模型
 *
 */
+ (void)detailtView:(NSObject *)model orderStatus:(YTEOrderStatus)orderStatus {
   
    YTEOrderDetailView *messageAlertView = [[NSBundle mainBundle] loadNibNamed:@"YTEOrderDetailView" owner:nil options:nil].lastObject;
    //设置属性
    messageAlertView.model = model;
    messageAlertView.yte_width = YTEScreenBoundsWidth * 0.9;
    messageAlertView.yte_height = YTEScreenBoundsHeight * 0.7;
    messageAlertView.orderStatus = orderStatus;
    //返回实例
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:messageAlertView.coverView];
    messageAlertView.detailView = messageAlertView;
    [window addSubview:messageAlertView];
}

#pragma mark - Private

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    //设置frame
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - self.bounds.size.width) * 0.5;
    CGFloat y = ([UIScreen mainScreen].bounds.size.height - self.bounds.size.height) * 0.5;
    self.frame = CGRectMake(x, y, self.bounds.size.width, self.bounds.size.height);
    
    [self alertViewDidAppear];
}


- (void)alertViewDidAppear{
    //    self.transform = CGAffineTransformMakeTranslation(-self.frame.origin.x, -self.frame.origin.y);
    self.transform = CGAffineTransformMakeScale(0.0, 0.0);
    [UIView animateWithDuration:YTEAnimationDefaultTime animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}


#pragma mark - Actions

- (IBAction)cancel {
    [self coverViewTap];
}

- (void)coverViewTap {
    [UIView animateWithDuration:YTEAnimationDefaultTime animations:^{
        self.detailView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
        [self.detailView removeFromSuperview];
    }];
}

#pragma mark - Setter & Getter

- (void)setOrderStatus:(YTEOrderStatus)orderStatus {
    _orderStatus = orderStatus;
    
}

- (UIView *)coverView{
    if (_coverView == nil) {
        _coverView = [[UIView alloc] init];
        _coverView.frame = [UIScreen mainScreen].bounds;
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewTap)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}

- (void)setModel:(NSObject *)model {
    _model = model;
    if ([model isKindOfClass:[YTEGuideBidModel class]]) {
        YTEGuideBidModel *guideBidModel = (YTEGuideBidModel *)model;
        self.titleLabel.text = @"导游订单";
        self.orderNumLabel.text = guideBidModel.orderNum;
        self.label00.text = @"订单日期：";
        self.orderDateLabel.text = [[guideBidModel.arriveDate stringByAppendingString:@" 至 "] stringByAppendingString:guideBidModel.finishDate];
        self.label11.text = @"导游类型：";
        self.label12.text = [NSString stringFromGuideMerchantType:guideBidModel.merchantType.integerValue];
        self.label21.text = @"国家：";
        self.label22.text = guideBidModel.arriveCountry;
        self.label31.text = @"城市：";
        self.label32.text = guideBidModel.arriveCity;
        self.label41.text = @"人数：";
        self.label42.text = guideBidModel.guestNum;
        self.label51.text = @"行李数：";
        self.label52.text = guideBidModel.luggageNum;
        self.label61.text = @"交通工具：";
        self.label62.text = [NSString stringFromTransportType:[guideBidModel.transportType integerValue]];
        self.descriptionLabel.text = guideBidModel.remark;
    } else if ([model isKindOfClass:[YTEPickupBidModel class]]) {
        YTEPickupBidModel *pickupBidModel = (YTEPickupBidModel *)model;
        self.titleLabel.text = @"接送订单";
        self.orderNumLabel.text = pickupBidModel.orderNum;
        self.label00.text = @"接送时间：";
        self.orderDateLabel.text = [[pickupBidModel.finishDate stringByAppendingString:@" "] stringByAppendingString:pickupBidModel.arriveTime];
        self.label11.text = @"接送类型：";
        self.label12.text = [NSString stringFromPickupMerchantType:pickupBidModel.merchantType.integerValue];
        self.label21.text = @"国家城市：";
        self.label22.text = [pickupBidModel.arriveCountry stringByAppendingString:pickupBidModel.arriveCity];
        self.label31.text = @"接送机场：";
        self.label32.text = pickupBidModel.pickAddress;
        self.label41.text = @"接送地址：";
        self.label42.text = pickupBidModel.toAddress;
        self.label51.text = @"人数：";
        self.label52.text = pickupBidModel.guestNum;
        self.label61.text = @"航班号：";
        self.label62.text = pickupBidModel.flightNum;
        self.descriptionLabel.text = pickupBidModel.remark;
    } else if ([model isKindOfClass:[YTETranslateBidModel class]]) {
        YTETranslateBidModel *translateBidModel = (YTETranslateBidModel *)model;
        self.titleLabel.text = @"翻译订单";
        self.orderNumLabel.text = translateBidModel.orderNum;
        self.label00.text = @"翻译日期：";
        self.orderDateLabel.text = [[translateBidModel.arriveDate stringByAppendingString:@" 至 "] stringByAppendingString:translateBidModel.finishDate];
        self.label11.text = @"翻译语种：";
        self.label12.text = [NSString stringFromTransLanguage:translateBidModel.transLanguage.integerValue];
        self.label21.text = @"翻译类型：";
        self.label22.text = [NSString stringFromTranslateMerchantType:translateBidModel.merchantType.integerValue];
        self.label31.text = @"翻译领域：";
        self.label32.text = [NSString stringFromTransArea:translateBidModel.transArea.integerValue];
        self.label41.text = @"国家：";
        self.label42.text = translateBidModel.arriveCountry;
        self.label51.text = @"";
        self.label52.text = @"";
        self.label61.text = @"";
        self.label62.text = @"";
        self.descriptionLabel.text = translateBidModel.remark;
    } else if ([model isKindOfClass:[YTEBusBidModel class]]) {
        YTEBusBidModel *busBidModel = (YTEBusBidModel *)model;
        self.titleLabel.text = @"大巴订单";
        self.orderNumLabel.text = busBidModel.orderNum;
        self.label00.text = @"租用日期：";
        self.orderDateLabel.text = busBidModel.arriveDate;
        self.label11.text = @"租用天数：";
        self.label12.text = busBidModel.rentDays;
        self.label21.text = @"国家：";
        self.label22.text = busBidModel.arriveCountry;
        self.label31.text = @"城市：";
        self.label32.text = busBidModel.arriveCity;
        self.label41.text = @"人数：";
        self.label42.text = busBidModel.guestNum;
        self.label51.text = @"";
        self.label52.text = @"";
        self.label61.text = @"";
        self.label62.text = @"";
        self.descriptionLabel.text = busBidModel.remark;
    } else if ([model isKindOfClass:[YTEVipBidModel class]]) {
        YTEVipBidModel *vipBidModel = (YTEVipBidModel *)model;
        self.titleLabel.text = @"私人订制订单";
        self.orderNumLabel.text = vipBidModel.orderNum;
        self.label00.text = @"订单日期：";
        self.orderDateLabel.text = [[vipBidModel.arriveDate stringByAppendingString:@" 至 "] stringByAppendingString:vipBidModel.finishDate];
        self.label11.text = @"国家：";
        self.label12.text = vipBidModel.arriveCountry;
        self.label21.text = @"城市：";
        self.label22.text = vipBidModel.arriveCity;
        self.label31.text = @"人数：";
        self.label32.text = vipBidModel.guestNum;
        self.label41.text = @"行李数：";
        self.label42.text = vipBidModel.luggageNum;
        self.label51.text = @"";
        self.label52.text = @"";
        self.label61.text = @"";
        self.label62.text = @"";
        self.descriptionLabel.text = vipBidModel.remark;
    } else if ([model isKindOfClass:[YTEGroupBidModel class]]) {
        YTEGroupBidModel *groupBidModel = (YTEGroupBidModel *)model;
        self.titleLabel.text = @"团餐订单";
        self.orderNumLabel.text = groupBidModel.orderNum;
        self.label00.text = @"日期：";
        self.orderDateLabel.text = groupBidModel.finishDate;
        self.label11.text = @"国家：";
        self.label12.text = groupBidModel.arriveCountry;
        self.label21.text = @"城市：";
        self.label22.text = groupBidModel.arriveCity;
        self.label31.text = @"人数：";
        self.label32.text = groupBidModel.guestNum;
        self.label41.text = @"时间：";
        self.label42.text = groupBidModel.arriveTime;
        self.label51.text = @"";
        self.label52.text = @"";
        self.label61.text = @"";
        self.label62.text = @"";
        self.descriptionLabel.text = groupBidModel.remark;
    }
    
    if ([model isKindOfClass:[YTEGuideDemandModel class]]) {
        YTEGuideDemandModel *guideDemandModel = (YTEGuideDemandModel *)model;
        self.titleLabel.text = @"导游订单";
        self.orderNumLabel.text = guideDemandModel.orderNum;
        self.label00.text = @"订单日期：";
        self.orderDateLabel.text = [[guideDemandModel.arriveDate stringByAppendingString:@" 至 "] stringByAppendingString:guideDemandModel.finishDate];
        self.label11.text = @"导游类型：";
        self.label12.text = [NSString stringFromGuideMerchantType:guideDemandModel.merchantType.integerValue];
        self.label21.text = @"国家：";
        self.label22.text = guideDemandModel.arriveCountry;
        self.label31.text = @"城市：";
        self.label32.text = guideDemandModel.arriveCity;
        self.label41.text = @"人数：";
        self.label42.text = guideDemandModel.guestNum;
        self.label51.text = @"行李数：";
        self.label52.text = guideDemandModel.luggageNum;
        self.label61.text = @"交通工具：";
        self.label62.text = [NSString stringFromTransportType:[guideDemandModel.transportType integerValue]];
        self.descriptionLabel.text = guideDemandModel.remark;
    } else if ([model isKindOfClass:[YTEBusDemandModel class]]) {
        YTEBusDemandModel *busDemandModel = (YTEBusDemandModel *)model;
        self.titleLabel.text = @"大巴订单";
        self.orderNumLabel.text = busDemandModel.orderNum;
        self.label00.text = @"租用日期：";
        self.orderDateLabel.text = busDemandModel.arriveDate;
        self.label11.text = @"租用天数：";
        self.label12.text = busDemandModel.rentDays;
        self.label21.text = @"国家：";
        self.label22.text = busDemandModel.arriveCountry;
        self.label31.text = @"城市：";
        self.label32.text = busDemandModel.arriveCity;
        self.label41.text = @"人数：";
        self.label42.text = busDemandModel.guestNum;
        self.label51.text = @"";
        self.label52.text = @"";
        self.label61.text = @"";
        self.label62.text = @"";
        self.descriptionLabel.text = busDemandModel.remark;
    } else if ([model isKindOfClass:[YTEGroupDemandModel class]]) {
        YTEGroupDemandModel *groupDemandModel = (YTEGroupDemandModel *)model;
        self.titleLabel.text = @"团餐订单";
        self.orderNumLabel.text = groupDemandModel.orderNum;
        self.label00.text = @"日期：";
        self.orderDateLabel.text = groupDemandModel.finishDate;
        self.label11.text = @"国家：";
        self.label12.text = groupDemandModel.arriveCountry;
        self.label21.text = @"城市：";
        self.label22.text = groupDemandModel.arriveCity;
        self.label31.text = @"人数：";
        self.label32.text = groupDemandModel.guestNum;
        self.label41.text = @"时间：";
        self.label42.text = groupDemandModel.arriveTime;
        self.label51.text = @"";
        self.label52.text = @"";
        self.label61.text = @"";
        self.label62.text = @"";
        self.descriptionLabel.text = groupDemandModel.remark;
    } else if ([model isKindOfClass:[YTEVipDemandModel class]]) {
        YTEVipDemandModel *vipDemandModel = (YTEVipDemandModel *)model;
        self.titleLabel.text = @"私人订制订单";
        self.orderNumLabel.text = vipDemandModel.orderNum;
        self.label00.text = @"订单日期：";
        self.orderDateLabel.text = [[vipDemandModel.arriveDate stringByAppendingString:@" 至 "] stringByAppendingString:vipDemandModel.finishDate];
        self.label11.text = @"国家：";
        self.label12.text = vipDemandModel.arriveCountry;
        self.label21.text = @"城市：";
        self.label22.text = vipDemandModel.arriveCity;
        self.label31.text = @"人数：";
        self.label32.text = vipDemandModel.guestNum;
        self.label41.text = @"行李数：";
        self.label42.text = vipDemandModel.luggageNum;
        self.label51.text = @"";
        self.label52.text = @"";
        self.label61.text = @"";
        self.label62.text = @"";
        self.descriptionLabel.text = vipDemandModel.remark;
    } else if ([model isKindOfClass:[YTETranslateDemandModel class]]) {
        YTETranslateDemandModel *translateDemandModel = (YTETranslateDemandModel *)model;
        self.titleLabel.text = @"翻译订单";
        self.orderNumLabel.text = translateDemandModel.orderNum;
        self.label00.text = @"翻译日期：";
        self.orderDateLabel.text = [[translateDemandModel.arriveDate stringByAppendingString:@" 至 "] stringByAppendingString:translateDemandModel.finishDate];
        self.label11.text = @"翻译语种：";
        self.label12.text = [NSString stringFromTransLanguage:translateDemandModel.transLanguage.integerValue];
        self.label21.text = @"翻译类型：";
        self.label22.text = [NSString stringFromTranslateMerchantType:translateDemandModel.merchantType.integerValue];
        self.label31.text = @"翻译领域：";
        self.label32.text = [NSString stringFromTransArea:translateDemandModel.transArea.integerValue];
        self.label41.text = @"国家：";
        self.label42.text = translateDemandModel.arriveCountry;
        self.label51.text = @"";
        self.label52.text = @"";
        self.label61.text = @"";
        self.label62.text = @"";
        self.descriptionLabel.text = translateDemandModel.remark;
    } else if ([model isKindOfClass:[YTEPickupDemandModel class]]) {
        YTEPickupDemandModel *pickupDemandModel = (YTEPickupDemandModel *)model;
        self.titleLabel.text = @"接送订单";
        self.orderNumLabel.text = pickupDemandModel.orderNum;
        self.label00.text = @"接送时间：";
        self.orderDateLabel.text = [[pickupDemandModel.finishDate stringByAppendingString:@" "] stringByAppendingString:pickupDemandModel.arriveTime];
        self.label11.text = @"接送类型：";
        self.label12.text = [NSString stringFromPickupMerchantType:pickupDemandModel.merchantType.integerValue];
        self.label21.text = @"国家城市：";
        self.label22.text = [pickupDemandModel.arriveCountry stringByAppendingString:pickupDemandModel.arriveCity];
        self.label31.text = @"接送机场：";
        self.label32.text = pickupDemandModel.pickAddress;
        self.label41.text = @"接送地址：";
        self.label42.text = pickupDemandModel.toAddress;
        self.label51.text = @"人数：";
        self.label52.text = pickupDemandModel.guestNum;
        self.label61.text = @"航班号：";
        self.label62.text = pickupDemandModel.flightNum;
        self.descriptionLabel.text = pickupDemandModel.remark;
    }
}


@end
