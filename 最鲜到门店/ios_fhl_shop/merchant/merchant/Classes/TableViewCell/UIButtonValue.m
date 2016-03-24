//
//  UIButtonValue.m
//  merchant
//
//  Created by 郏国上 on 15/6/24.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "UIButtonValue.h"

@implementation UIButtonValue

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
    
//        _detailButton = nil;
//        _arrowButton = nil;
//        _contentButton = nil;
//        _detailBackgroundButton = nil;
        _contentUIView = nil;
        _row = -1;

    }
    return self;
}
@end
