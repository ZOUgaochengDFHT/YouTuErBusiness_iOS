//
//  YTEButton.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/11.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEButton.h"

@implementation YTEButton

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setBackgroundImage:[UIImage createImageWithColor:YTEDominantColor] forState:UIControlStateNormal];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setBackgroundImage:[UIImage createImageWithColor:YTEDominantColor] forState:UIControlStateNormal];
    }
    return self;
}


@end
