//
//  AccountRechTableViewCell.h
//  merchant
//
//  Created by gs on 15/5/20.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountRechTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;

@property (assign,nonatomic) BOOL isAdd;
+(CGFloat)cellHeight;
-(void)changeColor;
@end
