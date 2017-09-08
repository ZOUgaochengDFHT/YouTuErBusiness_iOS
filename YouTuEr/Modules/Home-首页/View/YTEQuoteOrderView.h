//
//  YTEQuoteOrderView.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/10.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YTEQuoteOrderCallback)(NSInteger tag);

@interface YTEQuoteOrderView : UIView

@property (copy, nonatomic) YTEQuoteOrderCallback quoteOrderHandle;
@property (copy, nonatomic) NSString *arriveDate;

@end
