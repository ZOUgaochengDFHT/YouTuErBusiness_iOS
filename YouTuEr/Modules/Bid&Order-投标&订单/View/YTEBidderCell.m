//
//  YTEBidderCell.m
//  YouTuEr
//
//  Created by 苏一 on 2017/6/22.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "YTEBidderCell.h"

@interface YTEBidderCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (nonatomic, weak) IBOutlet UILabel *nameLabel; //名字
@property (nonatomic, weak) IBOutlet UILabel *locationLabel; //所在国家
@property (nonatomic, weak) IBOutlet UILabel *originLabel; //籍贯
@property (nonatomic, weak) IBOutlet UILabel *typeLabel; //类型
@property (nonatomic, weak) IBOutlet UILabel *specialtyLabel; //专长
@property (nonatomic, weak) IBOutlet UILabel *workingHoursLabel; //工作时长
@property (nonatomic, weak) IBOutlet UILabel *overtimeFeeLabel; //加班费
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel; //评分
@property (nonatomic, weak) IBOutlet UILabel *costLabel; //费用
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel; //详细行程
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel1;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel2;
@property (weak, nonatomic) IBOutlet UIImageView *certifiedImage; //认证图标


@end

@implementation YTEBidderCell

/**
 *  快速创建cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"bidderCell";
    YTEBidderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        //        cell = [[YTEOngoingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell = [[NSBundle mainBundle] loadNibNamed:@"YTEBidderCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setModel:(NSObject *)model {
    //    self.yte_height = self.backgrounView.yte_bottom + 5;
    self.descriptionLabel.text = @"阿斯顿肌肤是大家佛阿萨德评价佛阿萨德佛教阿萨德破发阿斯顿肌肤是大家佛阿萨德评价佛阿萨德佛教阿萨德破发阿斯顿肌肤是大家佛阿萨德评价佛阿萨德佛教阿萨德破发阿斯顿肌肤是大家佛阿萨德评价佛阿萨德佛教阿萨德破发阿斯顿肌肤是大家佛阿萨德评价佛阿萨德佛教阿萨德破发阿斯顿肌肤是大家佛阿萨德评价佛阿萨德佛教阿萨德破发";
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.descriptionLabel.preferredMaxLayoutWidth = self.yte_width * 0.9;
}

- (IBAction)acceptBtnClicked:(id)sender {
    YTELog(@"点击了接受按钮");
}


@end
