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
#import "Const.h"
#import "POP.h"


@interface MHBagCell()


@end

@implementation MHBagCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        //设置点击无样式
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //取消分割线
        
        //创建self的弱引用
        WEAKSELF
            //背景图片约束
        [self.contentView addSubview:self.bcgImg];
        _bcgImg.layer.cornerRadius = 5;
        _bcgImg.layer.masksToBounds = YES;
        [self.bcgImg makeConstraints:^(MASConstraintMaker *make){
            //Mask约束
            make.center.equalTo(weakSelf.contentView);
            make.edges.offset(UIEdgeInsetsMake(2, 2, 2, 2));
        }];
            //类型图片约束
        [self.contentView addSubview:self.typeImg];
        [_typeImg makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(weakSelf.contentView);
            make.left.equalTo(weakSelf.contentView).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(TYPE_IMG_SIZE, TYPE_IMG_SIZE));
        }];
            //账户类型名称Label约束
        [self.contentView addSubview:self.typeLabel];
        [_typeLabel makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(weakSelf.contentView);
            make.left.equalTo(_typeImg.mas_right).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(100, 30));
        }];
            //账户余额Label约束
        [self.contentView addSubview:self.moneyLabel];
        [_moneyLabel makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(weakSelf.contentView);
            make.right.equalTo(weakSelf.contentView).with.offset(-5);
        }];
    }
    return self;
}

- (UIImageView *)bcgImg
{
    if (!_bcgImg) {
        _bcgImg = [[UIImageView alloc] init];
    }
    return _bcgImg;
}

- (UIImageView *)typeImg
{
    if (!_typeImg) {
        _typeImg = [[UIImageView alloc] init];
    }
    return _typeImg;
}

- (UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = [UIFont systemFontOfSize:18];
        
        _typeLabel.textColor = [UIColor whiteColor];
    }
    return _typeLabel;
}

- (UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.font = [UIFont systemFontOfSize:16];
    }
    return _moneyLabel;
}

+ (void)sumMoneyCell:(MHBagCell *)cell WithAccount:(NSMutableArray *)accountArray
{
    MHBagModel *myAccount = [[MHBagModel alloc] init];
    myAccount.type = @"余额";
    myAccount.img = @"余额_img";
    myAccount.color = 90;
    float allMoney = 0.00;
    for (MHBagModel *model in accountArray) {
        allMoney = allMoney + [model.money floatValue];
    }
    myAccount.money = [NSString stringWithFormat:@"%.2f",allMoney];
    cell.bagModel = myAccount;
    cell.typeLabel.textColor = [UIColor blackColor];
    cell.moneyLabel.textColor = [UIColor blackColor];
    cell.moneyLabel.font = [UIFont systemFontOfSize:20];
}

- (void)setBagModel:(MHBagModel *)bagModel
{
    _typeImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",bagModel.img]];
    _typeLabel.text = bagModel.type;
    _moneyLabel.text = bagModel.money;
    switch (bagModel.color) {
        case 0:
            self.bcgImg.backgroundColor = BLUE;
            break;
        case 1:
            self.bcgImg.backgroundColor = VIOLET;
            break;
        case 2:
            self.bcgImg.backgroundColor = EMERALD_GREEN;
            break;
        case 3:
            self.bcgImg.backgroundColor = ORANGE;
            break;
        case 4:
            self.bcgImg.backgroundColor = DOUGELLO;
            break;
        case 5:
            self.bcgImg.backgroundColor = DEEPBLUE;
            break;
        case 6:
            self.bcgImg.backgroundColor = TPMATO;
            break;
        case 7:
            self.bcgImg.backgroundColor = LAVENDER;
            break;
        default:
            self.bcgImg.backgroundColor = WHITE;
            break;
    }
}



-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (self.highlighted) {
        
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.duration           = 0.1f;
        scaleAnimation.toValue            = [NSValue valueWithCGPoint:CGPointMake(0.95, 0.95)];
        [self.typeImg pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        [self.typeLabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        [self.moneyLabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        
        
    } else {
        
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.toValue             = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnimation.velocity            = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
        scaleAnimation.springBounciness    = 20.f;
//        [self.titlelabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        [self.typeImg pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        [self.typeLabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        [self.moneyLabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }

}
@end
