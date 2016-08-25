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

#define TYPE_IMG_SIZE 28


#define     BLUE ([UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0]);
#define     VIOLET ([UIColor colorWithRed:138/255.0 green:43/255.0 blue:226/255.0 alpha:1.0]);
#define     EMERALD_GREEN  ([UIColor colorWithRed:0/255.0 green:201/255.0 blue:87/255.0 alpha:1.0]);
#define     ORANGE ([UIColor colorWithRed:255/255.0 green:97/255.0 blue:0/255.0 alpha:1.0]);
#define     WHITE ([UIColor colorWithRed:250/255.0 green:255/255.0 blue:240/255.0 alpha:1.0]);
#define     DOUGELLO ([UIColor colorWithRed:235/255.0 green:142/255.0 blue:85/255.0 alpha:1.0]);
#define     DEEPBLUE ([UIColor colorWithRed:51/255.0 green:161/255.0 blue:201/255.0 alpha:1.0]);
#define     TPMATO ([UIColor colorWithRed:255/255.0 green:112/255.0 blue:71/255.0 alpha:1.0]);
#define     LAVENDER ([UIColor colorWithRed:218/255.0 green:112/255.0 blue:214/255.0 alpha:1.0]);

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