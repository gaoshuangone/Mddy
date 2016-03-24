//
//  AreaPickerView.m
//  FHL
//
//  Created by panume on 14-9-30.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "AreaPickerView.h"
#import "FMDB.h"

#define PICKER_HIGH     162

@interface AreaPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSInteger selectedCityIndex;
    NSInteger selectedProvinceIndex;
    
}

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, strong) UIView *superView;
@property (nonatomic,strong) NSString* strProvince;
@property (nonatomic,strong)NSString* strCity;

@end

@implementation AreaPickerView

- (instancetype)initWithFrame:(CGRect)frame 
{
    FLDDLogDebug(@"frame:%@", NSStringFromCGRect(frame));
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHex:0x000 alpha:0.0];
        [self addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, WINDOW_HEIGHT - PICKER_HIGH , WINDOW_WIDTH, 150)];
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.pickerView.backgroundColor =[UIColor whiteColor ];
     
//        [UIColor colorWithHex:0xf2f2f2];
        self.pickerView.showsSelectionIndicator = YES;
        
        selectedCityIndex = 0;
        selectedProvinceIndex = 0;
        
        [self addSubview:self.pickerView];
        
        
        
//        [self.pickerView selectRow:10 inComponent:0 animated:YES];
//        
//        
//        selectedProvinceIndex = 10;
//        selectedCityIndex = 0;
//        self.cities = [NSMutableArray array];
//        self.districts = [NSMutableArray array];
////        [self.pickerView reloadComponent:1];
////        [self.pickerView reloadComponent:2];
      
//
//        
//        selectedCityIndex = 0;
//        self.districts = [NSMutableArray array];
////        [self.pickerView  reloadComponent:2];
////        [self.pickerView  selectRow:4 inComponent:2 animated:YES];
    }
    return self;
}



- (FMDatabase *)db
{
    if (_db) {
        return _db;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Area" ofType:@"db"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    if (![db open]) {
        FLDDLogWarn(@"could not open db");
        return nil;
    }
    
    FLDDLogDebug(@"db open success:%@", db);

    _db = db;
    
    return db;
}


- (NSArray *)districts
{
    if (!self.db) {
        return @[];
    }
    
    if (_districts.count > 0) {
        return _districts;
    }
    
    NSMutableArray *districts = [NSMutableArray array];
    
    FMResultSet *rs = [self.db executeQuery:@"SELECT * FROM District WHERE provinceCode = ? and cityCode = ?", [SelfUser currentSelfUser].proVinceCode ,[SelfUser currentSelfUser].cityCode];
//     FMResultSet *rs = [self.db executeQuery:@"SELECT * FROM District WHERE provinceCode = 330000 and cityCode = 330100 "];
    while ([rs next]) {
        NSString *districtCode = [rs stringForColumn:DISTRICT_CODE];
        NSString *districtName = [rs stringForColumn:DISTRICT_NAME];
        
        NSDictionary *district = @{DISTRICT_NAME : districtName,
                                   DISTRICT_CODE : districtCode
                                   };
        [districts addObject:district];
    }
    [rs close];
    
    
    _districts = [NSArray arrayWithArray:districts];
    
    return _districts;
}

- (NSArray *)cities
{
    if (!self.db) {
        return @[];
    }
    
    if (_cities.count > 0) {
        return _cities;
    }
    NSMutableArray *cities = [NSMutableArray array];
    
    FMResultSet *rs = [self.db executeQuery:@"SELECT * FROM City WHERE provinceCode = ?", [SelfUser currentSelfUser].proVinceCode];
// FMResultSet *rs = [self.db executeQuery:@"SELECT * FROM City WHERE provinceCode = 330000"];
    
    while ([rs next]) {
        NSString *cityName = [rs stringForColumn:CITY_NAME];
        NSString *cityCode = [rs stringForColumn:CITY_CODE];
//        NSString *provincode = [rs stringForColumn:PROVINCE_CODE];
        
        NSDictionary *city = @{CITY_CODE : cityCode,
                               CITY_NAME : cityName
                               };
        
        [cities addObject:city];
        
//        FLDDLogDebug(@"provinceCode:%@", provincode);
    }
    
    [rs close];
    
    _cities = [NSArray arrayWithArray:cities];
    
    return _cities;
}

- (NSArray *)provinces
{
    if (!self.db) {
        return @[];
    }
    if (_provinces.count > 0) {
        return _provinces;
    }
    NSMutableArray *provinces = [NSMutableArray array];
    
    FMResultSet *rs = [self.db executeQuery:@"SELECT * FROM Province"];
    
    while ([rs next]) {
        NSString *provinceName = [rs stringForColumn:PROVINCE_NAME];
        NSString *provinceCode = [rs stringForColumn:PROVINCE_CODE];
        
        NSDictionary *province = @{PROVINCE_NAME : provinceName,
                                   PROVINCE_CODE : provinceCode
                                   };
        
        [provinces addObject:province];
    }
    
    [rs close];
    
    _provinces = [NSArray arrayWithArray:provinces];
    return _provinces;
}


- (void)showWithSuperView:(UIView *)superView withDiList:(int)diList
{
    if (!self.db) {
        return;
    }
    if (self.superview) {
        [self removeFromSuperview];
    }
    else {
         [self.pickerView selectRow:diList inComponent:0 animated:YES];
        _superView = superView;
//        self.alpha = 0.0;
        self.frame = CGRectMake(0, 1000, self.bounds.size.width, self.bounds.size.height);
        [_superView addSubview:self];
        //        self.alpha = 0.0;
        
        [UIView animateWithDuration:0.2 animations:^{
//            self.alpha = 1.0;
            self.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
            
        } completion:^(BOOL finished) {
            
            self.backgroundColor = [UIColor colorWithHex:0x000 alpha:0.5];

            
//            NSString *provinceName = [self.provinces[[self.pickerView selectedRowInComponent:0] ] objectForKey:PROVINCE_NAME];
//            NSString *cityName = [self.cities[[self.pickerView selectedRowInComponent:1]] objectForKey:CITY_NAME];
//            NSString *districtName = [self.districts[[self.pickerView selectedRowInComponent:2]] objectForKey:DISTRICT_NAME];
//
//            NSString *provinceCode = [self.provinces[[self.pickerView selectedRowInComponent:0] ] objectForKey:PROVINCE_CODE];
//            NSString *cityCode = [self.cities[[self.pickerView selectedRowInComponent:1]] objectForKey:CITY_CODE];
//            NSString *districtCode = [self.districts[[self.pickerView selectedRowInComponent:2]] objectForKey:DISTRICT_CODE];
            
            if (self.selectDistrictAction) {
//                self.selectDistrictAction(@{PROVINCE_NAME: provinceName,
//                                            CITY_NAME: cityName,
//                                            DISTRICT_NAME:districtName} ,
//                                          @{PROVINCE_CODE: provinceCode,
//                                            CITY_CODE: cityCode,
//                                            DISTRICT_CODE:districtCode}
//                                          );
            }
        }];
    }
    
}

- (IBAction)dismiss:(id)sender
{
    
    self.backgroundColor = [UIColor colorWithHex:0x000 alpha:0.0];

    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, 1000, self.bounds.size.width, self.bounds.size.height);
        
    } completion:^(BOOL finished) {
        [self.db close];
        if (self.dismissAction) {
            self.dismissAction();
        }
        [self removeFromSuperview];
        
    }];
    
    
}

#pragma mark -

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
//    if (component == 0) {
//        return self.provinces.count;
//
//    }
//    else if (component == 1)
//    {
//        return self.cities.count;
//    }
//    else
//    {
        return self.districts.count;
//    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
//    if (component == 0) {
//        return [self.provinces[row] objectForKey:PROVINCE_NAME];
//        
//    }
//    else if (component == 1)
//    {
//        return [self.cities[row] objectForKey:CITY_NAME];
//    }
//    else
//    {
        return [self.districts[row] objectForKey:DISTRICT_NAME];
//    }
    
    return @"";
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.bounds.size.width / 3, 30)];
    
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    
//    if (component == 0) {
//        label.text = [self.provinces[row] objectForKey:PROVINCE_NAME];
//        
//    }
//    else if (component == 1)
//    {
//        label.text = [self.cities[row] objectForKey:CITY_NAME];
//    }
//    else
//    {
        label.text = [self.districts[row] objectForKey:DISTRICT_NAME];
//    }
    
    return label;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
//    if (component == 0) {
//        selectedProvinceIndex = row;
//        selectedCityIndex = 0;
//        self.cities = [NSMutableArray array];
        self.districts = [NSMutableArray array];
        
 
    
//    NSString *provinceName = [self.provinces[[self.pickerView selectedRowInComponent:0] ] objectForKey:PROVINCE_NAME];
//    NSString *cityName = [self.cities[[self.pickerView selectedRowInComponent:1]] objectForKey:CITY_NAME];
//    NSString *districtName = [self.districts[[self.pickerView selectedRowInComponent:2]] objectForKey:DISTRICT_NAME];
//    
//    NSString *provinceCode = [self.provinces[[self.pickerView selectedRowInComponent:0] ] objectForKey:PROVINCE_CODE];
//    NSString *cityCode = [self.cities[[self.pickerView selectedRowInComponent:1]] objectForKey:CITY_CODE];
//    NSString *districtCode = [self.districts[[self.pickerView selectedRowInComponent:2]] objectForKey:DISTRICT_CODE];
    
    if (self.selectDistrictAction) {
//        self.selectDistrictAction(@{PROVINCE_NAME: provinceName,
//                                    CITY_NAME: cityName,
//                                    DISTRICT_NAME:districtName} ,
//                                  @{PROVINCE_CODE: provinceCode,
//                                    CITY_CODE: cityCode,
//                                    DISTRICT_CODE:districtCode}
//                                  );
    
        for (NSString* dict in [self provinces]) {
            if ([[dict valueForKey:@"provinceCode"]isEqualToString:[SelfUser currentSelfUser].proVinceCode] ) {
                self.strProvince =[dict valueForKey:@"provinceName"];
                break;
                
            }
        }
        
        for (NSString* dict in [self cities]) {
            if ([[dict valueForKey:@"cityCode"]isEqualToString:[SelfUser currentSelfUser].cityCode] ) {
                self.strCity =[dict valueForKey:@"cityName"];
                break;
                
            }
        }
        
        if (self.selectDistrictAction) {
                    self.selectDistrictAction(@{PROVINCE_NAME: self.strProvince,
                                                CITY_NAME: self.strCity,
                                                DISTRICT_NAME:[self.districts[row] objectForKey:DISTRICT_NAME]} ,
                                              @{PROVINCE_CODE: [SelfUser currentSelfUser].proVinceCode,
                                                CITY_CODE: [SelfUser currentSelfUser].cityCode,
                                                DISTRICT_CODE:[self.districts[row] objectForKey:DISTRICT_CODE]}
                                              );
        
    }
}
}
@end


