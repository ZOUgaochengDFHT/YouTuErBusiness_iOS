//
//  YTEBidderCell.h
//  YouTuEr
//
//  Created by 苏一 on 2017/6/22.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTEBidderCell : UITableViewCell

@property (nonatomic, strong)NSObject *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
