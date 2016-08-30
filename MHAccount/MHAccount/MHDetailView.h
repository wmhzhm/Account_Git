//
//  MHDetailView.h
//  MHAccount
//
//  Created by 希亚许 on 16/8/16.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHAddBillModelViewController.h"

@interface MHDetailView : UIView
@property(nonatomic,strong)UIView *topView;//上部视图
@property (nonatomic ,strong)UIImageView *headImg;//上部视图背景图
@property (nonatomic ,strong)UILabel *usedMoney;//”本月支出“
@property (nonatomic ,strong)UIButton *usedMoneyNum;//本月支出金额
@property (nonatomic,strong)UILabel *inMoney;//“本月收入”
@property (nonatomic, strong)UILabel *inMoneyNum;//本月收入金额
@property (nonatomic ,strong) UILabel *budgetBalance;//预算余额
@property (nonatomic,strong)UILabel *budgetBalanceNum;//预算余额金额

@property (nonatomic ,strong)UIButton *middleBtn;//中部添加按钮;

@property (nonatomic ,strong)UITableView *lowerView;//下部tableview
@property (nonatomic,strong)UIButton *billBtn; //单笔交易按钮
@end
