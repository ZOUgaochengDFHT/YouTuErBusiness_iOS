//
//  YTEBaseFormViewController.h
//  YouTuEr
//
//  Created by 苏一 on 2017/3/7.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RETableViewManager.h"
#import "YTENetworkTool.h"
@interface YTEBaseFormViewController : UITableViewController<RETableViewManagerDelegate>

@property (nonatomic, strong, readwrite) RETableViewManager *manager;
@property (nonatomic, strong, readwrite) RETableViewSection *basicControlsSection;
@property (nonatomic, strong, readwrite) RETableViewSection *buttonSection;
@property (nonatomic, strong) RETableViewItem *buttonItem;

- (void)setupManager:(RETableViewManager *)manager;
- (RETableViewSection *)addButtonSectionWithTitle:(NSString *)title;
@end
