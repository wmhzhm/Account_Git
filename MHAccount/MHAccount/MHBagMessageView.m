//
//  MHBagMessageView.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/24.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#define     BLUE ([UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0]);
#define     VIOLET ([UIColor colorWithRed:138/255.0 green:43/255.0 blue:226/255.0 alpha:1.0]);
#define     EMERALD_GREEN  ([UIColor colorWithRed:0/255.0 green:201/255.0 blue:87/255.0 alpha:1.0]);
#define     ORANGE ([UIColor colorWithRed:255/255.0 green:97/255.0 blue:0/255.0 alpha:1.0]);
#define     WHITE ([UIColor colorWithRed:250/255.0 green:255/255.0 blue:240/255.0 alpha:1.0]);
#define     DOUGELLO ([UIColor colorWithRed:235/255.0 green:142/255.0 blue:85/255.0 alpha:1.0]);
#define     DEEPBLUE ([UIColor colorWithRed:51/255.0 green:161/255.0 blue:201/255.0 alpha:1.0]);
#define     TPMATO ([UIColor colorWithRed:255/255.0 green:99/255.0 blue:71/255.0 alpha:1.0]);
#define     LAVENDER ([UIColor colorWithRed:218/255.0 green:112/255.0 blue:214/255.0 alpha:1.0]);

#define padding 10
#define BTNPADDING 20
#define COLORIMG_SIZE 30

#import "MHBagMessageView.h"
#import <Masonry.h>


@implementation MHBagMessageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithRed:250/255.0 green:255/255.0 blue:240/255.0 alpha:1.0];
    [self layout];
    
    self.colorNum = 0;
    
    
    [self initColorBtn];
    return self;
}


- (void)layout{
    WEAKSELF
    [self addSubview:self.accountName];
    [self.accountName makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(44);
        make.centerX.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(5);
        make.top.equalTo(70);
    }];
    
    [self addSubview:self.accountMoney];
    [self.accountMoney makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(44);
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(_accountName.bottom).offset(padding);
        make.left.equalTo(weakSelf).with.offset(5);
    }];
    
    [self addSubview:self.colorView];
    [self.colorView makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(_accountMoney.bottom).offset(padding);
        make.centerX.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(5);
        make.height.equalTo(200);
    }];
    
    [self.colorView addSubview:self.colorLabel];
    [self.colorLabel makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(padding + 5);
        make.left.equalTo(padding);
    }];
    
    [self.colorView addSubview:self.colorImg];
    [self.colorImg makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(weakSelf.colorLabel);
        make.left.equalTo(weakSelf.colorLabel.right).offset(20);
        make.size.equalTo(CGSizeMake(COLORIMG_SIZE, COLORIMG_SIZE));
    }];
}
- (void)clickColorBtn:(UIButton *)button
{
    NSInteger btnNum = button.tag;
    self.colorNum = (int)btnNum;
    NSLog(@"colorNum : %d",_colorNum);
    switch ( btnNum ) {
        case 0:
            self.colorImg.backgroundColor = BLUE;
            break;
        case 1:
            self.colorImg.backgroundColor = VIOLET;
            break;
        case 2:
            self.colorImg.backgroundColor = EMERALD_GREEN;
            break;
        case 3:
            self.colorImg.backgroundColor = ORANGE;
            break;
        case 4:
            self.colorImg.backgroundColor = DOUGELLO;
            break;
        case 5:
            self.colorImg.backgroundColor = DEEPBLUE;
            break;
        case 6:
            self.colorImg.backgroundColor = TPMATO;
            break;
        case 7:
            self.colorImg.backgroundColor = LAVENDER;
            break;
        default:
            self.colorImg.backgroundColor = TPMATO;
            break;
    }
}

- (void)initColorBtn{
    for (int i = 0; i < 8; i++) {
        UIButton *colorBtn = [[UIButton alloc] init];
        [colorBtn addTarget:self action:@selector(clickColorBtn:) forControlEvents:UIControlEventTouchUpInside];
        colorBtn.layer.cornerRadius = 5;
        colorBtn.layer.masksToBounds = YES;
        colorBtn.tag = i;
        
        [self.colorView addSubview:colorBtn];
        int cloumn = i / 4;
        colorBtn.frame = CGRectMake(BTNPADDING + (i % 4) * (40 + BTNPADDING),60 + cloumn * (40 + BTNPADDING) , 40, 40);
        switch ( i ) {
            case 0:
                colorBtn.backgroundColor = BLUE;
                break;
            case 1:
                colorBtn.backgroundColor = VIOLET;
                break;
            case 2:
                colorBtn.backgroundColor = EMERALD_GREEN;
                break;
            case 3:
                colorBtn.backgroundColor = ORANGE;
                break;
            case 4:
                colorBtn.backgroundColor = DOUGELLO;
                break;
            case 5:
                colorBtn.backgroundColor = DEEPBLUE;
                break;
            case 6:
                colorBtn.backgroundColor = TPMATO;
                break;
            case 7:
                colorBtn.backgroundColor = LAVENDER;
                break;
            default:
                colorBtn.backgroundColor = TPMATO;
                break;
        }//switch end
        
    }
}

- (UITextField *)accountName
{
    if (!_accountName) {
        _accountName = [[UITextField alloc] init];
    }
    _accountName.placeholder = [NSString stringWithFormat:@"账户名称"];
    _accountName.borderStyle = UITextBorderStyleRoundedRect;
    return _accountName;
}


- (UITextField *)accountMoney
{
    if (!_accountMoney) {
        _accountMoney = [[UITextField alloc] init];
        _accountMoney.placeholder = [NSString stringWithFormat:@"账户金额"];
        _accountMoney.borderStyle = UITextBorderStyleRoundedRect;
        _accountMoney.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }

    return _accountMoney;
}

- (UIView*)colorView
{
    if (!_colorView) {
        _colorView = [[UIView alloc] init];
        _colorView.backgroundColor = [UIColor whiteColor];
        _colorView.layer.cornerRadius = 10;
        _colorView.layer.masksToBounds = YES;
    }
    return _colorView;
}

- (UILabel *)colorLabel
{
    if (!_colorLabel) {
        _colorLabel = [[UILabel alloc] init];
        _colorLabel.text = @"选择颜色";
        _colorLabel.textColor = [UIColor grayColor];
    }
    return _colorLabel;
}

- (UIButton *)colorImg
{
    if (!_colorImg) {
        _colorImg = [[UIButton alloc] init];
        _colorImg.layer.cornerRadius = COLORIMG_SIZE / 2;
        _colorImg.layer.masksToBounds = YES;
        _colorImg.backgroundColor = BLUE;
    }
    return _colorImg;
}

@end
