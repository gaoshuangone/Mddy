//
//  PresonalInfoCell.h
//  merchant
//
//  Created by gs on 14/11/3.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresonalInfoCell : UITableViewCell
@property (strong, nonatomic) UIImageView* cellImageView;
@property (strong, nonatomic) UIImageView *imageViewYou;
@property (strong, nonatomic) UILabel* labelTitle;
@property (strong, nonatomic) UILabel* labelTitleAddress;
@property (strong, nonatomic) UILabel* labelPhoneNumber;
@property (strong, nonatomic) UILabel* labelAddress;

+(CGFloat)cellHeight;
-(void)setImageViewYouWithIndex:(NSInteger)index;
@end
