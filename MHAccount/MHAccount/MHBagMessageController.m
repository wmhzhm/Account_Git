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

@end

@implementation MHBagMessageController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    MHBagMessageView *bMView = [[MHBagMessageView alloc] initWithFrame:self.view.frame];
    self.view = bMView;
    
    
    bMView.accountName.delegate = self;
    bMView.accountMoney.delegate = self;
    
    
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
    //插入数据到MH_ACCOUNT表中
        //获取模型数据
    
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view resignFirstResponder];
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
    NSLog(@"123");
    [self.view endEditing:YES];
    return YES;
    
}

@end
