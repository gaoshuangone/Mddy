//
//  TableViewCellValue.h
//  merchant
//
//  Created by 郏国上 on 15/6/30.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCellValue : UITableViewCell
@property (nonatomic, strong) NSString *iconFileName;
//@property (nonatomic, assign) BOOL bfailDownloadIcon;
@property (nonatomic, assign) BOOL bNeedGetIcon;
//@property (nonatomic, assign) long waybillId;
@property (nonatomic, strong) UIImageView *imageViewIcon;
@property (nonatomic, strong) NSString *orderTypeIconFileName;
@property (nonatomic, strong) UIImageView *imageViewOrderTypeIcon;
@property (nonatomic, assign) BOOL bNeedGetOrderTypeIcon;
@end
