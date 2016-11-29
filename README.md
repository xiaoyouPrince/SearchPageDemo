# SearchPageDemo

最近公司项目需要，写的一个搜索页面，这次写的时候感觉本搜索页面的三个部分可以封装起来，避免重复造轮子，因为我感觉已经造过很多次轮子了。所以就封装起来了，
目的是为了方便以后使用相同的东西。

## Preview
![Demo Animation](animation.gif)

## 自定义的三个部分分别为
### 1.XYSearchBar : 封装了一个searchBar，由于g系统的searchBar修改样式不太好弄，以后此类的都可以直接调用实现
### 2.XYHotSearches ：封装了一个热门搜索小模块，分两部分：上面是title，下面是热门词。
### 3.XYSearchHistoryView ：封装了一个搜索历史记录小模块，分两部分：上面是title，下面是记录的历史和一个删除历史记录按钮（只在有记录的时候显示）。

## Usage
导入对应的```XYSearchBar.h```,```XYHotSearches.h```,```XYSearchHistoryView.h```，根据头文件参数配置即可。
### An Example

```Objective-C
  // 1.搜索条
    XYSearchBar *searchBar = [[XYSearchBar alloc] init];
    searchBar.frame = CGRectMake(40, 20, [UIScreen mainScreen].bounds.size.width - 80, 30);
    searchBar.placeholder = @"搜索";
    self.navigationItem.titleView = searchBar;
    [searchBar startEditing];
    // 开始搜索回调
    searchBar.startSearch = ^(NSString *keywords){
        DLog(@"keywords = %@",keywords);
        [self startSearchWithKeyWords:keywords];
    };
    //点击clearBtn取消搜索回调
    searchBar.cancelSearch = ^(){
        [self cancelSearchAndChangeUI];
    };
    
    
    // 2.热门词条 ---（热门词可以根据进入页面之后搜索值再来设置。）
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
    // 点击某个热门词的回调
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
    
    // 点击历史记录中的项目的回调
    __weak typeof(XYSearchHistoryView *) weakHistory = history;
    history.itemClick = ^(NSString *title){
        
        DLog(@"用户选择了历史记录中的 - %@",title);
        [self startSearchWithKeyWords:title];
    };
    //删除历史记录的回调
    history.deleteBlock = ^(){
    
        // 用户选择清除历史记录，
        // 1.清除数据缓存
        [[XYSearchCache shareInstance] deleteAllData];
        // 2.移除历史记录板
        [weakHistory removeFromSuperview];
    };
```
