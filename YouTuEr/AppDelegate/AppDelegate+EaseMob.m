//
//  AppDelegate+EaseMob.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/9/13.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "AppDelegate+EaseMob.h"
#import "YTEChatHelper.h"
#import "YTENavigationController.h"
#import "YTELoginController.h"
#import "YTEFillInDataViewController.h"

@implementation AppDelegate (EaseMob)

#pragma mark - Public

- (void)easemobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
                    appkey:(NSString *)appkey
              apnsCertName:(NSString *)apnsCertName
               otherConfig:(NSDictionary *)otherConfig {
    
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    // 集成环信SDK
    EMOptions *options = [EMOptions optionsWithAppkey:appkey];
    [options setApnsCertName:apnsCertName];
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    [[EaseSDKHelper shareHelper] hyphenateApplication:application
                        didFinishLaunchingWithOptions:launchOptions
                                               appkey:appkey
                                         apnsCertName:apnsCertName
                                          otherConfig:@{@"httpsOnly":[NSNumber numberWithBool:YES], kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES],@"easeSandBox":[NSNumber numberWithBool:YES]}];
    
    /**
     *  iOS8以上 注册APNs
     */
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
    
    [YTEChatHelper shareHelper];
    
}


- (void)easemobApplication:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[EaseSDKHelper shareHelper] hyphenateApplication:application didReceiveRemoteNotification:userInfo];
}

#pragma mark - App Delegate

// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[EMClient sharedClient] bindDeviceToken:deviceToken];
    });
}

// 注册deviceToken失败，此处失败，与环信SDK无关，一般是您的环境配置或者证书配置有误
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns.failToRegisterApns", Fail to register apns)
                                                    message:error.description
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - login changed

- (void)loginStateChange:(NSNotification *)notification {
    if ([notification.object isKindOfClass:[NSDictionary class]]) {
        [self performBlock:^{
            [[SRMessage sharedMessage] showMessage:notification.object[kDataJSONKey_Msg] withType:MessageTypeNotice];
        } afterDelay:0.5];
        [[SRUserDefaultManager sharedManager] setObject:notification.object[SR_CLINETID] forKey:SR_CLINETID];
        [[SRUserDefaultManager sharedManager] setObject:notification.object[SR_AUTHEN] forKey:SR_AUTHEN];
        [[SRUserDefaultManager sharedManager] setObject:notification.object[SR_HASPROFILE] forKey:SR_HASPROFILE];
        self.window.rootViewController = [notification.object[SR_HASPROFILE] isEqual:@"true"] ?  [[YTETabBarController alloc] init] : [[YTENavigationController alloc] initWithRootViewController:[[YTEFillInDataViewController alloc] init]];
    } else {
        self.window.rootViewController = [[YTENavigationController alloc] initWithRootViewController:[[YTELoginController alloc] init]];
        [[SRUserDefaultManager sharedManager] removeObjectForKey:SR_CLINETID];
        [[EMClient sharedClient] logout:YES];
    }

}

@end
