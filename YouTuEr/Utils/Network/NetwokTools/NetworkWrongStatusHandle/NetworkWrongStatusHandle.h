//
//  NetworkWrongStatusHandle.h
//
//  Created by GaoCheng.Zou on 2017/4/14.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkDefinition.h"

@interface NetworkWrongStatusHandle : NSObject

/**
 根据不同的错误进行处理
 */
+ (void)checkNetworkCode:(NetworkErrorStatus)code
                errorMsg:(NSString *)errorMsg
            hideErrorTip:(BOOL)hide;

@end
