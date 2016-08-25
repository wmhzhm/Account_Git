//
//  MHDatabase.h
//  MHAccount
//
//  Created by 希亚许 on 16/8/18.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHBagModel.h"

@interface MHDatabase : NSObject
+ (void)createDatabase;
+ (NSMutableArray*)searchAccount;
+ (NSMutableArray *)searchBagType;
+ (void)addBagModel:(MHBagModel*)model;
+ (void)deleteBagModel:(MHBagModel *)model;
+ (void)upDateOldBagModel:(MHBagModel*)oldModel ToNewBagModel:(MHBagModel*)newModel;
@end
