//
//  MHMyBagTableViewController.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/18.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import "MHMyBagTableViewController.h"
#import "MHBagCell.h"
#import "MHBagModel.h"

@interface MHMyBagTableViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *accountArray;//账户对象组


@end

@implementation MHMyBagTableViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}


#pragma mark - TableViewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _accountArray.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = @"MHBag";
    MHBagModel *bagModel = [[MHBagModel alloc] initWithDict:_accountArray[indexPath.row]];
    MHBagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[MHBagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    return cell;
}
@end
