//
//  PickerView.h
//  FHL
//
//  Created by panume on 14-9-26.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PickerView : UIControl <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, copy) void (^selectedAction)(NSInteger index);
@property (nonatomic, copy) void (^dismissAction)(NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame contents:(NSArray *)contents;
- (void)showWithSuperView:(UIView *)superView;

@end
