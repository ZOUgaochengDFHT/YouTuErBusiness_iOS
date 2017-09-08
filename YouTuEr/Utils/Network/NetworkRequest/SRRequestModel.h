//
//  RequestModel.h
//
//  Created by GaoCheng.Zou on 2017/4/14.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkParamDefinition.h"

@interface SRRequestModel : NSObject

/**
 必要参数，接口URL
 */
@property (nonatomic, copy) NSString *url;


/**
 选填，请求方式，POST、GET、默认GET
 */
@property (nonatomic, assign) NetworkRequestType requestType;

/**
 选填，没有则不显示加载动画
 注：用于loading开始与结束，以及tableview的endloading结束，只有target是BaseViewController的子类才有loading
 */
@property (nonatomic, weak) id target;

/**
 选填，是否隐藏loading（注：默认不隐藏，tableview的endloding还是会调用）
 */
@property (nonatomic, assign) BOOL hideRefresh;

/**
 选填，需要返回的数据是什么类型的model
 */
@property (nonatomic, assign) Class cls;

/**
 选填，是否隐藏错误提示
 */
@property (nonatomic, assign) BOOL hideErrorTip;


@end

