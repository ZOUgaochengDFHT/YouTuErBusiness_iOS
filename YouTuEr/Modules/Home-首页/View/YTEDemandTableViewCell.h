//
//  YTEDemandTableViewCell.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/10.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YTEQuoteOrderQuestBlock)(NSInteger tag);

@interface YTEDemandTableViewCell : UITableViewCell

@property (copy, nonatomic) YTEQuoteOrderQuestBlock quoteOrderQuest;
@property (strong, nonatomic) NSObject *demandModel;
@end
