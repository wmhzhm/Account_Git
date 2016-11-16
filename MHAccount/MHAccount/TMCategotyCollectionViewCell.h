//
//  TMCategotyCollectionViewCell.h
//  Timi
//
//  Created by chairman on 16/5/26.
//  Copyright © 2016年 LaiYoung. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MHCategory;
@interface TMCategotyCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *categoryImageView;
@property (nonatomic, strong) MHCategory *categoty;
@end
