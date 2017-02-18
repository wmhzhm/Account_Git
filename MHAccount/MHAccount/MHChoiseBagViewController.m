//
//  MHChoiseBagViewControllerTableViewController.m
//  MHAccount
//
//  Created by 吴铭汉 on 2017/2/16.
//  Copyright © 2017年 MinghanWu. All rights reserved.
//
////define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS



#import "MHChoiseBagViewController.h"
#import "MHDatabase.h"
#import "MHBagCell.h"
#import "MHBagModel.h"
#import <Masonry.h>

@interface MHChoiseBagViewController()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *bagTableView;//账户列表
@property (nonatomic, strong)UIView *navigationView;//模拟导航栏View
@property (nonatomic, strong)NSMutableArray *mAccountArray;//账户数组
@property (nonatomic, strong)UIButton *backBtn;//返回按钮
@property (nonatomic, strong)UILabel *titleLabel;//界面标题

@end

@implementation MHChoiseBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bagTableView.delegate = self;
    self.bagTableView.dataSource = self;

    [self layout];
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.mAccountArray = [MHDatabase searchAccount];
    
}
#pragma mark - lazyloading
- (UITableView *)bagTableView{
    if (!_bagTableView) {
        _bagTableView = [[UITableView alloc] init];
        _bagTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _bagTableView;
}

- (UIView *)navigationView{
    if (!_navigationView) {
        _navigationView = [[UIView alloc] init];
        _navigationView.backgroundColor = [UIColor whiteColor];
        _navigationView.layer.shadowOffset = CGSizeMake(0, 1);
        _navigationView.layer.shadowOpacity = 0.40;
    }
    return _navigationView;
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
    }
    return _backBtn;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_titleLabel setText:@"请选择出账账户"];
    }
    return _titleLabel;
}


#pragma mark - layout
- (void)layout{
    WEAKSELF
    [self.view addSubview:self.navigationView];
    [self.navigationView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.top.equalTo(0);
        make.height.equalTo(80);
    }];
    
    [self.navigationView addSubview:self.backBtn];
    [self.backBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(30);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
    
    [self.navigationView addSubview:self.titleLabel];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.navigationView.centerX);
        make.centerY.equalTo(self.navigationView.centerY);
    }];
    
    
    [self.view addSubview:self.bagTableView];
    [self.bagTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.bottom).with.offset(0);
        make.centerX.equalTo(weakSelf.view);
        make.bottom.equalTo(0);
        make.left.equalTo(0);
    }];
    
    
    [self.view bringSubviewToFront:self.navigationView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 自定义方法
- (void)clickBack{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"返回");
    }];
}




#pragma mark - Table view data source & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_mAccountArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"MHChoiseBag";
    
    MHBagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[MHBagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
//    if (indexPath.row == 0) {
//        [MHBagCell sumMoneyCell:cell WithAccount:_mAccountArray];
//    }else{
        cell.bagModel = _mAccountArray[indexPath.row];
        cell.typeLabel.textColor = [UIColor whiteColor];
        cell.moneyLabel.textColor = [UIColor whiteColor];
//    }

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}
@end
