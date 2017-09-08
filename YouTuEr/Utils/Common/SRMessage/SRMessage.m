//
//  SRMessage.m
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/7/28.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRMessage.h"
#import "MBProgressHUD.h"

@interface SRMessage ()

@property (weak, nonatomic) MBProgressHUD *currentShownHUD;


@end

@implementation SRMessage

+ (instancetype)sharedMessage {
    static SRMessage *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SRMessage alloc] init];
    });
    return instance;
}

- (void)showMessage:(NSString *)message withType:(MessageType)type {
    if (self.currentShownHUD) {
        [self.currentShownHUD hide:YES];
    }
    [self createMessageViewWithMessage:message withType:type];
}

#pragma mark - private
- (void)createMessageViewWithMessage:(NSString *)message withType:(MessageType)type {
    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:[UIApplication sharedApplication].keyWindow];
    [HUD setUserInteractionEnabled:NO];
    [HUD setRemoveFromSuperViewOnHide:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    
    // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
    switch (type) {
        case MessageTypeSucceeded:
            //            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"message_succeed"]];
            HUD.mode = MBProgressHUDModeCustomView;
            break;
        case MessageTypeError:
            //            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"message_error"]];
            HUD.mode = MBProgressHUDModeCustomView;
            break;
        case MessageTypeDownloading:
            //            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"message_download"]];
            HUD.mode = MBProgressHUDModeCustomView;
            break;
        case MessageTypeNotice:
            HUD.mode = MBProgressHUDModeText;
            break;
        default:
            break;
    }
    NSString *mutableLineString = [[message replaceAll:@"," with:@"\n"] replaceAll:@"，" with:@"\n"];
    HUD.detailsLabelFont = [UIFont systemFontOfSize:14.0f];
    HUD.detailsLabelText = mutableLineString;
    [HUD show:YES];
    [HUD hide:YES afterDelay:2.0];
    self.currentShownHUD = HUD;
}


@end
