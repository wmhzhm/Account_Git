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
+ (NSArray*)searchAccount;
+ (NSArray *)searchBagType;
+ (void)addBagModel:(MHBagModel*)model;
@end
