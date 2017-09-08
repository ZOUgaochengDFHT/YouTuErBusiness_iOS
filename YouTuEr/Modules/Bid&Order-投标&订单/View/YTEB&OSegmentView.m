//
//  YTEB&OSegmentView.m
//  YouTuEr
//
//  Created by 苏一 on 2017/4/19.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEB&OSegmentView.h"
#define TopViewHeight 44
@interface YTEB_OSegmentView()
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIImageView *maskView;
@property (nonatomic, strong) UIButton *selectedButton;
@end

@implementation YTEB_OSegmentView


+ (instancetype)segmentViewWithTitles:(NSArray *)titles {
    YTEB_OSegmentView *segmentView = [self new];
    segmentView.titles = titles;
    return segmentView;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, YTETopPad, YTEScreenBoundsWidth, TopViewHeight);
    }
    return self;
}

- (void)setupSubviews {
    
    self.backgroundColor = YTEARGBColor(255, 255, 255);
    
    self.maskView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, YTEScreenBoundsWidth / self.titles.count, TopViewHeight * 0.85)];
    self.maskView.image = [UIImage imageNamed:@"icon_nav_hover"];
    self.maskView.contentMode = UIViewContentModeBottom;
    [self addSubview:self.maskView];
    
    CGFloat buttonWidth = YTEScreenBoundsWidth / self.titles.count;
    CGFloat buttonHeight = TopViewHeight;
    for (int i = 0; i < self.titles.count; i++) {
        UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(i * buttonWidth, 0, buttonWidth, buttonHeight)];
        [titleButton setTitle:self.titles[i] forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:13];
        titleButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleButton setTitleColor:YTEARGBColor(102, 102, 102) forState:UIControlStateNormal];
        [titleButton setTitleColor:YTEDominantColor forState:UIControlStateSelected];
        titleButton.tag = i + 100;
        titleButton.adjustsImageWhenHighlighted = NO;
        [titleButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:titleButton];
        
        if (i == 0) {
            titleButton.selected = YES;
            self.selectedButton = titleButton;
        }
        YTELog(@"%@",NSStringFromCGRect(titleButton.titleLabel.frame));
    }

    
}

- (void)clickedButton:(UIButton *)button{
    [self setButtonSelectedWithTag:button.tag];
    if ([self.delegate respondsToSelector:@selector(segmentView:didClickButtonAtIndex:)]) {
        [self.delegate segmentView:self didClickButtonAtIndex:button.tag - 100];
    }
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    [self setupSubviews];
}

- (void)maskViewScrollToPositionX:(CGFloat)x {
    self.maskView.yte_x = x;
}

- (void)setButtonSelectedWithTag:(NSInteger)tag {
    UIButton *button = [self viewWithTag:tag];
    if (self.selectedButton == button) {
        return;
    }
    self.selectedButton.selected = NO;
    self.selectedButton = button;
    button.selected = YES;
}
@end
