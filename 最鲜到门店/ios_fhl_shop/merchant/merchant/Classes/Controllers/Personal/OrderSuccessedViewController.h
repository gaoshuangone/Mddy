//
//  OrderSuccessedViewController.h
//  merchant
//
//  Created by gs on 14/11/4.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@interface OrderSuccessedViewController : BaseTableViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)UIActivityIndicatorView* activityIndicatorView;
@property (strong, nonatomic) UIImageView* imageViewNoData;
@end
