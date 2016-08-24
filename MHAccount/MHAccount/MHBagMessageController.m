//
//  MHBagMessageController.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/23.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#define WEAKSELF __weak typeof(self) weakSelf = self;

#import "MHBagMessageController.h"
#import "MHDatabase.h"
#import "MHBagMessageView.h"
#import <Masonry.h>

@interface MHBagMessageController()<UITextFieldDelegate>

@property (nonatomic, strong)MHBagTypeModel *bagModel;

@property (nonatomic, strong)UITextField *accountName;
@property (nonatomic ,strong)UITextField *accountMoney;


@end

@implementation MHBagMessageController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MHBagMessageView *bMView = [[MHBagMessageView alloc] init];
    
    self.view = bMView;
    
    bMView.accountName.delegate = self;
    bMView.accountMoney.delegate = self;
    
    [self layout];
    
    self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:255/255.0 blue:240/255.0 alpha:1.0];
    
    
    self.accountName.delegate = self;
    self.accountMoney.delegate = self;
    
    [self.navigationItem setTitle:[NSString stringWithFormat:@"填写%@账户",self.bagModel.type]];
    
    
    //添加确定按钮
    //生成添加账户按钮
    UIButton *itemBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,50,30)];
    itemBtn.titleLabel.text = @"确定";
    [itemBtn setTitle:[NSString stringWithFormat:@"确定"] forState:UIControlStateNormal];
    [itemBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:99/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    [itemBtn addTarget:self action:@selector(clickEvent)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
    self.navigationItem.rightBarButtonItem= rightItem;

}

- (void)clickEvent{
    //插入数据到MH_ACCOUNT表中
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}

- (void)layout{
    WEAKSELF
    [self.view addSubview:self.accountName];
    [self.accountName makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(44);
        make.centerX.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.view).with.offset(5);
        make.top.equalTo(70);
    }];

    [self.view addSubview:self.accountMoney];
    [self.accountMoney makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(44);
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(_accountName.bottom).offset(10);
        make.left.equalTo(weakSelf.view).with.offset(5);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self resignFirstResponder];
}

- (UITextField *)accountName
{
    if (!_accountName) {
        _accountName = [[UITextField alloc] init];
    }
    _accountName.placeholder = [NSString stringWithFormat:@"账户名称"];
    _accountName.borderStyle = UITextBorderStyleRoundedRect;
    return _accountName;
}

- (UITextField *)accountMoney
{
    if (!_accountMoney) {
        _accountMoney = [[UITextField alloc] init];
    }
    _accountMoney.placeholder = [NSString stringWithFormat:@"账户金额"];
    _accountMoney.borderStyle = UITextBorderStyleRoundedRect;
    return _accountMoney;
}

/**
 *  接受选择钱包正向传递的模型
 */
- (void)setModel:(MHBagTypeModel *)model
{
    _bagModel = model;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resignFirstResponder];
    return YES;
    
}

@end
