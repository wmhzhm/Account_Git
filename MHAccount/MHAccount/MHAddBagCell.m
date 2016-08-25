//
//  MHAddBagCell.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/22.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS


#import "MHAddBagCell.h"
#import "UIImage+Extension.h"
#import "Const.h"


@implementation MHAddBagCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    WEAKSELF
    [self.contentView addSubview:self.typeImg];
    [_typeImg makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(TYPE_IMG_SIZE, TYPE_IMG_SIZE));
        
    }];
    _typeImg.layer.cornerRadius = TYPE_IMG_SIZE / 2;
    _typeImg.layer.masksToBounds = YES;
    
    
    [self.contentView addSubview:self.typeName];
    [_typeName makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(_typeImg.mas_right).with.offset(5);
    }];
    
    return self;
}

- (UIImageView *)typeImg
{
    if (!_typeImg) {
        _typeImg = [[UIImageView alloc] init];
    }
    return _typeImg;
}

- (UILabel *)typeName
{
    if (!_typeName) {
        _typeName = [[UILabel alloc] init];
        _typeName.textColor = [UIColor blackColor];
        _typeName.font = [UIFont systemFontOfSize:18];
    }
    return  _typeName;
}

- (void)setBagTypeModel:(MHBagTypeModel *)bagTypeModel
{
#pragma wrong
    _typeImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",bagTypeModel.img]];
    
    _typeName.text = bagTypeModel.type;
    switch (bagTypeModel.color) {
        case 0:
            _typeImg.backgroundColor = BLUE;
            break;
        case 1:
            _typeImg.backgroundColor = VIOLET;
            break;
        case 2:
            _typeImg.backgroundColor = EMERALD_GREEN;
            break;
        case 3:
            _typeImg.backgroundColor = ORANGE;
            break;
        case 4:
            _typeImg.backgroundColor = DOUGELLO;
            break;
        case 5:
            _typeImg.backgroundColor = DEEPBLUE;
            break;
        case 6:
            _typeImg.backgroundColor = TPMATO;
            break;
        case 7:
            _typeImg.backgroundColor = LAVENDER;
            break;
            
        default:
            _typeImg.backgroundColor = TPMATO;
            break;
    }
}


@end