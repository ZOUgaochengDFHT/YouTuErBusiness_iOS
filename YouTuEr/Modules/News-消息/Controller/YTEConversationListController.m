//
//  YTEConversationListController.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/9/6.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "UIViewController+SearchController.h"
#import "YTEConversationListController.h"
#import "YTEContactListViewController.h"
#import "YTESettingsViewController.h"
#import "YTEChatViewController.h"
#import "YTEChatHelper.h"

@interface YTEConversationListController () <EaseConversationListViewControllerDelegate, EaseMessageViewControllerDataSource, EMSearchControllerDelegate>

@end

@implementation YTEConversationListController

#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _configureViews];
    [self _setupBarButtonItem];
    [self _setupSearchController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshAndSortView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initializer
- (void)_configureViews {
    [self.navigationItem setTitle:NSLocalizedString(@"title.conversation", @"Conversations")];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.tabBarController.tabBar setTranslucent:NO];
    
    self.showRefreshHeader = YES;
//    self.dataSource = self;
    self.delegate = self;
}

- (void)_setupBarButtonItem {
    UIButton *settingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    settingButton.accessibilityIdentifier = @"setting";
    [settingButton setImage:SR_IMGName(@"tabbar_setting") forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(gotoSettingVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    UIButton *contactsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 18)];
    contactsButton.accessibilityIdentifier = @"contacts";
    [contactsButton setImage:SR_IMGName(@"tabbar_contacts") forState:UIControlStateNormal];
    [contactsButton addTarget:self action:@selector(gotoContactsVC) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contactsButton];
}

- (void)_setupSearchController
{
    [self enableSearchController];
    
    __weak YTEConversationListController *weakSelf = self;
    [self.resultController setCellForRowAtIndexPathCompletion:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        NSString *CellIdentifier = [EaseConversationCell cellIdentifierWithModel:nil];
        EaseConversationCell *cell = (EaseConversationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[EaseConversationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        id<IConversationModel> model = [weakSelf.resultController.displaySource objectAtIndex:indexPath.row];
        cell.model = model;
        
//        cell.detailLabel.attributedText = [weakSelf conversationListViewController:weakSelf latestMessageTitleForConversationModel:model];
//        cell.timeLabel.text = [weakSelf conversationListViewController:weakSelf latestMessageTimeForConversationModel:model];
        return cell;
    }];
    
    [self.resultController setHeightForRowAtIndexPathCompletion:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return [EaseConversationCell cellHeightWithModel:nil];
    }];
    
    [self.resultController setDidSelectRowAtIndexPathCompletion:^(UITableView *tableView, NSIndexPath *indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [weakSelf.searchController.searchBar endEditing:YES];
        id<IConversationModel> model = [weakSelf.resultController.displaySource objectAtIndex:indexPath.row];
        EMConversation *conversation = model.conversation;
        YTEChatViewController *chatController;
//        if ([[RobotManager sharedInstance] isRobotWithUsername:conversation.conversationId]) {
//            chatController = [[RobotChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
//            chatController.title = [[RobotManager sharedInstance] getRobotNickWithUsername:conversation.conversationId];
//        }else {
//#ifdef REDPACKET_AVALABLE
//            chatController = [[RedPacketChatViewController alloc]  initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
//#else
//            chatController = [[YTEChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
//#endif
//            chatController.title = [conversation showName];
//        }
        [weakSelf.navigationController pushViewController:chatController animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUnreadMessageCount" object:nil];
        [weakSelf.tableView reloadData];
        [weakSelf cancelSearch];
    }];
    
    UISearchBar *searchBar = self.searchController.searchBar;
    self.tableView.frame = CGRectMake(0, searchBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - searchBar.frame.size.height);
    [self.view addSubview:searchBar];
    //    self.tableView.tableHeaderView = searchBar;
    //    [searchBar sizeToFit];
}

#pragma mark - EaseConversationListViewControllerDelegate
- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController didSelectConversationModel:(id<IConversationModel>)conversationModel {
    if (conversationModel) {
        EMConversation *conversation = conversationModel.conversation;
        if (conversation) {
            UIViewController *chatController = nil;
            chatController = [[YTEChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
            chatController.title = conversationModel.title;
            [self.navigationController pushViewController:chatController animated:YES];
        }
        [YTENotifiCenter postNotificationName:YTESETUPUNREADMESSAGECOUNTNOTIFICATION object:nil];
        [self.tableView reloadData];
    }
}

#pragma mark - EaseConversationListViewControllerDataSource

//- (id<IConversationModel>)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
//                                    modelForConversation:(EMConversation *)conversation
//{
//    EaseConversationModel *model = [[EaseConversationModel alloc] initWithConversation:conversation];
//    return model;
//}

#pragma mark - EMSearchControllerDelegate



#pragma mark - Action

- (void)gotoSettingVC {
    YTESettingsViewController *settingVC = [YTESettingsViewController new];
    settingVC.navigationItem.title = NSLocalizedString(@"title.settings", @"settings");
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)gotoContactsVC {
    YTEContactListViewController *contactsVC = [YTEContactListViewController new];
    contactsVC.navigationItem.title = NSLocalizedString(@"title.addressbook", @"addressbook");
    [self.navigationController pushViewController:contactsVC animated:YES];
}


@end
