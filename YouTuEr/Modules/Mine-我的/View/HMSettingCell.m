//
//  HMSettingCell.m
//  01-网易彩票
//
//  Created by SZSYKT_iOSBasic_2 on 16/2/20.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "HMSettingCell.h"
#import "HMSettingItemArrow.h"
#import "HMSettingItemSwitch.h"
#import "HMSettingItem.h"
#import "HMSettingItemLabel.h"
#import "HMSettingItemMiddleLabel.h"
// 字体
//#define HMFont(s) [UIFont fontWithName:@"MicrosoftYaHei" size:s]
#define HMFont(s) [UIFont systemFontOfSize:s]

// 颜色
#define HMColor(r,g,b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]
#define HMSameColor(color) HMColor(color,color,color)
@interface HMSettingCell()
/**
 *  箭头
 */
@property (nonatomic, strong) UIImageView *arrowView;
/**
 *  开关
 */
@property (nonatomic, strong) UISwitch *stView;
/**
 *  分割线
 */
@property (nonatomic, weak) UIView *lineView;

/**
 *  文本标签
 */
@property (nonatomic, strong) UILabel *labelView;

@end

@implementation HMSettingCell

/**
 *  快速创建cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"setting";
    HMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HMSettingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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

/**
 *  设置cell的基本信息
 */
- (void)setup {
    // 设置文字的字体和颜色
    self.textLabel.font = HMFont(17);
    self.textLabel.textColor = HMSameColor(51);
    
    
    self.detailTextLabel.font = HMFont(13);
    self.detailTextLabel.textColor = HMSameColor(110);
    
    // 设置cell选中状态下显示的控件(不需要设置frame)
    UIView *selectedView = [[UIView alloc] init];
    selectedView.backgroundColor = HMColor(228,221,220);//[UIColor colorWithRed:228 / 255.0 green:221 / 255.0 blue:220 / 255.0 alpha:1.0];
    self.selectedBackgroundView = selectedView;
    
    // 创建分割线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = YTEARGBColor(204, 204, 204);
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
}

/**
 *  设置子控件内容
 */
- (void)setItem:(HMSettingItem *)item {
    _item = item;
    // 设置子控件内容
    [self setupData];
    // 设置cell右边显示的辅助控件
    [self setupRightAccessoryView];
}

/**
 *  设置子控件内容
 */
- (void)setupData {
    self.textLabel.text = _item.title;
//    self.detailTextLabel.text = _item.subTitle;
    if (_item.icon) {
        self.imageView.image = [UIImage imageNamed:_item.icon];
    } else {
        self.imageView.image = nil;
    }
}

/**
 *  设置cell右边显示的辅助控件
 */
- (void)setupRightAccessoryView {
    self.selectionStyle =  ([_item isKindOfClass:[HMSettingItemSwitch class]]) ? UITableViewCellSelectionStyleNone:UITableViewCellSelectionStyleDefault;
    if ([_item isKindOfClass:[HMSettingItemArrow class]]) { // 箭头
        self.accessoryView = self.arrowView;
        self.labelView.text = _item.subTitle;
        [self.contentView addSubview:self.labelView];
    } else if ([_item isKindOfClass:[HMSettingItemSwitch class]]) { // 开关
//        // 根据item从偏好设置中获得开关状态
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        // 设置开关的状态
//        self.stView.on = [defaults boolForKey:_item.title];
        
        HMSettingItemSwitch *stItem = (HMSettingItemSwitch *)_item;
        self.stView.on = stItem.on;
        self.accessoryView = self.stView;
    } else if ([_item isKindOfClass:[HMSettingItemLabel class]]) { // 文本标签
        HMSettingItemLabel *itemLabel = (HMSettingItemLabel *)_item;
        self.labelView.text = itemLabel.text;
        self.accessoryView = self.labelView;
    } else {
        self.accessoryView = nil;
    }
    
    if ([_item isKindOfClass:[HMSettingItemArrow class]]) {
        // 设置cell选中状态下显示的控件(不需要设置frame)
        UIView *selectedView = [[UIView alloc] init];
        selectedView.backgroundColor = HMColor(228,221,220);//[UIColor colorWithRed:228 / 255.0 green:221 / 255.0 blue:220 / 255.0 alpha:1.0];
        self.selectedBackgroundView = selectedView;
    }else {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

/**
 *  设置是否隐藏分割线
 */
- (void)setHideLineView:(BOOL)hideLineView {
    _hideLineView = hideLineView;
    self.lineView.hidden = _hideLineView;
}

/**
 *  布局子控件
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置分割线frame
    CGFloat lineX = self.textLabel.yte_x;
    CGFloat lineH = 0.7;
    CGFloat lineY = CGRectGetHeight(self.frame) - lineH;
    CGFloat lineW = CGRectGetWidth(self.frame) - lineX;
    
    self.lineView.frame = CGRectMake(lineX, lineY, lineW, lineH);
    
    if ([_item isKindOfClass:[HMSettingItemMiddleLabel class]]) {
        self.textLabel.yte_centerX = self.yte_centerX;
    }
}
#pragma mark - 懒加载控件
- (UIImageView *)arrowView {
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
    }
    return _arrowView;
}

- (UISwitch *)stView {
    if (_stView == nil) {
        _stView = [[UISwitch alloc] init];
        // 监听开关值改变
        [_stView addTarget:self action:@selector(stValueChanged) forControlEvents:UIControlEventValueChanged];
    }
    return _stView;
}

- (UILabel *)labelView {
    if (_labelView == nil) {
        _labelView = [[UILabel alloc] initWithFrame:CGRectMake(YTEScreenBoundsWidth - 190, 0, 160, self.yte_height)];
        _labelView.textAlignment = NSTextAlignmentRight;
        _labelView.font = HMFont(14);
        _labelView.textColor = [_item.subTitle hasPrefix:@"未"] ? YTEDominantColor : HMSameColor(139);
    }
    return _labelView;
}


/**
 *  监听开关值改变
 */
- (void)stValueChanged {
    // 开关状态保存到 偏好设置
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setBool:self.stView.on forKey:self.item.title];
    
    HMSettingItemSwitch *stItem = (HMSettingItemSwitch *)_item;
    stItem.on = self.stView.on;
}
@end



