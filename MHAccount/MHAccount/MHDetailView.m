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
#import "MHDetailView.h"
#import "Const.h"
#import <Masonry.h>

@interface MHDetailView()

@property(nonatomic,strong)UIView *topView;//上部视图
@property (nonatomic ,strong)UIImageView *headImg;
@property (nonatomic ,strong)UILabel *usedMoney;
@property (nonatomic,strong)UILabel *inMoney;
@property (nonatomic, strong)UILabel *inMoneyNum;
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
        make.left.equalTo(_inMoney.right);
        make.centerY.equalTo(_inMoney.centerY);
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
    }
    return _headImg;
}

- (UILabel *)usedMoney{
    if (!_usedMoney) {
        _usedMoney = [[UILabel alloc] init];
        _usedMoney.text = @"本月支出";
        _usedMoney.textColor = [UIColor grayColor];
        _usedMoney.font = [UIFont systemFontOfSize:LABEL_FONT_SIZE];
    }
    return _usedMoney;
}

- (UILabel *)inMoney{
    if (!_inMoney) {
        _inMoney = [[UILabel alloc] init];
        _inMoney.text = [NSString stringWithFormat:@"本月收入"];
        _inMoney.textColor = [UIColor grayColor];
        _inMoney.font = [UIFont systemFontOfSize:LABEL_FONT_SIZE];
    }
    return _inMoney;
}

- (UILabel *)inMoneyNum
{
    if (!_inMoneyNum) {
        _inMoneyNum = [[UILabel alloc] init];
        _inMoneyNum.textColor = [UIColor grayColor];
        _inMoneyNum.text = @"00.00";
        _inMoneyNum.font = [UIFont systemFontOfSize:LABEL_FONT_SIZE];
        _inMoneyNum.textAlignment = UITextAlignmentRight;
    }
    return _inMoneyNum;
}
@end
