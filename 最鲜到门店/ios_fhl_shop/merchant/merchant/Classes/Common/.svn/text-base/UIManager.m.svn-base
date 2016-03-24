//
//  UIManager.m
//  FHL
//
//  Created by panume on 14-9-26.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "UIManager.h"

@implementation UIManager

+ (UIBarButtonItem *)backBarButtonWithTarget:(id)target action:(SEL)action
{
    
    UIImage *image = [UIImage imageNamed:@"back.png"];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
