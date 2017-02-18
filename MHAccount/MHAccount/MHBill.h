//
//  MHBill.h
//  MHAccount
//
//  Created by 希亚许 on 16/11/15.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHCategory.h"

@interface MHBill : NSObject
//账单类型
@property (nonatomic, strong) MHCategory *category;
//该笔账单金额
@property (nonatomic ,strong) NSString *money;
//记账时间
@property (nonatomic ,strong) NSString *dateStr;

@end
