//
//  YTESettingsViewController.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/9/6.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTESettingsViewController.h"
#import "YTEBlackListViewController.h"
#import "YTEPushNotificationViewController.h"

@interface YTESettingsViewController ()

@property (strong, nonatomic) UIView *footerView;

@property (strong, nonatomic) UISwitch *autoLoginSwitch;
@property (strong, nonatomic) UISwitch *delConversationSwitch;
@property (strong, nonatomic) UISwitch *groupInviteSwitch;
@property (strong, nonatomic) UISwitch *sortMethodSwitch;
@property (strong, nonatomic) UISwitch *deliveryAckSwitch;
@property (strong, nonatomic) UISwitch *historySwitch;

@end

@implementation YTESettingsViewController

@synthesize autoLoginSwitch = _autoLoginSwitch;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"title.setting", @"Setting");
    self.view.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0];
    self.navigationItem.backBarButtonItem.accessibilityIdentifier = @"back";
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = self.footerView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - getter

- (UISwitch *)autoLoginSwitch
{
    if (_autoLoginSwitch == nil) {
        _autoLoginSwitch = [[UISwitch alloc] init];
        [_autoLoginSwitch addTarget:self action:@selector(autoLoginChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _autoLoginSwitch;
}

- (UISwitch *)delConversationSwitch
{
    if (!_delConversationSwitch)
    {
        _delConversationSwitch = [[UISwitch alloc] init];
        _delConversationSwitch.on = [[EMClient sharedClient].options isDeleteMessagesWhenExitGroup];
        [_delConversationSwitch addTarget:self action:@selector(delConversationChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _delConversationSwitch;
}

- (UISwitch *)groupInviteSwitch
{
    if (!_groupInviteSwitch)
    {
        _groupInviteSwitch = [[UISwitch alloc] init];
        _groupInviteSwitch.on = [[EMClient sharedClient].options isAutoAcceptGroupInvitation];
        [_groupInviteSwitch addTarget:self action:@selector(groupInviteChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _groupInviteSwitch;
}

- (UISwitch *)sortMethodSwitch
{
    if (_sortMethodSwitch == nil) {
        _sortMethodSwitch = [[UISwitch alloc] init];
        [_sortMethodSwitch addTarget:self action:@selector(sortMethodChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _sortMethodSwitch;
}

- (UISwitch *)deliveryAckSwitch
{
    if (_deliveryAckSwitch == nil) {
        _deliveryAckSwitch = [[UISwitch alloc] init];
        [_deliveryAckSwitch addTarget:self action:@selector(deliveryAckChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _deliveryAckSwitch;
}

- (UISwitch *)historySwitch
{
    if (_historySwitch == nil) {
        _historySwitch = [[UISwitch alloc] init];
        NSUserDefaults *uDefaults = [NSUserDefaults standardUserDefaults];
        _historySwitch.on = [uDefaults boolForKey:@"isFetchHistory"];
        [_historySwitch addTarget:self action:@selector(historySrouceChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _historySwitch;
}

#pragma mark - Table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#ifdef REDPACKET_AVALABLE
    return 2;
#endif
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#ifdef REDPACKET_AVALABLE
    if (section == 0) {
        return 1;
    }
#endif
    
#if DEMO_CALL == 1
    return 12;
#endif
    
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    } else {
        [cell.contentView.subviews enumerateObjectsUsingBlock:^(UIView * subView, NSUInteger idx, BOOL *stop) {
            [subView removeFromSuperview];
        }];
    }
    
#ifdef REDPACKET_AVALABLE
    if (indexPath.section == 0) {
        cell.textLabel.text = @"零钱";
#ifdef AliAuthPay
        cell.textLabel.text = @"红包记录";
#endif
    }else if (indexPath.section == 1) {
#else
        if (indexPath.section == 0) {
#endif
            if (indexPath.row == 0) {
                cell.textLabel.text = NSLocalizedString(@"setting.autoLogin", @"automatic login");
                cell.accessoryType = UITableViewCellAccessoryNone;
                self.autoLoginSwitch.frame = CGRectMake(self.tableView.frame.size.width - (self.autoLoginSwitch.frame.size.width + 10), (cell.contentView.frame.size.height - self.autoLoginSwitch.frame.size.height) / 2, self.autoLoginSwitch.frame.size.width, self.autoLoginSwitch.frame.size.height);
                [cell.contentView addSubview:self.autoLoginSwitch];
            } else if (indexPath.row == 1)
            {
                cell.textLabel.text = NSLocalizedString(@"title.apnsSetting", @"Apns Settings");
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else if (indexPath.row == 2)
            {
                cell.textLabel.text = NSLocalizedString(@"title.buddyBlock", @"Black List");
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else if (indexPath.row == 3)
            {
                cell.textLabel.text = NSLocalizedString(@"title.debug", @"Debug");
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else if (indexPath.row == 4){
                cell.textLabel.text = NSLocalizedString(@"setting.deleteConWhenLeave", @"Delete conversation when leave a group");
                cell.accessoryType = UITableViewCellAccessoryNone;
                self.delConversationSwitch.frame = CGRectMake(self.tableView.frame.size.width - (self.delConversationSwitch.frame.size.width + 10), (cell.contentView.frame.size.height - self.delConversationSwitch.frame.size.height) / 2, self.delConversationSwitch.frame.size.width, self.delConversationSwitch.frame.size.height);
                [cell.contentView addSubview:self.delConversationSwitch];
            } else if (indexPath.row == 5) {
                cell.textLabel.text = NSLocalizedString(@"setting.autoAcceptGrupInvite", @"Auto accept group invite");
                cell.accessoryType = UITableViewCellAccessoryNone;
                self.groupInviteSwitch.frame = CGRectMake(self.tableView.frame.size.width - (self.groupInviteSwitch.frame.size.width + 10), (cell.contentView.frame.size.height - self.groupInviteSwitch.frame.size.height) / 2, self.groupInviteSwitch.frame.size.width, self.groupInviteSwitch.frame.size.height);
                [cell.contentView addSubview:self.groupInviteSwitch];
            } else if (indexPath.row == 6) {
                cell.textLabel.text = NSLocalizedString(@"setting.iospushname", @"iOS push nickname");
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else if (indexPath.row == 7) {
                cell.textLabel.text = NSLocalizedString(@"setting.personalInfo", nil);
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else if (indexPath.row == 8) {
                cell.textLabel.text = NSLocalizedString(@"setting.sortbyservertime", @"Sort message by server time");
                cell.accessoryType = UITableViewCellAccessoryNone;
                self.sortMethodSwitch.frame = CGRectMake(self.tableView.frame.size.width - (self.sortMethodSwitch.frame.size.width + 10), (cell.contentView.frame.size.height - self.sortMethodSwitch.frame.size.height) / 2, self.sortMethodSwitch.frame.size.width, self.sortMethodSwitch.frame.size.height);
                [cell.contentView addSubview:self.sortMethodSwitch];
            } else if (indexPath.row == 9) {
                cell.textLabel.text = NSLocalizedString(@"setting.call", nil);
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else if (indexPath.row == 10) {
                cell.textLabel.text = NSLocalizedString(@"setting.enableDeliveryAck", @"Whether to send delivery ack");
                cell.accessoryType = UITableViewCellAccessoryNone;
                self.deliveryAckSwitch.frame = CGRectMake(self.tableView.frame.size.width - (self.deliveryAckSwitch.frame.size.width + 10), (cell.contentView.frame.size.height - self.deliveryAckSwitch.frame.size.height) / 2, self.deliveryAckSwitch.frame.size.width, self.deliveryAckSwitch.frame.size.height);
                [cell.contentView addSubview:self.deliveryAckSwitch];
            } else if (indexPath.row == 11) {
                cell.textLabel.text = NSLocalizedString(@"setting.messageRource", @"The priority server gets the message");
                cell.accessoryType = UITableViewCellAccessoryNone;
                self.historySwitch.frame = CGRectMake(self.tableView.frame.size.width - (self.historySwitch.frame.size.width + 10), (cell.contentView.frame.size.height - self.historySwitch.frame.size.height) / 2, self.historySwitch.frame.size.width, self.historySwitch.frame.size.height);
                [cell.contentView addSubview:self.historySwitch];
            }
        }
        
        return cell;
}
    
#pragma mark - Table view delegate
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
#ifdef REDPACKET_AVALABLE
    if (indexPath.section == 0) {
        [RedpacketViewControl presentChangePocketViewControllerFromeController:self];
        return;
    }
#endif
    
    if (indexPath.row == 1) {
        YTEPushNotificationViewController *pushController = [[YTEPushNotificationViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:pushController animated:YES];
    }
    else if (indexPath.row == 2)
    {
        YTEBlackListViewController *blackController = [[YTEBlackListViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:blackController animated:YES];
    }
    else if (indexPath.row == 3)
    {
//        DebugViewController *debugController = [[DebugViewController alloc] initWithStyle:UITableViewStylePlain];
//        [self.navigationController pushViewController:debugController animated:YES];
    } else if (indexPath.row == 6) {
//        EditNicknameViewController *editName = [[EditNicknameViewController alloc] initWithNibName:nil bundle:nil];
//        [self.navigationController pushViewController:editName animated:YES];
    } else if (indexPath.row == 7){
//        UserProfileEditViewController *userProfile = [[UserProfileEditViewController alloc] initWithStyle:UITableViewStylePlain];
//        [self.navigationController pushViewController:userProfile animated:YES];
        
    } else if (indexPath.row == 9) {
//        CallSettingViewController *callSettingController = [[CallSettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
//        [self.navigationController pushViewController:callSettingController animated:YES];
    }
}
    
#pragma mark - getter
    
- (UIView *)footerView
{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
        _footerView.backgroundColor = [UIColor clearColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 0, _footerView.frame.size.width - 10, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [_footerView addSubview:line];
        
        UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, _footerView.frame.size.width - 20, 45)];
        logoutButton.accessibilityIdentifier = @"logoff";
        [logoutButton setBackgroundColor:RGBACOLOR(0xfe, 0x64, 0x50, 1)];
        NSString *username = [[EMClient sharedClient] currentUsername];
        NSString *logoutButtonTitle = [[NSString alloc] initWithFormat:NSLocalizedString(@"setting.loginUser", @"log out(%@)"), username];
        [logoutButton setTitle:logoutButtonTitle forState:UIControlStateNormal];
        [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [logoutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:logoutButton];
    }
    
    return _footerView;
}

#pragma mark - action

- (void)autoLoginChanged:(UISwitch *)autoSwitch
{
    [[EMClient sharedClient].options setIsAutoLogin:autoSwitch.isOn];
}

- (void)delConversationChanged:(UISwitch *)control
{
    [[EMClient sharedClient].options setIsDeleteMessagesWhenExitGroup:control.on];
}

- (void)groupInviteChanged:(UISwitch *)control
{
    [[EMClient sharedClient].options setIsAutoAcceptGroupInvitation:control.on];
}

- (void)sortMethodChanged:(UISwitch *)control
{
    [[EMClient sharedClient].options setSortMessageByServerTime:control.on];
}

- (void)deliveryAckChanged:(UISwitch *)control
{
    [[EMClient sharedClient].options setEnableDeliveryAck:control.on];
}

- (void)historySrouceChanged:(UISwitch *)control {
    NSUserDefaults *udefaults = [NSUserDefaults standardUserDefaults];
    [udefaults setBool:control.isOn forKey:@"isFetchHistory"];
}

- (void)refreshConfig
{
    [self.autoLoginSwitch setOn:[[EMClient sharedClient].options isAutoLogin] animated:NO];
    [self.sortMethodSwitch setOn:[[EMClient sharedClient].options sortMessageByServerTime] animated:NO];
    [self.deliveryAckSwitch setOn:[EMClient sharedClient].options.enableDeliveryAck animated:NO];
    
    [self.tableView reloadData];
}

- (void)logoutAction
{
    __weak YTESettingsViewController *weakSelf = self;
    [self showHudInView:self.view hint:NSLocalizedString(@"setting.logoutOngoing", @"loging out...")];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] logout:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideHud];
            if (error != nil) {
                [weakSelf showHint:error.errorDescription];
            }
            else{
//                [[ApplyViewController shareController] clear];
//                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
            }
        });
    });
}

@end
