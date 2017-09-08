//
//  YTEHomeButtonModel.m
//  YouTuEr
//
//  Created by 苏一 on 2017/3/5.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEHomeButtonModel.h"
#import <MJExtension/MJExtension.h>
@implementation YTEHomeButtonModel
+ (NSArray *)homeButtonModels {
    NSArray *modelDicArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"homeButtons" ofType:@"plist"]];
    NSMutableArray *buttonModels = [NSMutableArray arrayWithCapacity:modelDicArr.count];
    for (id obj in modelDicArr) {
        YTEHomeButtonModel *buttonModel = [[YTEHomeButtonModel alloc] init];
        [buttonModel setValuesForKeysWithDictionary:obj];
        [buttonModels addObject:buttonModel];
    }
    return buttonModels.copy;
}
@end
