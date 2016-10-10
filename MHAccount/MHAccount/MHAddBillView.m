//
//  MHAddBillView.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/30.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//
////define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS



#import "MHAddBillView.h"
#import "Const.h"
#import <Masonry.h>
@interface MHAddBillView()
@property (nonatomic ,strong) UIView *lineView;
@end

@implementation MHAddBillView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self layout];
    
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

- (void)layout{
    WEAKSELF
    [self addSubview:self.back];
    [self.back makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(10);
        make.top.equalTo(30);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
    
    [self addSubview:self.lineView];
    [_lineView makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_back.bottom).with.offset(10);
        make.centerX.equalTo(weakSelf);
        make.left.equalTo(0);
        make.height.equalTo(1);
    }];
    
    
    [self addSubview:self.moneyTextField];
    [_moneyTextField makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_lineView.bottom).with.offset(5);
        make.left.equalTo(5);
        make.width.equalTo(weakSelf).multipliedBy(0.5);
    }];
    
    [self addSubview:self.inOrOut];
    [self.inOrOut makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(_back.centerY);
        make.centerX.equalTo(weakSelf);
        make.left.equalTo(_back.right).with.offset(40);
        make.bottom.equalTo(_lineView.top).with.offset(-5);
    }];
}

- (UIButton *)back{
    if (!_back) {
        _back = [[UIButton alloc] init];
        [_back setBackgroundImage:[UIImage imageNamed:@"back_img"] forState:UIControlStateNormal];
        _back.layer.cornerRadius = 15;
        _back.layer.masksToBounds = YES;
    }
    return _back;
}

- (UITextField *)moneyTextField{
    if (!_moneyTextField) {
        _moneyTextField = [[UITextField alloc] init];
        _moneyTextField.placeholder = [NSString stringWithFormat:@"00.00"];
    }
    return _moneyTextField;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor grayColor];
    }
    return _lineView;
}

- (UISegmentedControl *)inOrOut
{
    if (!_inOrOut) {
        NSArray *arr = [[NSArray alloc] initWithObjects:@"收入",@"支出", nil];
        _inOrOut = [[UISegmentedControl alloc] initWithItems:arr];
        _inOrOut.selectedSegmentIndex = 0;
    }
    return _inOrOut;
}
@end
