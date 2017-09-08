//
//  YTEChatHelper.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/9/7.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTEConversationListController.h"
#import "YTEContactListViewController.h"
#import "YTETabBarController.h"
#import "YTEChatViewController.h"

#define kHaveUnreadAtMessage    @"kHaveAtMessage"
#define kAtYouMessage           1
#define kAtAllMessage           2

@interface YTEChatHelper : NSObject <EMClientDelegate, EMChatManagerDelegate, EMContactManagerDelegate, EMGroupManagerDelegate, EMChatroomManagerDelegate>

@property (nonatomic, weak) YTEContactListViewController *contactViewVC;

@property (nonatomic, weak) YTEConversationListController *conversationListVC;

@property (nonatomic, weak) YTETabBarController *mainVC;

@property (nonatomic, weak) YTEChatViewController *chatVC;

+ (instancetype)shareHelper;

- (void)asyncPushOptions;

- (void)asyncGroupFromServer;

- (void)asyncConversationFromDB;

- (BOOL)isFetchHistoryChange;

@end
