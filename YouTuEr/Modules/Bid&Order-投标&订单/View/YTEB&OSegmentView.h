//
//  YTEB&OSegmentView.h
//  YouTuEr
//
//  Created by 苏一 on 2017/4/19.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTEB_OSegmentView;

@protocol YTEB_OSegmentViewDelegate <NSObject>

///点击标签回调
- (void)segmentView:(YTEB_OSegmentView *)segmentView didClickButtonAtIndex:(NSInteger)index;

@end

@interface YTEB_OSegmentView : UIView

@property(nonatomic,weak)id<YTEB_OSegmentViewDelegate> delegate;
@property (nonatomic, strong, readonly) NSArray *titles;
+ (instancetype)segmentViewWithTitles:(NSArray *)titles;
- (void)maskViewScrollToPositionX:(CGFloat)x;

- (void)setButtonSelectedWithTag:(NSInteger)tag;
@end
