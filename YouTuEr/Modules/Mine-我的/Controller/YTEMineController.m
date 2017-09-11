//
//  YTEMineController.m
//  YouTuEr
//
//  Created by ss on 17/2/18.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "SRUserService.h"
#import "YTENetworkTool.h"
#import "YTEAccountModel.h"
#import "YTEB&OController.h"
#import "YTEMineController.h"
#import "YTELoginController.h"
#import "SRGetInfoServiceModel.h"
#import "YTEMineTableHeaderView.h"
#import "YTENavigationController.h"
#import <MMPopupView/MMAlertView.h>
#import "YTEModifyPSWViewController.h"
#import "YTEAuthenListViewController.h"
#import "YTEModifyDataViewController.h"


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface YTEMineController ()
@property (nonatomic, strong) YTEMineTableHeaderView *headerView;
@property (nonatomic, strong) YTEAccountModel *accountModel;
@property (strong, nonatomic) MMAlertView *alertView;

@end

@implementation YTEMineController
// 隐藏及显示导航栏代码

#pragma mark - View Cycle
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    if (self.navigationController.childViewControllers.count > 1) [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.headerView = [YTEMineTableHeaderView headerView];
    self.tableView.tableHeaderView = self.headerView;
    [self setupGroups];
    [self memberGetInfoRequest];
    
    [YTENotifiCenter addObserver:self
                        selector:@selector(memberGetInfoRequest)
                            name:YTEMODIFYDATASUCCESSNOTIFICATION
                          object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Request
- (void)memberGetInfoRequest {
    SRGetInfoServiceModel *serviceModel1 = [SRGetInfoServiceModel new];
    if (![SRReachabilityManager networkIsReachable]) return;
    [self showProgressView];
    @weakify(self);
    [[SRUserService sharedService] memberGetInfoRequestWithModel:serviceModel1 successBlock:^(NSDictionary * returnData, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
        self.accountModel = [YTEAccountModel yy_modelWithJSON:returnData[@"member"]];
        [[SRUserDefaultManager sharedManager] setObject:self.accountModel.nickName forKey:@"bidUsername"];
        [self.headerView reloadData:self.accountModel];
    } failureBlock:^(NetworkErrorStatus error, NSURLSessionTask *task) {
        @strongify(self);
        [self hideProgressView];
    }];
}

#pragma mark - Initializer

- (void)setupGroups {
    // 创建两个组模型
    // 创建第1组
    HMSettingItem *item11 = [HMSettingItemArrow itemWithTitle:@"商家认证" icon:@"mine_editprofile_icon" destVc:[YTEAuthenListViewController class]];
    @weakify(self);
    HMSettingItem *item12 = [HMSettingItemArrow itemWithTitle:@"历史订单" icon:@"mine_orderhistory_icon"];
    item12.operationBlock = ^{
        @strongify(self);
        [YTENotifiCenter postNotificationName:YTECHANGESEGMENTINDEXNOTIFICATION object:nil];
        [[SRUserDefaultManager sharedManager] setObject:@(2) forKey:SR_INDEX];
        self.tabBarController.selectedIndex = 1;
        [self performBlock:^{
            [[SRUserDefaultManager sharedManager] removeObjectForKey:SR_INDEX];
        } afterDelay:1];
    };
    HMSettingItem *item13 = [HMSettingItemArrow itemWithTitle:@"钱包" icon:@"mine_wallet_icon" destVc:[YTEMineWalletViewController class]];
    HMSettingItem *item14 = [HMSettingItemArrow itemWithTitle:@"修改资料" icon:@"mine_editprofile_icon" destVc:nil];
    item14.operationBlock = ^{
        @strongify(self);
        YTEModifyDataViewController *modifyDataVC = [[YTEModifyDataViewController alloc]init];
        modifyDataVC.accountModel = self.accountModel;
        [self.navigationController pushViewController:modifyDataVC animated:YES];
    };
    HMSettingItem *item15 = [HMSettingItemArrow itemWithTitle:@"修改密码" icon:@"mine_modifypassword_icon" destVc:[YTEModifyPSWViewController class]];

    HMSettingItem *item16 = [HMSettingItemArrow itemWithTitle:@"推荐给朋友" icon:@"mine_share_icon"];
    item16.operationBlock = ^{
        //1、创建分享参数
        NSArray* imageArray = @[[UIImage imageNamed:@"mine_share_icon"]];
        if (imageArray) {
            
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                             images:imageArray
                                                url:[NSURL URLWithString:@"http://mob.com"]
                                              title:@"分享标题"
                                               type:SSDKContentTypeAuto];
            //有的平台要客户端分享需要加此方法，例如微博
            [shareParams SSDKEnableUseClientShare];
            //2、分享（可以弹出我们的分享菜单和编辑界面）
            [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                     items:nil
                               shareParams:shareParams
                       onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                           
                           switch (state) {
                               case SSDKResponseStateSuccess:
                               {
                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                       message:nil
                                                                                      delegate:nil
                                                                             cancelButtonTitle:@"确定"
                                                                             otherButtonTitles:nil];
                                   [alertView show];
                                   break;
                               }
                               case SSDKResponseStateFail:
                               {
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                   message:[NSString stringWithFormat:@"%@",error]
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"OK"
                                                                         otherButtonTitles:nil, nil];
                                   [alert show];
                                   break;
                               }
                               default:
                                   break;
                           }
                       }
             ];
        }
    };
    HMSettingItem *item17 = [HMSettingItemArrow itemWithTitle:@"联系客服" icon:@"mine_icon_lianxikefu" destVc:[UITableViewController class]];
    item17.operationBlock = ^{
        
    };
    // 创建第3组
    HMSettingItem *item31 = [HMSettingItemMiddleLabel itemWithTitle:@"退出登录"];
    item31.operationBlock = ^{
        @strongify(self);
        [self.alertView show];
    };
    HMSettingGroup *group1 = [HMSettingGroup groupWithItems:@[item11, item12, item13]];
    HMSettingGroup *group2 = [HMSettingGroup groupWithItems:@[item14, item15, item16, item17]];
    HMSettingGroup *group4 = [HMSettingGroup groupWithItems:@[item31]];

    // 将组模型添加到数组中
    self.groups = [NSMutableArray arrayWithObjects:group1, group2, group4,nil];
    
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
    if (Offset_y < 0) {
        // 拉伸后图片的高度
        CGFloat totalOffset = HederViewHeight - Offset_y;
        // 图片放大比例
        CGFloat scale = totalOffset / HederViewHeight;
        CGFloat width = YTEScreenBoundsWidth;
        // 拉伸后图片位置
        self.headerView.headBGImage.frame = CGRectMake(-(HederViewWidth * scale - HederViewWidth) / 2, Offset_y, width * scale, totalOffset);
    }
}


#pragma mark - Getter & Setter
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
            if (index == 0) {
                self.view.window.rootViewController = [[YTENavigationController alloc] initWithRootViewController:[[YTELoginController alloc] init]];
                [[SRUserDefaultManager sharedManager] removeObjectForKey:SR_CLINETID];
                [[EMClient sharedClient] logout:YES];
            }
        };
        
        NSArray *items = @[MMItemMake(@"是", MMItemTypeNormal, block),
                           MMItemMake(@"否", MMItemTypeHighlight, block)];
        _alertView = [[MMAlertView alloc]initWithTitle:@" " detail:@"确认退出登录？" items:items];
        [_alertView.attachedView setMm_dimBackgroundBlurEnabled:NO];
        [_alertView.attachedView setMm_dimBackgroundBlurEffectStyle:UIBlurEffectStyleLight];
    }
    return _alertView;
}


@end
