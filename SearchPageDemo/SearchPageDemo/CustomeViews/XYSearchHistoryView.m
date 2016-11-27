//
//  XYSearchHistoryView.m
//  BBAngel
//
//  Created by 渠晓友 on 2016/11/24.
//  Copyright © 2016年 Xiaoyou. All rights reserved.
//

#import "XYSearchHistoryView.h"

#define margin 10
#define HistoryCount 5


@interface HistoryItem : UIView

@property (nonatomic, weak) UIImageView *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIView *bottomLine;

@property (nonatomic, copy) HistoryItemClickBlock block;

@end

@implementation HistoryItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setupContent];
    }
    return self;
}

- (void)setupContent
{
    // 1.放大镜
    UIImageView *icon = [UIImageView new];
    icon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    icon.contentMode = UIViewContentModeCenter;
    [self addSubview:icon];
    self.icon = icon;
    
    // 2.title
    UILabel *titleLabel= [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = [UIColor grayColor];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    // 3.底边线
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = XYColor(245, 245, 245);
    [self addSubview:bottomLine];
    self.bottomLine = bottomLine;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    CGFloat iconW = 30;
    self.icon.frame = CGRectMake(0, 0, iconW, frame.size.height);
    self.titleLabel.frame = CGRectMake(iconW, 0, frame.size.width - 3*iconW, frame.size.height);
    self.bottomLine.frame = CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5);
    
    // 4.创建蒙版，供点击使用
    UIButton *btn = [UIButton new];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:_title forState:0];
    [btn setTitleColor:[UIColor clearColor] forState:0];
    btn.frame = self.bounds;
    [self addSubview:btn];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)btnClick:(UIButton *)sender
{
    if (self.block) {
        self.block(sender.currentTitle);
    }
}


@end






@interface XYSearchHistoryView ()

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation XYSearchHistoryView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        [self setupContent];
    }
    return self;
}

- (void)setupContent
{
    // 这个不在这里创建，去set方法中去创建
}

// 懒加载titleLabel
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(margin, 0, ScreenW-2*margin, 33);
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setHistoryItems:(NSArray *)historyItems
{
    _historyItems = historyItems;
    
    if (historyItems.count) {
        // 如果有数据
        
        // 1.创建对应个数的item
        //   先对比共传进来几条，看看有没有大于HistoryCount，以较小值来展示
        NSInteger count = MIN(HistoryCount, historyItems.count);
        
        CGFloat itemH = 82*heightRate;
        for (int i = 0; i< count; i++) { //
            
            HistoryItem *item = [[HistoryItem alloc] init];
            item.title = historyItems[i];
            item.frame = CGRectMake(margin, CGRectGetMaxY(self.titleLabel.frame) + i*itemH, ScreenW-2*margin, itemH);
            [self addSubview:item];
            item.block = ^(NSString *title){
            
                // 被点击的item的回调
                if (self.itemClick) {
                    self.itemClick(title);
                }
            };
        }
        
        // 记录自己的高度并在使用时放回
        _totalHeight = CGRectGetMaxY(self.titleLabel.frame) + (count+1) * itemH ;
        
        // 2.创建最下面的清除记录的按钮、
        UIButton *deleteBtn = [UIButton new];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        deleteBtn.backgroundColor = [UIColor whiteColor];
        [deleteBtn setTitle:@"清除搜索记录" forState:0];
        [deleteBtn setTitleColor:[UIColor grayColor] forState:0];
        deleteBtn.frame = CGRectMake(margin, _totalHeight-itemH, ScreenW-2*margin, itemH);
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBtn];
   
        
    }else{
        // 如果没有数据，直接让自己全部隐藏
        self.titleLabel.hidden = YES;
    }
    
}

- (void)deleteBtnClick:(UIButton *)sender
{
    // 执行清除操作
    if (self.deleteBlock) {
        self.deleteBlock();
    }
    
}

- (CGFloat)totalHeight
{
    return _totalHeight;
}


@end
