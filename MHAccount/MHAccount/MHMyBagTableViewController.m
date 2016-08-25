//
//  MHMyBagTableViewController.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/18.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import "MHMyBagTableViewController.h"
#import "MHAddBagController.h"
#import "MHUpDateBagViewController.h"
#import "MHDatabase.h"
#import "MHBagCell.h"
#import "MHBagModel.h"

@interface MHMyBagTableViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *accountArray;//账户对象组
@property (nonatomic, strong) UIButton *rightBtn;

@end

@implementation MHMyBagTableViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //生成添加账户按钮
    UIButton *itemBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,20,20)];
    [itemBtn setImage:[UIImage imageNamed:@"add_img"]forState:UIControlStateNormal];
    [itemBtn addTarget:self action:@selector(clickEvent)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    //隐藏分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated
{
    //获取账户对象组
    _accountArray = [MHDatabase searchAccount];
    
    [[self tableView] reloadData];
}

- (void)clickEvent
{
    //跳转到添加账户控制器
    MHAddBagController *addBag = [[MHAddBagController alloc] init];
    [self.navigationController pushViewController:addBag animated:YES];
}

#pragma mark - TableViewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _accountArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *ID = @"MHBag";
    
        MHBagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (!cell) {
            cell = [[MHBagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
            if (indexPath.row == 0) {
                [MHBagCell sumMoneyCell:cell WithAccount:_accountArray];
            }else{
                cell.bagModel = _accountArray[indexPath.row - 1];
            }
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return NO;
    }else{
        return YES;
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //获取数据模型
        MHBagModel *model = _accountArray[indexPath.row - 1];
            //删除模型数组内该模型对象
//        NSInteger rows = indexPath.row;
        [self.accountArray removeObjectAtIndex:[indexPath row] - 1];
            //删除数据库中对应数据
        [MHDatabase deleteBagModel:model];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath ,nil] withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView reloadData];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return;
    }
    MHBagModel *model = _accountArray[indexPath.row - 1];
    
    MHUpDateBagViewController *upDateBagController = [[MHUpDateBagViewController alloc] init];
    
    upDateBagController.inModel = model;
    upDateBagController.row = indexPath.row;
    
    [self.navigationController pushViewController:upDateBagController animated:YES];
}
@end