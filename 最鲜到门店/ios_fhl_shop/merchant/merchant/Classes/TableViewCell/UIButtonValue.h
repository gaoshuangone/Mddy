//
//  UIButtonValue.h
//  merchant
//
//  Created by 郏国上 on 15/6/24.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButtonValue : UIButton
//@property (strong, nonatomic) UIButton *detailButton;
//@property (strong, nonatomic) UIButton *detailBackgroundButton;
//@property (strong, nonatomic) UIButton *arrowButton;
//@property (strong, nonatomic) UIButton *contentButton;
@property (strong, nonatomic) UIView *contentUIView;
//@property (strong, nonatomic) UIView *contentShortUIView;
@property (strong, nonatomic) UIButton *contentDisplayButton;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) BOOL isShortBtn;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
@end
