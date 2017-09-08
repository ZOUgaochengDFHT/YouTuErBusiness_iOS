//
//  YTEUploadImageCell.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/21.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTEUploadImageCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIView *warningBgView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) UILabel *warningLabel;
@property (nonatomic, strong) UIImageView *finishedImage;// 是否上传完成图片
@property (nonatomic, assign) BOOL isFromSupple;
@property (nonatomic, assign) BOOL changeLoadStatus;// 通过此值控制显示的图片

- (UIView *)snapshotView;

@end
