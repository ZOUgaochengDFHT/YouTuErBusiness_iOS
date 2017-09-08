//
//  ReachabilityManager.m
//
//  Created by GaoCheng.Zou on 2017/4/14.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRReachabilityManager.h"
#import "NetworkDefinition.h"

#define AFNetworkReachabilityStatusUndefined -2

@implementation SRReachabilityManager

+ (BOOL)networkIsReachable {
    [[SRReachabilityManager sharedManager] startMonitor];
    if ([SRReachabilityManager sharedManager].status == AFNetworkReachabilityStatusNotReachable) {
        [[SRMessage sharedMessage] showMessage:kErrorMsg[@(kNetErrorUnreachable)] withType:MessageTypeError];
        return NO;
    }
    return YES;
}

+ (SRReachabilityManager *)sharedManager {
    static SRReachabilityManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [SRReachabilityManager new];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _oldStatus = AFNetworkReachabilityStatusUndefined;
    }
    return self;
}

- (void)startMonitor {
    _status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNetworkReachabilityChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}


- (void)onNetworkReachabilityChange:(NSNotification *)notification {
    _status = [notification.userInfo[AFNetworkingReachabilityNotificationStatusItem] intValue];
    if (_oldStatus == AFNetworkReachabilityStatusUndefined || _oldStatus == _status) {
        _oldStatus = _status;
        return;
    }
    
    _oldStatus = _status;
    if (_status == AFNetworkReachabilityStatusNotReachable) {
        // Network is not reachable
        
    } else {
        
    }
}

@end
