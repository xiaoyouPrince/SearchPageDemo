//
//  XYSearchCache.m
//  BBAngel
//
//  Created by 渠晓友 on 2016/11/24.
//  Copyright © 2016年 Xiaoyou. All rights reserved.
//

#import "XYSearchCache.h"

@implementation XYSearchCache

+ (instancetype)shareInstance
{
    return [self defaultManager];
}

+ (instancetype)defaultManager
{
    static XYSearchCache *manager ;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[XYSearchCache alloc]init];
    });
    
    return manager;
}

-(instancetype)init{
    
    if (self = [super init]) {
        
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/searchedHistory.db"];
        _dataBase = [[FMDatabase alloc]initWithPath:path];
        
        if ([_dataBase open]) {
            
            NSLog(@"数据库打开");
        }
        
        NSString *creatTableSql =
        @"create table if not exists search_history_table (id integer primary key autoincrement,title varchar (256))";
        
        if([_dataBase executeUpdate:creatTableSql]){
            
            NSLog(@"表创建成功");
        }
    }
    return self;
}

/*!
 收藏数据
 */
-(void)insertDataWithTitle:(NSString *)title
{
    // 1、先查找数据库中有没有已经保存好的，如果有就不再另存储
    NSMutableArray *old_datas = [self selectAllData];
    if (![old_datas containsObject:title]) {
        NSString *insertSql = @"insert into search_history_table (title) values(?)";
        
        if([_dataBase executeUpdate:insertSql,title]){
            
            NSLog(@"收藏成功");
        }
    }
}

/*!
 删除数据
 */
-(void)deleteDataWithTitle:(NSString *)title
{
    NSString *deleteSql = @"delete from search_history_table where title = ?";
    
    if ([_dataBase executeUpdate:deleteSql,title]) {
        NSLog(@"取消收藏成功");
    }
}
/*!
 删除所有数据
 */
- (void)deleteAllData
{
    unsigned long count = [self selectAllData].count;
    for (int i = 0; i< count; i++) {
        
        NSArray *allDate = [self selectAllData];
        [self deleteDataWithTitle:allDate.lastObject];  //从最后一个元素，一个一个删除、防止数组长度变化过程中越界。
        NSLog(@"取消成功 -- %d -- coutn == %lu",i,allDate.count);
    }
}

/*!
 返回数据
 */
-(NSMutableArray *)selectDataWithTitle:(NSString *)title
{
    NSString *selectSql = @"select *from search_history_table where title = ?";
    
    FMResultSet *set = [_dataBase executeQuery:selectSql,title];
    
    NSMutableArray *dataArr = [NSMutableArray array];
    
    while ([set next]) {
        
        [dataArr addObject:[set stringForColumn:@"title"]];
    }
    return dataArr;
}

/*!
 返回所有数据
 */
-(NSMutableArray *)selectAllData
{
    NSString *selectSql = @"select *from search_history_table";
    
    FMResultSet *set = [_dataBase executeQuery:selectSql];
    
    NSMutableArray *dataArr = [NSMutableArray array];
    
    while ([set next]) {
        
        [dataArr addObject:[set stringForColumn:@"title"]];
    }
    
    return [self reversArray:dataArr];
    
    return dataArr;
}

/**
 倒序排列数组
 */
- (NSMutableArray *)reversArray:(NSArray *)array
{
//    NSEnumerator *enumerator = [array reverseObjectEnumerator];
//    NSMutableArray *arrayM = [NSMutableArray array];
//    for (NSString * title in [enumerator allObjects]) {
//        [arrayM addObject:title];
//    }
//    return arrayM;
    
    
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (id obj in array) {
        [arrayM addObject:obj];
    }
    
    if (arrayM.count < 2) {
        return arrayM;
    }
    
    NSUInteger midNum = 0;
    if (arrayM.count % 2 == 0) {
        // 偶数组
        midNum = arrayM.count / 2;
    }else
    {
        // 奇数组
        midNum = arrayM.count / 2 + 1;
    }
    
    for (int i = 0; i < midNum ; i++) {
        
        id obj = arrayM[i];
        id obj2 = arrayM[arrayM.count - i - 1];
        id temp = obj2;
        
        [arrayM replaceObjectAtIndex:arrayM.count - i - 1 withObject:obj];
        [arrayM replaceObjectAtIndex:i withObject:temp];
    }
    return arrayM;
}

@end
