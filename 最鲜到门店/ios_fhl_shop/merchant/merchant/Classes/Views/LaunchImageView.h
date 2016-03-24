//
//  LaunchImageView.h
//  FHL
//
//  Created by panume on 14/12/15.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaunchImageView : UIView

- (instancetype)initWithFrame:(CGRect)frame remind:(NSString *)remind;

@property (nonatomic, strong) NSString *remind;
@property (nonatomic, assign) BOOL netStatus;
@property (nonatomic, strong) UILabel *remindLabel;

@end
