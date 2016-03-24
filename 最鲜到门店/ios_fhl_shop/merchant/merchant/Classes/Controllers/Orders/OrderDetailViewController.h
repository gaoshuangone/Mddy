//
//  OrderDetailViewController.h
//  merchant
//
//  Created by gs on 14/11/5.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "BaseTableViewController.h"
#import "AnimatedView.h"


typedef NS_ENUM(NSUInteger, ORDER_STATUS) {
    ORDER_STATUS_WAIT_QIANGDAN,
    ORDER_STATUS_WAIT_LANSHOU,
    ORDER_STATUS_WAIT_QIANSHOU,
    
};
@interface OrderDetailViewController : BaseTableViewController<UIAlertViewDelegate,UIActionSheetDelegate,AnimateDelegate>
@property (strong, nonatomic) UILabel* labelPrice;
@property (strong, nonatomic) UILabel* labelSend;
@property (strong, nonatomic) UILabel* labelSuccessed;
@property (strong, nonatomic) UILabel* labelAddressed;
@property (strong, nonatomic) UILabel* labelQianShou;
@property (strong, nonatomic) UILabel* labelPhoneNumber;
@property (strong, nonatomic) UILabel* labelAddr;
@property (strong, nonatomic) UILabel* labelWishShouHuo;
@property (strong, nonatomic) UILabel* labelLanShou;
@property (strong, nonatomic) UIButton* buttonCancel;
@property (strong, nonatomic) UIButton* buttonTEL;
@property (strong, nonatomic) UIButton* buttonMaiJiaTEL;

@property (assign, nonatomic)ORDER_STATUS order_status;
@property (strong, nonatomic)NSString* strWayBillld;
@property (strong, nonatomic)NSString* strTEL;
@property (assign, nonatomic) NSInteger distance;

@end
