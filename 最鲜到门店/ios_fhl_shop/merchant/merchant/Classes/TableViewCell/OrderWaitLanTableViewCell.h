//
//  OrderWaitLanTableViewCell.h
//  merchant
//
//  Created by gs on 15/6/11.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButtonValue.h"
#import "TableViewCellValue.h"

@interface OrderWaitLanTableViewCell : TableViewCellValue
@property (weak, nonatomic) IBOutlet UILabel *labelJInE;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UILabel *labelPeiSongFei;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewOrderType;
@property (weak, nonatomic) IBOutlet UIButtonValue *detailBtn;
@property (weak, nonatomic) IBOutlet UIButtonValue *detailBackgroundBtn;
//@property (weak, nonatomic) IBOutlet UIButtonValue *arrowBtn;
@property (weak, nonatomic) IBOutlet UIButtonValue *contentBtn;
@property (weak, nonatomic) IBOutlet UIButtonValue *contentDisplayBtn;
@property (weak, nonatomic) IBOutlet UIView *contentDetailView;
@property (weak, nonatomic) IBOutlet UIButtonValue *contentShortBtn;
@property (weak, nonatomic) IBOutlet UIButtonValue *contentDisplayShortBtn;
@property (weak, nonatomic) IBOutlet UIView *contentShortDetailView;
+ (CGFloat)cellHeight;
@end
