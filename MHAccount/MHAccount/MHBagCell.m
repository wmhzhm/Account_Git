//
//  MHBagCell.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/18.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "MHBagCell.h"
#import "MHBagModel.h"
#import <Masonry.h>


@interface MHBagCell()
@property (nonatomic , strong)UIImageView *bcgImg;//背景图片
@property (nonatomic , strong)UIImageView *typeImg;//类型图片
@property (nonatomic , strong)UILabel *typeLabel;//账户类型名称
@property (nonatomic , strong)UILabel *moneyLabel;//账户余额
@property (nonatomic ,strong)MHBagModel *bagModel;//cell对应的Bag模型

@end

@implementation MHBagCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        //创建self的弱引用
        WEAKSELF
            //背景图片约束
        [self.contentView addSubview:_bcgImg];
        [self.bcgImg mas_makeConstraints:^(MASConstraintMaker *make){
            //Mask约束
            make.center.equalTo(weakSelf.contentView);
            make.top.equalTo(0);
            make.bottom.equalTo(0);
            make.left.equalTo(0);
            make.right.equalTo(0);
        }];
            //类型图片约束
        [self.contentView addSubview:_typeImg];
        [_typeImg mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(weakSelf.contentView);
            make.left.equalTo(10);
        }];
            //账户类型名称Label约束
            //账户余额Label约束
    }
    return 0;
}

- (UIImageView *)bcgImg
{
    if (!_bcgImg) {
        _bcgImg = [[UIImageView alloc] init];
        _bcgImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_bagModel.color]];
    }
    return _bcgImg;
}

- (UIImageView *)typeImg
{
    if (!_typeImg) {
        _typeImg = [[UIImageView alloc] init];
        _typeImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_bagModel.type]];
    }
    return _typeImg;
}

- (UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.text = [NSString stringWithFormat:@"%@",_bagModel.type];
        _typeLabel.font = [UIFont systemFontOfSize:12];
        _typeLabel.textColor = [UIColor whiteColor];
    }
    return _typeLabel;
}

- (UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.text = [NSString stringWithFormat:@"%@",_bagModel.money];
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.font = [UIFont systemFontOfSize:10];
    }
    return _moneyLabel;
}
@end
