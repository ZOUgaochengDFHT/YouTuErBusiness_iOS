//
//  YTEB&OLeftCell.m
//  YouTuEr
//
//  Created by 苏一 on 2017/5/2.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEB&OLeftCell.h"

@implementation YTEB_OLeftCell

/**
 *  快速创建cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"leftCell";
    YTEB_OLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YTEB_OLeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.textColor = YTEARGBColor(82, 83, 84);
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.textLabel.highlightedTextColor = YTEDominantColor;
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order-form_bg_left"]];
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"order-form_bg_left_selected"]];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
