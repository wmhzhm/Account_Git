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


static NSString *const collectionIdentifier = @"categoryCell";


@interface MHAddBillModelViewController()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong)MHAddBillView *billView;

@property (nonatomic, strong)NSMutableArray *inComeArray;
@property (nonatomic, strong)NSMutableArray *outComeArray;
@end

@implementation MHAddBillModelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.billView = [[MHAddBillView alloc] initWithFrame:self.view.frame];
    self.view = self.billView;
    [self.billView.back addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    self.billView.inComeCategoryCollectionView.delegate = self;
    self.billView.outComeCategoryCollectionView.delegate = self;
    self.billView.outComeCategoryCollectionView2.delegate = self;
    self.billView.outComeCategoryScrollView.delegate = self;
    
    self.inComeArray = [MHCategory getInComeCategoryArray];
    self.outComeArray = [MHCategory getOutComeCategoryArray];
    
}


- (void)clickBack{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"返回明细");
    }];
}
- (void)collectionViewRegisterClass {
    [self.billView.inComeCategoryCollectionView registerClass:[TMCategotyCollectionViewCell class] forCellWithReuseIdentifier:collectionIdentifier];
    [self.billView.outComeCategoryCollectionView registerClass:[TMCategotyCollectionViewCell class] forCellWithReuseIdentifier:collectionIdentifier];
    [self.billView.outComeCategoryCollectionView2 registerClass:[TMCategotyCollectionViewCell class] forCellWithReuseIdentifier:collectionIdentifier];
}
#pragma mark - UIScrollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGPoint point = scrollView.contentOffset;
//    //* round 四舍五入 */
//    NSInteger index = round(point.x/scrollView.frame.size.width);
//    self.pageController.currentPage = index;
}

#pragma mark - UICollectionDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}



#pragma mark - UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView==self.billView.inComeCategoryCollectionView)
        return _inComeArray.count;
    else if (collectionView==self.billView.outComeCategoryCollectionView)
        return 24;
    else
        return _outComeArray.count - 24;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TMCategotyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionIdentifier forIndexPath:indexPath];
//    if (collectionView==self.billView.inComeCategoryCollectionView) {//收入类别
//            cell.categoty = [[MHCategory alloc] initWithDict:_inComeArray.[indexPath.row]];
//        }
//    } else if (collectionView==self.expenCategoryCollectionView) {//支出类别1
//        cell.categoty = [[TMDataBaseManager defaultManager] queryCategorysWithPaymentType:expend][indexPath.row];
//    } else {//支出类别2
//        if (indexPath.row == self.lastfewExpendCategorys.count) {
//            TMCategory *category = [TMCategory new];
//            category.categoryImageFileNmae = @"type_add";
//            category.categoryTitle = @"编辑";
//            cell.categoty =category;
//        } else {
//            cell.categoty = self.lastfewExpendCategorys[indexPath.row];
//        }
//    }
    return cell;

}
@end
