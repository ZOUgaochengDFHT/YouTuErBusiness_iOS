//
//  YTEQuotedPriceTableViewCell.m
//  YouTuEr
//
//  Created by GaoCheng.Zou on 2017/8/11.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEQuotedPriceTableViewCell.h"


@implementation YTEQuotedPriceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.tag == 0) {
        self.contentLabel.hidden = YES;
    } else {
        self.contentTextField.hidden = YES;
    }
}

- (IBAction)textFieldEditingChanged:(UITextField *)sender {
    sender.text = [sender.text length] > 0 ? ([sender.text hasPrefix:@"¥"] ? sender.text : [@"¥ " stringByAppendingString:sender.text]) : @"";
    if (self.quotedPricehandle) self.quotedPricehandle(sender.text);
}

@end
