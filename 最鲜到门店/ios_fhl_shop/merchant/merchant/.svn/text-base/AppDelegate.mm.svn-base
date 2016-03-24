
//
//  AppDelegate.m
//  merchant
//
//  Created by panume on 14-11-1.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "MessagesViewController.h"
#import "PersonalViewController.h"
#import "Reachability.h"



#import "OrderDetailViewController.h"
#import "OrderSuccessedDetailViewController.h"
#import "OrderErrorDetailkViewController.h"
#import "LoginViewController.h"
#import "MessageDetailViewController.h"
#import "SoonSendOrderViewController.h"
#include <sys/sysctl.h>
#import <AlipaySDK/AlipaySDK.h>
#import "AccountRechargeViewController.h"
#import "InputAddressViewController.h"
#import "InputAddDetailViewController.h"
#import "InputMapViewController.h"

Boolean g_showingHud;
@interface AppDelegate () < BMKLocationServiceDelegate, BMKGeneralDelegate, UIAlertViewDelegate>
{
    NSTimer *timer;
}
@property (assign,nonatomic)int timeCount;
@property (strong, nonatomic) NSDictionary* dictPush;
@property (strong, nonatomic) NSMutableArray* mArray;//连接收到push的时候，做一个队列
@property (strong, nonatomic) NSMutableArray* mPushArray;//连接收到push的时候，做一个队列
@property (assign,nonatomic) BOOL isLogin;
@end

@implementation AppDelegate


//-(void)reachabilityChanged:(NSNotification*)note
//{
//    Reachability * reach = [note object];
//    [SelfUser currentSelfUser].networkStatus = [reach currentReachabilityStatus];
//}


-(void)getSystemInfo{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    machine = nil;
    
    NSString *strSysName = [[UIDevice currentDevice] systemVersion];
    
    
    
    [AppManager setUserDefaultsValue:platform key:@"phoneType"];
    [AppManager setUserDefaultsValue:strSysName key:@"phoneSystem"];
    [AppManager setUserDefaultsValue:g_versionSNO key:@"version"];
    platform = nil;
    strSysName = nil;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    g_reachability = nil;
    g_showNoNetNotice = NO;
    g_needUpgrade = 0;
    g_downloadUrl = nil;
    g_routeSearchStat = STATE_INIT;
    g_MBKPermissionSuccessCount = 0;
    
#ifdef DEBUG
//    [AppManager setUserDefaultsValue:@"http://test.zuixiandao.cn/fhl/phone/mddy/" key:@"RootUrl"];
//    [AppManager setUserDefaultsValue:@"测试test" key:@"RootUrlIndex"];
//    [AppManager setUserDefaultsValue:@"http://172.16.28.165:8080/fhl/phone/mddy/" key:@"RootUrl"];
//    [AppManager setUserDefaultsValue:@"小灰灰" key:@"RootUrlIndex"];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
    
#if TARGET_OS_IPHONE
    UIColor *pink = [UIColor colorWithRed:(255/255.0) green:(58/255.0) blue:(159/255.0) alpha:1.0];
#else
    NSColor *pink = [NSColor colorWithCalibratedRed:(255/255.0) green:(58/255.0) blue:(159/255.0) alpha:1.0];
#endif
    [[DDTTYLogger sharedInstance] setForegroundColor:pink backgroundColor:nil forFlag:DDLogFlagInfo];
#if TARGET_OS_IPHONE
    UIColor *gray = [UIColor grayColor];
#else
    NSColor *gray = [NSColor grayColor];
#endif
    [[DDTTYLogger sharedInstance] setForegroundColor:gray backgroundColor:nil forFlag:DDLogFlagVerbose];
    
#ifdef TEST_XCODE_COLORS
    FLDDLogError(@"TEST DDLogError");
    FLDDLogWarn(@"TEST DDLogWarn");
    FLDDLogInfo(@"TEST DDLogInfo)");
    FLDDLogDebug(@"TEST DDLogDebug");
    FLDDLogVerbose(@"TEST DDLogVerbose");
#endif
    
#endif
    self.mArray = [NSMutableArray arrayWithCapacity:5];
    self.mPushArray = [NSMutableArray arrayWithCapacity:5];
    
    [User currentUser].g_versionState = VERSION_STATE_INIT;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    if(app_Version != nil)
    {
        g_versionSNO = app_Version;
    }
    else
    {
        g_versionSNO = @"1.1.1";
    }
    
    [AppManager setUserDefaultsValue:g_versionSNO key:@"version"];
    [SelfUser currentSelfUser].networkStatus = NotReachable;
    timer = nil;
    g_loginStat = LOGIN_STATE_INIT;
    g_getNetState = STATE_INIT;
    
    //    if ( [AppManager valueForKey:@"phoneType"]==nil)
    //    {
    [self getSystemInfo];
    //    }
    
    
    // Override point for customization after application launch.
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hitHeartNotification:) name:HIT_HEART_NOTIFICATION object:nil];//心跳1.7.1版本去掉💗
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setPushNotification:) name:PUSH_CONFIG_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateVersionNotification:) name:UPDATE_VERSION_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateHearVersionNotification:) name:UPDATE_HEART_VERSION_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateVersionPromptNotification:) name:UPDATE_VERSION_PROMPT_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onceLoginIN) name:ONCELOGININ object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timerXinTiao) name:XINTIAO object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push) name:PUSH object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationDingWei) name:LOCATION object:nil];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(reachabilityChanged:)
    //                                                 name:kReachabilityChangedNotification
    //                                               object:nil];//网络改变时的通知
    
    
    
    
    
    [AppManager setUserDefaultsValue:@"30.0000000000" key:@"latitude"];
    [AppManager setUserDefaultsValue:@"120.0000000000" key:@"longitude"];
    //BaiduMap Manager init
    self.bmkMapManager = [[BMKMapManager alloc] init];
    BOOL isAuth =[self.bmkMapManager start:@"8FcbLvlt2eXjC6TPABOMkQ58" generalDelegate:self];
    //
    if (!isAuth) {
        FLDDLogWarn(@"开启失败!");
    }
    else
    {
        [SelfUser currentSelfUser].userBMKMapManager = self.bmkMapManager;
        
    }
    
    [SelfUser currentSelfUser].userBMKMapManager = nil;
    //
    self.locationService = [[BMKLocationService alloc] init];
    self.locationService.delegate = self;
    
    [self.locationService startUserLocationService];
    
    
    //BaiduPush init
    //    [BPush setupChannel:launchOptions];
    //    [BPush setDelegate:self];
    
    
    //    if (IOS_VERSION_LARGE_OR_EQUAL(8.0)) {
    //        UIUserNotificationType type = UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge;
    //        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
    //        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    //    }
    //    else {
    //        UIRemoteNotificationType type = UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge;
    //        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:type];
    //    }
    
    
    
    
    
    
    
    
    
    NSString *phoneId = [AppManager valueForKey:@"phoneId"];
    if (phoneId.length == 0) {
        FLDDLogDebug(@"第一启动设置phoneId ＝ %@",g_bUDID);
        [AppManager setUserDefaultsValue:g_bUDID key:@"phoneId"];
        [self getPhoneId];
    }
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    //    SoonSendOrderViewController*homeViewController = [[SoonSe                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                ndOrderViewController alloc] init];
    homeViewController.title = @"首页";
    
    MessagesViewController *messageViewController = [[MessagesViewController alloc] init];
    messageViewController.title = @"消息";
    
    PersonalViewController *personalViewController = [[PersonalViewController alloc] init];
    personalViewController.title = @"我的";
    
    self.baseTabBarController = [[UITabBarController alloc] init];
    self.baseTabBarController.viewControllers = @[homeViewController, messageViewController, personalViewController];
    
    
    //    UITabBar *tabBar = self.baseTabBarController.tabBar;
    //    if (IOS_VERSION_LARGE_OR_EQUAL(7.0)) {
    //        UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    //        [item0 setFinishedSelectedImage:[[UIImage imageNamed:@"home_tabbar_p.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] withFinishedUnselectedImage:[[UIImage imageNamed:@"home_tabbar_n.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //
    //
    //        UITabBarItem *item2 = [tabBar.items objectAtIndex:1];
    //        [item2 setFinishedSelectedImage:[[UIImage imageNamed:@"messages_tabbar_p.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] withFinishedUnselectedImage:[[UIImage imageNamed:@"messages_tabbar_n.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //
    //
    //        UITabBarItem *item4 = [tabBar.items objectAtIndex:2];
    //        [item4 setFinishedSelectedImage:[[UIImage imageNamed:@"my_tabbar_p.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] withFinishedUnselectedImage:[[UIImage imageNamed:@"my_tabbar_n.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //    }
    //    else {
    //        UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    //        [item0 setFinishedSelectedImage:[UIImage imageNamed:@"home_tabbar_p.png"]withFinishedUnselectedImage:[UIImage imageNamed:@"home_tabbar_n.png"]];
    //
    //
    //        UITabBarItem *item2 = [tabBar.items objectAtIndex:1];
    //        [item2 setFinishedSelectedImage:[UIImage imageNamed:@"messages_tabbar_p.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"messages_tabbar_n.png"] ];
    //
    //
    //        UITabBarItem *item4 = [tabBar.items objectAtIndex:2];
    //        [item4 setFinishedSelectedImage:[UIImage imageNamed:@"my_tabbar_p.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"my_tabbar_n.png"] ];
    //    }
    
    
    
    //    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
    //                                                       [UIColor colorWithHex:0xfc6605], UITextAttributeTextColor,
    //                                                       nil] forState:UIControlStateSelected];
    //    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
    //                                                       [UIColor blackColor], UITextAttributeTextColor,
    //                                                       nil] forState:UIControlStateNormal];
    self.baseNavigationController = [[UINavigationController alloc] initWithRootViewController:self.baseTabBarController];
    self.baseNavigationController.navigationBar.translucent = NO;//不透明性，其它视图不能对NavItem进行渲染
    self.baseTabBarController.tabBar. translucent = NO;
    
    
    if (IOS_VERSION_LARGE_OR_EQUAL(7.0)) {
        //       self.navigationController.navigationBar.barTintColor = [UIColor colorWithHex:0xde582b];
        //        self.baseNavigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor ,nil];
        self.baseNavigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName ,nil];
    }
    else {
        self.baseNavigationController.navigationBar.tintColor = [UIColor colorWithHex:0x10ff5722];
    }
    //       [HomeViewController checkNetWork];
    
    
    self.window.rootViewController = self.baseNavigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    
    
    
    
    
    
    
    return YES;
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //
        //        [[AlipaySDK defaultService] processAuth_V2Result:url
        //                                         standbyCallback:^(NSDictionary *resultDic) {
        //                                             NSLog(@"result = %@",resultDic);
        //                                             NSString *resultStr = resultDic[@"result"];
        //
        //
        //        }];
        
        //        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
        //            NSLog(@"result = %@",resultDic);
        //            NSString *resultStr = resultDic[@"result"];
        //            NSLog(@"memo = %@,resultStatus =%@",[resultDic valueForKey:@"memo"],[resultDic valueForKey:@"resultStatus"]);
        //
        //
        //
        //            if ([[[resultDic valueForKey:@"resultStatus"] toString]isEqualToString:@"9000"]) {
        //
        //                [[NSNotificationCenter defaultCenter]postNotificationName:ZHIDURESULT object:self userInfo:@{@"info":@"1"}];
        //            }else{
        //            [[NSNotificationCenter defaultCenter]postNotificationName:ZHIDURESULT object:self userInfo:@{@"info":@"0"}];
        //            }
        //
        //        }];
        
        
        [[AlipaySDK defaultService]processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            
        }];
    }
    
    //    [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
    //        NSLog(@"result = %@",resultDic);
    //    }];
    
    //    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
    //        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
    //            NSLog(@"result = %@",resultDic);
    //        }];
    //    }
    
    return YES;
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    FLDDLogDebug(@"My token is: %@", deviceToken);
    
    [AppManager setUserDefaultsValue:deviceToken key:@"deviceToken"];
    [[NSNotificationCenter defaultCenter] postNotificationName:PUSH_CONFIG_NOTIFICATION object:nil];
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    FLDDLogWarn(@"Failed to get token, error: %@", error);
}


-(void)timerXinTiao{
    
    //        self.timeCount +=1;
    //        if (self.timeCount <3) {
    //            FLDDLogDebug(@"update location");
    //            [self hitHeart];
    //        }else{
    //            if (self.timeCount%7>5) {
    
    [self hitHeart];
    //            }
    //
    //        }
    
    
}
//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification{
//
//}

//suppertIOS8
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application setApplicationIconBadgeNumber:0];
    //register to receive notifications
    [application registerForRemoteNotifications];
}

+ (void)registerForRemoteNotification {
    
    
    
    
    FLDDLogDebug(@"*\n*\n*\nregisterForRemoteNotification\n*\n*\n*\n");
    if (IOS8_OR_LATER) {
        UIUserNotificationType types = UIUserNotificationTypeSound | UIUserNotificationTypeBadge | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    } else {
        //        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
        UIRemoteNotificationType type = UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:type];
        
    }
}


//- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    for (id key in userInfo) {
//        FLDDLogDebug(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
//    }
//}
//在application: didRegisterForRemoteNotificationsWithDeviceToken:中调用API，注册device token：
//- (void)application:(UIApplication *)application
//didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//
//    [BPush registerDeviceToken:deviceToken]; // 必须
//
//    [BPush bindChannel]; // 必须。可以在其它时机调用，只有在该方法返回（通过onMethod:response:回调）绑定成功时，app才能接收到Push消息。一个app绑定成功至少一次即可（如果access token变更请重新绑定）。
//}

//实现BPushDelegate协议，必须实现方法onMethod:response:：
// 必须，如果正确调用了setDelegate，在bindChannel之后，结果在这个回调中返回。
// 若绑定失败，请进行重新绑定，确保至少绑定成功一次
//- (void)onMethod:(NSString*)method response:(NSDictionary*)data
//{
//    FLDDLogDebug(@"bpush method:%@", method);
//    FLDDLogDebug(@"bpush data:%@", data);
//
//    if (data) {
//        NSString *userId = [[data objectForKey:@"user_id"] toString];
//        NSString *channelId = [[data objectForKey:@"channel_id"] toString];
//        NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
//        if ([BPushRequestMethod_Bind isEqualToString:method])
//        {
//
//            [AppManager setUserDefaultsValue:userId key:@"bindUserId"];
//            [AppManager setUserDefaultsValue:channelId key:@"bindChannelId"];
//
////            NSString *appid = [res valueForKey:BPushRequestAppIdKey];
////            NSString *userid = [res valueForKey:BPushRequestUserIdKey];
////            NSString *channelid = [res valueForKey:BPushRequestChannelIdKey];
////            int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
////            NSString *requestid = [res valueForKey:BPushRequestRequestIdKey];
//
//            int returnCode1 = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
//
//            if (returnCode1 == BPushErrorCode_Success) {
//
//            }
//        }else if ([BPushRequestMethod_Unbind isEqualToString:method]) {
//            int returnCode2 = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
//            if (returnCode2 == BPushErrorCode_Success) {
//
//            }
//        }
//
//    }
//}

//{
//    "aps": {
//        "alert": "测试强大推送陈子旭测试陈子旭测试陈子旭测试陈子旭测试陈子旭测试陈子旭测试陈子陈子旭测试陈子",
//        "badge": 1,
//        "sound": "default"
//    },
//    "page": {
//        "id": "53",
//        "type": "psy_grab"
//    }
//}
//{"aps":{"sound":"default","alert":"暗示法撒旦范德萨发法司法阿福是法师法师法师法师撒上沙发沙发沙...","badge":1},"page":{"id":"1074","title":"电饭锅电饭锅电饭锅","userTel":"18758214288","type":"mddy_appnotify"}}
//在application: didReceiveRemoteNotification:中调用API，处理接收到的Push消息：
-(void)push{
    for (NSDictionary* dict in self.mPushArray) {
      [self application:[UIApplication sharedApplication] didReceiveRemoteNotification:dict];
    }
    
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    //    [application setApplicationIconBadgeNumber:[[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] intValue]];
    [application setApplicationIconBadgeNumber:0];
    //    FLDDLogDebug(@"Receive Notify: %@", [userInfo JSONString]);
    FLDDLogDebug(@"%@",userInfo);
    NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    self.dictPush = nil;
    self.dictPush  =[NSDictionary dictionaryWithDictionary:[userInfo objectForKey:@"page"] ];
    
    NSString* sreType =[self.dictPush valueForKey:@"type"];
    if (![[[self.dictPush valueForKey:@"userTel"] toString]isEqualToString:[AppManager valueForKey:@"telephone"]]) {
        return;
    }
    
    if((sreType) && [sreType isEqualToString:@"mddy_needUpgrade"])
    {
        NSString *url = [self.dictPush objectForKey:@"downloadUrl"];
        if(url != nil)
        {
            g_needUpgrade = 1;
            g_downloadUrl = url;
        }
        return;
    }
    
    
    if (application.applicationState == UIApplicationStateActive) {
        
        NSString* strPushMessageTitle = nil;
        if ([sreType isEqualToString:@"mddy_neworder"]) {
            strPushMessageTitle = PushMddy_neworder;
        }else if ([sreType isEqualToString:@"mddy_collection"]){
            strPushMessageTitle =PushMddy_collection;
        }else if ([sreType isEqualToString:@"mddy_normalend"]){
            strPushMessageTitle = PushMddy_normalend;
        }else if ([sreType isEqualToString:@"mddy_cacelend"]){
            strPushMessageTitle =PushMddy_cacelend;
        }else if ([sreType isEqualToString:@"mddy_rejectend"]){
            strPushMessageTitle =PushMddy_rejectend;
        }else if ([sreType isEqualToString:@"mddy_appnotify"]){
            
            
            strPushMessageTitle =[[userInfo objectForKey:@"page"] objectForKey:@"title"];
            
            
        }else if ([sreType isEqualToString:@"mddy_logout"]){
            strPushMessageTitle = @"mddy_logout";
        }
        else{
            strPushMessageTitle = @"";
        }
        
        
#define PushMddy_neworder        @"最鲜到新订单"//带抢单
//#define PushMddy_collection      @"运单揽收成功"
//#define PushMddy_normalend       @"运单签收成功"
//#define PushMddy_cacelend        @"运单取消成功"//取消完成运单详情
//        
//#define PushMddy_rejectend       @"运单拒收"//拒收处理中
#define PushMddy_appnotify       @"投诉处理结果"//系统消息详情
        FLDDLogDebug(@"%@",strPushMessageTitle);
        
        // Nothing to do if applicationState is Inactive, the iOS already displayed an alert view.
        if ([strPushMessageTitle isEqualToString:@"mddy_logout"]) {
            [AppManager setUserDefaultsValue:@"1" key:@"isFirst"];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:alert
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"确定",nil];
            self.isLogin = YES;
            alertView.tag = 102;
            @try {
                [alertView show];
            }
            @catch (NSException *exception) {
                
            }
            
        }else{
            BOOL hasPrompt = [AppManager boolValueForKey:@"HasPrompt"];
            if (hasPrompt) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:strPushMessageTitle
                                                                message:alert
                                                               delegate:self
                                                      cancelButtonTitle:@"忽略"
                                                      otherButtonTitles:@"进入",nil];
            alertView.tag = 104;
            
            [self.mArray addObject:self.dictPush];
                [alertView show];
            }else {
                [self.mPushArray addObject:userInfo];
            }
            
            @try {
               
            }
            @catch (NSException *exception) {
                
            }
        }
        if (![AppManager boolValueForKey:@"shock"]) {
            
        }else {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
        
    }
    //    if (application.applicationState == UIApplicationStateBackground) {
    //
    //    }
    if (application.applicationState == UIApplicationStateInactive) {
        
        if (![AppManager boolValueForKey:@"shock"]) {
            if ([sreType isEqualToString:@"mddy_neworder"]) {
                [self playAudioWithIndex:1];
            }
            
        }else{
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            
        }
        
        
        //        if ([AppManager boolValueForKey:@"shock"]) {
        //            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        //
        //        }
        //        else {
        //            [self playAudioWithIndex:1];
        //        }
        
        [self getPushViewControlmethWithType:sreType];
    }
    //    [BPush handleNotification:userInfo]; // 可选
    
    [[NSNotificationCenter defaultCenter]postNotificationName:GETIFFO object:self];
}
- (void)playAudioWithIndex:(NSInteger)index
{
    NSString* strType = nil;//揽收
                            //    if (index == 1) {
    strType =@"new_order";
    //    }else if(index == 2){
    //        strType =@"received_order";
    //    }else if (index == 3){
    //        strType =@"Mddy";
    //
    //    }
    NSString *string = [[NSBundle mainBundle] pathForResource:strType ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:string];
    
    NSError* error = nil;
    self.palyer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    //    FLDDLogDebug(@"%@",error);
    [self.palyer  prepareToPlay];
    [self.palyer  play];
}

- (void)updateHearVersionNotification:(NSNotification *)notification
{
    [User currentUser].g_versionState = VERSION_STATE_FORCE_UPDATE;
    [User currentUser].g_newVersionURL = g_downloadUrl;
    //    [User currentUser].g_newVersionURL = @"https://itunes.apple.com/cn/app/zui-xian-dao/id944692670?mt=8";
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"版本更新" message:@"检测到最新版本，请及时更新" delegate:self cancelButtonTitle:@"更新" otherButtonTitles:nil,nil];
    alert.tag = 100;
    @try
    {
        [alert show];
        [User currentUser].g_bVersionUpdatePrompt = YES;
    }
    @catch (NSException *exception) {
    }
}

- (void)updateVersionNotification:(NSNotification *)notification
{
    [AppDelegate registerForRemoteNotification];
    
    //    [User currentUser].g_versionState = VERSION_STATE_INIT;
    //    [User currentUser].g_bVersionUpdatePrompt = NO;
    //    [User currentUser].g_newVersionURL = nil;
    //    //    NSString *userState = [User currentUser].state;
    //    //    if (![userState isEqualToString:@"0"] && ![userState isEqualToString:@"1"] && userState != nil)
    //    {
    //        NSMutableDictionary *paramsList = [NSMutableDictionary dictionary];
    //        [paramsList setObject:g_versionSNO forKey:@"version"];
    //        FLDDLogDebug(@"paramsList:%@", paramsList);
    //
    //        [User getVersionSNOWithParams:paramsList block:^(NSError *error) {
    //
    //            if (!error)
    //            {
    if((VERSION_STATE_FORCE_UPDATE == [User currentUser].g_versionState) && ([User currentUser].g_newVersionURL != nil))
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"版本更新" message:@"检测到最新版本，请及时更新" delegate:self cancelButtonTitle:@"更新" otherButtonTitles:nil,nil];
        alert.tag = 100;
        @try
        {
            [alert show];
            [User currentUser].g_bVersionUpdatePrompt = YES;
        }
        @catch (NSException *exception) {
        }
    }
    else if((VERSION_STATE_REMIND_UPDATE == [User currentUser].g_versionState) && ([User currentUser].g_newVersionURL != nil))
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"版本更新" message:@"检测到最新版本，请及时更新" delegate:self cancelButtonTitle:@"放弃" otherButtonTitles:@"更新",nil];
        alert.tag = 101;
        @try
        {
            [alert show];
        }
        @catch (NSException *exception) {
        }
    }
    //                else
    //                {
    ////                    FLDDLogDebug(@"updateVersionNotifica:%@", error);
    //                    [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_NOTIFICATION object:nil];
    //                }
    //            }
    //            else
    //            {
    //                LogError(@"err:%@", error);
    ////                [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    //                [User currentUser].g_versionState = VERSION_STATE_FETCH_FAIL;
    //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"检测新版本失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    //                alert.tag = 103;
    //                @try
    //                {
    //                    [alert show];
    //                }
    //                @catch (NSException *exception) {
    //                    LogError(@"err:%@", exception);
    //                }
    //            }
    //        }];
    
    //    }
}
- (void)updateVersionPromptNotification:(NSNotification *)notification
{
    
    [User currentUser].g_versionState = VERSION_STATE_INIT;
    [User currentUser].g_bVersionUpdatePrompt = NO;
    [User currentUser].g_newVersionURL = nil;
    //    NSString *userState = [User currentUser].state;
    //    if (![userState isEqualToString:@"0"] && ![userState isEqualToString:@"1"] && userState != nil)
    {
        NSMutableDictionary *paramsList = [NSMutableDictionary dictionary];
        [paramsList setObject:g_versionSNO forKey:@"version"];
        FLDDLogDebug(@"paramsList:%@", paramsList);
        
        [User getVersionSNOWithParams:paramsList block:^(NSError *error) {
            
            if (!error)
            {
                if((VERSION_STATE_FORCE_UPDATE == [User currentUser].g_versionState) && ([User currentUser].g_newVersionURL != nil))
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"版本更新" message:@"检测到最新版本，请及时更新" delegate:self cancelButtonTitle:@"更新" otherButtonTitles:nil,nil];
                    alert.tag = 100;
                    @try
                    {
                        [alert show];
                        [User currentUser].g_bVersionUpdatePrompt = YES;
                    }
                    @catch (NSException *exception) {
                    }
                }
                else if((VERSION_STATE_REMIND_UPDATE == [User currentUser].g_versionState) && ([User currentUser].g_newVersionURL != nil))
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"版本更新" message:@"检测到最新版本，请及时更新" delegate:self cancelButtonTitle:@"放弃" otherButtonTitles:@"更新",nil];
                    alert.tag = 101;
                    @try
                    {
                        [alert show];
                    }
                    @catch (NSException *exception) {
                    }
                }
                else
                {
                    //                    [SVProgressHUD showSuccessWithStatus:@"已经是最新版本。"];
                    [MBProgressHUD hudShowWithStatus:self :@"已经是最新版本。"];
                }
            }
            else
            {
                FLDDLogInfo(@"err:%@", error);
                //                [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
                [MBProgressHUD hudShowWithStatus:self :[error localizedDescription]];
                [User currentUser].g_versionState = VERSION_STATE_FETCH_FAIL;
            }
        }];
        
    }
}
-(void)getPushViewControlmethWithType:(NSString*)sreType{
    
    
    
#define PushMddy_neworder        @"最鲜到新订单"//带抢单
#define PushMddy_collection      @"订单揽收成功"
#define PushMddy_normalend       @"订单签收成功"
#define PushMddy_cacelend        @"订单取消成功"//取消完成运单详情
    
#define PushMddy_rejectend       @"订单拒收"//拒收处理中
#define PushMddy_appnotify       @"投诉处理结果"//系统消息详情
    NSLog(@"222%@",self.mArray);
    NSLog(@"!!!%@",self.dictPush);
    NSString* strBuillld = [self.dictPush valueForKey:@"id"];
    
    FLDDLogDebug(@"sreType=%@ -----id = %@",sreType,strBuillld);
    
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController* topViewController = appdelegate.baseTabBarController.navigationController.topViewController;
    if ([topViewController isKindOfClass:[ InputAddDetailViewController class]] ||[topViewController isKindOfClass:[ InputMapViewController class]] ) {
   
    for (UIView* view in self.baseNavigationController.navigationBar.subviews) {
        if (view.frame.origin.x>=70) {
            [view removeFromSuperview];
        }
        if (view.frame.origin.x == -5) {
            [view removeFromSuperview];
        }
        
    }
      
    }
    
    if ([sreType isEqualToString:@"mddy_neworder"]) {//待抢单订单详情
        
        if ([topViewController isKindOfClass:[ OrderDetailViewController class]]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"OrderDetailViewController" object:nil userInfo:@{@"status":@"qiangdan",@"billld":strBuillld}];
            
        }else{
            OrderDetailViewController* orderDetail = [[OrderDetailViewController alloc]initWithNibName:nil bundle:nil];
            orderDetail.order_status = ORDER_STATUS_WAIT_QIANGDAN;
            orderDetail.strWayBillld = strBuillld;
            [self.baseNavigationController pushViewController:orderDetail animated:YES];
        }
        
        
    }else if([sreType isEqualToString:@"mddy_collection"]){//待签收订单详情
        if ([topViewController isKindOfClass:[ OrderDetailViewController class]]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"OrderDetailViewController" object:nil userInfo:@{@"status":@"qianshou",@"billld":strBuillld}];
        }else{
            OrderDetailViewController* orderDetail = [[OrderDetailViewController alloc]initWithNibName:nil bundle:nil];
            orderDetail.order_status = ORDER_STATUS_WAIT_LANSHOU;
            orderDetail.strWayBillld = strBuillld;
            [self.baseNavigationController pushViewController:orderDetail animated:YES];
        }
        
        
    }
    else if([sreType isEqualToString:@"mddy_normalend"]){//进入完成订单详情页
        if ([topViewController isKindOfClass:[ OrderSuccessedDetailViewController class]]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"OrderSuccessedDetailViewController" object:nil userInfo:@{@"billld":strBuillld}];
            
        }else{
            OrderSuccessedDetailViewController * orderSuccesssedDetail = [[OrderSuccessedDetailViewController alloc]initWithNibName:nil bundle:nil];
            orderSuccesssedDetail.strWaybillId = strBuillld;
            [self.baseNavigationController pushViewController:orderSuccesssedDetail animated:YES];
        }
    }
    
    else if([sreType isEqualToString:@"mddy_cacelend"]){//进入已取消历史订单详情页
        
        if ([topViewController isKindOfClass:[ OrderErrorDetailkViewController class]]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"OrderErrorDetailkViewController" object:nil userInfo:@{@"status":@"cancel",@"statusED":@"cancel",@"billld":strBuillld}];
            
        }else{
            OrderErrorDetailkViewController* orderCancel= [[OrderErrorDetailkViewController alloc]initWithNibName:nil bundle:nil];
            
            orderCancel.orderStatus = ORDER_ERROR_STATUS_WAIT_CANCEL;
            orderCancel.orderStatusED= ORDER_CANCEL;
            
            orderCancel.strWayBillld = strBuillld;
            orderCancel.isDonig = YES;
            [self.baseNavigationController pushViewController:orderCancel animated:YES];
        }
        
    }
    //    else if([sreType isEqualToString:@"mddy_reject"]){//进入已拒收历史订单详情页
    //
    //        if ([topViewController isKindOfClass:[ OrderErrorDetailkViewController class]]) {
    //            [[NSNotificationCenter defaultCenter]postNotificationName:@"OrderErrorDetailkViewController" object:nil userInfo:@{@"status":@"jushou",@"statusED":@"jushou"}];
    //
    //        }else{
    //            OrderErrorDetailkViewController* orderCancel= [[OrderErrorDetailkViewController alloc]initWithNibName:nil bundle:nil];
    //            orderCancel.orderStatus = ORDER_ERROR_STATUS_WAIT_JUSHOU;
    ////            orderCancel.orderStatusED= ORDER_JUSHOU;
    //
    //
    //            orderCancel.strWayBillld = strBuillld;
    //            [self.baseNavigationController pushViewController:orderCancel animated:YES];
    //        }
    //
    //    }
    
    
    
    else if([sreType isEqualToString:@"mddy_rejectend"]){//拒收处理中详情
        if ([topViewController isKindOfClass:[ OrderErrorDetailkViewController class]]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"OrderErrorDetailkViewController111" object:nil userInfo:@{@"status":@"jushou",@"billld":strBuillld}];
            
        }else{
            OrderErrorDetailkViewController* errorDetail = [[OrderErrorDetailkViewController alloc ]initWithNibName:nil bundle:nil];
            errorDetail.orderStatus = ORDER_ERROR_STATUS_WAIT_JUSHOU;
            errorDetail.strWayBillld =strBuillld;
            errorDetail.isDonig = YES;
            [self.baseTabBarController.navigationController pushViewController:errorDetail animated:YES];
        }
        
    }
    else if([sreType isEqualToString:@"mddy_appnotify"]){//app消息详情页
        
        if ([topViewController isKindOfClass:[ MessageDetailViewController class]]) {
            
            if ([[self.dictPush allKeys] containsObject:@"notifyType"]) {
                if ([[[self.dictPush valueForKey:@"notifyType"]toString]isEqualToString:@"2"]) {//运单消息
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"MessageDetailViewController" object:nil userInfo:@{@"type":@"yundan",@"messageId":strBuillld}];
                }else{
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"MessageDetailViewController" object:nil userInfo:@{@"type":@"xitong",@"messageId":strBuillld}];
                    
                }
                
            }else{
                [[NSNotificationCenter defaultCenter]postNotificationName:@"MessageDetailViewController" object:nil userInfo:@{@"type":@"xitong",@"messageId":strBuillld}];
            }
            
            
        }else{
            
            MessageDetailViewController* message1 = [[MessageDetailViewController alloc ]initWithNibName:nil bundle:nil];
            
            if ([[self.dictPush allKeys] containsObject:@"notifyType"]) {
                if ([[[self.dictPush valueForKey:@"notifyType"]toString]isEqualToString:@"2"]) {//运单消息
                    message1.type = MessageTypeOrder;
                }else{
                    message1.type = MessageTypeSys;
                    
                }
                
            }else{
                message1.type = MessageTypeSys;
            }
            
            message1.isNoti = YES;
            message1.messageId = strBuillld;
            [self.baseTabBarController.navigationController pushViewController:message1 animated:YES];
        }
        
    }else if([sreType isEqualToString:@"mddy_logout"]) {//登录页面
        
        
        if ([topViewController isKindOfClass:[ LoginViewController class]]) {
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:HIT_HEART_NOTIFICATION object:nil userInfo:@{@"beginHit" : @(NO)}];
            [[UIApplication sharedApplication] unregisterForRemoteNotifications];
            
            LoginViewController* login = [[LoginViewController alloc]initWithNibName:nil bundle:nil];
            //        [AppManager setUserDefaultsValue:@"" key:@"telephone"];
            [AppManager setUserDefaultsValue:@"" key:@"password"];
            [self.baseTabBarController.navigationController pushViewController:login animated:YES];
            
        }
    }
    
    
    
}
-(void)onceLoginIN{
    [AppManager setUserDefaultsValue:@"1" key:@"isFirst"];
    
    
    
    //    NSString *phone = [AppManager valueForKey:@"telephone"];
    //    NSString *password = [AppManager valueForKey:@"password"];
    //    FLDDLogDebug(@"取到密码%@",password);
    //    if (phone == nil || password == nil) {
    //        [SVProgressHUD dismiss];
    //        [SelfUser hudHideWithViewcontroller:self];
    //        return;
    //
    //    }
    //
    //    NSDictionary *params = @{@"clerkTel": phone,
    //                             @"passwd" : password};
    //
    //
    //    [User reLoginWithParams:params block:^(NSError *error) {
    //
    //        [SVProgressHUD dismiss];
    //        if (!error) {
    //
    //
    //
    ////            [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_VERSION_NOTIFICATION object:nil];
    ////            [[NSNotificationCenter defaultCenter] postNotificationName:PUSH_CONFIG_NOTIFICATION object:nil];
    //            [AppManager setUserDefaultsValue:@"2" key:@"isFirst"];
    //
    //
    //
    //        }
    //        else {
    //            [[NSNotificationCenter defaultCenter] postNotificationName:HIT_HEART_NOTIFICATION object:nil userInfo:@{@"beginHit" : @(NO)}];
    //            [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    //            [SelfUser currentSelfUser].isNeedReturnLanShou = YES;
    //            LoginViewController* login = [[LoginViewController alloc]initWithNibName:nil bundle:nil];
    //            [AppManager setUserDefaultsValue:@"" key:@"telephone"];
    //            [AppManager setUserDefaultsValue:@"" key:@"password"];
    //            [self.baseTabBarController.navigationController pushViewController:login animated:YES];
    //        }
    //    }];
    
    
    
    
    NSString *phone = [AppManager valueForKey:@"telephone"];
    NSString *password = [AppManager valueForKey:@"password"];
    NSString* strphoneType=[AppManager valueForKey:@"phoneType"];
    FLDDLogDebug(@"取到密码%@",password);
    if (phone == nil || password == nil ||strphoneType == nil) {
        return;
        
    }
    NSMutableDictionary* paramsList=[[NSMutableDictionary alloc]init];
    [paramsList setObject:[AppManager valueForKey:@"phoneType"] forKey:@"phoneType"];
    [paramsList setObject:[AppManager valueForKey:@"phoneSystem"] forKey:@"phoneSystem"];
    [paramsList setObject:[AppManager valueForKey:@"version"] forKey:@"version"];
    [paramsList setObject:phone forKey:@"clerkTel"];
    [paramsList setObject:password forKey:@"passwd"];
    
    
    [User reLoginNoSessionWithFixedPasswordJsonPhone:paramsList block:^(NSError *error) {
        if (!error) {
            
            
            
            //            [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_VERSION_NOTIFICATION object:nil];
            //            [[NSNotificationCenter defaultCenter] postNotificationName:PUSH_CONFIG_NOTIFICATION object:nil];
            [AppManager setUserDefaultsValue:@"2" key:@"isFirst"];
            g_loginStat = LOGIN_STATE_LOGIN_SUCESS;
            
            
        }
        else {
            [[NSNotificationCenter defaultCenter] postNotificationName:HIT_HEART_NOTIFICATION object:nil userInfo:@{@"beginHit" : @(NO)}];
            [[UIApplication sharedApplication] unregisterForRemoteNotifications];
            [SelfUser currentSelfUser].isNeedReturnLanShou = YES;
            LoginViewController* login = [[LoginViewController alloc]initWithNibName:nil bundle:nil];
            //                    [AppManager setUserDefaultsValue:@"" key:@"telephone"];
            //                    [AppManager setUserDefaultsValue:@"" key:@"password"];
            [self.baseTabBarController.navigationController pushViewController:login animated:YES];
        }
        
    }];
    
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView tag] == 100)
    {
        switch (buttonIndex) {
                //            case 0://NO应该做的事
                //            {
                //                [User currentUser].g_bVersionUpdatePrompt = NO;
                //                exit(0);
                //                break;
                //            }
            case 0: //YES应该做的事
            {
                [User currentUser].g_bVersionUpdatePrompt = NO;
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[User currentUser].g_newVersionURL]];
                break;
                //                [User currentUser].g_bVersionUpdatePrompt = NO;
                //                exit(0);
                //                break;
            }
                //            case 1: //YES应该做的事
                //            {
                //                [User currentUser].g_bVersionUpdatePrompt = NO;
                //                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[User currentUser].g_newVersionURL]];
                //                break;
                //            }
        }
    }
    else if([alertView tag] == 101)
    {
        switch (buttonIndex) {
            case 0://NO应该做的事
            {
                //[User currentUser].g_bVersionUpdatePrompt = NO;
                [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_NOTIFICATION object:nil];
                break;
            }
            case 1: //YES应该做的事
            {
                //[User currentUser].g_bVersionUpdatePrompt = NO;
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[User currentUser].g_newVersionURL]];
                break;
            }
                
        }
    }
    else if([alertView tag] == 102)
    {
        
        if (self.isLogin)
        {
            self.isLogin = NO;
            
        }
        NSString* sreType =[self.dictPush valueForKey:@"type"];
        [self getPushViewControlmethWithType:sreType];
    }else if([alertView tag] == 104){
        if (buttonIndex == 0) {
             NSLog(@"~~~%@",self.mArray);
            [self.mArray removeObjectAtIndex:[self.mArray count]-1];
            NSLog(@"@@@@%@",self.mArray);
            return;
        }
        
//        NSString* sreType =[self.dictPush valueForKey:@"type"];
        NSLog(@"~~~%@",self.mArray);
        self.dictPush = [self.mArray objectAtIndex:[self.mArray count]-1];
        NSString* sreType= [self.dictPush valueForKey:@"type"];
        [self.mArray removeObjectAtIndex:[self.mArray count]-1];
        [self getPushViewControlmethWithType:sreType];
        
        
    }else if([alertView tag] == 103)
    {
        switch (buttonIndex) {
            case 0://NO应该做的事
            {
                exit(0);
                break;
            }
            case 1: //YES应该做的事
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_VERSION_NOTIFICATION object:nil];
                break;
            }
                
        }
    }
    else
    {
        NSString* sreType =[self.dictPush valueForKey:@"type"];
        [self getPushViewControlmethWithType:sreType];
        
    }
    
}



- (void)setPushNotification:(NSNotification *)notification
{
    //    NSString *userId = [AppManager valueForKey:@"bindUserId"];
    //    NSString *channelId = [AppManager valueForKey:@"bindChannelId"];
    //
    //    NSString *bind = [userId stringByAppendingString:@";"];
    //    bind = [bind stringByAppendingString:channelId];
    NSString* deviceToken = [[[[AppManager valueForKey:@"deviceToken"] toString] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""];
    if (deviceToken.length == 0) {
        deviceToken = @"";
    }
    deviceToken = [NSString stringWithFormat:@"token:%@",deviceToken];
    //    [[API shareAPI] setPushWithParams:@{@"pushPhoneParam": bind} block:^(NSError *error) {
    //        if (!error) {
    //
    //            FLDDLogDebug(@"success");
    //
    //        }
    //    }];
    
    
    [SelfUser mddyRequestWithMethodName:@"pushPhoneParamJsonPhone.htm" withParams:@{@"cmdCode" : g_pushConfigCmd,@"pushPhoneParam":deviceToken} withBlock:^(id responseObject, NSError *error) {
        FLDDLogDebug(@"%@",responseObject);
        
        if (!error) {
            
            FLDDLogDebug(@"%@",responseObject);
            
            @try {
                
                
                
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            
            
            
        }else{
            FLDDLogInfo(@"%@",responseObject);
            
        }
        
        
    }];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //    [HomeViewController checkNetWork];
    FLDDLogDebug(@"g_versionState :%d, g_bVersionUpdatePrompt : %d", [User currentUser].g_versionState, [User currentUser].g_bVersionUpdatePrompt);
    
    if((NotReachable == [SelfUser currentSelfUser].networkStatus) && (g_showNoNetNotice))
    {
        FLDDLogDebug(@"applicationDidBecomeActive : g_showNoNetNotice");
        [HomeViewController checkNetWork];
    }
    
    if((VERSION_STATE_FORCE_UPDATE == [User currentUser].g_versionState) && (!([User currentUser].g_bVersionUpdatePrompt)) && ([User currentUser].g_newVersionURL != nil))
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"版本更新" message:@"检测到最新版本，请及时更新" delegate:self cancelButtonTitle:@"更新" otherButtonTitles:nil];
        alert.tag = 100;
        @try
        {
            [alert show];
            [User currentUser].g_bVersionUpdatePrompt = YES;
        }
        @catch (NSException *exception) {
        }
        
    }
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    UIApplication*   app = [UIApplication sharedApplication];
    __block    UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController* topViewController = appdelegate.baseTabBarController.navigationController.topViewController;
    NSLog(@"%@",[topViewController class]);
    if ([topViewController isKindOfClass:[ self.baseTabBarController class]]) {
        [HomeViewController checkGPS];
    }
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    
    

    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] postNotificationName:HIT_HEART_NOTIFICATION object:nil userInfo:@{@"beginHit" : @(NO)}];
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
        [AppManager setUserDefaultsValue:@"" key:@"cookie"];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    //    [SelfUser mddyRequestWithMethodName:@"logoutJsonPhone.htm" withParams:@{} withBlock:^(id responseObject, NSError *error) {
    ////        [SVProgressHUD dismiss ];
    //        [MBProgressHUD hudHideWithViewcontroller:self];
    //        if (!error) {
    //            @try {
    //                FLDDLogDebug(@"%@",responseObject);
    //
    //            }
    //            @catch (NSException *exception) {
    //
    //            }
    //            @finally {
    //
    //            }
    //
    //        }else{
    //            [MBProgressHUD hudShowWithStatus:self :[SelfUser currentSelfUser].ErrorMessage];
    ////            [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
    //        }
    //
    //    }];
    
}
- (void)getPhoneId
{
    [[API shareAPI] getPhoneIdWithBlock:^(NSString *phoneId, NSError *error) {
        FLDDLogDebug(@"获得phoneId:%@", phoneId);
        
        if (!error) {
            NSString *iOSPhoneId = [NSString stringWithFormat:@"ios_%@", phoneId];
            [AppManager setUserDefaultsValue:iOSPhoneId key:@"phoneId"];
        }
        else {
            
            //            [SVProgressHUD showErrorWithStatus:[error description]];
        }
    }];
}
- (void)hitHeart
{
    NSDictionary *params = @{@"version"  : g_versionSNO};
    
    //    if ([[AppManager valueForKey:@"longitude"] toString].length>0 && [[AppManager valueForKey:@"latitude"] toString].length>0) {
    //        params = @{@"longitude" : [[AppManager valueForKey:@"longitude"] toString],
    //                   @"latitude"  : [[AppManager valueForKey:@"latitude"] toString]};
    //    }else{
    //        params = @{@"longitude" : [[AppManager valueForKey:@"longitude"] toString],
    //                   @"latitude"  : [[AppManager valueForKey:@"latitude"] toString]};
    //    }
    FLDDLogDebug(@"hitHeart time:%@", [NSDate date]);
    [[API shareAPI] hitHeartWithParams:params block:^(NSError *error) {
        if (!error) {
            FLDDLogDebug(@"hit heart");
        }else {
            
        }
    }];
}
- (void)hitHeartNotification:(NSNotification *)notification
{
    
    NSDictionary *userInfo = notification.userInfo;
    
    BOOL begin = [[userInfo objectForKey:@"beginHit"] boolValue];
    
    if (!begin) {
        if (timer)
        {
            FLDDLogDebug(@"stop hit heart");
            [timer setFireDate:[NSDate distantFuture]];
            return;
        }
        
    }
    else
    {
        if (!timer) {
            timer = [NSTimer scheduledTimerWithTimeInterval:600 target:self selector:@selector(hitHeart) userInfo:nil repeats:YES];
            return;
        }
        FLDDLogDebug(@"begin hit heart");
        NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:600];
        FLDDLogDebug(@"%@, %@", [NSDate date], startDate);
        [timer setFireDate:startDate];
    }
    
    //sessionId 失效时暂停？
    
    
}
//{
//    NSDictionary *userInfo = notification.userInfo;
//
//    BOOL begin = [[userInfo objectForKey:@"beginHit"] boolValue];
//
//
//    if (!timer) {
//        timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(hitHeart) userInfo:nil repeats:YES];
//    }
//    else
//    {
//
//        if (!begin) {
//
//            FLDDLogDebug(@"stop hit heart");
//            [timer setFireDate:[NSDate distantFuture]];
//        }
//        else {
//            FLDDLogDebug(@"begin hit heart");
//            NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:600];
//            LogInfo(@"%@, %@", [NSDate date], startDate);
//            [timer setFireDate:startDate];
//        }
//    }
//
//
////    NSTimer* time1 =    [NSTimer scheduledTimerWithTimeInterval:600 target:self selector:@selector(timerXinTiao) userInfo:nil repeats:YES ];
////    if (![timer isValid]) {
////        timer =  [NSTimer scheduledTimerWithTimeInterval:600 target:self selector:@selector(timerXinTiao) userInfo:nil repeats:YES ];
////    }
////
////    [timer fire];
////    if (![timer isValid]) {
////        timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(hitHeart) userInfo:nil repeats:YES];
////    }
////
////    //sessionId 失效时暂停？
////
////    BOOL begin = YES;
////
////    if (!begin) {
////        [timer setFireDate:[NSDate distantFuture]];
////    }
////    else {
////        [timer setFireDate:[NSDate date]];
////    }
//}
-(void)locationDingWei{
    
    [self.locationService startUserLocationService];
}
#pragma mark - BMKLocationServiceDelegate

- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    double distance = [userLocation.location distanceFromLocation:_location.location];
    //    FLDDLogDebug(@"distance:%f", distance);
    
    if (_location) {
        
        
        
        if (distance > 100) {
            FLDDLogDebug(@"update location");
            [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_LOCATION_NOTIFICATION object:nil];
        }
        
        
    }
    
    
    
    
    
    _location = userLocation;
    
    NSString *latitude = [NSString stringWithFormat:@"%.10f", self.location.location.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%.10f", self.location.location.coordinate.longitude];
    [AppManager setUserDefaultsValue:latitude key:@"latitude"];
    [AppManager setUserDefaultsValue:longitude key:@"longitude"];
    [self.locationService stopUserLocationService];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:LOCATIONNOTI object:self];
    
}
- (void)didFailToLocateUserWithError:(NSError *)error{
    NSString *latitude = [NSString stringWithFormat:@"0.000000"];
    NSString *longitude = [NSString stringWithFormat:@"0.000000"];
    [AppManager setUserDefaultsValue:latitude key:@"latitude"];
    [AppManager setUserDefaultsValue:longitude key:@"longitude"];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:LOCATIONNOTI object:self];
    
}


- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        FLDDLogDebug(@"联网成功");
    }
    else{
        FLDDLogInfo(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        if(2 > g_MBKPermissionSuccessCount)
        {
            g_MBKPermissionSuccessCount++;
            if((LOGIN_STATE_LOGIN_SUCESS == g_loginStat) && (STATE_SUCESS == g_getNetState) && (STATE_FAIL  == g_routeSearchStat))
            {
                //            g_routeSearchStat = STATE_SUCESS;
                [[NSNotificationCenter defaultCenter] postNotificationName:MBK_PERMISSION_SUCCESS_NOTIFICATION object:nil];
            }
        }
        else if(2  == g_MBKPermissionSuccessCount)
        {
            g_MBKPermissionSuccessCount++;
            if((LOGIN_STATE_LOGIN_SUCESS == g_loginStat) && (STATE_SUCESS == g_getNetState) && (STATE_FAIL  == g_routeSearchStat))
            {
                g_routeSearchStat = STATE_SUCESS;
                [[NSNotificationCenter defaultCenter] postNotificationName:MBK_PERMISSION_SUCCESS_NOTIFICATION object:nil];
            }
        }
        FLDDLogDebug(@"授权成功");
    }
    else {
        FLDDLogWarn(@"onGetPermissionState %d",iError);
    }
}


@end
