//
//  MHCagegory.h
//  MHAccount
//
//  Created by wmh—future on 16/11/15.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHCategory : NSObject
@property (strong ,nonatomic) NSString *categoryImageFileNmae;
@property (strong ,nonatomic) NSString *categoryTitle;
@property (strong ,nonatomic) NSString *isIncome;

+ (NSMutableArray *)getInComeCategoryArray;
+ (NSMutableArray *)getOutComeCategoryArray;
+ (instancetype)bagWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
