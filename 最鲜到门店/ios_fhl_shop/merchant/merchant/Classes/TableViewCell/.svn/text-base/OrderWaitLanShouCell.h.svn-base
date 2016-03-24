//
//  OrderCell.h
//  FHL
//
//  Created by panume on 14-10-21.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, OrderType) {
    OrderTypeAll,
    OrderTypeReceipt,
    OrderTypePayment
};

@interface OrderWaitLanShouCell : UITableViewCell


@property (nonatomic,strong) UILabel* labelAddr;
@property (nonatomic,strong) UILabel* labelWishShouHuo;
@property (nonatomic,strong) UILabel* labelLanShou;
@property (nonatomic,strong) UILabel* labelWishShouo;
@property (strong, nonatomic) UIButton* buttonTEL;
@property (strong, nonatomic) UILabel* labelWaitStatus;//区分待签收和待揽收
@property (strong,nonatomic) UILabel* labelLanshouGUDing;//区别待揽收和待签收上揽收时间是否显示
@property (strong, nonatomic) UIImageView* imageViewWait;


@property (strong, nonatomic) UILabel* labelPrice;
@property (strong, nonatomic) UILabel* labelSongDaTime;

@property (strong, nonatomic) UIImageView* imageViewPhone;
+ (CGFloat)cellHeight;
-(void)setFrame1;

@end
