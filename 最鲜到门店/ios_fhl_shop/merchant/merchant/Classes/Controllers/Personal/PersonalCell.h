//
//  PersonalCell.h
//  FHL
//
//  Created by panume on 14-10-28.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCell : UITableViewCell

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLabel;

+ (CGFloat)cellHeight;

@end
