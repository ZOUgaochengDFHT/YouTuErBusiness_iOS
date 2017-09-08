//
//  YTETabBarController.h
//  YouTuEr
//
//  Created by ss on 17/2/18.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTETabBarController : UITabBarController

- (void)setupUnreadMessageCount;

- (void)networkChanged:(EMConnectionState)connectionState;

- (void)playSoundAndVibration;

- (void)showNotificationWithMessage:(EMMessage *)message;
@end
