//
//  OrderDoingCell.h
//  merchant
//
//  Created by gs on 14/11/6.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ORDER_DOING_STATUS) {
    ORDER_EORDER_DOING_CANCEL,
    ORDER_ORDER_DOING_JUSHOU,
};

@interface OrderDoingCell : UITableViewCell
@property (strong, nonatomic) UILabel* labelPrice;
@property (strong, nonatomic) UILabel* labelSend;
@property (strong, nonatomic) UILabel* labelSuccessed;
@property (strong, nonatomic) UILabel* labelStatusTime;
@property (strong, nonatomic) UILabel* labelAddressed;
@property (assign, nonatomic) ORDER_DOING_STATUS orderErrorStatus;
@property (strong , nonatomic) UIImageView* imageViewStatus;
+ (CGFloat)cellHeight;

-(void)changImageView:(ORDER_DOING_STATUS)status;
@end
