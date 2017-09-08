//
//  YTEUploadImageViewController.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/21.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YTEUploadImageBlock)(NSMutableArray *urlArr, NSMutableArray *assetsArr, NSString *navTitle);

@interface YTEUploadImageViewController : UIViewController

@property (copy, nonatomic) YTEUploadImageBlock uploadImageHandle;
@property (assign, nonatomic) YTEMerchantAuthType authType;
@property (strong, nonatomic) NSMutableArray *selectedPhotos;
@property (strong, nonatomic) NSMutableArray *selectedAssets;

@end
