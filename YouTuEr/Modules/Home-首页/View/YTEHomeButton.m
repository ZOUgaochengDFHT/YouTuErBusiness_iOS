//
//  YTEHomeButton.m
//  YouTuEr
//
//  Created by 苏一 on 2017/3/4.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEHomeButton.h"

@implementation YTEHomeButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.adjustsImageWhenHighlighted = NO;
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:YTEARGBColor(51, 51, 51) forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.yte_centerX = self.yte_width * 0.5;
    self.imageView.yte_y = self.yte_height * 0.096;
    
    self.titleLabel.yte_width = self.yte_width;
    self.titleLabel.yte_centerX = self.imageView.yte_centerX;
    self.titleLabel.yte_y = self.imageView.yte_bottom + 10;
    self.titleLabel.yte_height = 22;
}

@end
