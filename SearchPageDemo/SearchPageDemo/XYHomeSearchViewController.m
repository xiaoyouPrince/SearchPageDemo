//
//  XYHomeSearchViewController.m
//  XYAngel
//
//  Created by 渠晓友 on 2016/11/23.
//  Copyright © 2016年 Xiaoyou. All rights reserved.
//

#import "XYHomeSearchViewController.h"
#import "XYSearchBar.h"
#import "XYHotSearches.h"
#import "XYSearchCache.h"
#import "XYSearchHistoryView.h"
#import "XYNewHomePageSearchResultCell.h"
#import "XYSearchModel.h"



@interface XYHomeSearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *searchHistoryArray;
@property (nonatomic, weak) XYSearchBar *searchBar;
@property (nonatomic, weak) XYHotSearches *hot;
@property (nonatomic, weak) XYSearchHistoryView *history;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation XYHomeSearchViewController
{
    NSArray *arr;
}

- (NSMutableArray *)searchHistoryArray
{
    if (_searchHistoryArray == nil) {
        _searchHistoryArray = [[XYSearchCache defaultManager] selectAllData];
    }
    return _searchHistoryArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self buildUI];
    
    [self loadData];
}


- (void)buildUI
{
    // 0.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1. 导航栏
    [self setupNav];
    
    // 2. scrollView
    [self setupScrollView];
    
}


- (void)setupNav
{
    // 0.导航栏背景色设置
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor orangeColor];
    
    
    // 1.左边的item显示为空
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ddddd"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:(UIBarButtonItemStylePlain) target:self action:@selector(rightItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.hidesBackButton = YES;
    
    // 2.中间搜索条
    XYSearchBar *searchBar = [[XYSearchBar alloc] init];
    searchBar.frame = CGRectMake(40, 20, [UIScreen mainScreen].bounds.size.width - 80, 30);
    searchBar.placeholder = @"搜索";
    self.navigationItem.titleView = searchBar;
    self.searchBar = searchBar;
    [searchBar startEditing];
    searchBar.startSearch = ^(NSString *keywords){
        DLog(@"keywords = %@",keywords);
        [self startSearchWithKeyWords:keywords];
    };
    searchBar.cancelSearch = ^(){
        [self cancelSearchAndChangeUI];
    };

    // 3.右边item为取消，只有取消返回功能
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    rightItem.imageInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    rightItem.width = 30;
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

/**
 *  右边的item点击返回
 */
- (void)rightItemClick
{
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            [obj endEditing:YES];
        }
    }];
    [self.navigationItem.titleView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            [obj endEditing:YES];
        }
    }];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



- (void)setupScrollView
{
    // 1.底部ScrollView
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.frame = CGRectMake(0, 64, ScreenW, ScreenH - 63);
    scrollView.scrollEnabled = YES;
    scrollView.delegate = self;
    scrollView.backgroundColor = XYColor(245, 245, 245);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTap:)];
    [scrollView addGestureRecognizer:tap];
    scrollView.contentSize = CGSizeMake(ScreenW, scrollView.frame.size.height + 1);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    // 2.热门词条
    XYHotSearches *hot = [XYHotSearches sharedInstance];
    hot.title = @"热门搜索";
    hot.itemNames = @[@"项目管理",
                     @"活动管理",
                     @"志愿管理",
                     @"帮帮学院",
                     @"帮帮学院",
                     @"帮帮学院",
                     @"发起管理",
                     @"消息"];
    hot.frame = CGRectMake(0, 0, ScreenW, 193*heightRate);
    [scrollView addSubview:hot];
    self.hot = hot;
    hot.chooseItem = ^(NSInteger index,NSString *itemName){
    
        DLog(@"%ld--%@",index,itemName);
        [self startSearchWithKeyWords:itemName];
    };
    
    // 3. 历史记录
    XYSearchHistoryView *history = [[XYSearchHistoryView alloc]init];
    history.title = @"历史搜索";
    history.historyItems = self.searchHistoryArray;
    history.frame = CGRectMake(0, CGRectGetMaxY(hot.frame), ScreenW, history.totalHeight);
    [scrollView addSubview:history];
    self.history = history;
    
    __weak typeof(XYSearchHistoryView *) weakHistory = history;
    history.itemClick = ^(NSString *title){
        
        DLog(@"用户选择了历史记录中的 - %@",title);
        [self startSearchWithKeyWords:title];
    };
    history.deleteBlock = ^(){
    
        // 用户选择清除历史记录，
        // 1.清除数据缓存
        [[XYSearchCache shareInstance] deleteAllData];
        // 2.移除历史记录板
        [weakHistory removeFromSuperview];
    };
    
}



- (void)loadData
{
    // 1.加载热门标题数据
    
    // 2.加载用户搜索记录数据
    
    
    arr = @[@"帮帮一家",@"帮帮互助",@"帮帮公益",@"帮帮力量",@"帮帮头条"];
}

#pragma mark -- 取消搜索 和 通过关键词搜索

- (void)cancelSearchAndChangeUI
{
    // 用户点击清除按钮，取消搜索
    // 展示热门和搜索记录
    if (self.tableView) {
        [self.tableView removeFromSuperview];
        _searchHistoryArray = nil;
        [self setupScrollView];
    }else
    {
        // 如果没tableview表示还没搜，
        // 但是也要重新加载一下，这样最新的记录会展示
        [self.scrollView removeFromSuperview];
        [self setupScrollView];
    }
}

- (void)startSearchWithKeyWords:(NSString *)keywords
{
    // 调接口
    DLog(@"用户查询的关键字--%@",keywords);

    
    // 0.搜索框展示对应文字
    self.searchBar.text = keywords;
    [self endEditing];
    
    // 1.缓存关键字
    [[XYSearchCache shareInstance] insertDataWithTitle:keywords];
    
    // 2.调用查询接口(刷新页面等等)
    
    
    // 开始查询--
    [self searBeginWithKeywords:keywords];
  
}

- (void)searBeginWithKeywords:(NSString *)keywords
{

    
    // 假设5种类型的结果都出现的。
    // 0.UI修改
    [self.scrollView removeFromSuperview];
    [self setupTableView];
    
    // 1.解析和保存对应数据
    
    
    // 2.刷新对应的tableviewUI
    [self.tableView reloadData];}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH-64) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched; // 设置组的分割线style
    [self.view addSubview:tableView];
    self.tableView = tableView;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // 组数根据查询结构返回
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 65 * heightRate;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *line = [UIView new];
    line.backgroundColor = XYColor(231, 231, 231);
    line.frame = CGRectMake(XYMargin, 64*heightRate, ScreenW - XYMargin, 1);
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"   %@",arr[section]];
    label.font = [UIFont systemFontOfSize:12];
    [label addSubview:line];
    return label;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XYNewHomePageSearchResultCell *cell = [XYNewHomePageSearchResultCell cellWithTableView:tableView];
    cell.model = [XYSearchModel new];
    return cell;
}


#pragma mark -- 推出键盘的两个方法
- (void)scrollViewTap:(UITapGestureRecognizer *)tap
{
    [self endEditing];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self endEditing];
}

- (void)endEditing
{
    [self.navigationItem.titleView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            [obj endEditing:YES];
        }
    }];
}



@end
