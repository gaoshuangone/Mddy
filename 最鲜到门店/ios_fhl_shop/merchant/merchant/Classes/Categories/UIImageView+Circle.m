//
//  UIImageView+Circle.m
//  FHL
//
//  Created by panume on 14-10-17.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "UIImageView+Circle.h"

@implementation UIImageView (Circle)

+ (UIImageView *)circleImageViewFrame:(CGRect)frame Radius:(NSInteger)radius
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    
    imageView.layer.cornerRadius = radius;
    imageView.layer.masksToBounds = YES;
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return imageView;
    
}

@end
