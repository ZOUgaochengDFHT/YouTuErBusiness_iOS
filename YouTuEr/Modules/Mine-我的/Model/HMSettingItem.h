//
//  HMSettingItem.h
//  01-网易彩票
//
//  Created by SZSYKT_iOSBasic_2 on 16/2/20.
//  Copyright © 2016年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef enum {
//    HMSettingItemTypeArrow ,// 箭头
//    HMSettingItemTypeSwitch,// 开关
//} HMSettingItemType;

typedef void (^OperationBlock)();

// 每一个item对象就对应一行数据
@interface HMSettingItem : NSObject
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  子标题
 */
@property (nonatomic, copy) NSString *subTitle;

/**
 *  图标
 */
@property (nonatomic, copy) NSString *icon;

/**
 *  cell的类型
 */
//@property (nonatomic, assign) HMSettingItemType type;
// 用来保存点击cell，要执行的代码
@property (nonatomic, copy) OperationBlock operationBlock;


+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle  icon:(NSString *)icon;
+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle;
+(instancetype)itemWithTitle:(NSString *)title;
@end
