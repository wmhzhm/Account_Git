//
//  MHMyBagTableViewController.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/18.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import "MHMyBagTableViewController.h"
#import "MHAddBagController.h"
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
    
    //获取账户对象组
    _accountArray = [[MHDatabase searchAccount] copy];
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
            if (indexPath.row == 0) {
                [MHBagCell sumMoneyCell:cell WithAccount:_accountArray];
            }else{
                cell.bagModel = _accountArray[indexPath.row - 1];
            }
        }
    return cell;
}
@end