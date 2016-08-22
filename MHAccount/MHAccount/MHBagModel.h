//
//  MHBagModel.h
//  MHAccount
//
//  Created by 希亚许 on 16/8/18.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MHBagModel;
#define WEAKSELF __weak typeof(self) weakSelf = self;
@interface MHBagModel : NSObject
@property (nonatomic ,copy)NSString *type;//账户类型
@property (nonatomic ,copy)NSString *img;//图片名称
@property (nonatomic ,assign)int color;//背景颜色
@property (nonatomic ,copy)NSString *money;//账户余额

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)bagWithDict:(NSDictionary *)dict;
@end
