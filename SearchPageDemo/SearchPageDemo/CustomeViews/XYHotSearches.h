//
//  XYHotSearches.h
//  BBAngel
//
//  Created by 渠晓友 on 2016/11/24.
//  Copyright © 2016年 Xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseItemBlock)(NSInteger index,NSString *itemName);

@interface XYHotSearches : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray *itemNames;

@property (nonatomic, copy)  ChooseItemBlock chooseItem;

+ (instancetype)sharedInstance;

@end
