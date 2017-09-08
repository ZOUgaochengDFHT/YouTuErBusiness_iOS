//
//  YTEChatViewController.h
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/9/6.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <EaseUI/EaseUI.h>

@interface YTEChatViewController : EaseMessageViewController<EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource>


- (void)showMenuViewController:(UIView *)showInView
                  andIndexPath:(NSIndexPath *)indexPath
                   messageType:(EMMessageBodyType)messageType;

@end
