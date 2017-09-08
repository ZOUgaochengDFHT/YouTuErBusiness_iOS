//
//  YTEBusBidModel.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/12.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEBusBidModel.h"

@implementation YTEBusBidModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}

+ (NSMutableArray *)getModels:(NSArray *)modelsDicArr {
    
    //将获取的字典数组转换为模型数组
    //1.创建可变的模型数组
    NSMutableArray *models = [NSMutableArray array];
    //2.循环遍历字典数组，将字典数组中的每一个字典转换为模型对象，添加到模型数组中
    for (NSDictionary *dic in modelsDicArr) {
        //3.每一个字典对应着一个模型
        YTEBusBidModel *model = [YTEBusBidModel yy_modelWithJSON:dic];
        //4.添加到模型数组
        [models addObject:model];
    }
    return  [models mutableCopy];
}


@end
