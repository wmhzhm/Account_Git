//
//  MHCagegory.m
//  MHAccount
//
//  Created by wmh—future on 16/11/15.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import "MHCategory.h"

@implementation MHCategory

+ (NSMutableArray *)getInComeCategoryArray
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"category" ofType:@"plist"];

    NSArray *cate = [NSArray arrayWithContentsOfFile:plistPath];
    NSMutableArray *mCategory = [[NSMutableArray alloc] init];
    for (NSDictionary *category in cate) {
        MHCategory *categoryModel = [[MHCategory alloc] initWithDict:category];
        if([categoryModel.isIncome isEqualToString:@"1"])
        [mCategory addObject:categoryModel];
    }
    return  mCategory;
}

+ (NSMutableArray *)getOutComeCategoryArray
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"category" ofType:@"plist"];
    
    NSArray *cate = [NSArray arrayWithContentsOfFile:plistPath];
    NSMutableArray *mCategory = [[NSMutableArray alloc] init];
    for (NSDictionary *category in cate) {
        MHCategory *categoryModel = [[MHCategory alloc] initWithDict:category];
        if([categoryModel.isIncome isEqualToString:@"0"])
            [mCategory addObject:categoryModel];
    }
    return  mCategory;
}



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
