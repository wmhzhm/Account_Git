//
//  MHRemarkViewController.h
//  MHAccount
//
//  Created by wmh—future on 2017/3/8.
//  Copyright © 2017年 MinghanWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MHBill;
@interface MHRemarkViewController : UIViewController

@property (strong ,nonatomic) MHBill *bill;
@property (nonatomic, copy) void (^passbackBlock)(NSString *remarks,NSData *photoData);
@end
