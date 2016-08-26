//
//  MHAddBagController.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/22.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import "MHAddBagController.h"
#import "MHDatabase.h"
#import "MHAddBagCell.h"
#import "MHBagTypeModel.h"
#import "MHBagMessageController.h"

@interface MHAddBagController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong)NSArray *bagTypeArray;

@end

@implementation MHAddBagController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"选择账户类型"];
    
    self.bagTypeArray = [NSArray array];
    self.bagTypeArray = [MHDatabase searchBagType];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _bagTypeArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *ID = @"AddBag";
    
    MHAddBagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[MHAddBagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.bagTypeModel = _bagTypeArray[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHBagMessageController *bMC = [[MHBagMessageController alloc] init];
    
    bMC.model = _bagTypeArray[indexPath.row];
    
    [self.navigationController pushViewController:bMC animated:YES];
}
@end
