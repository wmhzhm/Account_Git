//
//  MHBagTypeModel.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/23.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import "MHBagTypeModel.h"

@implementation MHBagTypeModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)bagTypeWithDict:(NSDictionary *)dict
{
    return  [[self alloc] initWithDict:dict];
}
@end
