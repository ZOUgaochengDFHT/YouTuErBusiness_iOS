//
//  YTEBaseListViewController.h
//  YouTuEr
//
//  Created by 苏一 on 2017/4/27.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTENetworkTool.h"
@interface YTEBaseListViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *leftDataArray;
@property (nonatomic, strong) NSMutableDictionary *rightDataDic;

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, assign) NSInteger selectIndex;

- (void)reloadData;

@end
