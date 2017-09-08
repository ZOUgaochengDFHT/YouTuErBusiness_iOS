//
//  YTEBaseFormViewController.m
//  YouTuEr
//
//  Created by 苏一 on 2017/3/7.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEBaseFormViewController.h"

@interface YTEBaseFormViewController ()

@end

@implementation YTEBaseFormViewController

#pragma mark - View Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:YTEScreenBounds style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
//    self.tableView.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
//    self.tableView.sectionFooterHeight = 15;
//    self.tableView.sectionHeaderHeight = 0.000001;
    self.tableView.showsVerticalScrollIndicator = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initializer

- (void)setupManager:(RETableViewManager *)manager {
    
    // Set default cell height
    //
    manager.style.cellHeight = 42.0;
    
    // Set cell background image
    //
//    [manager.style setBackgroundImage:[[UIImage imageNamed:@"First"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 50, 10, 20)]
//                               forCellType:RETableViewCellTypeFirst];
//    [manager.style setBackgroundImage:[[UIImage imageNamed:@"Middle"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
//                               forCellType:RETableViewCellTypeMiddle];
////    [manager.style setBackgroundImage:[[UIImage imageNamed:@"Last"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
//                               forCellType:RETableViewCellTypeLast];
//    [manager.style setBackgroundImage:[[UIImage imageNamed:@"Single"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
//                               forCellType:RETableViewCellTypeSingle];
    
    // Set selected cell background image
//    //
//    [manager.style setSelectedBackgroundImage:[[UIImage imageNamed:@"First_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
//                                       forCellType:RETableViewCellTypeFirst];
//    [manager.style setSelectedBackgroundImage:[[UIImage imageNamed:@"Middle_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
//                                       forCellType:RETableViewCellTypeMiddle];
//    [manager.style setSelectedBackgroundImage:[[UIImage imageNamed:@"Last_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
//                                       forCellType:RETableViewCellTypeLast];
//    [manager.style setSelectedBackgroundImage:[[UIImage imageNamed:@"Single_Selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
//                                       forCellType:RETableViewCellTypeSingle];
    
    
//    self.manager.style.contentViewMargin = 10.0;
//    self.manager.style.backgroundImageMargin = 10.0;
    // Retain legacy grouped cell style in iOS [redacted]
    //    //
    //    if (REDeviceIsUIKit7()) {
    //        self.manager.style.contentViewMargin = 10.0;
    //        self.manager.style.backgroundImageMargin = 10.0;
    //    }
}

- (RETableViewSection *)addButtonSectionWithTitle:(NSString *)title {
    
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:title accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
    }];
    
    section.style = [self.manager.style copy];
    section.style.backgroundImages = nil;
    section.style.selectedBackgroundImages = nil;
//    buttonItem.textColor = [UIColor whiteColor];
//    buttonItem.textFont = YTEFont(20.0);
//    buttonItem.backgroundColor = YTEDominantColor;
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];
    
    self.buttonItem = buttonItem;
    return section;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.tableView endEditing:YES];
}

#pragma mark - table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.manager.sections.count - 1 || section == self.manager.sections.count - 2) return 20;
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000001;
}




@end
