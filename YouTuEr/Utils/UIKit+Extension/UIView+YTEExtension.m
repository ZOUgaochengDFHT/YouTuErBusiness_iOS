//
//  UIView+YTEExtension.m
//  YouTuEr
//
//  Created by ss on 17/2/20.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "UIView+YTEExtension.h"

@implementation UIView (YTEExtension)

- (CGFloat)yte_x {
    return self.frame.origin.x;
}

- (void)setYte_x:(CGFloat)yte_x {
    CGRect frame = self.frame;
    frame.origin.x = yte_x;
    self.frame = frame;
}

- (CGFloat)yte_y {
    return self.frame.origin.y;
}

- (void)setYte_y:(CGFloat)yte_y {
    CGRect frame = self.frame;
    frame.origin.y = yte_y;
    self.frame = frame;
}

- (CGFloat)yte_width {
    return self.frame.size.width;
}

- (void)setYte_width:(CGFloat)yte_width {
    CGRect frame = self.frame;
    frame.size.width = yte_width;
    self.frame = frame;
}

- (CGFloat)yte_height {
    return self.frame.size.height;
}

- (void)setYte_height:(CGFloat)yte_height {
    CGRect frame = self.frame;
    frame.size.height = yte_height;
    self.frame = frame;
}

- (CGFloat)yte_centerX {
    return self.center.x;
}

- (void)setYte_centerX:(CGFloat)yte_centerX {
    CGPoint center = self.center;
    center.x = yte_centerX;
    self.center = center;
}

- (CGFloat)yte_centerY {
    return self.center.y;
}

- (void)setYte_centerY:(CGFloat)yte_centerY {
    CGPoint center = self.center;
    center.y = yte_centerY;
    self.center = center;
}

- (CGFloat)yte_right {
    return CGRectGetMaxX(self.frame);
}

- (void)setYte_right:(CGFloat)yte_right {
    self.yte_x = yte_right - self.yte_width;
}

- (CGFloat)yte_bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setYte_bottom:(CGFloat)yte_bottom {
    self.yte_y = yte_bottom - self.yte_height;
}

#pragma mark - Tap Gesture

static const void *kTapGestureKey = &kTapGestureKey;

- (void)addTapGesture:(void (^) (UITapGestureRecognizer *gesture))handler {
    objc_setAssociatedObject(self, kTapGestureKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapView:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)onTapView:(UITapGestureRecognizer *)sender {
    void (^handler) (UITapGestureRecognizer *) = objc_getAssociatedObject(self, kTapGestureKey);
    handler(sender);
}

@end
