//
//  MHAddBagController.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/22.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import "MHAddBagController.h"
@interface MHAddBagController()<UITableViewDelegate,UITableViewDataSource>



@end

@implementation MHAddBagController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"添加钱包"];
}


#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *ID = @"AddBag";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    }
    return cell;
}

@end
