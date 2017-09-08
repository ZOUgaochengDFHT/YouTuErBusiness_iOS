//
//  NetworkWrongStatusHandle.m
//
//  Created by GaoCheng.Zou on 2017/4/14.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "NetworkWrongStatusHandle.h"

@implementation NetworkWrongStatusHandle

+ (void)checkNetworkCode:(NetworkErrorStatus)code
                errorMsg:(NSString *)errorMsg
            hideErrorTip:(BOOL)hide {
    if (hide) return;
    switch (code) {
        case Network_netless:
        {
            
        }
            break;
        case Network_misdata:
        {
            
        }
            break;
        case Network_badResult:
        {
            if (!errorMsg) {
                errorMsg = kErrorMsg[@(kNetServiceError)];
            }
            [[SRMessage sharedMessage] showMessage:errorMsg withType:MessageTypeError];
        }
            break;
        default:
            
            break;
    }
}

@end
