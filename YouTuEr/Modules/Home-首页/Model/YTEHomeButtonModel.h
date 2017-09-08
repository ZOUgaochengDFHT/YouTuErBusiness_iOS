//
//  YTEHomeButtonModel.h
//  YouTuEr
//
//  Created by 苏一 on 2017/3/5.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTEHomeButtonModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSArray *bgColor;

+ (NSArray *)homeButtonModels;
@end
