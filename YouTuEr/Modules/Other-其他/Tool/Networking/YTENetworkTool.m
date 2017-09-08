//
//  YTENetworkTool.m
//  YouTuEr
//
//  Created by 苏一 on 2017/6/14.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTENetworkTool.h"

@implementation YTENetworkTool

/// 返回网络请求工具单例
+ (instancetype)sharedNetworkTool {
    
    static YTENetworkTool *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        //        NSURL *baseURL = [NSURL URLWithString:@"http://iosapi.itcast.cn/"];
        //        instance = [[self alloc] initWithBaseURL:baseURL];
        
        instance = [self manager];
        
        // 设置请求数据以JSON格式请求
        instance.requestSerializer = [AFJSONRequestSerializer serializer];
        instance.responseSerializer = [AFJSONResponseSerializer serializer];
        // 修改响应解析器能够解析的数据类型
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", @"text/html",nil];
    });
    return instance;
    
}
@end
