//
//  MHDetailView.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/16.
//  Copyright © 2016年 MinghanWu. All rights reserved.
////define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS


#define LABEL_FONT_SIZE 12
#define LABEL_USEDMONEYNUM_FONT 30


#import "MHDetailView.h"
#import "Const.h"
#import <Masonry.h>


@interface MHDetailView()



@end
@implementation MHDetailView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self layout];
    self.backgroundColor = [UIColor whiteColor];
    
    return self;
}


- (void)layout{
    WEAKSELF
    
    [self addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(20);
        make.left.equalTo(0);
        make.centerX.equalTo(weakSelf.centerX);
        make.height.equalTo(weakSelf.height).multipliedBy(0.3);
    }];
    
    [self.topView addSubview:self.headImg];
    [_headImg makeConstraints:^(MASConstraintMaker *make){
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.topView addSubview:self.inMoney];
    [self.inMoney makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(-5);
        make.left.equalTo(5);
    }];
    
    [self.topView addSubview:self.inMoneyNum];
    [self.inMoneyNum makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(_inMoney.right).with.offset(5);
        make.centerY.equalTo(_inMoney.centerY);
    }];
    
    [self.topView addSubview:self.usedMoneyNum];
    [self.usedMoneyNum makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(_inMoney.top).with.offset(-10);
        make.left.equalTo(5);
    }];
    
    [self.topView addSubview:self.usedMoney];
    [self.usedMoney makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(_usedMoneyNum.top);
        make.left.equalTo(5);
    }];
    
    
    [self.topView addSubview:self.budgetBalanceNum];
    [self.budgetBalanceNum makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(-5);
        make.bottom.equalTo(-5);
    }];
    
    
    [self.topView addSubview:self.budgetBalance];
    [self.budgetBalance makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(_budgetBalanceNum.left).with.offset(-5);
        make.bottom.equalTo(-5);
    }];
    
    //中部按钮
    [self addSubview:self.middleBtn];
    [self.middleBtn makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(weakSelf.centerX);
        make.left.equalTo(30);
        make.top.equalTo(_topView.bottom).with.offset(10);
    }];
}

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc] init];
    }
    return _topView;
}


- (UIImageView *)headImg
{
    if (!_headImg) {
        _headImg = [[UIImageView alloc] init];
        _headImg.image = [UIImage imageNamed:@"topBcg_img"];
    }
    return _headImg;
}

- (UILabel *)usedMoney{
    if (!_usedMoney) {
        _usedMoney = [[UILabel alloc] init];
        _usedMoney.text = @"本月支出";
        _usedMoney.textColor = [UIColor whiteColor];
        _usedMoney.font = [UIFont systemFontOfSize:LABEL_FONT_SIZE];
    }
    return _usedMoney;
}

- (UIButton *)usedMoneyNum
{
    if (!_usedMoneyNum) {
        _usedMoneyNum = [[UIButton alloc] init];
        [_usedMoneyNum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _usedMoneyNum.titleLabel.font = [UIFont systemFontOfSize:LABEL_USEDMONEYNUM_FONT];
        [_usedMoneyNum setTitle:@"00.00" forState:UIControlStateNormal];
    }
    return _usedMoneyNum;
}

- (UILabel *)inMoney{
    if (!_inMoney) {
        _inMoney = [[UILabel alloc] init];
        _inMoney.text = [NSString stringWithFormat:@"本月收入"];
        _inMoney.textColor = [UIColor whiteColor];
        _inMoney.font = [UIFont systemFontOfSize:LABEL_FONT_SIZE];
    }
    return _inMoney;
}

- (UILabel *)inMoneyNum
{
    if (!_inMoneyNum) {
        _inMoneyNum = [[UILabel alloc] init];
        _inMoneyNum.textColor = [UIColor whiteColor];
        _inMoneyNum.text = @"00.00";
        _inMoneyNum.font = [UIFont systemFontOfSize:LABEL_FONT_SIZE];
        _inMoneyNum.textAlignment = UITextAlignmentRight;
    }
    return _inMoneyNum;
}

-(UILabel *)budgetBalance
{
    if (!_budgetBalance) {
        _budgetBalance = [[UILabel alloc] init];
        _budgetBalance.textColor = [UIColor whiteColor];
        _budgetBalance.font = [UIFont systemFontOfSize:LABEL_FONT_SIZE];
        _budgetBalance.text = @"本月预算余额";
    }
    return _budgetBalance;
}

- (UILabel *)budgetBalanceNum{
    if (!_budgetBalanceNum) {
        _budgetBalanceNum = [[UILabel alloc] init];
        _budgetBalanceNum.textColor = [UIColor whiteColor];
        _budgetBalanceNum.text = @"00.00";
        _budgetBalanceNum.font  = [UIFont systemFontOfSize:LABEL_FONT_SIZE];
        _budgetBalanceNum.textAlignment = UITextAlignmentRight;
    }
    return _budgetBalanceNum;
}

- (UITableView *)lowerView
{
    if (!_lowerView) {
        _lowerView = [[UITableView alloc] init];
    }
    return  _lowerView;
}

- (UIButton *)middleBtn
{
    if (!_middleBtn) {
        _middleBtn = [[UIButton alloc] init];
        _middleBtn.layer.cornerRadius = 10;
        _middleBtn.layer.masksToBounds = YES;
        [_middleBtn setTitle:@"记上一笔" forState:UIControlStateNormal];
        [_middleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_middleBtn setBackgroundColor:[UIColor orangeColor]];
        [_middleBtn setFont:[UIFont systemFontOfSize:30]];
    }
    return _middleBtn;
}

@end
