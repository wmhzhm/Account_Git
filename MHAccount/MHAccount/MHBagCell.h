//
//  MHBagCell.h
//  MHAccount
//
//  Created by 希亚许 on 16/8/18.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHBagModel.h"
#import <Masonry.h>
@class MHBagModel;

@interface MHBagCell : UITableViewCell

@property (nonatomic , strong)UIImageView *bcgImg;//背景图片
@property (nonatomic , strong)UIImageView *typeImg;//类型图片
@property (nonatomic , strong)UILabel *typeLabel;//账户类型名称
@property (nonatomic , strong)UILabel *moneyLabel;//账户余额
@property (nonatomic ,strong)MHBagModel *bagModel;//cell对应的Bag模型
+ (void)sumMoneyCell:(MHBagCell *)cell WithAccount:(NSMutableArray *)accountArray;
@end
