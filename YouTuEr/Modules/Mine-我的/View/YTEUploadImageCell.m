//
//  YTEUploadImageCell.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/21.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEUploadImageCell.h"
#import "UIView+Layout.h"

@implementation YTEUploadImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _bgImageView = [UIImageView new];
        _bgImageView.backgroundColor = [UIColor clearColor];
        _bgImageView.layer.cornerRadius = 10.0;
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_bgImageView];
        _bgImageView.clipsToBounds = YES;
        
        _warningBgView = [UIView new];
        _warningBgView.tz_size = CGSizeMake(19, 60);
        [self addSubview:_warningBgView];
        
        UIImage *plusImg = SR_IMGName(@"product_fifth_picture_plus");
        
        UIImageView *plusImgView = [UIImageView new];
        plusImgView.backgroundColor = [UIColor clearColor];
        plusImgView.frame = CGRectMake(0, 0, 19.0, 19.0);
        
        plusImgView.image = plusImg;
        [_warningBgView addSubview:plusImgView];
        
        _warningLabel = [UILabel new];
        _warningLabel.font = [UIFont systemFontOfSize:14.0];
        _warningLabel.textColor = SR_RGBCOLOR(128, 128, 128);
        _warningLabel.textAlignment = NSTextAlignmentCenter;
        _warningLabel.frame = CGRectMake(-50.5,  plusImgView.tz_bottom + 20, 120, 21);
        [_warningBgView addSubview:_warningLabel];
        
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:SR_IMGName(@"photo_delete") forState:UIControlStateNormal];
        _deleteBtn.frame = CGRectMake(self.tz_width - 36, 0, 36, 36);
        _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -10);
        _deleteBtn.alpha = 0.6;
        [self addSubview:_deleteBtn];
        
        _finishedImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.tz_width - 50 - 4.5, self.tz_height - 50 - 4.5, 54, 48)];
        _finishedImage.image = SR_IMGName(@"unuploadfinished");
        [self addSubview:_finishedImage];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _warningLabel.text = (self.isFromSupple == YES ? @"上传补件资料": @"请上传");
    _bgImageView.frame = self.bounds;
    _warningBgView.center = _bgImageView.center;
    [[self class] addBorderToLayer:_bgImageView cornerRadius:_bgImageView.layer.cornerRadius lineWidth:1.0f];
}


- (void)setChangeLoadStatus:(BOOL)changeLoadStatus
{
    _changeLoadStatus = changeLoadStatus;
    if(_changeLoadStatus)
    {
        _finishedImage.image = SR_IMGName(@"uploadfinished");
    }else
    {
        _finishedImage.image = SR_IMGName(@"unuploadfinished");
    }
}

- (void)setRow:(NSInteger)row {
    _row = row;
    _deleteBtn.tag = row;
}

- (UIView *)snapshotView {
    UIView *snapshotView = [[UIView alloc]init];
    
    UIView *cellSnapshotView = nil;
    
    if ([self respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
        cellSnapshotView = [self snapshotViewAfterScreenUpdates:NO];
    } else {
        CGSize size = CGSizeMake(self.bounds.size.width + 20, self.bounds.size.height + 20);
        UIGraphicsBeginImageContextWithOptions(size, self.opaque, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage * cellSnapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        cellSnapshotView = [[UIImageView alloc]initWithImage:cellSnapshotImage];
    }
    
    snapshotView.frame = CGRectMake(0, 0, cellSnapshotView.frame.size.width, cellSnapshotView.frame.size.height);
    cellSnapshotView.frame = CGRectMake(0, 0, cellSnapshotView.frame.size.width, cellSnapshotView.frame.size.height);
    
    [snapshotView addSubview:cellSnapshotView];
    return snapshotView;
}

+ (void)addBorderToLayer:(UIImageView *)view cornerRadius:(CGFloat)cornerRadius lineWidth:(CGFloat)lineWidth
{
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = SR_RGBCOLOR(208, 208, 208).CGColor;
    border.fillColor = SR_RGBACOLOR(1, 1, 1, 0.28).CGColor;
    border.path = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:cornerRadius].CGPath;
    border.frame = view.bounds;
    border.lineWidth = lineWidth;
    border.lineCap = @"square";
    border.lineDashPattern = @[@4, @2];
    [view.layer addSublayer:border];
}
@end
