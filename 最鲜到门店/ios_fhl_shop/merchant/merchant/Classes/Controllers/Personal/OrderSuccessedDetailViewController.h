//
//  OrderSuccessedDetailViewController.h
//  merchant
//
//  Created by gs on 14/11/4.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "BaseTableViewController.h"

@interface OrderSuccessedDetailViewController : BaseTableViewController
@property (strong, nonatomic) UILabel* labelPrice;
@property (strong, nonatomic) UILabel* labelSend;
@property (strong, nonatomic) UILabel* labelSuccessed;
@property (strong, nonatomic) UILabel* labelAddressed;
@property (strong, nonatomic) UILabel* labelQianShou;
@property (strong, nonatomic) UILabel* labelPhoneNumber;
@property (strong, nonatomic) UILabel* labelAddr;
@property (strong, nonatomic) NSString* strWaybillId;
@property (strong, nonatomic) UIButton* buttonTEL;
@property (strong, nonatomic) UIButton* buttonMaiJiaTEL;
@property (strong, nonatomic)NSString* strTEL;
@property (strong,nonatomic)UIActivityIndicatorView* activityIndicatorView;
@end
