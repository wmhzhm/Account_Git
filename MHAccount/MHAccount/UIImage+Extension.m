//
//  UIImage+Extension.m
//  MHAccount
//
//  Created by 希亚许 on 16/8/23.
//  Copyright © 2016年 MinghanWu. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
- (UIImage *)drawRectWithRoundedCorner:(CGFloat)redius sizetoFit:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(redius, redius)];
    UIGraphicsBeginImageContextWithOptions(rect.size, false, [[UIScreen mainScreen] scale]);
    CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
    
    CGContextClip(UIGraphicsGetCurrentContext());
    [self drawInRect:rect];
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;
}

@end
