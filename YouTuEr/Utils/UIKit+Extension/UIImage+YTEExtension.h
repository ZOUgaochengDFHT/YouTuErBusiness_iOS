//
//  UIImage+YTEExtension.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/11.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YTEExtension)

+ (UIImage *)createImageWithColor:(UIColor*)color;

+ (UIImage *)fixOrientation:(UIImage *)aImage;

@end
