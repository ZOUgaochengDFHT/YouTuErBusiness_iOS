//
//  YTEOngoingDetailController.m
//  YouTuEr
//
//  Created by 苏一 on 2017/6/23.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEOngoingDetailController.h"
#import "YTEOngoingDetailView.h"
@interface YTEOngoingDetailController ()

@end

@implementation YTEOngoingDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    self.view = [YTEOngoingDetailView detailtView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
