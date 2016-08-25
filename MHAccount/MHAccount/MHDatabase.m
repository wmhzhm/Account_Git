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
#import "MHBagModel.h"
#import "MHBagTypeModel.h"

@implementation MHDatabase
/**
 *  返回当前数据库
 */
+ (FMDatabase*)myDB
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *DBPath = [documentPath stringByAppendingPathComponent:@"members.db"];//成员列表数据库
    FMDatabase *db = [FMDatabase databaseWithPath:DBPath];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         NSLog(@"%@",DBPath);
    });
    return db;
}

/**
 *  创建基础数据库
 */
+ (void)createDatabase
{
    FMDatabase *db = [self myDB];
    
    if (![db open]) {
        NSLog(@"数据库打开失败!");
        return;
    }else{
        NSLog(@"数据库打开成功");
    }

    [[self alloc] buildTableAtDB:db];
    [[self alloc] insertMH_ACCOUNT:db];
    [[self alloc] insertMH_ACCOUNT_TYPE:db];
    
    [db close];
}

- (void)buildTableAtDB:(FMDatabase*)db{
    NSString *sql_create_table = @"create table if not exists MH_ACCOUNT (id integer primary key autoincrement not null, ACCOUNT_TYPE text not null,ACCOUNT_IMG text not null, ACCOUNT_COLOR INTEGER not null, ACCOUNT_MONEY TEXT not null);"
    
    "create table if not exists MH_BILL (id integer primary key autoincrement, BILL_TYPE TEXT not null,IN_OUT TEXT not null,BILL_WHEN TEXT not null,REMARK TEXT);"
    
    "create table if not exists MH_OUT_TYPE  (id integer primary key autoincrement, TYPE_NAME TEXT not null,TYPE_IMG TEXT not null);"
    
    "create table if not exists MH_ACCOUNT_TYPE  (id integer primary key autoincrement, TYPE_NAME TEXT not null,TYPE_IMG TEXT not null,COLOR INTEGER not null);"
    
    
    "create table if not exists MH_IN_TYPE  (id integer primary key autoincrement,TYPE_NAME TEXT not null,TYPE_IMG TEXT not null)";
    BOOL success = [db executeStatements:sql_create_table];
    if (!success) {
        NSLog(@"建表失败！");
    }else{
        NSLog(@"建表成功！");
    }
}
- (void)insertMH_ACCOUNT:(FMDatabase*)db{
    FMResultSet *res = [db executeQuery:@"select * from MH_ACCOUNT"];
    if (![res next]) {
        [db executeUpdate:@"insert into MH_ACCOUNT (ACCOUNT_TYPE,ACCOUNT_IMG,ACCOUNT_COLOR,ACCOUNT_MONEY) VALUES (?,?,?,?)",@"现金",@"cash_img",@"0",@"0.00"];
        [db executeUpdate:@"insert into MH_ACCOUNT (ACCOUNT_TYPE,ACCOUNT_IMG,ACCOUNT_COLOR,ACCOUNT_MONEY) VALUES (?,?,?,?)",@"储蓄卡",@"savingcard_img",@"1",@"0.00"];
        [db executeUpdate:@"insert into MH_ACCOUNT (ACCOUNT_TYPE,ACCOUNT_IMG,ACCOUNT_COLOR,ACCOUNT_MONEY) VALUES (?,?,?,?)",@"信用卡",@"credit_card",@"2",@"0.00"];
        [db executeUpdate:@"insert into MH_ACCOUNT (ACCOUNT_TYPE,ACCOUNT_IMG,ACCOUNT_COLOR,ACCOUNT_MONEY) VALUES (?,?,?,?)",@"支付宝",@"alipay",@"3",@"0.00"];
        NSLog(@"生产默认账户数据");
    }
    [res close];
}
- (void)insertMH_ACCOUNT_TYPE:(FMDatabase *)db{
    FMResultSet *res = [db executeQuery:@"select * from MH_ACCOUNT_TYPE"];
    if (![res next]) {
        [db executeUpdate:@"insert into MH_ACCOUNT_TYPE (TYPE_NAME,TYPE_IMG,COLOR) VALUES (?,?,?)",@"现金",@"cash_img",@"0"];
        [db executeUpdate:@"insert into MH_ACCOUNT_TYPE (TYPE_NAME,TYPE_IMG,COLOR) VALUES (?,?,?)",@"储蓄卡",@"savingcard_img",@"1"];
        [db executeUpdate:@"insert into MH_ACCOUNT_TYPE (TYPE_NAME,TYPE_IMG,COLOR) VALUES (?,?,?)",@"信用卡",@"credit_card",@"2"];
        [db executeUpdate:@"insert into MH_ACCOUNT_TYPE (TYPE_NAME,TYPE_IMG,COLOR) VALUES (?,?,?)",@"网络账户",@"alipay",@"3"];
        [db executeUpdate:@"insert into MH_ACCOUNT_TYPE (TYPE_NAME,TYPE_IMG,COLOR) VALUES (?,?,?)",@"投资账户",@"investment_img",@"4"];
        [db executeUpdate:@"insert into MH_ACCOUNT_TYPE (TYPE_NAME,TYPE_IMG,COLOR) VALUES (?,?,?)",@"储值卡",@"value_img",@"5"];
        [db executeUpdate:@"insert into MH_ACCOUNT_TYPE (TYPE_NAME,TYPE_IMG,COLOR) VALUES (?,?,?)",@"应付账",@"pay_img",@"6"];
        [db executeUpdate:@"insert into MH_ACCOUNT_TYPE (TYPE_NAME,TYPE_IMG,COLOR) VALUES (?,?,?)",@"应收账",@"money_img",@"7"];
        NSLog(@"生产账户类型数据");
    }
    [res close];
}
/**
 *  获取账户信息表
 *
 *  @return 返回一个含有所有账户模型对象的数组
 */
+ (NSMutableArray*)searchAccount{
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    FMDatabase *db = [self myDB];
    
    [db open];
    
    
    FMResultSet *res = [db executeQuery:@"select ACCOUNT_TYPE,ACCOUNT_IMG,ACCOUNT_COLOR,ACCOUNT_MONEY from MH_ACCOUNT"];
    while ([res next]) {
        MHBagModel *model = [[MHBagModel alloc] init];
        model.type = [res stringForColumn:@"ACCOUNT_TYPE"];
        model.img = [res stringForColumn:@"ACCOUNT_IMG"];
        model.color = [res intForColumn:@"ACCOUNT_COLOR"];
        model.money = [res stringForColumn:@"ACCOUNT_MONEY"];
        
        [mArray addObject:model];
    }

    [res close];
    [db close];
    return mArray;
}
/**
 *  查询当前所有钱包分类
 *
 *  @return 返回含有所有钱包分类模型对象的数组
 */

+ (NSMutableArray *)searchBagType{
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    FMDatabase *db = [self myDB];
    
    [db open];
    
    
    FMResultSet *res = [db executeQuery:@"select TYPE_NAME,TYPE_IMG,COLOR from MH_ACCOUNT_TYPE"];
    while ([res next]) {
        MHBagTypeModel *model = [[MHBagTypeModel alloc] init];
        model.type = [res stringForColumn:@"TYPE_NAME"];
        model.img = [res stringForColumn:@"TYPE_IMG"];
        model.color = [res intForColumn:@"COLOR"];
        [mArray addObject:model];
    }
    [res close];
    [db close];
    return mArray;
}


+ (void)addBagModel:(MHBagModel*)model
{
    FMDatabase *db = [self myDB];
    [db open];
    [db executeUpdate:@"insert into MH_ACCOUNT (ACCOUNT_TYPE,ACCOUNT_IMG,ACCOUNT_COLOR,ACCOUNT_MONEY) VALUES (?,?,?,?)",[NSString stringWithFormat:@"%@",model.type],[NSString stringWithFormat:@"%@",model.img],[NSString stringWithFormat:@"%d",model.color],[NSString stringWithFormat:@"%@",model.money]];
    [db close];
}

+ (void)deleteBagModel:(MHBagModel *)model
{
    FMDatabase *db = [self myDB];
    [db open];
    [db executeUpdate:@"DELETE FROM MH_ACCOUNT WHERE ACCOUNT_TYPE = ? AND ACCOUNT_IMG = ? AND ACCOUNT_COLOR = ? AND ACCOUNT_MONEY = ?",[NSString stringWithFormat:@"%@",model.type],[NSString stringWithFormat:@"%@",model.img],[NSString stringWithFormat:@"%d",model.color],[NSString stringWithFormat:@"%@",model.money]];
    [db close];
}
@end
