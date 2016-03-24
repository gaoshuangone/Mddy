//
//  OrderErrorDetailkViewController.h
//  merchant
//
//  Created by gs on 14/11/5.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSUInteger, ORDER_ERROR_STATUS) {
    ORDER_ERROR_STATUS_WAIT_CANCEL,
    ORDER_ERROR_STATUS_WAIT_JUSHOU,
    
};
typedef NS_ENUM(NSUInteger, ORDER_statusED) {
    ORDER_CANCEL,
    ORDER_JUSHOU,
    
    
};
@interface OrderErrorDetailkViewController : BaseViewController
@property(assign,nonatomic)ORDER_ERROR_STATUS orderStatus;//区分正在处理中的拒收和取消

@property (assign, nonatomic)ORDER_statusED orderStatusED;//区分已完成的拒收和取消

@property (assign,nonatomic) BOOL isDonig;//区分已完成的还是已处理中的

@property (strong, nonatomic) UILabel* labelPrice;
@property (strong, nonatomic) UILabel* labelSend;
@property (strong, nonatomic) UILabel* labelSuccessed;
@property (strong, nonatomic) UILabel* labelAddressed;
@property (strong, nonatomic) UILabel* labelQianShou;
@property (strong, nonatomic) UILabel* labelPhoneNumber;
@property (strong, nonatomic) UILabel* labelAddr;
@property (strong, nonatomic) UILabel* labelWishShouHuo;
@property (strong, nonatomic) UILabel* labelLanShou;
@property (strong, nonatomic) UILabel* labelJuShouReason;
@property (strong, nonatomic) NSString* strWayBillld;
@property (strong, nonatomic) UIButton* buttonTEL;
@property (strong, nonatomic) UIButton* buttonMaiJiaTEL;
@property (strong, nonatomic) NSString* strTEL;

@end
