//
//  SRColorDefine.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/7/28.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#ifndef SRColorDefine_h
#define SRColorDefine_h


#define SR_RGBCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define SR_RGBACOLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

//2.clear背景颜色
#define SR_CLEARCOLOR [UIColor clearColor]

//3.设置随机颜色
#define SR_RANDOMCOLOR [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

#endif /* SRColorDefine_h */
