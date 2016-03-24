//
//  MapViewController.h
//  merchant
//
//  Created by gs on 15/1/26.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "BaseViewController.h"
#import "BMapKit.h"
#import "AnimatedView.h"
@interface MapViewController : BaseViewController<BMKMapViewDelegate,BMKGeneralDelegate,BMKLocationServiceDelegate,BMKRouteSearchDelegate,AnimateDelegate>
@property(retain,nonatomic) BMKMapView* mapView;
@property (nonatomic, strong) BMKLocationService *locationService;
@property (nonatomic, strong, readonly) BMKUserLocation *location;
@property (strong, nonatomic) NSString* waybillId;
@property (nonatomic, strong) BMKRouteSearch *routeSearch;
@property (strong, nonatomic) NSMutableDictionary* dictData;
@property (assign,nonatomic) BOOL isHavaMaiJia;
@property (assign, nonatomic)BOOL isWaitLanShou;
@property (nonatomic, strong) AnimatedView *animatedView;
@end
