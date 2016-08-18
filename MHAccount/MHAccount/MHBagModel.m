//
//  MHBagModel.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/18.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import "MHBagModel.h"

@implementation MHBagModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
         if (self = [super init]) {
                 [self setValuesForKeysWithDictionary:dict];
             }
         return self;
}

+ (instancetype)bagWithDict:(NSDictionary *)dict
{
    return  [[self alloc] initWithDict:dict];
}
@end
