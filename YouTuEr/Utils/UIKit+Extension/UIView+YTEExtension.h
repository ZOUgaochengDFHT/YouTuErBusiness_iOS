//
//  UIView+YTEExtension.h
//  YouTuEr
//
//  Created by ss on 17/2/20.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YTEExtension)
@property (nonatomic, assign) CGFloat yte_x;
@property (nonatomic, assign) CGFloat yte_y;
@property (nonatomic, assign) CGFloat yte_width;
@property (nonatomic, assign) CGFloat yte_height;
@property (nonatomic, assign) CGFloat yte_centerX;
@property (nonatomic, assign) CGFloat yte_centerY;
@property (nonatomic, assign) CGFloat yte_right;
@property (nonatomic, assign) CGFloat yte_bottom;

/**
 给UIView添加Tap事件
 */
- (void)addTapGesture:(void (^) (UITapGestureRecognizer *gesture))handler;

@end
