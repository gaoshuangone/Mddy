//
//  AreaPickerView.h
//  FHL
//
//  Created by panume on 14-9-30.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import <Foundation/Foundation.h>


#define PROVINCE_NAME   @"provinceName"
#define PROVINCE_CODE   @"provinceCode"
#define CITY_NAME       @"cityName"
#define CITY_CODE       @"cityCode"
#define DISTRICT_NAME   @"districtName"
#define DISTRICT_CODE   @"districtCode"

@interface AreaPickerView : UIControl

@property (nonatomic, strong) NSArray *provinces;
@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, strong) NSArray *districts;
@property (nonatomic, copy) void (^selectDistrictAction)(NSDictionary *nameInfo,NSDictionary *codeInfo);
@property (nonatomic, copy) void (^dismissAction) (void);

- (instancetype)initWithFrame:(CGRect)frame;
- (void)showWithSuperView:(UIView *)superView withDiList:(int)diList;
- (NSArray *)districts;
@end
