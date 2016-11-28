# SearchPageDemo

最近公司项目需要，写的一个搜索页面，这次写的时候感觉本搜索页面的三个部分可以封装起来，避免重复造轮子，因为我感觉已经造过很多次轮子了。所以就封装起来了，
目的是为了方便以后使用相同的东西。

## Preview
![Demo Animation](animation.gif)

## 自定义的三个部分分别为
### 1.XYSearchBar : 封装了一个searchBar，由于g系统的searchBar修改样式不太好弄，以后此类的都可以直接调用实现
### 2.XYHotSearches ：封装了一个热门搜索小模块，分两部分：上面是title，下面是热门词。
### 3.XYSearchHistoryView ：封装了一个搜索历史记录小模块，分两部分：上面是title，下面是记录的历史和一个删除历史记录按钮（只在有记录的时候显示）。
