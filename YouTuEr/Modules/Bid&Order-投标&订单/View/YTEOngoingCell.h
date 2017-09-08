//
//  YTEOngoingCell.h
//  YouTuEr
//
//  Created by 苏一 on 2017/6/19.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTEOngoingCell : UITableViewCell

@property (nonatomic, copy) NSString *orderNumber;
@property (nonatomic, strong) NSObject *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
