//
//  NSString+Verify.h
//  02-正则表达式实战【掌握】
//
//  Created by shenzhenIOS on 16/3/28.
//  Copyright © 2016年 shenzhenIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Verify)

- (BOOL) isQQ;

- (BOOL) isPhone;

- (BOOL) isEmail;

- (BOOL) checkPassword;
@end
