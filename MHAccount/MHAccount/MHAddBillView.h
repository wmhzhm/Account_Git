//
//  MHAddBillView.h
//  MHAccount
//
//  Created by 希亚许 on 16/8/30.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHAddBillView : UIView
@property (nonatomic,strong)UIButton *back;
@property (nonatomic ,strong)UISegmentedControl *segmentedControl;
//InComeCollectionView
@property (nonatomic, strong) UICollectionView *inComeCategoryCollectionView;
//OutComeCollectionView1-2
@property (nonatomic, strong) UICollectionView *outComeCategoryCollectionView;
@property (nonatomic, strong) UICollectionView *outComeCategoryCollectionView2;
@property (nonatomic, strong) UIScrollView *outComeCategoryScrollView;
@property (nonatomic, strong) UIPageControl *pageController;
@end
