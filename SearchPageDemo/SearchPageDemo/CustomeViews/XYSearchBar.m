//
//  XYSearchBar.m
//  BBAngel
//
//  Created by 渠晓友 on 2016/11/24.
//  Copyright © 2016年 Xiaoyou. All rights reserved.
//

#import "XYSearchBar.h"

@interface XYSearchBar ()<UITextFieldDelegate>

@property (nonatomic, weak) UIImageView *leftIcon;
@property (nonatomic, weak) UITextField *rightTF;

@end

@implementation XYSearchBar

/**
 *  快速返回一个自定义的searchBar
 */
+ (instancetype)searchBar
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        
        [self creatContentView];
    }
    return self;
}

- (void)creatContentView
{
    // 0.设置自己背景
    self.backgroundColor = [UIColor whiteColor];

    // 1.创建左边的搜索iamgeview
    UIImageView *leftIcon = [UIImageView new];
    [leftIcon setImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    leftIcon.contentMode = UIViewContentModeCenter;
    [self addSubview:leftIcon];
    self.leftIcon = leftIcon;
    
    // 2.右边的输入框textField
    UITextField *rightTF = [UITextField new];
    rightTF.font = [UIFont systemFontOfSize:13];
    rightTF.clearButtonMode = UITextFieldViewModeAlways;
    // 设置键盘右下角按钮为search
    rightTF.keyboardType = UIKeyboardTypeWebSearch;
    rightTF.enablesReturnKeyAutomatically = YES;
//    [rightTF becomeFirstResponder];
    rightTF.delegate = self;
    [self addSubview:rightTF];
    self.rightTF = rightTF;
    
}

- (void)endEditing
{
    [self.rightTF endEditing:YES];
}

- (void)startEditing
{
    [self.rightTF becomeFirstResponder];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    
    CGFloat iconW = 30;
    // 1.创建左边的搜索iamgeview
    self.leftIcon.frame = CGRectMake(0, 0, iconW, frame.size.height);
    
    // 2.右边的输入框textField
    self.rightTF.frame = CGRectMake(iconW, 0, frame.size.width - iconW, frame.size.height);
   
}

- (void)setText:(NSString *)text
{
    self.rightTF.text = text;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    self.rightTF.placeholder = placeholder;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    // 设置自己的边角
    self.layer.cornerRadius = 4;
    self.clipsToBounds = YES;
}

#pragma mark -- 代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (self.startSearch) {
        self.startSearch(textField.text);
    }
    
    // 用户点击了return
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (self.cancelSearch) {
        self.cancelSearch();
    }
    
    return YES;
}


@end
