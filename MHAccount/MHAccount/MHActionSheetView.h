//
//  MHActionSheetView.h
//  MHAccount
//
//  Created by wmh—future on 2017/3/8.
//  Copyright © 2017年 MinghanWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHActionSheetView : UIView
@property (nonatomic, copy) void (^cancelBtnBlock)();
@property (nonatomic, copy) void (^camerBtnBlock)();
@property (nonatomic, copy) void (^albumBtnBlock)();
@end
