//
//  AppDelegate.h
//  merchant
//
//  Created by panume on 14-11-1.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"BMapKit.h"
#import <AVFoundation/AVFoundation.h>


#define AUTO_LOGIN_NOTIFICATION                 @"AutoLoginNotification"
#define UPDATE_LOCATION_NOTIFICATION            @"UpdateUserLocationNotification"
#define WORK_STATUS_DID_CHANGE_NOTIFICATION     @"WorkStatusDidChangeNotification"
#define RE_LOGIN_NOTIFICATION                   @"ReLoginNotification"
#define PUSH_CONFIG_NOTIFICATION                @"PushConfigNotification"//推送提交手机标示符
#define UPDATE_VERSION_NOTIFICATION             @"UpdateVersionNotification"
#define UPDATE_HEART_VERSION_NOTIFICATION       @"UpdateHeartVersionNotification"
#define UPDATE_VERSION_PROMPT_NOTIFICATION      @"UpdateVersionPromptNotification"
#define ONCELOGININ     @"onceLogin"
#define GETIFFO     @"getInfo"
#define XINTIAO     @"xintiao"
#define LOCATION     @"location" //定位
#define LOCATIONNOTI     @"locationNoti" //收到定位后发出
#define ZHIDURESULT     @"zhifuResult" //收到支付后发出
#define ZHIFUSUCCESS     @"zhifuSuccess" //收到支付后发出跳转到账户资产界面弹窗
#define XIADanREZHiFU    @"xiaDanRepay" //收到支付后支付失败返回重新下单界面
#define PUSH               @"push"//第一次登陆有单步引导，推送延迟

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKLocationServiceDelegate, BMKGeneralDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) UITabBarController *baseTabBarController;
@property (nonatomic, strong) UINavigationController *baseNavigationController;
@property (nonatomic, strong) BMKLocationService *locationService;
@property (nonatomic, strong) BMKMapManager *bmkMapManager;
@property (nonatomic, strong, readonly) BMKUserLocation *location;
@property (nonatomic, strong) UIImageView* startLogoImageView;
@property (nonatomic, strong) AVAudioPlayer* palyer;
@property (nonatomic, assign) BOOL firstBecomeActive;

+ (void)registerForRemoteNotification;
-(void)locationDingWei;

@end

