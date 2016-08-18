//
//  MHDatabase.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/18.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import "MHDatabase.h"
#import <FMDB.h>
#import <FMResultSet.h>
@implementation MHDatabase
+ (void)createDatabase
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *DBPath = [documentPath stringByAppendingPathComponent:@"members.db"];//成员列表数据库
    NSLog(@"数据库路径：%@",DBPath);
    
    FMDatabase *db = [FMDatabase databaseWithPath:DBPath];
    
    if (![db open]) {
        NSLog(@"数据库打开失败!");
        return;
    }else{
        NSLog(@"数据库打开成功");
    }

    /**
     *  建表
     *
     *  @param null MH_ACCOUNT
     *  @param null MH_BILL
     *  @param null MH_OU_TYPE
     *  @param null MH_IN_TYPE
     */
    NSString *sql = @"create table if not exists MH_ACCOUNT (id integer primary key autoincrement not null, ACCOUNT_TYPE text not null,ACCOUNT_IMG text not null, ACCOUNT_COLOR TEXT not null, ACCOUNT_MONEY TEXT not null);"
    
                    "create table if not exists MH_BILL (id integer primary key autoincrement, BILL_TYPE TEXT not null,IN_OUT TEXT not null,BILL_WHEN TEXT not null,REMARK TEXT);"
    
                    "create table if not exists MH_OUT_TYPE  (id integer primary key autoincrement, TYPE_NAME TEXT not null,TYPE_IMG TEXT not null);"
    
                    "create table if not exists MH_IN_TYPE  (id integer primary key autoincrement,TYPE_NAME TEXT not null,TYPE_IMG TEXT not null)";
    BOOL success = [db executeStatements:sql];
    if (!success) {
        NSLog(@"建表失败！");
    }else{
        NSLog(@"建表成功！");
    }
    
    /**
     *  插入基本数据
     */
#pragma mark - 插入数据
    
    
    [db close];
}


@end
