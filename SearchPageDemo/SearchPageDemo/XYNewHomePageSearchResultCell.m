
//
//  XYNewHomePageSearchResultCell.m
//  XYAngel
//
//  Created by 渠晓友 on 2016/11/25.
//  Copyright © 2016年 Xiaoyou. All rights reserved.
//

#import "XYNewHomePageSearchResultCell.h"
#import "XYSearchModel.h"

@interface XYNewHomePageSearchResultCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation XYNewHomePageSearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    self.separatorInset = UIEdgeInsetsMake(0, -70, 0, 0);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"XYNewHomePageSearchResultCell";
    
    [tableView registerNib:[UINib nibWithNibName:@"XYNewHomePageSearchResultCell" bundle:nil] forCellReuseIdentifier:ID];
    XYNewHomePageSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    return cell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIView *line = [UIView new];
    line.frame = CGRectMake(XYMargin, self.frame.size.height - 0.5, self.frame.size.width - XYMargin, 0.5);
    line.backgroundColor = XYColor(231, 231, 231);
    [self.contentView addSubview:line];
}

/**
 *  传递模型数据
 */
- (void)setModel:(XYSearchModel *)model
{
    
    _model = model;
    
//    self.icon.image = [UIImage imageNamed:model.icon_url];
    self.icon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
//    self.textLabel.attributedText = model.title;
    self.label.text = @"我法克，这个字符串还是两种啊";
}


@end
