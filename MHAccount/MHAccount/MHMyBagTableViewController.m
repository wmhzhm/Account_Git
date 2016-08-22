//
//  MHMyBagTableViewController.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/18.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import "MHMyBagTableViewController.h"
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
    
    //获取账户对象组
    _accountArray = [[MHDatabase searchAccount] copy];
    NSLog(@"%@",_accountArray);
}


#pragma mark - TableViewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _accountArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = @"MHBag";
    
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
