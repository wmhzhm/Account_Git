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
#import "TMCreateHeaderView.h"
#import "TMCategoryCollectionViewFlowLayout.h"

@interface MHAddBillView()
@property (nonatomic ,strong) UIView *lineView;

//入账类型按钮
@property (nonatomic, strong) UIButton *inComeBtn;
//出账类型按钮
@property (nonatomic ,strong) UIButton *outComeBtn;
//目前Bill类型
@property (nonatomic, assign, getter=isIcome) BOOL income;
//headView
@property (nonatomic, strong) TMCreateHeaderView *headerView;
@property (nonatomic, strong) UIView *headeView;



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
    
    
    //出账类型按钮
    [self addSubview:self.outComeBtn];
    [self.outComeBtn makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(weakSelf.centerX).with.offset(-30);
        make.bottom.equalTo(_lineView.bottom).with.offset(-5);
    }];
    
    //入账类型按钮
    [self addSubview:self.inComeBtn];
    [self.inComeBtn makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(weakSelf.centerX).with.offset(30);
        make.bottom.equalTo(_lineView.bottom).with.offset(-5);
    }];
    
    //头部视图
    [self addSubview:self.headeView];
    [self.headeView makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_lineView.bottom).with.offset(0);
        make.centerX.equalTo(weakSelf);
        make.left.equalTo(0);
        make.height.equalTo(60);
    }];
    
    
    
    
    self.headerView = [[TMCreateHeaderView alloc] initWithFrame:BillHeaderViewFrame];
    [self.headerView animationWithBgColor:[UIColor colorWithRed:0.485 green:0.686 blue:0.667 alpha:1.000]];
    self.headerView.backgroundColor = [UIColor colorWithRed:0.485 green:0.686 blue:0.667 alpha:1.000];
    [self.headeView addSubview:self.headerView];
//        [self.headerView makeConstraints:^(MASConstraintMaker *make){
//        make.left.equalTo(self.headeView.left);
//            make.top.equalTo(self.headeView.top);
////        make.top.equalTo(_lineView.bottom);
//    }];
    [self bringSubviewToFront:self.headerView];
}
#pragma mark - lazyInit
- (UIButton *)back{
    if (!_back) {
        _back = [[UIButton alloc] init];
        [_back setBackgroundImage:[UIImage imageNamed:@"back_img"] forState:UIControlStateNormal];
        _back.layer.cornerRadius = 15;
        _back.layer.masksToBounds = YES;
    }
    return _back;
}

- (UIView *)headeView{
    if (!_headeView) {
        _headeView = [[UIView alloc] init];
        _headeView.backgroundColor = [UIColor whiteColor];
    }
    return _headeView;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor grayColor];
    }
    return _lineView;
}
//出账类型按钮
- (UIButton *)outComeBtn{
    if (!_outComeBtn) {
        _outComeBtn = [[UIButton alloc] init];
        _outComeBtn.backgroundColor = [UIColor clearColor];
        [_outComeBtn setTitle:@"支出" forState:UIControlStateNormal];
        [_outComeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_outComeBtn addTarget:self action:@selector(clickOutComeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _outComeBtn;
}

//入账类型按钮
- (UIButton *)inComeBtn{
    if(!_inComeBtn){
        _inComeBtn = [[UIButton alloc] init];
        _inComeBtn.backgroundColor = [UIColor clearColor];
        [_inComeBtn setTitle:@"收入" forState:UIControlStateNormal];
        [_inComeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_inComeBtn addTarget:self action:@selector(clickIncomeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _inComeBtn;
}
//入账CategoryCollectionView
- (UICollectionView *)inComeCategoryCollectionView{
    
    if(!_inComeCategoryCollectionView){
        _inComeCategoryCollectionView  = [[UICollectionView alloc] initWithFrame:kCollectionFrame collectionViewLayout:[[TMCategoryCollectionViewFlowLayout alloc] init]];
    }
    return _inComeCategoryCollectionView;
}
//出账CategoryCollectionView
- (UICollectionView *)outComeCategoryCollectionView{
    
    if(!_outComeCategoryCollectionView){
        _outComeCategoryCollectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, (kCollectionCellWidth+20 + 10) * 4 - 10)  collectionViewLayout:[[TMCategoryCollectionViewFlowLayout alloc] init]];
    }
    return _outComeCategoryCollectionView;
}

//出账CategoryCollectionView2
- (UICollectionView *)outComeCategoryCollectionView2{
    
    if(!_outComeCategoryCollectionView2){
        _outComeCategoryCollectionView2  = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width, 0, SCREEN_SIZE.width, (kCollectionCellWidth+20 + 10) * 4 -10) collectionViewLayout:[[TMCategoryCollectionViewFlowLayout alloc] init]];
    }
    return _outComeCategoryCollectionView2;
}
- (UIScrollView *)outComeCategoryScrollView{
    if (!_outComeCategoryScrollView) {
        _outComeCategoryScrollView = [[UIScrollView alloc] initWithFrame:kCollectionFrame];
        _outComeCategoryScrollView.contentSize = CGSizeMake(kCollectionFrame.size.width * 2, kCollectionFrame.size.height);

        [_outComeCategoryScrollView addSubview:self.outComeCategoryCollectionView];
        [_outComeCategoryScrollView addSubview:self.outComeCategoryCollectionView2];
    }
    return _outComeCategoryScrollView;
}

- (UIPageControl *)pageController
{
    if (!_pageController) {
        _pageController = [[UIPageControl alloc] initWithFrame:kPageControllerFrame];
        _pageController.numberOfPages = 2;
        _pageController.userInteractionEnabled = NO;
        _pageController.pageIndicatorTintColor = [UIColor colorWithWhite:0.829 alpha:1.000];
        _pageController.currentPageIndicatorTintColor = kSelectColor;
    }
    return _pageController;
}



#pragma mark - 方法
- (void)clickIncomeBtn:(UIButton *)sender {
//    //* ------------ */
//    TMCategory *firstIncomeCategory = [[TMDataBaseManager defaultManager] queryCategorysWithPaymentType:income].firstObject;
//    self.selectedCategory = firstIncomeCategory;
//    if (!self.isUpdade) {
//        self.bill.isIncome = @YES;
//    } else {
//        self.income = YES;
//    }
//    //* ------------ */
//    NSLog(@"click IncomeBtn");
//    sender.selected = YES;
//    self.expendBtn.selected = NO;
//    [self.view bringSubviewToFront:self.incomeCategoryCollectionView];
//    [self.view bringSubviewToFront:self.headerView];
//    [self.view sendSubviewToBack:self.expendCategoryScrollView];
//    
//    [self.headerView categoryImageWithFileName:firstIncomeCategory.categoryImageFileNmae andCategoryName:firstIncomeCategory.categoryTitle];
//    
//    CCColorCube *imageColor = [[CCColorCube alloc] init];
//    NSArray *colors = [imageColor extractColorsFromImage:firstIncomeCategory.categoryImage flags:CCAvoidBlack count:1];
//    //* 设置HeaderView的背景颜色 */
//    [self.headerView animationWithBgColor:colors.firstObject];
//    self.pageController.numberOfPages = 1;
//    [self.incomeCategoryCollectionView reloadData];
}
- (void)clickOutComeBtn:(UIButton *)sender{
    
}
@end
