//
//  ReachabilityManager.h
//
//  Created by GaoCheng.Zou on 2017/4/14.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface SRReachabilityManager : NSObject {
    AFNetworkReachabilityStatus _oldStatus;
}

@property (nonatomic, assign, readonly) AFNetworkReachabilityStatus status;

+ (SRReachabilityManager *)sharedManager;

- (void)startMonitor;

+ (BOOL)networkIsReachable;


@end
