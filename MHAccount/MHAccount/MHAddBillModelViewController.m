//
//  MHAddBillModelViewController.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/30.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import "MHAddBillModelViewController.h"
#import "MHAddBillView.h"
@interface MHAddBillModelViewController()<UITextFieldDelegate>
@property (nonatomic,strong)MHAddBillView *billView;
@end
@implementation MHAddBillModelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.billView = [[MHAddBillView alloc] initWithFrame:self.view.frame];
    self.view = self.billView;
    [self.billView.back addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    _billView.moneyTextField.delegate = self;
}


- (void)clickBack{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"返回明细");
    }];
}


@end
