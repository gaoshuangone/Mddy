//
//  CommonUtils+BaiDUMapMothod.h
//  merchant
//
//  Created by gs on 15/7/10.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "CommonUtils.h"
typedef enum type{
    aa
}type;
@interface CommonUtils (BaiDUMapMothod)<BMKGeoCodeSearchDelegate>

//地理编码 address 正地理编码  Coor2D反地理编码
+(void)commonGeoCodeSearchWithCity:(NSString*)city withTagget:(id)tagget withAddress:(NSString*)address withCoor2D:(CLLocationCoordinate2D)coor2D withBlock:(void(^)(BOOL isSuccess))block;
+(BMKPlanNode*)comBaiDu_BMKPlanNodeWithCityName:(NSString*)cityName withAddr:(NSString*)cityAddr withCoor2D:(CLLocationCoordinate2D)coor2D;
+(void)comBaiDu_DistanceInfoWithNodeStaty:(BMKPlanNode*)nodeStart withNodeEnd:(BMKPlanNode*)modeEnd  withTagget:(id)tagget withBlock:(void(^)(BOOL isSuccess))block;

@end
