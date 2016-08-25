//
//  MHUpDateBagView.h
//  MHAccount
//
//  Created by 希亚许 on 16/8/25.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHBagModel.h"
@interface MHUpDateBagView : UIView

@property (nonatomic, strong)UITextField *accountName;
@property (nonatomic ,strong)UITextField *accountMoney;
@property (nonatomic, strong)UIView *colorView;
@property (nonatomic, strong)UILabel *colorLabel;
@property (nonatomic, strong)UIButton *colorImg;
@property (nonatomic, assign)int colorNum;
@property (nonatomic ,strong)MHBagModel *model;

@end
