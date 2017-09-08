//
//  YTEQuotedPriceTableViewCell.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/11.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YTEQuotedPriceCallBack)(NSString *text);

@interface YTEQuotedPriceTableViewCell : UITableViewCell

@property (copy, nonatomic) YTEQuotedPriceCallBack quotedPricehandle;
@property (weak, nonatomic) IBOutlet UILabel *preLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
