//
//  MHAddBagCell.h
//  MHAccount
//
//  Created by 希亚许 on 16/8/22.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "MHBagTypeModel.h"

@class MHBagTypeModel;

@interface MHAddBagCell : UITableViewCell

@property(nonatomic, strong)UIImageView *typeImg;
@property(nonatomic ,strong)UILabel *typeName;
@property (nonatomic ,strong)MHBagTypeModel *bagTypeModel;//cell对应的Bag模型
@end
