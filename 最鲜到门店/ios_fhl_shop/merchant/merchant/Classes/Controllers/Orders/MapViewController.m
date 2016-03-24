//
//  MapViewController.m
//  merchant
//
//  Created by gs on 15/1/26.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "MapViewController.h"

@interface GuideView : UIView
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) NSString *distance;


@end

@implementation GuideView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *bg = [UIImage imageNamed:@"card_bg_map.png"];
        bg = [bg stretchableImageWithLeftCapWidth:bg.size.width * 0.5 topCapHeight:bg.size.height * 0.5];
        
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        bgImageView.image = bg;
        bgImageView.tag = 102;
        bgImageView.hidden = YES;
        [self addSubview:bgImageView];
        bgImageView = nil;
        
        if (self.nameLabel== nil) {
      
        self.nameLabel = [[UILabel alloc] init];
          self.nameLabel.text = @"                                                 ";
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        [self.nameLabel sizeToFit];
        self.nameLabel.center = CGPointMake(8 + self.nameLabel.bounds.size.width / 2, self.frame.size.height/2);
        [self addSubview:self.nameLabel];
        }
        
//        self.distanceLabel = [[UILabel alloc] init];
//        self.distanceLabel.text = @"约99.99公里";
//        self.distanceLabel.font = [UIFont systemFontOfSize:14];
//        self.distanceLabel.textAlignment = NSTextAlignmentRight;
//        [self.distanceLabel sizeToFit];
//        self.distanceLabel.center = CGPointMake(self.bounds.size.width - 10 - self.distanceLabel.bounds.size.width / 2, self.nameLabel.center.y);
//        [self addSubview:self.distanceLabel];
//        
//        NSString *address = @"天目山路华鸿大厦238号";
//
//        
//        CGRect rect = [address boundingRectWithSize:CGSizeMake(frame.size.width - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
//        
//        self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameLabel.frame) + 10, frame.size.width - 16, rect.size.height)];
//        self.addressLabel.text = address;
//        self.addressLabel.font = [UIFont systemFontOfSize:14];
//        self.addressLabel.textColor = [UIColor lightGrayColor];
//        self.addressLabel.numberOfLines = 0;
//        self.addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        self.addressLabel.center = CGPointMake(8 + self.addressLabel.bounds.size.width / 2, CGRectGetMaxY(self.nameLabel.frame) + 10 + self.addressLabel.bounds.size.height / 2);
        
//        [self addSubview:self.addressLabel];

    }
    return self;
}

@end


@interface MapViewController ()
@property (nonatomic,strong)GuideView* guideView;
@end

@implementation MapViewController
//- (void)onGetNetworkState:(int)iError
//{
//    if (0 == iError) {
//        FLDDLogDebug(@"联网成功");
//    }
//    else{
//        FLDDLogDebug(@"onGetNetworkState %d",iError);
//    }
//    
//}
//
//- (void)onGetPermissionState:(int)iError
//{
//    if (0 == iError) {
//        FLDDLogDebug(@"授权成功");
//    }
//    else {
//        FLDDLogDebug(@"onGetPermissionState %d",iError);
//    }
//}
-(void)doChangeAnimate{
    [self getDictData];
}
- (void)viewDidLoad {

    [super viewDidLoad];
    self.title = @"已完成的订单";
    self.navigationItem.hidesBackButton = YES;
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"backWithTitle.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 53, 19);
    
    UIBarButtonItem* rithtBarItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = rithtBarItem ;
    rithtBarItem = nil;
    button = nil;
    
    self.title = @"地图定位";
    
//    BMKMapManager* bmk = [SelfUser currentSelfUser].userBMKMapManager;
//    if(bmk != nil)
//    {
//        [bmk start:@"8FcbLvlt2eXjC6TPABOMkQ58" generalDelegate:self];
//    }
//    else
//    {
//        bmk = [[BMKMapManager alloc] init];
//        BOOL isAuth =
//        [bmk start:@"8FcbLvlt2eXjC6TPABOMkQ58" generalDelegate:self];
//        //
//        if (!isAuth) {
//            FLDDLogDebug(@"开启失败!");
//        }
//        else
//        {
//            [SelfUser currentSelfUser].userBMKMapManager = bmk;
//        }
//    }
    
//    self.locationService = [[BMKLocationService alloc] init];
//    self.locationService.delegate = self;
//    [self.locationService startUserLocationService];
//    [SelfUser currentSelfUser].locationService = self.locationService;
    if (self.animatedView== nil) {
        
        
        self.animatedView = [[AnimatedView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT) imageName:@"logo_watermark_run" remark:@"正在努力加载中"];
        self.animatedView.delegate11 = self;
        //    __weak __typeof(self)weakSelf = self;
        //    self.animatedView.touchAction = ^(void){
        //         [weakSelf getDictData];
        //    };
        [self.view addSubview:self.animatedView];
        
    }
    [self getDictData];
    self.mapView = [[BMKMapView alloc]init];
    self.mapView.frame =CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT);
    self.mapView.delegate =self;
    self.mapView.zoomLevel = 15;
    

    

//    
////    需要添加标注后代理方法才执行
//    BMKPointAnnotation *shopPoint = [[BMKPointAnnotation alloc] init];
//    shopPoint.coordinate = colocation2D;
//    shopPoint.title = @"门店位置";
//    [self.mapView addAnnotation:shopPoint];
//////
//////    
//////    [AppManager setUserDefaultsValue:@"30.0000000000" key:@"latitude"];
//////    [AppManager setUserDefaultsValue:@"120.0000000000" key:@"longitude"];
//      BMKPointAnnotation *shopPoint1 = [[BMKPointAnnotation alloc] init];
//    CLLocationCoordinate2D colocation2D1 ;
//    colocation2D1.latitude =[@"30.0100100300" floatValue];
//    colocation2D1.longitude = [@"120.0000000200" floatValue ];
//    shopPoint1.coordinate = colocation2D1;
//    shopPoint1.title = @"配送员的位置";
//    [self.mapView addAnnotation:shopPoint1];
//    
//    
//    BMKPointAnnotation *shopPoint2 = [[BMKPointAnnotation alloc] init];
//    CLLocationCoordinate2D colocation2D2 ;
//    colocation2D2.latitude =[@"30.0200100300" floatValue];
//    colocation2D2.longitude = [@"120.0000000200" floatValue ];
//    shopPoint2.coordinate = colocation2D2;
//    shopPoint2.title = @"买家的位置";
//    [self.mapView addAnnotation:shopPoint2];
    
    
    [self.view addGestureRecognizer:self.swip];
    
   }

#pragma mark -BMKRouteSearchDelegate
-(void)getDictData{
    __weak __typeof(self)weakSelf = self;
    [SelfUser mddyRequestWithMethodName:@"getCourierPositionWaybillJsonPhone.htm" withParams:@{@"waybillId":self.waybillId} withBlock:^(id responseObject, NSError *error) {
        
        
        if (!error) {
            @try {
                FLDDLogDebug(@"%@",responseObject);
                
                weakSelf.dictData = responseObject;
                
                
                //    [self.mapView setUserTrackingMode:BMKUserTrackingModeFollow];
                //    self.mapView.showsUserLocation = YES;
                
                
                if (weakSelf.animatedView) {
                    [weakSelf.animatedView removeFromSuperview];
                    weakSelf.animatedView =  nil;
                    
                }
                //    需要添加标注后代理方法才执行
                CLLocationCoordinate2D colocation2D ;
                colocation2D.latitude =[[responseObject valueForKey:@"shopLatitude"] floatValue];
                colocation2D.longitude = [[responseObject valueForKey:@"shopLongitude"] floatValue ];
                weakSelf.mapView.centerCoordinate = colocation2D;
                [weakSelf.view addSubview:self.mapView];
                
                BMKPointAnnotation *shopPoint = [[BMKPointAnnotation alloc] init];
                shopPoint.coordinate = colocation2D;
                shopPoint.title = @"门店位置";
                [weakSelf.mapView addAnnotation:shopPoint];
                shopPoint = nil;
                
                //买家位置
                CLLocationCoordinate2D colocation2D2 ;
                colocation2D2.latitude =[[responseObject valueForKey:@"consigneeLatitude"] floatValue];
                colocation2D2.longitude = [[responseObject valueForKey:@"consigneeLongitude"] floatValue ];
                if ([[responseObject valueForKey:@"consigneeLatitude"] integerValue] == 0) {
                    
                }else{
                    BMKPointAnnotation *shopPoint2 = [[BMKPointAnnotation alloc] init];
                    
                    shopPoint2.coordinate = colocation2D2;
                    shopPoint2.title = @"买家的位置";
                    [weakSelf.mapView addAnnotation:shopPoint2];
                    weakSelf.isHavaMaiJia = YES;
                    shopPoint2 = nil;
                    
                }
                
                //                配送员位置
                BMKPointAnnotation *shopPoint1 = [[BMKPointAnnotation alloc] init];
                CLLocationCoordinate2D colocation2D1 ;
                colocation2D1.latitude =[[responseObject valueForKey:@"courierLatitude"] floatValue];
                colocation2D1.longitude = [[responseObject valueForKey:@"courierLongitude"] floatValue ];
                
                shopPoint1.coordinate = colocation2D1;
                shopPoint1.title = @"配送员的位置";
                [weakSelf.mapView addAnnotation:shopPoint1];
                shopPoint1 = nil;
                if (weakSelf.guideView == nil) {
                    
                    
                    weakSelf.guideView = [[GuideView alloc] initWithFrame:CGRectMake(10 , WINDOW_HEIGHT - 64 - 14 - 55, WINDOW_WIDTH - 2 * 10, 55) ];
                    
                    [weakSelf.view addSubview:weakSelf.guideView];
                    
                }
                //                if (isHavaMaiJia) {
                //
                //
                //                    float distance;
                //                    distance =[self distanceBetweenOrderBy:colocation2D1.latitude :colocation2D2.latitude : colocation2D1.longitude:colocation2D2.longitude];
                //
                //                    self.guideView.nameLabel.text = [NSString stringWithFormat:@"配送员距离买家约%.2f公里",distance/1000];
                //                }else{
                //                     float distance;
                ////                    BMKMapPoint dP = BMKMapPointMake(colocation2D1.latitude, colocation2D1.longitude);
                ////                    BMKMapPoint uP = BMKMapPointMake(colocation2D.latitude, colocation2D.longitude);
                ////                    distance = BMKMetersBetweenMapPoints(dP,uP);
                //
                //                    distance =[self distanceBetweenOrderBy:colocation2D1.latitude :colocation2D2.latitude : colocation2D1.longitude:colocation2D.longitude];
                //
                //                       self.guideView.nameLabel.text = [NSString stringWithFormat:@"配送员距离本店约%.2f公里",distance/1000];
                //                }
                //                }
                
                
                
                
                
                
                
                //                CLLocationDistance distance;
                //                CLLocation *before=[[CLLocation alloc] initWithLatitude:[[responseObject valueForKey:@"courierLatitude"] doubleValue] longitude:[[responseObject valueForKey:@"courierLongitude"] doubleValue]];
                //                CLLocation *current=[[CLLocation alloc] initWithLatitude:[[responseObject valueForKey:@"consigneeLatitude"] doubleValue] longitude:[[responseObject valueForKey:@"consigneeLongitude"] doubleValue]];
                //
                //                //    meters=[current distanceFromLocation:before];
                //                distance=[before distanceFromLocation:current]/1000;
                //                FLDDLogDebug(@"yyyyyyyyyyyyyyyyy=%f",distance);
                
                if ([[responseObject valueForKey:@"courierLatitude"] integerValue] == 0) {
                    UIImageView* imageView = (UIImageView*)[self.view viewWithTag:102];
                    imageView.hidden = NO;
                    weakSelf.guideView.nameLabel.text = [NSString stringWithFormat:@"无法获取配送员位置"];
                }else{
                    //                [weakSelf performSelector:@selector(distanceInfo) withObject:weakSelf afterDelay:0.01];
                    [weakSelf distanceInfo];
                }
                
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            
            
        }else{
        [weakSelf.animatedView stopAnimate];
             [MBProgressHUD hudShowWithStatus:weakSelf :[SelfUser currentSelfUser].ErrorMessage];
        }
        
        
    }];
    

}
- (void)onGetWalkingRouteResult:(BMKRouteSearch *)searcher result:(BMKWalkingRouteResult *)result errorCode:(BMKSearchErrorCode)error
{
 
    if (error == BMK_SEARCH_NO_ERROR) {
        
        BMKWalkingRouteLine *walkingLine = (BMKWalkingRouteLine *)[result.routes objectAtIndex:0];
        NSString* distance=[NSString stringWithFormat:@"%d",walkingLine.distance];
         FLDDLogDebug(@"distance:%d", walkingLine.distance);
        
        UIImageView* imageView = (UIImageView*)[self.view viewWithTag:102];
        imageView.hidden = NO;
        if ([[self.dictData valueForKey:@"courierLatitude"] integerValue] == 0) {
            self.guideView.nameLabel.text = [NSString stringWithFormat:@"无法获取配送员位置"];
        }else{
            if (self.isHavaMaiJia&&!self.isWaitLanShou) {
                
                self.guideView.nameLabel.text = [NSString stringWithFormat:@"配送员距离买家约%.2f公里",[distance floatValue]/1000];
            }else{
             
                
                self.guideView.nameLabel.text = [NSString stringWithFormat:@"配送员距离本店约%.2f公里",[distance floatValue]/1000];
            }

        }

        walkingLine = nil;
       
        
    }else{
        UIImageView* imageView = (UIImageView*)[self.view viewWithTag:102];
        imageView.hidden = NO;
        self.guideView.nameLabel.text = [NSString stringWithFormat:@"无法获取买家位置"];

    }
    FLDDLogDebug(@"%u",error);
        
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)addReguideButton
//{
//    UIButton *guideButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    UIImage *image = [UIImage imageNamed:@"card_bg_button_map.png"];
//    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
//    
//    guideButton.frame =  CGRectMake(0, 0, 98, 48);
//    [guideButton setBackgroundImage:image forState:UIControlStateNormal];
//    [guideButton setTitle:@"重新指路" forState:UIControlStateNormal];
//    [guideButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [guideButton addTarget:self action:@selector(reGuideButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    guideButton.center = CGPointMake(WINDOW_WIDTH - 8 - guideButton.bounds.size.width / 2, WINDOW_HEIGHT - 100 - 64 - guideButton.bounds.size.height / 2);
//    [self.view addSubview:guideButton];
//    
//}
/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    FLDDLogDebug(@"~~~%@",annotation.title);
    BMKAnnotationView* annotationView1;
//    FLDDLogDebug(@"1111111%f",annotation.coordinate.latitude);
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
    
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
       
//        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
   
      

        
    }
    
  
    
    
    if ([annotation.title isEqualToString:@"门店位置"]) {
        annotationView.image =  [UIImage imageNamed:@"local_house_map_s.png"];
//        UIImageView* imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 106, 27)];
//        UIImage* image =[UIImage imageNamed:@"tip_map_s.png"];
//        imageView.image =[[UIImage imageNamed:@"tip_map_s.png"] stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*1];
//        
//        UILabel* label =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 106, 27)];
//        label.text = @"本店的位置";
//        label.textColor = [UIColor whiteColor];
//        [imageView addSubview:label];
//        
//        annotationView.paopaoView =[[BMKActionPaopaoView alloc]initWithCustomView:imageView];
//      
//   annotationView.calloutOffset = CGPointMake(70, (annotationView.frame.size.height * 0.5)+10);
    }
    
    if ([annotation.title isEqualToString:@"配送员的位置"]) {
        annotationView.image =  [UIImage imageNamed:@"local_send_map.png"];
//        UIImageView* imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 110, 27)];
//        UIImage* image =[UIImage imageNamed:@"tip_map_send.png"];
//        imageView.image =[[UIImage imageNamed:@"tip_map_send.png"] stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*1];
//        
//        UILabel* label =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 110, 27)];
//        label.text = @"配送员的位置";
//        label.textColor = [UIColor blackColor];
//        [imageView addSubview:label];
//        
//        annotationView.paopaoView =[[BMKActionPaopaoView alloc]initWithCustomView:imageView];
//         annotationView.calloutOffset = CGPointMake(70, (annotationView.frame.size.height * 0.5)+10);
    }
    
    if ([annotation.title isEqualToString:@"买家的位置"]) {
        annotationView.image =  [UIImage imageNamed:@"tip_map_z_1"];
//        UIImageView* imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 106, 27)];
//        UIImage* image =[UIImage imageNamed:@"tip_map_z.png"];
//        imageView.image =[[UIImage imageNamed:@"tip_map_z.png"] stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*1];
//        
//        UILabel* label =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 106, 27)];
//        label.text = @"买家的位置";
//        label.textColor = [UIColor whiteColor];
//        [imageView addSubview:label];
//        
//        annotationView.paopaoView =[[BMKActionPaopaoView alloc]initWithCustomView:imageView];
//        
//           annotationView.calloutOffset = CGPointMake(70, (annotationView.frame.size.height * 0.5)+10);
    }

    
    
    // 设置位置
    
    annotationView.annotation = annotation;
    
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
//    annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    annotationView.enabled = NO;
//    annotationView.selected = YES;
  
    annotationView1 = annotationView;
    [annotationView removeFromSuperview];
    annotationView = nil;
    return annotationView1;

    
}
-(void)distanceInfo{
    if (!self.routeSearch) {
        self.routeSearch = [[BMKRouteSearch alloc] init];
        self.routeSearch.delegate = self;
    }
    
    
    BMKPlanNode *start = [[BMKPlanNode alloc] init];
    CLLocationCoordinate2D cloStart;
    cloStart.latitude = [[self.dictData valueForKey:@"courierLatitude"] doubleValue];
    cloStart.longitude = [[self.dictData  valueForKey:@"courierLongitude"] doubleValue];
    start.pt = cloStart;
    //              [self.mapView setCenterCoordinate:start.pt animated:YES];
    
    
    
    BMKPlanNode *end = [[BMKPlanNode alloc] init];
    CLLocationCoordinate2D cloEnd;
    
    if (self.isHavaMaiJia&&!self.isWaitLanShou) {
      
    cloEnd.latitude = [[self.dictData  valueForKey:@"consigneeLatitude"] doubleValue];
    cloEnd.longitude = [[self.dictData  valueForKey:@"consigneeLongitude"] doubleValue];
    }else{
        cloEnd.latitude = [[self.dictData  valueForKey:@"shopLatitude"] doubleValue];
        cloEnd.longitude = [[self.dictData  valueForKey:@"shopLongitude"] doubleValue];
    }
    
    end.pt = cloEnd;
    
    BMKWalkingRoutePlanOption *walkingRoutePlanOption = [[BMKWalkingRoutePlanOption alloc] init];
    walkingRoutePlanOption.from = start;
    walkingRoutePlanOption.to = end;
    
    BOOL flg = [self.routeSearch walkingSearch:walkingRoutePlanOption];
    
    if (flg) {
        FLDDLogDebug(@"success");
    }
    else {
        FLDDLogInfo(@"failed");
    }
    walkingRoutePlanOption = nil;
    end = nil;
    start= nil;

}
-(void)back{
    [self.guideView removeFromSuperview];
   [ self.mapView removeFromSuperview];
    self.guideView = nil;

  self.mapView = nil;
    self.routeSearch.delegate = nil;
    self.routeSearch=nil;
    self.mapView.delegate = nil;
    
    
    [self.navigationController popViewControllerAnimated:NO];
    
  
}
-(double)distanceBetweenOrderBy:(double)lat1 :(double)lat2 :(double)lng1 :(double)lng2{
    CLLocation* curLocation = [[CLLocation alloc] initWithLatitude:lat1 longitude:lng1];
    CLLocation* otherLocation = [[CLLocation alloc] initWithLatitude:lat2 longitude:lng2];
    double distance  = [curLocation distanceFromLocation:otherLocation];
    return distance;
}
#pragma mark - BMKLocationServiceDelegate

//- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
//{
//  
//    _location = userLocation;
//    
//    NSString *latitude = [NSString stringWithFormat:@"%.10f", self.location.location.coordinate.latitude];
//    NSString *longitude = [NSString stringWithFormat:@"%.10f", self.location.location.coordinate.longitude];
//    
//    [AppManager setUserDefaultsValue:latitude key:@"latitude"];
//    [AppManager setUserDefaultsValue:longitude key:@"longitude"];
////    [self.locationService stopUserLocationService];
//    [[SelfUser currentSelfUser].locationService stopUserLocationService];
//    
//  
//
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
