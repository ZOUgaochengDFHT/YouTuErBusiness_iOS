//
//  YTEMineTableHeaderView.h
//  YouTuEr
//
//  Created by 苏一 on 2017/3/30.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YTEAccountModel;
#define HederViewHeight (YTEScreenBoundsHeight * 0.3373)
#define HederViewWidth YTEScreenBoundsWidth
@interface YTEMineTableHeaderView : UIView
@property (nonatomic, strong)UIImageView *headBGImage;

+ (instancetype)headerView;

- (void)reloadData:(YTEAccountModel *)accountModel;
@end
