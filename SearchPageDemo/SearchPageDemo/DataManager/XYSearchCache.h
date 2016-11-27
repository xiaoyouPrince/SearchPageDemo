//
//  XYSearchCache.h
//  BBAngel
//
//  Created by 渠晓友 on 2016/11/24.
//  Copyright © 2016年 Xiaoyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface XYSearchCache : NSObject
{
    FMDatabase *_dataBase;
}

+ (instancetype)shareInstance;

+ (instancetype)defaultManager;

/*!
 收藏数据
 */
-(void)insertDataWithTitle:(NSString *)title;

/*!
 删除数据
 */
-(void)deleteDataWithTitle:(NSString *)title;
/*!
 删除所有数据
 */
-(void)deleteAllData;

/*!
 返回数据
 */
-(NSMutableArray *)selectDataWithTitle:(NSString *)title;

/*!
 返回所有数据
 */
-(NSMutableArray *)selectAllData;

@end
