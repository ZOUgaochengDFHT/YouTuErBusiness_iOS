//
//  YTEB&OController.m
//  YouTuEr
//
//  Created by ss on 17/2/18.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEMyOrderViewController.h"
#import "YTEOngoingViewController.h"
#import "YTEHistoryViewController.h"
#import <MMPopupView/MMAlertView.h>
#import "YTEAuthenListViewController.h"
#import "YTEB&OSegmentView.h"
#import "YTEB&OController.h"
#import "YTEAuthenModel.h"
#import "SRAuthService.h"



@interface YTEB_OController ()<UIScrollViewDelegate,YTEB_OSegmentViewDelegate>
@property (strong, nonatomic) YTEB_OSegmentView *segmentView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) MMAlertView *alertView;
@property (strong, nonatomic) YTEMyOrderViewController *myOrderVC;
@property (strong, nonatomic) YTEOngoingViewController *ongingVC;
@property (strong, nonatomic) YTEHistoryViewController *historyVC;
@property (strong, nonatomic) YTEAuthenModel *authenModel;
@end

@implementation YTEB_OController

#pragma mark - View Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = YTEGlobalBGColor;
    self.navigationItem.title = @"订单";
    [YTENotifiCenter addObserver:self
                        selector:@selector(changeSelectedIndex)
                            name:YTECHANGESEGMENTINDEXNOTIFICATION
                          object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self memberAuthenRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Request

- (void)memberAuthenRequest {
    if (![SRReachabilityManager networkIsReachable]) return;
    [self showProgressView];
    @weakify(self);
    [[SRAuthService sharedService] memberAuthenRequestWithModel:[SRRequestModel new] successBlock:^(NSDictionary * returnData, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
        self.authenModel = [YTEAuthenModel yy_modelWithJSON:returnData[@"authen"]];
        [[SRUserDefaultManager sharedManager] setObject:returnData[@"authen"] forKey:SR_AUTHEN];
        [self configureView];
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
    }];
}

#pragma mark - Initializer

- (void)configureView {
    if ([[self.authenModel yy_modelToJSONString] containsString:@"1"]) {
        if (self.segmentView) {
            [self.myOrderVC reloadData];
            [self.ongingVC reloadData];
            [self.historyVC reloadData];
        } else {
            [self createSegmentView];
            self.selectIndex = [[[SRUserDefaultManager sharedManager] objectForKey:SR_INDEX] intValue];
        }
    } else {
        [self.alertView show];
    }
}

- (void)createSegmentView {
    self.segmentView = [YTEB_OSegmentView segmentViewWithTitles:@[@"我的需求", @"正在进行", @"历史订单"]];
    self.segmentView.delegate = self;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.segmentView];
    [self addControllers];
    
}
//添加子控制器
- (void)addControllers{
    // 我的需求
    [self.scrollView addSubview:self.myOrderVC.view];
    // 正在进行
    [self.scrollView addSubview:self.ongingVC.view];
    // 历史订单
    [self.scrollView addSubview:self.historyVC.view];
    
    CGFloat contentX = self.segmentView.titles.count * YTEScreenBoundsWidth;
    self.scrollView.contentSize = CGSizeMake(contentX, 0);
}

#pragma mark - UIScrollViewDelegate 计算滑动坐标 修改状态
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self.segmentView setButtonSelectedWithTag:index + 100];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //1、滑动到当前page的处理
    CGFloat pageRate = scrollView.contentOffset.x / scrollView.yte_width;
    if (((int)(pageRate*1000))%1000<1) {
        int page = (int)pageRate;//当前滑动到的page
        if (_selectIndex != page) {
            _selectIndex = page;
            //            [self tabItemSelected:_currentIndex];
        }
    }
    //2、YXCommonUITabsTopViewTypeForNoScroll模式下面 对于maskView的处理
    CGFloat rate = scrollView.contentOffset.x/scrollView.contentSize.width;
    [self.segmentView maskViewScrollToPositionX:rate * self.view.yte_width];
}


#pragma mark - YTEB_OSegmentViewDelegate
- (void)segmentView:(YTEB_OSegmentView *)segmentView didClickButtonAtIndex:(NSInteger)index {
    if (_selectIndex == index) {
        return;
    }
    _selectIndex = index;
    CGPoint contentOff = self.scrollView.contentOffset;
    contentOff.x = YTEScreenBoundsWidth * index;
    [self.scrollView setContentOffset:contentOff animated:YES];
}

#pragma mark - Private 

- (void)changeSelectedIndex {
    self.selectIndex = 2;
}


#pragma mark - Getter & Setter
- (UIScrollView *)scrollView{
    if(_scrollView == nil){
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, self.segmentView.yte_bottom, YTEScreenBoundsWidth, YTEScreenBoundsHeight - self.segmentView.yte_bottom);
        _scrollView.delegate = self;
        _scrollView.backgroundColor = YTEGlobalBGColor;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}


- (void)setSelectIndex:(NSInteger)selectIndex{
    if(_selectIndex != selectIndex){
        _selectIndex = selectIndex;
        CGPoint contentOff = self.scrollView.contentOffset;
        contentOff.x = YTEScreenBoundsWidth * selectIndex;
        self.scrollView.contentOffset = contentOff;
    }else{
        //刷新
    }
}

- (MMAlertView *)alertView {
    if (!_alertView) {
        MMAlertViewConfig *config = [MMAlertViewConfig globalConfig];
        [config setButtonFontSize:15];
        [config setItemNormalColor:YTELabelBoldColor];
        [config setWidth:242];
        [config setItemHighlightColor:YTEDominantColor];
        [config setDetailColor:YTELabelBoldColor];
        [config setTitleFontSize:0];
        [config setDetailFontSize:15];
        [config setButtonHeight:51.5];
        [config setSplitColor:YTEARGBColor(211, 211, 211)];
        [config setItemPressedColor:YTEARGBColor(248, 248, 248)];
        [config setInnerMargin:30];
        
        @weakify(self);
        MMPopupItemHandler block = ^(NSInteger index) {
            @strongify(self);
            self.tabBarController.selectedIndex = 3;
        };
        
        NSArray *items = @[MMItemMake(@"确认", MMItemTypeNormal, block)];
        _alertView = [[MMAlertView alloc]initWithTitle:@" " detail:@"请先进行商家认证！" items:items];
        [_alertView.attachedView setMm_dimBackgroundBlurEnabled:NO];
        [_alertView.attachedView setMm_dimBackgroundBlurEffectStyle:UIBlurEffectStyleLight];
    }
    return _alertView;
}

- (YTEMyOrderViewController *)myOrderVC {
    if (!_myOrderVC) {
        YTEMyOrderViewController *myOrderVC = [[YTEMyOrderViewController alloc]init];
        myOrderVC.view.backgroundColor = YTERandomColor;
        [self addChildViewController:myOrderVC];
        myOrderVC.view.frame = CGRectMake(0, 0, YTEScreenBoundsWidth, YTEScreenBoundsHeight);
        _myOrderVC = myOrderVC;
    }
    return _myOrderVC;
}

- (YTEOngoingViewController *)ongingVC {
    if (!_ongingVC) {
        YTEOngoingViewController *ongingVC = [[YTEOngoingViewController alloc]init];
        ongingVC.view.backgroundColor = YTERandomColor;
        [self addChildViewController:ongingVC];
        ongingVC.view.frame = CGRectMake(YTEScreenBoundsWidth, 0, YTEScreenBoundsWidth, YTEScreenBoundsHeight);
        _ongingVC = ongingVC;
    }
    return _ongingVC;
}

- (YTEHistoryViewController *)historyVC {
    if (!_historyVC) {
        YTEHistoryViewController *historyVC = [[YTEHistoryViewController alloc]init];
        historyVC.view.backgroundColor = YTERandomColor;
        [self addChildViewController:historyVC];
        historyVC.view.frame = CGRectMake(YTEScreenBoundsWidth * 2, 0, YTEScreenBoundsWidth, YTEScreenBoundsHeight);
        _historyVC = historyVC;
    }
    return _historyVC;
}

@end
