//
//  XYSearchHistoryView.h
//  BBAngel
//
//  Created by 渠晓友 on 2016/11/24.
//  Copyright © 2016年 Xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HistoryItemClickBlock)(NSString *title);
typedef void(^DeleteBtnClickBlock)();

@interface XYSearchHistoryView : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *historyItems;
@property (nonatomic, assign) CGFloat totalHeight;

@property (nonatomic, copy) HistoryItemClickBlock itemClick;
@property (nonatomic, copy) DeleteBtnClickBlock deleteBlock;

@end
