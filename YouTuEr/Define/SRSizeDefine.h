//
//  SRSizeDefine.h
//  SwimRabbit
//
//  Created by GaoCheng.Zou on 2017/7/30.
//  Copyright © 2017年 Minxin. All rights reserved.
//

#ifndef SRSizeDefine_h
#define SRSizeDefine_h

// 获取屏幕宽度与高度
#define SR_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SR_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SR_SCREEN_SIZE [UIScreen mainScreen].bounds.size

// Device's width and height
#define SR_DEVICE_HEIGHT ((SR_SCREEN_HEIGHT > SR_SCREEN_WIDTH) ? SR_SCREEN_HEIGHT : SR_SCREEN_WIDTH)

#define SR_NAV_HEIGHT    64.0f
#define SR_TABBAR_HEIGHT 49.0f

#define SR_IPHONE4     (SR_DEVICE_HEIGHT == 480)
#define SR_IPHONE5     (SR_DEVICE_HEIGHT == 568)
#define SR_IPHONE6     (SR_DEVICE_HEIGHT == 667)
#define SR_IPHONE6P    (SR_DEVICE_HEIGHT == 736)


#endif /* SRSizeDefine_h */
