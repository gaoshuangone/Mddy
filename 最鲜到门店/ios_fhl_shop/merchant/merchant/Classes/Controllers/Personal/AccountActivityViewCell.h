//
//  AccountActivityViewCell.h
//  merchant
//
//  Created by gs on 15/5/21.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountActivityViewCell : UITableViewCell
@property (strong, nonatomic)NSArray* array;

@property (strong, nonatomic)UILabel* labelActivity;
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
-(void)setText;
@end
