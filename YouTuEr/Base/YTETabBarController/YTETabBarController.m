//
//  YTETabBarController.m
//  YouTuEr
//
//  Created by ss on 17/2/18.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTETabBarController.h"
#import "YTENavigationController.h"
#import "YTEHomeController.h"
#import "YTEB&OController.h"
#import "YTEConversationListController.h"
#import "YTEMineController.h"
#import "YTERegisterViewController.h"
#import "YTELoginController.h"
#import "UserProfileManager.h"
#import <UserNotifications/UserNotifications.h>
#import "YTEApplyViewController.h"

#define ATETabBarTitleNormalColor    SR_RGBCOLOR(16, 16, 16)
//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";

@interface YTETabBarController () <UITabBarControllerDelegate> {
    int _tagIndex;
    EMConnectionState _connectionState;
}

@property (strong, nonatomic) YTEConversationListController *chatListVC;
@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@end

@implementation YTETabBarController

#pragma mark - View Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDelegate:self];
    // 设置tabBarItem被选中时的颜色
    [self.tabBar setTintColor:YTEDominantColor];
    // 设置子控制器
    [self setupChildVCs];
    
    [YTENotifiCenter addObserver:self
                        selector:@selector(setupUnreadMessageCount)
                            name:YTESETUPUNREADMESSAGECOUNTNOTIFICATION
                          object:nil];
    [self setupUnreadMessageCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initializer

- (void)setupChildVCs {
    [self addChildVC:[[YTEHomeController alloc] init] title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    [self addChildVC:[[YTEB_OController alloc] init] title:@"订单" imageName:@"tabbar_order" selectedImageName:@"tabbar_order_selected"];
    [self addChildVC:self.chatListVC title:@"消息" imageName:@"tabbar_news" selectedImageName:@"tabbar_news_selected"];
    [self addChildVC:[[YTEMineController alloc] init] title:@"我的" imageName:@"tabbar_mine" selectedImageName:@"tabbar_mine_selected"];
}

- (void)addChildVC:(UIViewController *)VC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    YTENavigationController *nav = [[YTENavigationController alloc] initWithRootViewController:VC];
    [self addChildViewController:nav];
    [nav.tabBarItem setTitle:title];
    [nav.tabBarItem setTag:_tagIndex];
    _tagIndex++;
    [nav.tabBarItem setImage:SR_IMGName(imageName)];
    [nav.tabBarItem setSelectedImage:SR_IMGName(selectedImageName)];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : ATETabBarTitleNormalColor}
                              forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : YTEDominantColor}
                              forState:UIControlStateSelected];
}




#pragma mark - UITabBarControllerDelegate

/**
 iOS中用户未登录状态下点击下方tabBar触发登录
 */
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//    if (viewController.tabBarItem.tag == 3) {
//        YTELoginController *initViewController = [[YTELoginController alloc]init];
//        YTENavigationController *nav = [[YTENavigationController alloc]initWithRootViewController:initViewController];
//        [tabBarController.selectedViewController presentViewController:nav animated:YES completion:nil];
//        return NO;
//    }
    return YES;
}

#pragma mark - Public
- (void)setupUnreadMessageCount {
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    if (_chatListVC) {
        if (unreadCount > 0) {
            _chatListVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)unreadCount];
        }else{
            _chatListVC.tabBarItem.badgeValue = nil;
        }
    }
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
}


- (void)networkChanged:(EMConnectionState)connectionState {
    _connectionState = connectionState;
    [_chatListVC networkChanged:connectionState];
}

- (void)playSoundAndVibration {
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    [[EMCDDeviceManager sharedInstance] playVibration];
}


- (void)showNotificationWithMessage:(EMMessage *)message {
    EMPushOptions *options = [[EMClient sharedClient] pushOptions];
    NSString *alertBody = nil;
    if (options.displayStyle == EMPushDisplayStyleMessageSummary) {
        EMMessageBody *messageBody = message.body;
        NSString *messageStr = nil;
        switch (messageBody.type) {
            case EMMessageBodyTypeText:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case EMMessageBodyTypeImage:
            {
                messageStr = NSLocalizedString(@"message.image", @"Image");
            }
                break;
            case EMMessageBodyTypeLocation:
            {
                messageStr = NSLocalizedString(@"message.location", @"Location");
            }
                break;
            case EMMessageBodyTypeVoice:
            {
                messageStr = NSLocalizedString(@"message.voice", @"Voice");
            }
                break;
            case EMMessageBodyTypeVideo:{
                messageStr = NSLocalizedString(@"message.video", @"Video");
            }
                break;
            default:
                break;
        }
        
        do {
            NSString *title = [[UserProfileManager sharedInstance] getNickNameWithUsername:message.from];
            if (message.chatType == EMChatTypeGroupChat) {
                NSDictionary *ext = message.ext;
                if (ext && ext[kGroupMessageAtList]) {
                    id target = ext[kGroupMessageAtList];
                    if ([target isKindOfClass:[NSString class]]) {
                        if ([kGroupMessageAtAll compare:target options:NSCaseInsensitiveSearch] == NSOrderedSame) {
                            alertBody = [NSString stringWithFormat:@"%@%@", title, NSLocalizedString(@"group.atPushTitle", @" @ me in the group")];
                            break;
                        }
                    }
                    else if ([target isKindOfClass:[NSArray class]]) {
                        NSArray *atTargets = (NSArray*)target;
                        if ([atTargets containsObject:[EMClient sharedClient].currentUsername]) {
                            alertBody = [NSString stringWithFormat:@"%@%@", title, NSLocalizedString(@"group.atPushTitle", @" @ me in the group")];
                            break;
                        }
                    }
                }
                NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
                for (EMGroup *group in groupArray) {
                    if ([group.groupId isEqualToString:message.conversationId]) {
                        title = [NSString stringWithFormat:@"%@(%@)", message.from, group.subject];
                        break;
                    }
                }
            }
            else if (message.chatType == EMChatTypeChatRoom)
            {
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                NSString *key = [NSString stringWithFormat:@"OnceJoinedChatrooms_%@", [[EMClient sharedClient] currentUsername]];
                NSMutableDictionary *chatrooms = [NSMutableDictionary dictionaryWithDictionary:[ud objectForKey:key]];
                NSString *chatroomName = [chatrooms objectForKey:message.conversationId];
                if (chatroomName)
                {
                    title = [NSString stringWithFormat:@"%@(%@)", message.from, chatroomName];
                }
            }
            
            alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
        } while (0);
    }
    else{
        alertBody = NSLocalizedString(@"receiveMessage", @"you have a new message");
    }
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
    BOOL playSound = NO;
    if (!self.lastPlaySoundDate || timeInterval >= kDefaultPlaySoundInterval) {
        self.lastPlaySoundDate = [NSDate date];
        playSound = YES;
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:message.chatType] forKey:kMessageType];
    [userInfo setObject:message.conversationId forKey:kConversationChatter];
    
    //发送本地推送
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.01 repeats:NO];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        if (playSound) {
            content.sound = [UNNotificationSound defaultSound];
        }
        content.body =alertBody;
        content.userInfo = userInfo;
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:message.messageId content:content trigger:trigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
    }
    else {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [NSDate date]; //触发通知的时间
        notification.alertBody = alertBody;
        notification.alertAction = NSLocalizedString(@"open", @"Open");
        notification.timeZone = [NSTimeZone defaultTimeZone];
        if (playSound) {
            notification.soundName = UILocalNotificationDefaultSoundName;
        }
        notification.userInfo = userInfo;
        
        //发送通知
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}


#pragma mark - Getter 

- (YTEConversationListController *)chatListVC {
    if (!_chatListVC) _chatListVC = [[YTEConversationListController alloc] init];
    return _chatListVC;
}

@end
