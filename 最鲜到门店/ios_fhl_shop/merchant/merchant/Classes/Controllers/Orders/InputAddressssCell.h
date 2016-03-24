//
//  InputAddressssCell.h
//  merchant
//
//  Created by gs on 15/7/9.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputAddressssCell : UITableViewCell
@property (strong, nonatomic) UILabel *labelAddress;
@property (strong, nonatomic) UILabel *labelCityQU;

-(void)initViewWithAddress:(NSString*)address withCityQu:(NSString*)city WithQu:(NSString*)qu;
@end
