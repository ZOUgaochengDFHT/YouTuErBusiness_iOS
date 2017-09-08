//
//  YTEMineTableHeaderView.m
//  YouTuEr
//
//  Created by 苏一 on 2017/3/30.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEMineTableHeaderView.h"
#import "YTEAccountModel.h"
#import <YYWebImage/YYWebImage.h>

#define HeadIconTopPad (0.1707 * YTEScreenBoundsWidth)
#define HeadIconWidth (0.2307 * YTEScreenBoundsWidth)
#define HeadIconHeight HeadIconWidth

@interface YTEMineTableHeaderView()

@property (nonatomic, strong)UIImageView *headCircleView;
@property (nonatomic, strong)UIImageView *headIconView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *countryLabel;
@property (nonatomic, strong)UILabel *cityLabel;
@end

@implementation YTEMineTableHeaderView

+ (instancetype)headerView {
    
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, HederViewWidth, HederViewHeight);
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    _headBGImage = [[UIImageView alloc] initWithImage:SR_IMGName(@"mine_head_bg")];
    _headBGImage.frame = self.frame;
    [self addSubview:self.headBGImage];
    
    _headCircleView = [[UIImageView alloc] initWithImage:SR_IMGName(@"mine_head_circle")];
    [self addSubview:self.headCircleView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, YTEScreenBoundsWidth, 14)];
    _nameLabel.font = [UIFont boldSystemFontOfSize:14];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = YTEARGBColor(255, 255, 255);
    [self addSubview:self.nameLabel];
    
    _countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, YTEScreenBoundsWidth * 0.5, 14)];
    _countryLabel.font = [UIFont boldSystemFontOfSize:14];
    _countryLabel.textAlignment = NSTextAlignmentCenter;
    _countryLabel.textColor = YTEARGBColor(255, 255, 255);
    [self addSubview:self.countryLabel];
    
    _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, YTEScreenBoundsWidth * 0.5, 14)];
    _cityLabel.font = [UIFont boldSystemFontOfSize:14];
    _cityLabel.textAlignment = NSTextAlignmentCenter;
    _cityLabel.textColor = YTEARGBColor(255, 255, 255);
    [self addSubview:self.cityLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _headCircleView.yte_width = HeadIconWidth;
    _headCircleView.yte_height = HeadIconHeight;
    _headCircleView.layer.cornerRadius = HeadIconWidth/2;
    _headCircleView.layer.masksToBounds = YES;
    _headCircleView.yte_centerX = self.yte_centerX;
    _headCircleView.yte_y = HeadIconTopPad;
    
    _nameLabel.yte_y = _headCircleView.yte_bottom + 10;
    _nameLabel.yte_centerX = _headCircleView.yte_centerX;
    
    _countryLabel.yte_bottom = self.yte_bottom - 17;
    _countryLabel.yte_centerX = self.yte_width * 0.25;
    
    _cityLabel.yte_bottom = self.yte_bottom - 17;
    _cityLabel.yte_centerX = self.yte_width * 0.75;
}

- (void)reloadData:(YTEAccountModel *)accountModel {
    [_nameLabel setText:accountModel.nickName];
    [_countryLabel setText:accountModel.country];
    [_cityLabel setText:accountModel.city];
    [_headCircleView yy_setImageWithURL:[NSURL URLWithString:accountModel.photo] placeholder:SR_IMGName(@"mine_head_circle")];
}
@end
