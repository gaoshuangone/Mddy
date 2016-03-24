//
//  UIColor+Hex.m
//  FHL
//
//  Created by panume on 14-9-15.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(long)hex
{
    return [UIColor colorWithHex:hex alpha:1.0];
}

+ (UIColor *)colorWithHex:(long)hex alpha:(CGFloat)alpha
{
    float red = ((float)((hex & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hex & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hex & 0xFF))/255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
