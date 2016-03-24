//
//  ButtonDetailH5.h
//  merchant
//
//  Created by gs on 15/6/29.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonDetailH5 : UIButton
@property (strong, nonatomic) UIImageView *imageViewbut;
@property (strong, nonatomic) UIImageView *imageViewbutIcon;
@property (strong, nonatomic) UILabel *labelBut;
@property (strong, nonatomic) UIButton* buttonBut;
@property (copy, nonatomic) void(^buttonPressed)(NSInteger tag);
-(instancetype)initWithFrame:(CGRect)frame;
@end
