//
//  YTEOrderDetailView.h
//  YouTuEr
//
//  Created by 苏一 on 2017/5/26.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTEOrderDetailView : UIView

/**
 *  信息提示框
 *
 *  @param model 信息提示框显示信息的模型
 */
+ (void)detailtView:(NSObject *)model orderStatus:(YTEOrderStatus)orderStatus;
@end

