//
//  CouriesTableViewCell.h
//  merchant
//
//  Created by gs on 15/6/11.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouriesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewIC;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelDengJi;

@property (weak, nonatomic) IBOutlet UILabel *labelPhoneNUmber;

@property (weak, nonatomic) IBOutlet UILabel *labelCount;
-(void)setImageWithTel:(NSString*)tel;
@end
