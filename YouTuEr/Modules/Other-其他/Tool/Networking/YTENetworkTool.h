//
//  YTENetworkTool.h
//  YouTuEr
//
//  Created by 苏一 on 2017/6/14.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface YTENetworkTool : AFHTTPSessionManager

/// 返回网络请求工具单例
+ (instancetype)sharedNetworkTool;

@end
