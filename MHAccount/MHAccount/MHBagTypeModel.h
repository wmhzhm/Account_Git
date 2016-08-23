//
//  MHBagTypeModel.h
//  MHAccount
//
//  Created by 希亚许 on 16/8/23.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import <Foundation/Foundation.h>
#define WEAKSELF __weak typeof(self) weakSelf = self;
@interface MHBagTypeModel : NSObject
@property (nonatomic ,copy)NSString *type;//账户类型
@property (nonatomic ,copy)NSString *img;//图片名称
@property (nonatomic ,assign)int color;//背景颜色

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)bagTypeWithDict:(NSDictionary *)dict;
@end
