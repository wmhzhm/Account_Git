//
//  MHAddBillModelViewController.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/30.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import "MHAddBillModelViewController.h"
#import "MHAddBillView.h"
#import "MHCategory.h"
#import "TMCategotyCollectionViewCell.h"
#import "MHDatabase.h"
#import "CCColorCube.h"
#import "SZCalendarPicker.h"
#import "SVProgressHUD.h"
#import "MHBill.h"
#import "MHChoiseBagViewController.h"
#import "MHRemarkViewController.h"
#import "NSString+TMNSString.h"

static NSString *const collectionIdentifier = @"categoryCell";


@interface MHAddBillModelViewController()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate
                                            ,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)MHAddBillView *billView;    //需要添加的BillView
@property (nonatomic, strong)NSMutableArray *inComeArray;
@property (nonatomic, strong)NSMutableArray *outComeArray;
/**
 是否更新
 */
@property (nonatomic, assign) BOOL updateFlg;
/** 
 金额
 */
@property (nonatomic, assign) double money;
/**
 账单
 */
@property (nonatomic, strong) MHBill *bill;
/**
 控制器内储存的备注信息
 */
@property (nonatomic,strong) NSString *remarks;
/**
 控制器内储存的备注图片
 */
@property (nonatomic,strong) NSData *photoData;
@end

@implementation MHAddBillModelViewController
#pragma mark - lazloading
- (MHBill *)bill{
    if (!_bill) {
        _bill = [[MHBill alloc] init];
    }
    return _bill;
}


#pragma mark - systemMethoud
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadBillView];
    
    //设置block方法集
    [self loadBlocks];
}
#pragma mark - 初始化函数
- (void)loadBillView{
    //初始化BillView
    self.billView = [[MHAddBillView alloc] initWithFrame:self.view.frame];
    self.view = self.billView;
    //设置返回按钮
    [self.billView.back addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    //注册重用ID
    [self collectionViewRegisterClass];
    //设置代理
    self.billView.inComeCategoryCollectionView.delegate = self;
    self.billView.inComeCategoryCollectionView.dataSource = self;
    self.billView.outComeCategoryCollectionView.delegate = self;
    self.billView.outComeCategoryCollectionView.dataSource = self;
    self.billView.outComeCategoryCollectionView2.delegate = self;
    self.billView.outComeCategoryCollectionView2.dataSource = self;
    
    self.billView.outComeCategoryScrollView.delegate = self;
    
    
    //初始化数组
    [self loadInOutComeArray];

}
#pragma mark - block方法
- (void)loadBlocks{
    WEAKSELF
    //设置计算器中的点击日历事件
    self.billView.calculatorView.didClickDateBtnBlock = ^ {
        [weakSelf SZCalendatPicker];
    };
    
    //设置计算器中的点击数字事件
        self.billView.calculatorView.passValuesBlock = ^ (NSString *string){
        [weakSelf.billView.headerView updateMoney:string];
        if (!weakSelf.updateFlg) {
              weakSelf.bill.money = string;
        } else {
            if (string.floatValue > 0.0) {
                weakSelf.money = string.doubleValue;
            }
        }
    };
    
    //点击OK（保存）按钮
    self.billView.calculatorView.didClickSaveBtnBlock = ^ {
        if (!weakSelf.updateFlg) {
            if (weakSelf.bill.money.floatValue <= 0.0) {
                [weakSelf showSVProgressHUD:@"请输入有效金额!"];
                [weakSelf.billView.headerView shakingAnimation];
            } else {
                weakSelf.bill.category = weakSelf.billView.selectedCategory;
                //NSString *bookID = [NSString readUserDefaultOfSelectedBookID];
                //TMBooks *book = [[TMDataBaseManager defaultManager] queryBooksWithBookID:bookID];
                //weakSelf.bill.books = book;
                //[[TMDataBaseManager defaultManager] insertWithBill:weakSelf.bill];
                [weakSelf choiseBag];
            }
        } else {
            if (weakSelf.money <= 0.0) {
                [weakSelf showSVProgressHUD:@"请输入有效金额!"];
                [weakSelf.billView.headerView shakingAnimation];
            } else {
                [weakSelf choiseBag];
            }
        }
    };
    
    //点击 备注按钮
    self.billView.calculatorView.didClickRemarkBtnBlock = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            MHRemarkViewController *remarkVC = [[MHRemarkViewController alloc] init];
            //调用RemarkViewController中的block回调方法
            remarkVC.passbackBlock = ^(NSString *remarks,NSData *photoData){
                if (weakSelf.updateFlg) {
//                    NSLog(@"line = %i,remarks = %@,photoData = %@",__LINE__,remarks,photoData);
                    weakSelf.remarks = remarks;
                    weakSelf.photoData = photoData;
                } else {
                    weakSelf.bill.reMarks = remarks;
                    weakSelf.bill.remarkPhoto = photoData;
                }
            };
            remarkVC.bill = weakSelf.bill;
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:remarkVC];
            [weakSelf presentViewController:navi animated:YES completion:nil];
        });
    };
}


- (void)clickBack{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"返回明细");
    }];
}

- (void)choiseBag{
    MHChoiseBagViewController *choiseBagViewController = [[MHChoiseBagViewController alloc] init];
    choiseBagViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:choiseBagViewController animated:YES completion:nil];
}

- (void)collectionViewRegisterClass {
    [self.billView.inComeCategoryCollectionView registerClass:[TMCategotyCollectionViewCell class] forCellWithReuseIdentifier:collectionIdentifier];
    [self.billView.outComeCategoryCollectionView registerClass:[TMCategotyCollectionViewCell class] forCellWithReuseIdentifier:collectionIdentifier];
    [self.billView.outComeCategoryCollectionView2 registerClass:[TMCategotyCollectionViewCell class] forCellWithReuseIdentifier:collectionIdentifier];
}



#pragma mark - 自定义方法
///** 设置账单默认参数 */
//- (void)setupBill {
//    
//    [self.billView animationWithBgColor:[UIColor colorWithRed:0.485 green:0.686 blue:0.667 alpha:1.000]];
//    self.billView.backgroundColor = [UIColor colorWithRed:0.485 green:0.686 blue:0.667 alpha:1.000];
//}

- (void)loadInOutComeArray{
    if (_updateFlg == NO) {
        self.inComeArray = [MHDatabase searchCategoryInCome];
        self.outComeArray = [MHDatabase searchCategoryOutCome];
        _updateFlg = YES;
    }
    //加载初始bill
    self.bill.category = self.outComeArray[0];
    self.bill.money = @"0.00";
    self.bill.dateStr = [NSString currentDateStr];
}


/** 时间选择器 */
- (void)SZCalendatPicker{
    SZCalendarPicker *calendarPicker = [SZCalendarPicker showOnView:self.view];
    calendarPicker.today = [NSDate date];
    calendarPicker.date = calendarPicker.today;
    calendarPicker.frame = CGRectMake(0, SCREEN_SIZE.height - (self.billView.calculatorView.bounds.size.height + 50), SCREEN_SIZE.width, self.billView.calculatorView.bounds.size.height + 50);
    WEAKSELF
    calendarPicker.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year){
        NSLog(@"%li-%li-%li", year,month,day);
        NSString *time = nil;
        if (month<10) {
            time = [NSString stringWithFormat:@"%li-0%li-%li",year,month,day];
        }
        if (day<10) {
            time = [NSString    stringWithFormat:@"%li-%li-0%li",year,month,day];
        }
        if (month<10 && day <10) {
            time = [NSString stringWithFormat:@"%li-0%li-0%li",year,month,day];
        }else if(month>10 && day <10){
            time = [NSString stringWithFormat:@"%li-%li-0%li",year,month,day];
        }else if (month<10 && day >10)
        {
            time = [NSString stringWithFormat:@"%li-0%li-%li",year,month,day];
        }else if (month>10 && day >10){
              time = [NSString stringWithFormat:@"%li-%li-%li",year,month,day];
        }
//        if (weakSelf.isUpdade) {
//            weakSelf.updateTimeStr = time;
//        } else {
//            weakSelf.bill.dateStr = time;
//        }
        [weakSelf.billView.calculatorView setTimeWtihTimeString:time];
        
    };
    
}

#pragma mark - UIScrollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    //* round 四舍五入 */
    NSInteger index = round(point.x/scrollView.frame.size.width);
    self.billView.pageController.currentPage = index;
}

#pragma mark - UICollectionDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TMCategotyCollectionViewCell * cell = nil;
    MHCategory *category = nil;
    if (collectionView==self.billView.inComeCategoryCollectionView) {//收入类别
        cell = (TMCategotyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        category = self.inComeArray[indexPath.row];
    }else if (collectionView==self.billView.outComeCategoryCollectionView)//支出类别1
    {
        cell = (TMCategotyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        category = self.outComeArray[indexPath.row];
    }else{//支出类别2
        cell = (TMCategotyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        category = self.outComeArray[indexPath.row + 24];
    }
    
    //更新HeaderView
    self.billView.selectedCategory = category;
    [self.billView.headerView categoryImageWithFileName:category.categoryImageFileNmae andCategoryName:category.categoryTitle];
    //* 颜色提取 */
    CCColorCube *imageColor = [[CCColorCube alloc] init];
    NSArray *colors = [imageColor extractColorsFromImage:category.categoryImage flags:CCAvoidBlack count:1];
    //* 设置HeaderView的背景颜色 */
    [self.billView.headerView animationWithBgColor:colors.firstObject];

    //更新当前选择的Bill
    self.bill.category = category;
}



#pragma mark - UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_updateFlg == NO) {
        [self loadInOutComeArray];
    }
    if (collectionView==self.billView.inComeCategoryCollectionView)
        return _inComeArray.count;
    else if (collectionView==self.billView.outComeCategoryCollectionView)
        return 24;
    else
        return _outComeArray.count - 24;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TMCategotyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionIdentifier forIndexPath:indexPath];
    
    if (collectionView==self.billView.inComeCategoryCollectionView) {//收入类别
            cell.categoty = [[MHCategory alloc] initWithDict:_inComeArray[indexPath.row]];
        }
        else if (collectionView==self.billView.outComeCategoryCollectionView) {//支出类别1
                cell.categoty = [[MHCategory alloc] initWithDict:_outComeArray[indexPath.row]];
                } else {//支出类别2
//                        if (indexPath.row == self.lastfewExpendCategorys.count) {
////                                TMCategory *category = [TMCategory new];
////                                category.categoryImageFileNmae = @"type_add";
////                                category.categoryTitle = @"编辑";
////                                cell.categoty =category;
//                            } else {
                          cell.categoty = [[MHCategory alloc] initWithDict:_outComeArray[indexPath.row + 24]];
                }
    return cell;

}

#pragma mark - UITableViewDelegate


#pragma mark - UITableViewDataSouces



#pragma mark - SVProgressHUD
- (void)showSVProgressHUD:(NSString *)text {
    [SVProgressHUD setMinimumDismissTimeInterval:0.5];
    [SVProgressHUD showImage:nil status:text];
    //    [SVProgressHUD setMinimumSize:CGSizeMake(100, 60)];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:18]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}

@end
