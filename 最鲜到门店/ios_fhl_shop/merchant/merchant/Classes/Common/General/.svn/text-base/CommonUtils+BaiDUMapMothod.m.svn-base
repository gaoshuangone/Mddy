//
//  CommonUtils+BaiDUMapMothod.m
//  merchant
//
//  Created by gs on 15/7/10.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "CommonUtils+BaiDUMapMothod.h"

@implementation CommonUtils (BaiDUMapMothod)
+(void)commonGeoCodeSearchWithCity:(NSString*)city withTagget:(id)tagget withAddress:(NSString*)address withCoor2D:(CLLocationCoordinate2D)coor2D withBlock:(void(^)(BOOL isSuccess))block{
    //初始化检索对象
    BMKGeoCodeSearch *searcher =[[BMKGeoCodeSearch alloc]init];
    
     searcher.delegate = tagget;
    if (address && [address toString].length>=1 ) {
        
        
       
        BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
        geoCodeSearchOption.city= city;
        geoCodeSearchOption.address = address;
        BOOL flag = [searcher geoCode:geoCodeSearchOption];
        if(flag)
        {
            NSLog(@"geo检索发送成功");
            block(YES);
        }
        else
        {
            NSLog(@"geo检索发送失败");
            
            block(NO);
        }
//            geoCodeSearchOption = nil;
    }else{
   
        CLLocationCoordinate2D pt =coor2D;
        BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeoCodeSearchOption.reverseGeoPoint = pt;
        BOOL flag = [searcher reverseGeoCode:reverseGeoCodeSearchOption];
        if(flag)
        {
            NSLog(@"反geo检索发送成功");
              block(YES);
        }
        else
        {
            NSLog(@"反geo检索发送失败");
                 block(NO);
        }
         reverseGeoCodeSearchOption = nil;
    }

//    searcher.delegate = nil;
//        searcher = nil;

 
}


+(BMKPlanNode*)comBaiDu_BMKPlanNodeWithCityName:(NSString*)cityName withAddr:(NSString*)cityAddr withCoor2D:(CLLocationCoordinate2D)coor2D{
    BMKPlanNode* node = [[BMKPlanNode alloc]init];
    if (cityName) {
        node.cityName = cityName;
        node.name = cityAddr;
    }else{
        node.pt = coor2D;
    }
    return node;
}
+(void)comBaiDu_DistanceInfoWithNodeStaty:(BMKPlanNode*)nodeStart withNodeEnd:(BMKPlanNode*)modeEnd withTagget:(id)tagget withBlock:(void(^)(BOOL isSuccess))block{
    BMKRouteSearch*routeSearch = [[BMKRouteSearch alloc] init];
    routeSearch.delegate = tagget;
    
    BMKWalkingRoutePlanOption *walkingRoutePlanOption = [[BMKWalkingRoutePlanOption alloc] init];
    walkingRoutePlanOption.from = nodeStart;
    walkingRoutePlanOption.to = modeEnd;
    BOOL flg = [routeSearch walkingSearch:walkingRoutePlanOption];
    
    if (flg) {
         block(YES);
    }
    else {
        block(NO);
    }
    routeSearch = nil;
    walkingRoutePlanOption = nil;
    routeSearch.delegate = nil;
    routeSearch = nil;
}
@end
