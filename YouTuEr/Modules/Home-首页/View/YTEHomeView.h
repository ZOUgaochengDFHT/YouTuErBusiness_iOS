//
//  YTEHomeView.h
//  YouTuEr
//
//  Created by ss on 17/2/19.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YTEHomeViewDelegate <NSObject>

- (void)homeViewButtonDidClicked:(UIButton *)button destVCName:(NSString *)destVCName;

@end
@interface YTEHomeView : UIScrollView
// 公开工厂方法
+ (instancetype)homeView;

@property (nonatomic, strong) id<YTEHomeViewDelegate> homeViewDelegate;
@end
