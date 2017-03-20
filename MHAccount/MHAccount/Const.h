//
//  Const.h
//  MHAccount
//
//  Created by 希亚许 on 16/8/25.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#ifndef Const_h
#define Const_h


#define WEAKSELF __weak typeof(self) weakSelf = self;

/** 屏幕的SIZE */
#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#define BCG_COLOR_MARGIN 5
#define TYPE_IMG_SIZE 25

#define     BLUE ([UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0]);
#define     VIOLET ([UIColor colorWithRed:138/255.0 green:43/255.0 blue:226/255.0 alpha:1.0]);
#define     EMERALD_GREEN  ([UIColor colorWithRed:0/255.0 green:201/255.0 blue:87/255.0 alpha:1.0]);
#define     ORANGE ([UIColor colorWithRed:255/255.0 green:97/255.0 blue:0/255.0 alpha:1.0]);
#define     WHITE ([UIColor colorWithRed:250/255.0 green:255/255.0 blue:240/255.0 alpha:1.0]);
#define     DOUGELLO ([UIColor colorWithRed:235/255.0 green:142/255.0 blue:85/255.0 alpha:1.0]);
#define     DEEPBLUE ([UIColor colorWithRed:51/255.0 green:161/255.0 blue:201/255.0 alpha:1.0]);
#define     TPMATO ([UIColor colorWithRed:255/255.0 green:112/255.0 blue:71/255.0 alpha:1.0]);
#define     LAVENDER ([UIColor colorWithRed:218/255.0 green:112/255.0 blue:214/255.0 alpha:1.0]);

/** 时光轴线条颜色 */
#define LineColor [UIColor colorWithWhite:0.800 alpha:1.000]
#define SystemBlue [UIColor colorWithRed:10/255.0 green:117/255.0 blue:250/255.0 alpha:1.0]

//#define TYPE_IMG_SIZE 28
#define BillHeaderViewFrame CGRectMake(0, self.lineView.frame.origin.y, [UIScreen mainScreen].bounds.size.width, 60)
#define kSelectColor [UIColor colorWithRed:0.907 green:0.454 blue:0.000 alpha:1.000]
#define padding 10
#define BTNPADDING 20
#define COLORIMG_SIZE 30
/** height +10 是因为image和label都对顶部有5个像素的偏移量 */
#define kCollectionFrame CGRectMake(0, kMaxNBY + kCreateBillHeaderViewFrame.size.height, SCREEN_SIZE.width,(kCollectionCellWidth + 10) * 4)
/** 一个item的宽 */
#define kCollectionCellWidth SCREEN_SIZE.width/6

//按钮选中颜色
#define kSelectColor [UIColor colorWithRed:0.907 green:0.454 blue:0.000 alpha:1.000]

#define kPageControllerFrame CGRectMake(0, kMaxNBY + kCollectionFrame.size.height + kCreateBillHeaderViewFrame.size.height, SCREEN_SIZE.width, 30)

/** 记账界面的headerViewFrame */
#define kCreateBillHeaderViewFrame CGRectMake(0, kMaxNBY, SCREEN_SIZE.width, 60)
/** maxY navigationBar  + maxY statusBar*/
#define kMaxNBY 70
#endif /* Const_h */
