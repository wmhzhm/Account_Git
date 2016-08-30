//
//  MHDetailedViewController.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/16.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import "MHDetailedViewController.h"
#import "MHDetailView.h"
@interface MHDetailedViewController()

@property (nonatomic ,strong)MHDetailView *detailView;
@end

@implementation MHDetailedViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.detailView = [[MHDetailView alloc] initWithFrame:self.view.frame];
    self.view = self.detailView;
    [self.detailView.middleBtn addTarget:self action:@selector(clickAddBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickAddBtn{
    MHAddBillModelViewController *modelViewController = [[MHAddBillModelViewController alloc] init];
    modelViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:modelViewController animated:YES completion:nil];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    
}

- (MHDetailView *)detailView
{
    if (!_detailView) {
        _detailView = [[MHDetailView alloc] initWithFrame:self.view.frame];
    }
    return _detailView;
}


@end