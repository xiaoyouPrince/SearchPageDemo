//
//  XYSearchModel.m
//  XYAngel
//
//  Created by 渠晓友 on 2016/11/25.
//  Copyright © 2016年 Xiaoyou. All rights reserved.
//

#import "XYSearchModel.h"

@implementation XYSearchModel

- (NSString *)icon_url
{
    return @"default_ HeadImage";
}

- (NSAttributedString *)title
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    NSAttributedString *arr = [[NSAttributedString alloc] initWithString:@"你搜索的关键字" attributes:attrs];
    [arr attributedSubstringFromRange:NSMakeRange(4, 3)];
    return arr;
}

@end
