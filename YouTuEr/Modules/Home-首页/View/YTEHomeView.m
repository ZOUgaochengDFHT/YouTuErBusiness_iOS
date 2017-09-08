//
//  YTEHomeView.m
//  YouTuEr
//
//  Created by ss on 17/2/19.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEHomeView.h"
#import "YTEHomeButton.h"
#import "YTEHomeButtonModel.h"
// 每行最大列数
#define maxCols 3
// 按钮总数
//#define btnCount 6

@interface YTEHomeView()
// 用于保存被点击按钮的字典
@property (nonatomic, strong) NSDictionary *btnDic;

@end

@implementation YTEHomeView

+ (instancetype)homeView {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = YTEScreenBounds;
        self.backgroundColor = YTEGlobalBGColor;
        //         交互默认是打开的
        //        self.userInteractionEnabled = YES;
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    // 顶部的image
    UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_headimage"]];
    headerView.yte_width = YTEScreenBoundsWidth;
    headerView.yte_height = YTEScreenBoundsHeight * 0.5247;
    headerView.yte_x = 0;
    headerView.yte_y = 0;
    [self addSubview:headerView];
    // youtuer文字图片
    UIImageView *yoututour = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yoututour"]];
    yoututour.yte_y = 0.5 * 69;
    yoututour.yte_centerX = self.yte_centerX;
    [yoututour sizeToFit];
    [self addSubview:yoututour];
    
    // 下方的放buttun的view
    UIView *buttonsView = [[UIView alloc] init];
    UIImageView *buttonsBGView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_iconsbg"]];
    buttonsView.yte_width = YTEScreenBoundsWidth * 0.92;
    buttonsView.yte_height = YTEScreenBoundsHeight * 0.3898;
    buttonsBGView.frame = buttonsView.bounds;
    [buttonsView addSubview:buttonsBGView];
    buttonsView.yte_centerX = self.yte_centerX;
    buttonsView.yte_y = headerView.yte_bottom * 0.9114;
    [self addSubview:buttonsView];
    // btn的字典
    self.btnDic = @{@"导游":@"YTEDemandViewController", @"接送机":@"YTEDemandViewController", @"翻译":@"YTEDemandViewController", @"大巴":@"YTEDemandViewController", @"私人定制":@"YTEDemandViewController", @"团餐":@"YTEDemandViewController"};
    
    // 获得模型数组
    NSArray *btnModels = [YTEHomeButtonModel homeButtonModels];
    YTEHomeButtonModel *btnModel = [YTEHomeButtonModel new];
    // 垂直间距
//    CGFloat vPad = 15;
    // 水平间距
//    CGFloat hPad = vPad;
    // 按钮宽度与高度
    CGFloat btnWidth = buttonsView.yte_width * 0.333333;
    CGFloat btnHeight = buttonsView.yte_height * 0.45;
    for (NSInteger i = 0; i < btnModels.count; i++) {
        
        CGFloat btnX = btnWidth * (i % maxCols);
        // Y值要加上顶端navigationBar的间距
        // CGFloat btnY = YTETopPad + vPad + (vPad + btnHeight) * (i / maxCols);
        
        CGFloat btnY = btnHeight * (i / maxCols);
        
        YTEHomeButton *btn = [[YTEHomeButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnWidth, btnHeight)];
        
        btnModel = btnModels[i];
        NSString *bitTitle = btnModel.title;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:bitTitle forState:UIControlStateNormal];
        
        // 设置背景颜色
//        NSNumber *alphaNumber = btnModel.bgColor[0];
//        NSNumber *redNumber = btnModel.bgColor[1];
//        NSNumber *greenNumber = btnModel.bgColor[2];
//        NSNumber *blueNumber = btnModel.bgColor[3];
//        btn.backgroundColor = YTEARGBColor(alphaNumber.doubleValue,redNumber.doubleValue ,greenNumber.doubleValue ,blueNumber.doubleValue);
        
        [btn setImage:[UIImage imageNamed:btnModel.icon] forState:UIControlStateNormal];
        [buttonsView addSubview:btn];
        
    }
    self.contentSize = CGSizeMake(YTEScreenBoundsWidth, CGRectGetMaxY(self.subviews.lastObject.frame));
}

- (void)btnClicked:(UIButton *)btn {
    if ([self.homeViewDelegate respondsToSelector:@selector(homeViewButtonDidClicked:destVCName:)]) {
        [self.homeViewDelegate homeViewButtonDidClicked:btn destVCName:self.btnDic[btn.titleLabel.text]];
    }
}

@end
