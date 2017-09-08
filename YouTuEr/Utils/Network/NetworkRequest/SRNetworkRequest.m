//
//  NetworkRequest.m
//
//  Created by GaoCheng.Zou on 2017/4/14.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import "SRNetworkRequest.h"
#import "NSObject+SafeBlock.h"
#import "SRAppManager.h"

@interface SRNetworkRequest ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
/**
 存储所有请求，方便移除单个请求
 */
@property (nonatomic, strong) NSMutableArray *requests;



@end

@implementation SRNetworkRequest

#pragma mark - Public Methods

+ (SRNetworkRequest *)sharedNetworkRequest {
    static SRNetworkRequest *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [SRNetworkRequest new];
    });
    return instance;
}

#pragma maek - Request

- (NSURLSessionDataTask *)requestWithModel:(SRRequestModel *)requestModel
                              successBlock:(NetworkRequestSuccessBlock)successBlock
                              failureBlock:(NetworkRequestFailureBlock)failureBlock {
    
    // Complete the parameters
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[requestModel yy_modelToJSONObject]];
    [parameters setValuesForKeysWithDictionary:self.commonParams];
    
    NSURLSessionDataTask *dataTask = nil;
    [parameters setObject:[SRAppManager sharedManager].member_id forKey:@"member_id"];
    switch (requestModel.requestType) {
        case NetworkRequestGet: {
            dataTask = [self requestWithGet:requestModel.url parameters:parameters cls:requestModel.cls hideErrorTip:requestModel.hideErrorTip successBlock:successBlock failureBlock:failureBlock];
        }
            break;
        default: {
            dataTask = [self requestWithPost:requestModel.url parameters:parameters cls:requestModel.cls hideErrorTip:requestModel.hideErrorTip successBlock:successBlock failureBlock:failureBlock];
        }
            break;
    }
    [self.requests addObject:dataTask];
    return dataTask;
}

- (NSURLSessionDataTask *)requestWithGet:(NSString *)url
                              parameters:(NSDictionary *)parameters
                                     cls:(Class)cls
                            hideErrorTip:(BOOL)hide
                            successBlock:(NetworkRequestSuccessBlock)successBlock
                            failureBlock:(NetworkRequestFailureBlock)failureBlock {
    NSLog(@"%@", url);
    NSLog(@"%@", parameters);
    @weakify(self);
    NSURLSessionDataTask *dataTask = [self.sessionManager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        @strongify(self);
        [self handleRequestSuccess:responseObject dataTask:nil hideErrorTip:hide cls:cls withSuccessHandler:successBlock withFailureHandler:failureBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        @strongify(self);
        NSLog(@"error :%@", error);
        [self handleRequestFailure:nil hideErrorTip:hide failureBlock:failureBlock];
    }];
    
    
    
    return dataTask;
}

- (NSURLSessionDataTask *)requestWithPost:(NSString *)url
                               parameters:(NSDictionary *)parameters
                                      cls:(Class)cls
                             hideErrorTip:(BOOL)hide
                             successBlock:(NetworkRequestSuccessBlock)successBlock
                             failureBlock:(NetworkRequestFailureBlock)failureBlock {
    NSLog(@"%@", url);
    NSLog(@"%@", parameters);
    @weakify(self);
    NSURLSessionDataTask *dataTask = [self.sessionManager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self);
        [self handleRequestSuccess:responseObject dataTask:nil hideErrorTip:hide cls:cls withSuccessHandler:successBlock withFailureHandler:failureBlock];
    }   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        @strongify(self);
        NSLog(@"error :%@", error);
        [self handleRequestFailure:nil hideErrorTip:hide failureBlock:failureBlock];
    }];
    return dataTask;
}


- (NSURLSessionDataTask *)uploadRequestWithModel:(SRRequestModel *)requestModel
                                        fileData:(NSData *)fileData
                                    successBlock:(NetworkRequestSuccessBlock)successBlock
                                    failureBlock:(NetworkRequestFailureBlock)failureBlock {
    NSDictionary *parameters = [requestModel yy_modelToJSONObject];
    @weakify(self);
    NSURLSessionDataTask *dataTask = [self.sessionManager POST:requestModel.url parameters:parameters  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:@"file" fileName:@"YouTuEr.png" mimeType:@"image/png"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self);
        [self handleRequestSuccess:responseObject dataTask:nil hideErrorTip:requestModel.hideErrorTip cls:requestModel.cls withSuccessHandler:successBlock withFailureHandler:failureBlock];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        @strongify(self);
        NSLog(@"error :%@", error);
        [self handleRequestFailure:nil hideErrorTip:requestModel.hideErrorTip failureBlock:failureBlock];
    }];
    
    return dataTask;
}

#pragma mark - 初始化sessionManager

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.completionQueue = create_complete_handle_queue();
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", @"text/html",nil];

        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [securityPolicy setValidatesDomainName:NO];
        [securityPolicy setAllowInvalidCertificates:YES];
        _sessionManager.securityPolicy = securityPolicy;
    }
    return _sessionManager;
}


- (NSMutableArray *)requests {
    if (!_requests) {
        _requests = [NSMutableArray new];
    }
    return _requests;
}

#pragma mark - 取消网络请求
- (void)cancelAllNetworkRequest {
    for (NSURLSessionTask *task in self.requests) {
        if (task.state == NSURLSessionTaskStateRunning) {
            // cancel之后会走失败block，而失败的block里已经将该task移除了，所以这里不需要移除。
            [task cancel];
        }
    }
}

- (void)cancelNetworkRequestWithTask:(NSURLSessionTask *)task {
    if (task.state == NSURLSessionTaskStateRunning) {
        for (NSURLSessionTask *taskTemp in self.requests) {
            if ([task isEqual:taskTemp]) {
                [task cancel];
                return;
            }
        }
    }
}

#pragma mark -- Private
- (void)handleRequestSuccess:(id)responseObject
                    dataTask:(NSURLSessionDataTask *)dataTask
                hideErrorTip:(BOOL)hide
                         cls:(Class)cls
          withSuccessHandler:(NetworkRequestSuccessBlock)successBlock
          withFailureHandler:(NetworkRequestFailureBlock)failureBlock {
    NSLog(@"responseObject :%@", responseObject);
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([responseObject[kDataJSONKey_Code] integerValue] == kSRRequestSuccessCode) {
            [self successBlock:successBlock returnData:responseObject cls:cls task:dataTask];
        }else {
            if(![responseObject[kDataJSONKey_Msg] isKindOfClass:[NSNull class]]) {
                [[SRMessage sharedMessage] showMessage:responseObject[kDataJSONKey_Msg] withType:MessageTypeNotice];
            }
            [self failureBlock:failureBlock errorMsg:nil errorStatus:Network_misdata hideErroeTip:hide task:nil];
            [self.requests removeObject:dataTask];
            
        }
    });
    
}

- (void)handleRequestFailure:(NSURLSessionDataTask *)dataTask
                hideErrorTip:(BOOL)hide
                failureBlock:(NetworkRequestFailureBlock)failureBlock {
    [self failureBlock:failureBlock errorMsg:nil errorStatus:Network_requestFailed hideErroeTip:hide task:nil];
    [self.requests removeObject:dataTask];
}



#pragma mark - 事件回调处理queue
static dispatch_queue_t create_complete_handle_queue() {
    static dispatch_queue_t complete_handle_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        complete_handle_queue = dispatch_queue_create("_network_complete_handle_queue", DISPATCH_QUEUE_CONCURRENT);
    });
    return complete_handle_queue;
}




@end
