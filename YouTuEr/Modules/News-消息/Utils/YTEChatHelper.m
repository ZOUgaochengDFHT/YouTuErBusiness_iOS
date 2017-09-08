//
//  YTEChatHelper.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/9/7.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEChatHelper.h"
#import "AppDelegate.h"
#import "YTEApplyViewController.h"
#import "MBProgressHUD.h"
#import <UserNotifications/UserNotifications.h>


static YTEChatHelper *helper = nil;

@implementation YTEChatHelper

- (void)dealloc {
    [[EMClient sharedClient] removeDelegate:self];
    [[EMClient sharedClient].groupManager removeDelegate:self];
    [[EMClient sharedClient].contactManager removeDelegate:self];
    [[EMClient sharedClient].roomManager removeDelegate:self];
    [[EMClient sharedClient].chatManager removeDelegate:self];
}

#pragma mark - Initalizer

+ (instancetype)shareHelper {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[YTEChatHelper alloc] init];
    });
    return helper;
}

- (id)init {
    self = [super init];
    if (self) {
        [self initHelper];
    }
    return self;
}

- (void)initHelper {
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].groupManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].roomManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}

#pragma mark - EMClientDelegate

// 网络状态变化回调
- (void)didConnectionStateChanged:(EMConnectionState)connectionState {
    [self.mainVC networkChanged:connectionState];
}

- (void)autoLoginDidCompleteWithError:(EMError *)error {
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"自动登录失败，请重新登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alertView.tag = 100;
        [alertView show];
    } else if([[EMClient sharedClient] isConnected]){
        UIView *view = self.mainVC.view;
        [MBProgressHUD showHUDAddedTo:view animated:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            BOOL flag = [[EMClient sharedClient] migrateDatabaseToLatestSDK];
            if (flag) {
                [self asyncGroupFromServer];
                [self asyncConversationFromDB];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideAllHUDsForView:view animated:YES];
            });
        });
    }
}

- (void)userAccountDidLoginFromOtherDevice {
    [self _clearHelper];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"loginAtOtherDevice", @"your login account has been in other places") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    [alertView show];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
}

- (void)userAccountDidRemoveFromServer {
    [self _clearHelper];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"loginUserRemoveFromServer", @"your account has been removed from the server side") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    [alertView show];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
}

- (void)userDidForbidByServer {
    [self _clearHelper];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"servingIsBanned", @"Serving is banned") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    [alertView show];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
}

- (void)userAccountDidForcedToLogout:(EMError *)aError {
    [self _clearHelper];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:aError.errorDescription delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    [alertView show];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
}

#pragma mark - EMChatManagerDelegate

- (void)didUpdateConversationList:(NSArray *)aConversationList {
    if (self.mainVC) {
        [_mainVC setupUnreadMessageCount];
    }
    
    if (self.conversationListVC) {
        [_conversationListVC refreshDataSource];
    }
}

- (void)didReceiveMessages:(NSArray *)aMessages {
    BOOL isRefreshCons = YES;
    for(EMMessage *message in aMessages){
        BOOL needShowNotification = (message.chatType != EMChatTypeChat) ? [self _needShowNotification:message.conversationId] : YES;
        
        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
        if (needShowNotification) {
#if !TARGET_IPHONE_SIMULATOR
            switch (state) {
                case UIApplicationStateActive:
                    [self.mainVC playSoundAndVibration];
                    break;
                case UIApplicationStateInactive:
                    [self.mainVC playSoundAndVibration];
                    break;
                case UIApplicationStateBackground:
                    [self.mainVC showNotificationWithMessage:message];
                    break;
                default:
                    break;
            }
#endif
        }
        
        if (_chatVC == nil) {
            _chatVC = [self _getCurrentChatView];
        }
        BOOL isChatting = NO;
        if (_chatVC) {
            isChatting = [message.conversationId isEqualToString:_chatVC.conversation.conversationId];
        }
        if (_chatVC == nil || !isChatting || state == UIApplicationStateBackground) {
            [self _handleReceivedAtMessage:message];
            
            if (self.conversationListVC) {
                [_conversationListVC refresh];
            }
            
            if (self.mainVC) {
                [_mainVC setupUnreadMessageCount];
            }
            return;
        }
        
        if (isChatting) {
            isRefreshCons = NO;
        }
    }
    
    if (isRefreshCons) {
        if (self.conversationListVC) {
            [_conversationListVC refresh];
        }
        
        if (self.mainVC) {
            [_mainVC setupUnreadMessageCount];
        }
    }
}

- (void)messagesDidRecall:(NSArray *)aMessages {
    for (EMMessage *msg in aMessages) {
        NSString *text;
        if ([msg.from isEqualToString:[EMClient sharedClient].currentUsername]) {
            text = [NSString stringWithFormat:NSLocalizedString(@"message.recall", @"You recall a message")];
        } else {
            text = [NSString stringWithFormat:NSLocalizedString(@"message.recallByOthers", @"%@ recall a message"),msg.from];
        }
        EMMessage *message = [EaseSDKHelper sendTextMessage:text to:msg.conversationId messageType:msg.chatType messageExt:@{@"em_recall":@(YES)}];
        message.isRead = YES;
        [message setTimestamp:msg.timestamp];
        [message setLocalTime:msg.localTime];
        EMConversationType conversatinType = EMConversationTypeChat;
        switch (msg.chatType) {
            case EMChatTypeChat:
                conversatinType = EMConversationTypeChat;
                break;
            case EMChatTypeGroupChat:
                conversatinType = EMConversationTypeGroupChat;
                break;
            case EMChatTypeChatRoom:
                conversatinType = EMConversationTypeChatRoom;
                break;
            default:
                break;
        }
        EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:msg.conversationId type:conversatinType createIfNotExist:NO];
        NSDictionary *dict = msg.ext;
        if (dict && [dict objectForKey:@"em_at_list"]) {
            NSArray *atList = [dict objectForKey:@"em_at_list"];
            if ([atList containsObject:[EMClient sharedClient].currentUsername]) {
                NSMutableDictionary *conversationExt = conversation.ext ? [conversation.ext mutableCopy] : [NSMutableDictionary dictionary];
                [conversationExt removeObjectForKey:kHaveUnreadAtMessage];
                conversation.ext = conversationExt;
            }
        }
        [conversation insertMessage:message error:nil];
    }
    
    if (self.conversationListVC) {
        [_conversationListVC refresh];
    }
    
    if (self.mainVC) {
        [_mainVC setupUnreadMessageCount];
    }
}

#pragma mark - EMContactManagerDelegate

- (void)didReceiveAgreedFromUsername:(NSString *)aUsername {
    NSString *msgstr = [NSString stringWithFormat:@"%@同意了加好友申请", aUsername];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msgstr delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"Ok") otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)didReceiveDeclinedFromUsername:(NSString *)aUsername {
    NSString *msgstr = [NSString stringWithFormat:@"%@拒绝了加好友申请", aUsername];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msgstr delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"Ok") otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)didReceiveDeletedFromUsername:(NSString *)aUsername {
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:_mainVC.navigationController.viewControllers];
    YTEChatViewController *chatViewContrller = nil;
    for (id viewController in viewControllers) {
        if ([viewController isKindOfClass:[YTEChatViewController class]] && [aUsername isEqualToString:[(YTEChatViewController *)viewController conversation].conversationId])
        {
            chatViewContrller = viewController;
            break;
        }
    }
    if (chatViewContrller) {
        [viewControllers removeObject:chatViewContrller];
        if ([viewControllers count] > 0) {
            [_mainVC.navigationController setViewControllers:@[viewControllers[0]] animated:YES];
        } else {
            [_mainVC.navigationController setViewControllers:viewControllers animated:YES];
        }
    }
    [_mainVC showHint:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"delete", @"delete"), aUsername]];
    [_contactViewVC reloadDataSource];
}

- (void)didReceiveAddedFromUsername:(NSString *)aUsername {
    [_contactViewVC reloadDataSource];
}

- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage {
    if (!aUsername) {
        return;
    }
    
    if (!aMessage) {
        aMessage = [NSString stringWithFormat:NSLocalizedString(@"friend.somebodyAddWithName", @"%@ add you as a friend"), aUsername];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":aUsername, @"username":aUsername, @"applyMessage":aMessage, @"applyStyle":[NSNumber numberWithInteger:ApplyStyleFriend]}];
    [[YTEApplyViewController shareController] addNewApply:dic];
    if (self.mainVC) {
//        [self.mainVC setupUntreatedApplyCount];
#if !TARGET_IPHONE_SIMULATOR
        [self.mainVC playSoundAndVibration];
        
        BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
        if (!isAppActivity) {
            //发送本地推送
            if (NSClassFromString(@"UNUserNotificationCenter")) {
                UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.01 repeats:NO];
                UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
                content.sound = [UNNotificationSound defaultSound];
                content.body =[NSString stringWithFormat:NSLocalizedString(@"friend.somebodyAddWithName", @"%@ add you as a friend"), aUsername];
                UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:[[NSNumber numberWithDouble:[NSDate timeIntervalSinceReferenceDate] * 1000] stringValue] content:content trigger:trigger];
                [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
            }
            else {
                UILocalNotification *notification = [[UILocalNotification alloc] init];
                notification.fireDate = [NSDate date]; //触发通知的时间
                notification.alertBody = [NSString stringWithFormat:NSLocalizedString(@"friend.somebodyAddWithName", @"%@ add you as a friend"), aUsername];
                notification.alertAction = NSLocalizedString(@"open", @"Open");
                notification.timeZone = [NSTimeZone defaultTimeZone];
            }
        }
#endif
    }
    [_contactViewVC reloadApplyView];
}


#pragma mark - Public

- (void)asyncPushOptions {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = nil;
        [[EMClient sharedClient] getPushOptionsFromServerWithError:&error];
    });
}

- (void)asyncGroupFromServer {
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[EMClient sharedClient].groupManager getJoinedGroups];
        EMError *error = nil;
        [[EMClient sharedClient].groupManager getJoinedGroupsFromServerWithPage:0 pageSize:-1 error:&error];
        if (!error) {
            if (weakself.contactViewVC) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.contactViewVC reloadGroupView];
                });
            }
        }
    });
}


- (void)asyncConversationFromDB {
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *array = [[EMClient sharedClient].chatManager getAllConversations];
        [array enumerateObjectsUsingBlock:^(EMConversation *conversation, NSUInteger idx, BOOL *stop){
            if(conversation.latestMessage == nil){
                [[EMClient sharedClient].chatManager deleteConversation:conversation.conversationId isDeleteMessages:NO completion:nil];
            }
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakself.conversationListVC) {
                [weakself.conversationListVC refreshDataSource];
            }
            
            if (weakself.mainVC) {
                [weakself.mainVC setupUnreadMessageCount];
            }
        });
    });
}

- (BOOL)isFetchHistoryChange {
    NSUserDefaults *uDefaults = [NSUserDefaults standardUserDefaults];
    return [uDefaults boolForKey:@"isFetchHistory"];
}

#pragma mark - Private

- (void)_clearHelper {
    self.mainVC = nil;
    self.conversationListVC = nil;
    self.chatVC = nil;
    self.contactViewVC = nil;
    [[EMClient sharedClient] logout:NO];
}


- (YTEChatViewController*)_getCurrentChatView {
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:_mainVC.navigationController.viewControllers];
    YTEChatViewController *chatViewContrller = nil;
    for (id viewController in viewControllers) {
        if ([viewController isKindOfClass:[YTEChatViewController class]]) {
            chatViewContrller = viewController;
            break;
        }
    }
    return chatViewContrller;
}

- (BOOL)_needShowNotification:(NSString *)fromChatter {
    BOOL ret = YES;
    NSArray *igGroupIds = [[EMClient sharedClient].groupManager getGroupsWithoutPushNotification:nil];
    for (NSString *str in igGroupIds) {
        if ([str isEqualToString:fromChatter]) {
            ret = NO;
            break;
        }
    }
    return ret;
}

- (void)_handleReceivedAtMessage:(EMMessage*)aMessage
{
    if (aMessage.chatType != EMChatTypeGroupChat || aMessage.direction != EMMessageDirectionReceive) {
        return;
    }
    
    NSString *loginUser = [EMClient sharedClient].currentUsername;
    NSDictionary *ext = aMessage.ext;
    EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:aMessage.conversationId type:EMConversationTypeGroupChat createIfNotExist:NO];
    if (loginUser && conversation && ext && [ext objectForKey:kGroupMessageAtList]) {
        id target = [ext objectForKey:kGroupMessageAtList];
        if ([target isKindOfClass:[NSString class]] && [(NSString*)target compare:kGroupMessageAtAll options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            NSNumber *atAll = conversation.ext[kHaveUnreadAtMessage];
            if ([atAll intValue] != kAtAllMessage) {
                NSMutableDictionary *conversationExt = conversation.ext ? [conversation.ext mutableCopy] : [NSMutableDictionary dictionary];
                [conversationExt removeObjectForKey:kHaveUnreadAtMessage];
                [conversationExt setObject:@kAtAllMessage forKey:kHaveUnreadAtMessage];
                conversation.ext = conversationExt;
            }
        }
        else if ([target isKindOfClass:[NSArray class]]) {
            if ([target containsObject:loginUser]) {
                if (conversation.ext[kHaveUnreadAtMessage] == nil) {
                    NSMutableDictionary *conversationExt = conversation.ext ? [conversation.ext mutableCopy] : [NSMutableDictionary dictionary];
                    [conversationExt setObject:@kAtYouMessage forKey:kHaveUnreadAtMessage];
                    conversation.ext = conversationExt;
                }
            }
        }
    }
}


#pragma mark - Setter & Getter


@end
