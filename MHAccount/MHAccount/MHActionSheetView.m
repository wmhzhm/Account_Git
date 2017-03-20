//
//  MHActionSheetView.m
//  MHAccount
//
//  Created by wmh—future on 2017/3/8.
//  Copyright © 2017年 MinghanWu. All rights reserved.
//
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS


#import "MHActionSheetView.h"
#import <Masonry.h>
#import "Const.h"
@interface MHActionSheetView()

@property (nonatomic, strong) UIButton *camerBtn;
@property (nonatomic, strong) UIButton *albumBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@end


@implementation MHActionSheetView

#pragma mark - 设置控件位置
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        WEAKSELF
        [self addSubview:self.camerBtn];
        [self.camerBtn makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_SIZE.width-50, 40));
            make.centerX.equalTo(weakSelf);
            make.top.equalTo(weakSelf).offset(10);
        }];
        
        [self addSubview:self.albumBtn];
        [self.albumBtn makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(weakSelf.camerBtn);
            make.centerX.equalTo(weakSelf);
            make.top.equalTo(weakSelf.camerBtn.bottom).offset(10);
        }];
        
        [self addSubview:self.cancelBtn];
        [self.cancelBtn makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_SIZE.width-50, 35));
            make.centerX.equalTo(weakSelf);
            make.top.equalTo(weakSelf.albumBtn.bottom).offset(20);
        }];
    }
    return self;
}


#pragma mark - lazyloading

- (UIButton *)camerBtn
{
    if (!_camerBtn) {
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:@"拍照" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00]];
        [button addTarget:self action:@selector(clickCamerBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        _camerBtn = button;
    }
    return _camerBtn;
}
- (UIButton *)albumBtn
{
    if (!_albumBtn) {
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:@"照片库" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00]];
        [button addTarget:self action:@selector(clickAlbumBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        _albumBtn = button;
    }
    return _albumBtn;
}
- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithRed:0.75 green:0.76 blue:0.78 alpha:1.00]];
        [button addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        _cancelBtn = button;
    }
    return _cancelBtn;
}


#pragma mark - 按钮方法


- (void)clickCamerBtn:(UIButton *)sender {
//    NSLog(@"click CamerBtn");
    if (self.camerBtnBlock) {
        self.camerBtnBlock();
    }
}
- (void)clickAlbumBtn:(UIButton *)sender {
//    NSLog(@"click AlbunBtn");
    if (self.albumBtnBlock) {
        self.albumBtnBlock();
    }
}
-(void)clickCancelBtn:(UIButton *)sender {
//    NSLog(@"click CancelBtn");
    if (self.cancelBtnBlock) {
        self.cancelBtnBlock();
    }
}



@end
