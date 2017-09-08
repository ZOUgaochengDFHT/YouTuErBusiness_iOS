//
//  YTEContactSelectionViewController.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/9/6.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEEMChooseViewController.h"

@interface YTEContactSelectionViewController : YTEEMChooseViewController

//已有选中的成员username，在该页面，这些成员不能被取消选择
- (instancetype)initWithBlockSelectedUsernames:(NSArray *)blockUsernames;

- (instancetype)initWithContacts:(NSArray *)contacts;

@end
