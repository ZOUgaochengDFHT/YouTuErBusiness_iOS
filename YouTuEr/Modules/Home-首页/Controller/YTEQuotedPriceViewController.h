//
//  YTEQuotedPriceViewController.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/11.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YTEGuideDemandModel;

typedef enum : NSUInteger {
    YTEQuotedPriceWay_quoting = 0,
    YTEQuotedPriceWay_modifing = 1,
} YTEQuotedPriceWay;

@interface YTEQuotedPriceViewController : UIViewController

@property (strong, nonatomic) YTEGuideDemandModel *guideDemandeModel;
@property (copy, nonatomic) NSString *orderId;
@property (assign, nonatomic) YTEQuotedPriceWay quotedPriceWay;

@end
