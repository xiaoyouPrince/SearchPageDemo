//
//  XYNewHomePageSearchResultCell.h
//  XYAngel
//
//  Created by 渠晓友 on 2016/11/25.
//  Copyright © 2016年 Xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYSearchModel;

@interface XYNewHomePageSearchResultCell : UITableViewCell

@property (nonatomic, strong) XYSearchModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
