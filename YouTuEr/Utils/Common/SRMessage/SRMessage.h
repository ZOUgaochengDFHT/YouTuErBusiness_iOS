//
//  SRMessage.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/7/28.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, MessageType) {
    MessageTypeSucceeded    = 0,
    MessageTypeError        = 1,
    MessageTypeWarning      = 2,
    MessageTypeDownloading  = 3,
    MessageTypeNotice       = 4
};

@interface SRMessage : NSObject

+ (instancetype)sharedMessage;

- (void)showMessage:(NSString *)msg withType:(MessageType)type;

@end
