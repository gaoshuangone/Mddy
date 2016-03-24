//
//  UIImage+Hex.m
//  FHL
//
//  Created by panume on 14-9-25.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "UIImage+Hex.h"

@implementation UIImage (Hex)

+ (UIImage *)imageWithHex:(long)hex
{
//    UIColor *color = [UIColor colorWithHex:hex];
    UIColor *color = [UIColor whiteColor];
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
