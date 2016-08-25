//
//  MHBagMessageController.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/23.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//


#define WEAKSELF __weak typeof(self) weakSelf = self;

#import "MHBagMessageController.h"
#import "MHDatabase.h"
#import "MHBagMessageView.h"
#import "MHBagModel.h"


@interface MHBagMessageController()<UITextFieldDelegate>

@property (nonatomic, strong)MHBagTypeModel *bagTypeModel;
@property (nonatomic ,strong)MHBagMessageView *bMView;

@end

@implementation MHBagMessageController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.bMView = [[MHBagMessageView alloc] initWithFrame:self.view.frame];
    self.view = self.bMView;
    
    
    self.bMView.accountName.delegate = self;
    self.bMView.accountMoney.delegate = self;
    
    
    [self.navigationItem setTitle:[NSString stringWithFormat:@"填写%@账户",self.bagTypeModel.type]];
    
    
    [self addOKBtn];
}

- (void)addOKBtn
{
    //添加确定按钮
    UIButton *itemBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,50,30)];
    itemBtn.titleLabel.text = @"确定";
    [itemBtn setTitle:[NSString stringWithFormat:@"确定"] forState:UIControlStateNormal];
    [itemBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:99/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    [itemBtn addTarget:self action:@selector(clickEvent)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
    self.navigationItem.rightBarButtonItem= rightItem;
    
}



- (void)clickEvent{
    
    if (self.bMView.accountName.text.length == 0) {
        //发出警告
//        self.bMView.accountName.placeholder = [NSString stringWithFormat:@"请输入账户类型名称"];
        self.bMView.accountName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"*请输入账户类型名称" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
        return;
    }
    if (self.bMView.accountMoney.text.length == 0) {
        //发出警告
         self.bMView.accountName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"*请输入账户余额" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
        return;
    }
    //插入数据到MH_ACCOUNT表中
    [self insertDB];
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}

- (void)insertDB
{
    MHBagModel *model = [[MHBagModel alloc] init];
    model.type = self.bMView.accountName.text;
    model.img = self.bagTypeModel.img;
    model.color = self.bMView.colorNum;
    float money = [self.bMView.accountMoney.text floatValue];
    model.money = [NSString stringWithFormat:@"%.2f",money];
    [MHDatabase addBagModel:model];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



/**
 *  接受选择钱包正向传递的模型
 */
- (void)setModel:(MHBagTypeModel *)model
{
    _bagTypeModel = model;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

@end
