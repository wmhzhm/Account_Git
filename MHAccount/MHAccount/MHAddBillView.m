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
#import "TMCategoryCollectionViewFlowLayout.h"
#import "MHDatabase.h"
#import "CCColorCube.h"


@interface MHAddBillView()
@property (nonatomic ,strong) UIView *lineView;

//入账类型按钮
@property (nonatomic, strong) UIButton *inComeBtn;
//出账类型按钮
@property (nonatomic ,strong) UIButton *outComeBtn;
//目前Bill类型
@property (nonatomic, assign, getter=isIcome) BOOL income;

//遮罩层
@property (nonatomic, strong) UIView *shadeView;
//按钮容器
@property (nonatomic, strong) UIView *buttonView;

@property (nonatomic, strong) UIView *headeView;
@property (nonatomic, strong) MHCategory *firstIncomeCategory;


@end

@implementation MHAddBillView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self layout];
//    [self layoutIfNeeded];
//    [self loadRadioBtn];
    
    self.backgroundColor = [UIColor whiteColor];
    self.outComeBtn.selected = YES;
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
    
    [self addSubview:self.buttonView];
    [_buttonView makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(_back.right).offset(60);
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(30);
        make.bottom.equalTo(_lineView.top);
    }];
    
    //出账类型按钮
    [self.buttonView addSubview:self.outComeBtn];
    [self.outComeBtn makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(0);
        make.width.equalTo(_buttonView).multipliedBy(0.5);
        make.top.equalTo(0);
        make.bottom.equalTo(-5);
    }];
    
    
    
    //入账类型按钮
    [self.buttonView addSubview:self.inComeBtn];
    [self.inComeBtn makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(_outComeBtn.right).with.offset(-1);
        make.width.equalTo(_buttonView).multipliedBy(0.5);
        make.top.equalTo(0);
        make.bottom.equalTo(-5);
    }];
    [self bringSubviewToFront:_outComeBtn];
    
       //头部视图
    [self addSubview:self.headeView];
    [self.headeView makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_lineView.bottom).with.offset(0);
        make.centerX.equalTo(weakSelf);
        make.left.equalTo(0);
        make.height.equalTo(60);
    }];
    
    
    
    
    //添加headerView
    self.headerView = [[TMCreateHeaderView alloc] initWithFrame:BillHeaderViewFrame];
    //设置HeadView初始色彩
    [self.headerView animationWithBgColor:[UIColor colorWithRed:0.485 green:0.686 blue:0.667 alpha:1.000]];
    self.headerView.backgroundColor = [UIColor colorWithRed:0.485 green:0.686 blue:0.667 alpha:1.000];
    [self.headeView addSubview:self.headerView];
    

    [self bringSubviewToFront:self.headerView];
    
    //加入收入
    [self addSubview:self.inComeCategoryCollectionView];
    //加入遮罩层
    [self addSubview:self.shadeView];
    //加入PageController
    [self addSubview:self.pageController];
    
    //加入ScorllerView
    [self addSubview:self.outComeCategoryScrollView];

    //加入计算器
    [self addSubview:self.calculatorView];
    
    [self.buttonView bringSubviewToFront:self.outComeBtn];
}



//- (void)loadRadioBtn{
    //设置左圆角,右直角
//    UIBezierPath *maskPath_out=[UIBezierPath bezierPathWithRoundedRect:self.outComeBtn.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer *maskLayer_out=[[CAShapeLayer alloc]init];
//    maskLayer_out.frame=self.outComeBtn.bounds;
//    maskLayer_out.path=maskPath_out.CGPath;
//    self.outComeBtn.layer.mask=maskLayer_out;
////    [self.outComeBtn.layer setCornerRadius:10];
////    self.outComeBtn.layer add
//    
//    //设置左直角,右圆角
//    UIBezierPath *maskPath_in=[UIBezierPath bezierPathWithRoundedRect:self.inComeBtn.bounds byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer *maskLayer_in=[[CAShapeLayer alloc]init];
//    maskLayer_in.frame=self.inComeBtn.bounds;
////    maskLayer_in.path=maskPath_in.CGPath;
//    self.inComeBtn.layer.mask=maskLayer_in;
//    
//    
//    
//    [_outComeBtn.layer setBorderWidth:2];
//    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
//    
//    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){1,0,0,1});
//    
//    
//    [_outComeBtn.layer setBorderColor:color];
//}
#pragma mark - lazyInit
- (UIButton *)back{
    if (!_back) {
        _back = [[UIButton alloc] init];
        [_back setBackgroundImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
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
- (UIView *)shadeView{
    if (!_shadeView) {
        _shadeView = [[UIView alloc] initWithFrame:kCollectionFrame];
        _shadeView.backgroundColor = [UIColor whiteColor];
    }
    return _shadeView;
}
//按钮容器View
-(UIView *)buttonView{
    if (!_buttonView) {
        _buttonView = [[UIView alloc] init];
        _buttonView.backgroundColor = [UIColor clearColor];
//        _buttonView.layer.cornerRadius = 15;
//        
//        _buttonView.layer.masksToBounds = YES;
//        _buttonView.layer.borderWidth = 0.5;
//        _buttonView.layer.borderColor = [[UIColor grayColor] CGColor];
//        _buttonView.layer.shadowOpacity = 0.5;
//        _buttonView.layer.shadowColor = [UIColor grayColor].CGColor;
//        _buttonView.layer.shadowRadius = 3;
//        _buttonView.layer.shadowOffset  = CGSizeMake(1, 1);
    }
    return _buttonView;
}

//出账类型按钮
- (UIButton *)outComeBtn{
    if (!_outComeBtn) {
        _outComeBtn = [[UIButton alloc] init];
        [_outComeBtn setTitle:@"支出" forState:UIControlStateNormal];
        [_outComeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_outComeBtn setTitleColor:kSelectColor forState:UIControlStateSelected];
        [_outComeBtn addTarget:self action:@selector(clickOutComeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_outComeBtn.layer setBorderWidth:1];
        
        [_outComeBtn.layer setBorderColor:kSelectColor.CGColor];
    }
    return _outComeBtn;
}

//入账类型按钮
- (UIButton *)inComeBtn{
    if(!_inComeBtn){
        _inComeBtn = [[UIButton alloc] init];
        [_inComeBtn setTitle:@"收入" forState:UIControlStateNormal];
//        [_inComeBtn setImage:[UIImage imageNamed:@"收入默认"] forState:UIControlStateNormal];
//        [_inComeBtn setImage:[UIImage imageNamed:@"收入选中"] forState:UIControlStateSelected];
        [_inComeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_inComeBtn setTitleColor:kSelectColor forState:UIControlStateSelected];
        [_inComeBtn addTarget:self action:@selector(clickIncomeBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [_inComeBtn.layer setBorderWidth:1];
        [_inComeBtn.layer setBorderColor:[UIColor blackColor].CGColor];
//        [_inComeBtn.layer ]
        //[_inComeBtn.layer setCornerRadius:10];
    }
    return _inComeBtn;
}


//入账CategoryCollectionView
- (UICollectionView *)inComeCategoryCollectionView{
    
    if(!_inComeCategoryCollectionView){
        _inComeCategoryCollectionView  = [[UICollectionView alloc] initWithFrame:kCollectionFrame collectionViewLayout:[[TMCategoryCollectionViewFlowLayout alloc] init]];
        _inComeCategoryCollectionView.backgroundColor = [UIColor whiteColor];
    }
    return _inComeCategoryCollectionView;
}
//出账CategoryCollectionView
- (UICollectionView *)outComeCategoryCollectionView{
    
    if(!_outComeCategoryCollectionView){
        _outComeCategoryCollectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, (kCollectionCellWidth+20 + 10) * 4 - 10)  collectionViewLayout:[[TMCategoryCollectionViewFlowLayout alloc] init]];
        _outComeCategoryCollectionView.backgroundColor = [UIColor whiteColor];
    }
    return _outComeCategoryCollectionView;
}

//出账CategoryCollectionView2
- (UICollectionView *)outComeCategoryCollectionView2{
    
    if(!_outComeCategoryCollectionView2){
        _outComeCategoryCollectionView2  = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width, 0, SCREEN_SIZE.width, (kCollectionCellWidth+20 + 10) * 4 -10) collectionViewLayout:[[TMCategoryCollectionViewFlowLayout alloc] init]];
        _outComeCategoryCollectionView2.backgroundColor = [UIColor whiteColor];
    }
    return _outComeCategoryCollectionView2;
}

//ScrollerView
- (UIScrollView *)outComeCategoryScrollView{
    if (!_outComeCategoryScrollView) {
        _outComeCategoryScrollView = [[UIScrollView alloc] initWithFrame:kCollectionFrame];
        _outComeCategoryScrollView.contentSize = CGSizeMake(kCollectionFrame.size.width * 2, kCollectionFrame.size.height);

        [_outComeCategoryScrollView addSubview:self.outComeCategoryCollectionView];
        [_outComeCategoryScrollView addSubview:self.outComeCategoryCollectionView2];
        
        //设置类型
        _outComeCategoryScrollView.pagingEnabled = YES;
        _outComeCategoryCollectionView.bounces = YES;
        /** 设置滚动条不可见 */
        _outComeCategoryScrollView.showsHorizontalScrollIndicator = NO;
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

//记账键盘
- (TMCalculatorView *)calculatorView{
    if (!_calculatorView) {
        _calculatorView = [[[NSBundle mainBundle] loadNibNamed:@"TMCalculatorView" owner:nil options:nil] lastObject];
        _calculatorView.frame =CGRectMake(0, CGRectGetMaxY(_pageController.frame), SCREEN_SIZE.width, SCREEN_SIZE.height - CGRectGetMaxY(_pageController.frame));
    }
    return _calculatorView;
}

#pragma mark - 方法
/**
 收入按钮
 */
- (void)clickIncomeBtn:(UIButton *)sender {
    //* ------------ */
//    TMCategory *firstIncomeCategory = [[TMDataBaseManager defaultManager] queryCategorysWithPaymentType:income].firstObject;
//    self.selectedCategory = firstIncomeCategory;
//    if (!self.isUpdade) {
//        self.bill.isIncome = @YES;
//    } else {
//        self.income = YES;
//    }
//    //* ------------ */
//    NSLog(@"click IncomeBtn");
    
    self.firstIncomeCategory = [MHCategory bagWithDict: [MHDatabase searchCategoryInCome].firstObject];
//    self.inComeArray = [MHDatabase searchCategoryInCome];
//    self.outComeArray = [MHDatabase searchCategoryOutCome];
    sender.selected = YES;
    self.outComeBtn.selected = NO;
    [self bringSubviewToFront:self.inComeCategoryCollectionView];
    [self bringSubviewToFront:self.headerView];
    [self sendSubviewToBack:self.outComeCategoryScrollView];
    
    [self.headerView categoryImageWithFileName:_firstIncomeCategory.categoryImageFileNmae andCategoryName:_firstIncomeCategory.categoryTitle];

    CCColorCube *imageColor = [[CCColorCube alloc] init];
    NSArray *colors = [imageColor extractColorsFromImage:_firstIncomeCategory.categoryImage flags:CCAvoidBlack count:1];
//    //* 设置HeaderView的背景颜色 */
    [self.headerView animationWithBgColor:colors.firstObject];
    self.pageController.numberOfPages = 1;
    [self.inComeCategoryCollectionView reloadData];
    //切换颜色
    [_inComeBtn.layer setBorderColor:kSelectColor.CGColor];
    [_outComeBtn.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.buttonView bringSubviewToFront:self.outComeBtn];
    [self.buttonView bringSubviewToFront:self.inComeBtn];

}


/**
 支出按钮
 */
- (void)clickOutComeBtn:(UIButton *)sender{
    
    self.firstIncomeCategory = [MHCategory bagWithDict: [MHDatabase searchCategoryOutCome].firstObject];

    sender.selected = YES;
    self.inComeBtn.selected = NO;
    [self bringSubviewToFront:self.outComeCategoryScrollView];
    [self bringSubviewToFront:self.headerView];
    [self sendSubviewToBack:self.inComeCategoryCollectionView];
    
    [self.headerView categoryImageWithFileName:_firstIncomeCategory.categoryImageFileNmae andCategoryName:_firstIncomeCategory.categoryTitle];
    //
    CCColorCube *imageColor = [[CCColorCube alloc] init];
    NSArray *colors = [imageColor extractColorsFromImage:_firstIncomeCategory.categoryImage flags:CCAvoidBlack count:1];
    //    //* 设置HeaderView的背景颜色 */
    [self.headerView animationWithBgColor:colors.firstObject];
    self.pageController.numberOfPages = 2;
    [self.outComeCategoryCollectionView reloadData];
    [self.outComeCategoryCollectionView2 reloadData];
    
    //切换颜色
    [_outComeBtn.layer setBorderColor:kSelectColor.CGColor];
    [_inComeBtn.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.buttonView bringSubviewToFront:self.inComeBtn];
    [self.buttonView bringSubviewToFront:self.outComeBtn];
}
@end
