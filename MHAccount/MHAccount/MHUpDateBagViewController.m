//
//  MHUpDateBagViewController.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/25.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import "MHUpDateBagViewController.h"
#import "MHUpDateBagView.h"
#import "MHDatabase.h"

@interface MHUpDateBagViewController ()<UITextFieldDelegate>
//@property (nonatomic ,strong)MHBagModel *oldModel;
@property (nonatomic, strong)MHBagModel *outModel;
@property (nonatomic ,strong)MHUpDateBagView *bMView;
@property (nonatomic ,strong)NSMutableArray *accountArray;
@end

@implementation MHUpDateBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.bMView = [[MHUpDateBagView alloc] initWithFrame:self.view.frame];
    self.view = self.bMView;
    _bMView.model = self.inModel;
    
    _accountArray = [MHDatabase searchAccount];
    self.bMView.accountName.delegate = self;
    self.bMView.accountMoney.delegate = self;
    
//    self.oldModel = [[MHBagModel alloc] init];
    
    [self.navigationItem setTitle:[NSString stringWithFormat:@"修改%@账户",self.outModel.type]];
    
    [self addOKBtn];
}

//需要修改
- (void)addOKBtn
{
    //添加确定按钮
    UIButton *itemBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,50,30)];
    itemBtn.titleLabel.text = @"确定";
    [itemBtn setTitle:[NSString stringWithFormat:@"确定"] forState:UIControlStateNormal];
    [itemBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:99/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    [itemBtn addTarget:self action:@selector(clickUpDateEvent)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:itemBtn];
    self.navigationItem.rightBarButtonItem= rightItem;
}

- (void)clickUpDateEvent{
    
    if (self.bMView.accountName.text.length == 0) {
        //发出警告
        self.bMView.accountName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"*请输入账户类型名称" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
        return;
    }else{
        for (MHBagModel *models in _accountArray) {
            if ([self.bMView.accountName.text isEqualToString:models.type]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"账户已存在" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
        }
    }
    if (self.bMView.accountMoney.text.length == 0) {
        //发出警告
        self.bMView.accountName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"*请输入账户余额" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];
        return;
    }
    [self upDateDB];
    
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}


- (void)upDateDB
{
    self.outModel.type = self.bMView.accountName.text;
    self.outModel.color = self.bMView.colorNum;
    float money = [self.bMView.accountMoney.text floatValue];
    self.outModel.money = [NSString stringWithFormat:@"%.2f",money];
    
    [MHDatabase upDateOldBagModel:_inModel ToNewBagModel:_outModel];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


-(MHBagModel *)outModel
{
    if (!_outModel) {
        _outModel = [[MHBagModel alloc] init];
    }
    return _outModel;
}


- (void)setInModel:(MHBagModel *)inModel
{
    _inModel = inModel;
}
@end
