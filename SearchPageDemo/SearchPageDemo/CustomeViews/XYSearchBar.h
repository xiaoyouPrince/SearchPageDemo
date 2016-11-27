//
//  XYSearchBar.h
//  BBAngel
//
//  Created by 渠晓友 on 2016/11/24.
//  Copyright © 2016年 Xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义block
typedef void(^SearchBarGoToSearchBlock)(NSString *keywords);
typedef void(^SearchBarCancelSearchBlock)();

@interface XYSearchBar : UIView

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) SearchBarGoToSearchBlock startSearch;
@property (nonatomic, copy) SearchBarCancelSearchBlock cancelSearch;

+ (instancetype)searchBar;
- (void)startEditing;
- (void)endEditing;

@end
