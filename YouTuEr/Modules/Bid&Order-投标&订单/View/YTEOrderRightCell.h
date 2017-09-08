//
//  YTEOrderRightCell.h
//  YouTuEr
//
//  Created by 苏一 on 2017/5/11.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^YTEModifyQuotedPriceBlock)(NSString *Id);
typedef void (^YTECancelBidBlock)(NSString *Id);


@interface YTEOrderRightCell : UITableViewCell

@property (nonatomic, strong) NSObject *model;
@property (nonatomic, copy) YTEModifyQuotedPriceBlock modifyQuotedPriceHandle;
@property (nonatomic, copy) YTECancelBidBlock cancelBidHandle;
@property (nonatomic, assign) YTEOrderStatus orderStatus;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
