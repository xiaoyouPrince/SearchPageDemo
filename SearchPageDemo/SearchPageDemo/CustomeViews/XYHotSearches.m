//
//  XYHotSearches.m
//  BBAngel
//
//  Created by 渠晓友 on 2016/11/24.
//  Copyright © 2016年 Xiaoyou. All rights reserved.
//

#import "XYHotSearches.h"

@interface XYHotContentView : UIView


@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, copy) ChooseItemBlock contentItemChoose;

@end

@implementation XYHotContentView

// 这里面创建对应的item
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    
    int clum = 4; // 总列数
    CGFloat itemH = 62 * heightRate;
    CGFloat itemW = (frame.size.width / clum);
    
    for (int i = 0; i < self.titles.count; i++) {
        
        UIButton *item = [[UIButton alloc] init];
        item.layer.borderWidth = 0.5;
        item.layer.borderColor = XYColor(245, 245, 245).CGColor;
        item.tag = i;
        [item setTitle:self.titles[i] forState:0];
        item.backgroundColor = [UIColor whiteColor];
        [item setTitleColor:[UIColor grayColor] forState:0];
        item.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:item];

        item.frame = CGRectMake( (i % clum) *  itemW, i/clum * itemH, itemW , itemH);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTap:)];
        [item addGestureRecognizer:tap];
        
    }
}

- (void)itemTap:(UITapGestureRecognizer *)tap
{
    
    UIButton *item = (UIButton *)tap.view;
    
    // 调用block
    if (self.contentItemChoose) {
        self.contentItemChoose(item.tag,item.currentTitle);
    }
}




@end








@interface XYHotSearches ()

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation XYHotSearches

+ (instancetype)sharedInstance
{
    return [[self alloc] init];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        self.backgroundColor = [UIColor colorWithRed:245.f green:245.f blue:245.f alpha:0.3];
        self.backgroundColor = [UIColor clearColor];
        [self setupContent];
    }
    return self;
}

- (void)setupContent
{
    // 不能再这里创建，应该在下面传值的时候创建
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        CGFloat margin = 10;
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(margin, 0, ScreenW, 33);
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

- (void)setItemNames:(NSArray *)itemNames
{
    _itemNames = itemNames;
    
    CGFloat margin = 10;
    
    // 1.创建标题
    self.titleLabel.text = _title;

    // 2.创建items
    XYHotContentView *content = [[XYHotContentView alloc] init];
    content.titles = itemNames;
    content.frame = CGRectMake(margin, CGRectGetMaxY(self.titleLabel.frame), ScreenW - 2*margin, 128*heightRate);
    [self addSubview:content];
    content.contentItemChoose = ^(NSInteger index,NSString *title){
        if (self.chooseItem) {
            self.chooseItem(index,title);
        }
    };
    

}

- (void)setFrame:(CGRect)frame
{
    
    // 固定宽度为屏幕款，用户可以自己设置高度
    frame = CGRectMake(0, frame.origin.y, ScreenW, frame.size.height);
    
    [super setFrame:frame];

}

@end
