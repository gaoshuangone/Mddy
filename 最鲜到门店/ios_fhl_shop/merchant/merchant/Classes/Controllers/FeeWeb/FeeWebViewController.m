//
//  WebViewController.m
//  FHL
//
//  Created by panume on 14-10-20.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//
#import "WebViewJavascriptBridge.h"
#import "FeeWebViewController.h"
#include "Reachability.h"
#include "LoginViewController.h"
@interface FeeWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic,assign)BOOL isFirst;

@end

@implementation FeeWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Web";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView = [[UIWebView alloc] init];
    self.webView.frame = CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT - 64);
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        FLDDLogDebug(@"ObjC received message from JS: %@", data);
        responseCallback(@"Response for message from ObjC");
    }];
    
    [_bridge registerHandler:@"reloadPage" handler:^(id data, WVJBResponseCallback responseCallback) {
        FLDDLogDebug(@"reloadPage");
        [self reLoginReloadPage];
    }];
  

    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0, -64, WINDOW_WIDTH, WINDOW_HEIGHT);
    self.button.backgroundColor =[UIColor colorWithHex:0xf5f5f5];
    [self.button setTitle:@"" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    //    self.button.hidden = YES;
    [self.button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    [self startActivityView];

    [_bridge registerHandler:@"freightTemplateExplanationIosError" handler:^(id data, WVJBResponseCallback responseCallback) {
        FLDDLogDebug(@"freightTemplateExplanationIosError called");
        FLDDLogDebug(@"freightTemplateExplanationIosError called: %@", data);
        
        g_messageInfo = [[data objectForKey:@"message"] toString];
        if (!self.isFirst) {
            self.isFirst = YES;
               [self.navigationController popViewControllerAnimated:YES];
        }
     
    }];
    [_bridge send:@"123"];
    
    
    if (NotReachable == [SelfUser currentSelfUser].networkStatus) {
        self.button.hidden = NO;
        [self.button setTitle:@"点击屏幕重新加载" forState:UIControlStateNormal];
        
        [MBProgressHUD hudShowWithStatus:self :@"当前网络不可用，请检查您的网络设置"];
            [self stopActivityView];
        return;
    }
    NSURLRequest *request = [User getFreightTemplateExplanationPageRequest : _waybillId];
    if(request != nil)
    {
        FLDDLogDebug("request : %@", request);
        [self.webView loadRequest:request];
    }
    

    
     [self.view addGestureRecognizer:self.swip];
}


-(void)reLoginReloadPage
{
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];//用户退出登录后，取消推送的注册，登录时register
    
    if ([AppManager boolValueForKey:@"isFirstReLogin"]) {
        
        [AppManager setUserBoolValue:NO key:@"isFirstReLogin"];
        
        [self needLoginIn];
    }
}

- (void)needLoginIn
{
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
            [[NSNotificationCenter defaultCenter] postNotificationName:PUSH_CONFIG_NOTIFICATION object:nil];
//            [[NSNotificationCenter defaultCenter] postNotificationName:GET_MESSAGE_COUNT object:nil];
            
            
            [AppDelegate registerForRemoteNotification];
//            [AppManager setUserBoolValue:YES key:@"isFirstReLogin"];
            NSURLRequest *request = [User getFreightTemplateExplanationPageRequest : _waybillId];
            if(request != nil)
            {
                FLDDLogDebug("request : %@", request);
                [self.webView loadRequest:request];
            }
            
            
        }
        else {
            NSString *alert = @"账户在其他设备登录";
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:alert
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil, nil];
            alertView.tag = 1007;
            [alertView show];
            

        }
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 1007) {
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:HIT_HEART_NOTIFICATION object:nil userInfo:@{@"beginHit" : @(NO)}];
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
        [SelfUser currentSelfUser].isNeedReturnLanShou = YES;
        LoginViewController* login = [[LoginViewController alloc]initWithNibName:nil bundle:nil];
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate.baseTabBarController.navigationController pushViewController:login animated:YES];
        
    }
}


-(void)buttonPressed{
    [self startActivityView];
        [self.button setTitle:@"" forState:UIControlStateNormal];
    if (NotReachable == [SelfUser currentSelfUser].networkStatus) {
        self.button.hidden = NO;
        [self.button setTitle:@"点击屏幕重新加载" forState:UIControlStateNormal];
     
        [MBProgressHUD hudShowWithStatus:self :@"当前网络不可用，请检查您的网络设置"];
            [self stopActivityView];
        return;
    }
    
    NSURLRequest *request = [User getFreightTemplateExplanationPageRequest : _waybillId];
    if(request != nil)
    {
        FLDDLogDebug("request : %@", request);
        [self.webView loadRequest:request];
    }
 [self startActivityView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
//    [self loadPage:self.webView];
//    NSURLRequest *request = [User getUserPlicyPageRequest];
//    if(request != nil)
//    {
//        [self.webView loadRequest:request];
//    }
}

- (void)loadPage:(UIWebView*)webView {
    
//    NSString *html = @"";
//    if (self.type == WebViewTypeRegister) {
//        html = @"register";
//    }
//    else if (self.type == WebViewTypePolicy) {
//        html = @"policy";
//    }

    
    
//    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"businessPolicy" ofType:@"html"];
//    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
//    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
//    [webView loadHTMLString:appHtml baseURL:baseURL];
   
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    if (NotReachable == [SelfUser currentSelfUser].networkStatus) {
//            self.button.hidden = NO;
//      
//    }else{
//        
//       
//    }
//    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    FLDDLogDebug(@"webViewDidStartLoad");
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    FLDDLogDebug(@"webViewDidFinishLoad");
    if (NotReachable == [SelfUser currentSelfUser].networkStatus) {
      self.button.hidden = NO;
         [self.button setTitle:@"点击屏幕重新加载" forState:UIControlStateNormal];
//        [MBProgressHUD hudShowWithStatus:self :@"网络连接失败，请检查网络"];
          [MBProgressHUD hudShowWithStatus:self :[SelfUser currentSelfUser].ErrorMessage];
    }else{
         self.button.hidden = YES;
    }
    [self stopActivityView];
    [_bridge send:@"123"];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    FLDDLogDebug(@"instruction wevView load error:%@", error);
    [self stopActivityView];
//    if (NotReachable == [SelfUser curr  entSelfUser].networkStatus) {
//        
//        [MBProgressHUD hudShowWithStatus:self :@"网络连接失败，请检查网络"];
//    }
//        [self stopActivityView];
//      self.button.hidden = NO;
//   
    if (NotReachable == [SelfUser currentSelfUser].networkStatus) {
        self.button.hidden = NO;
        [self.button setTitle:@"点击屏幕重新加载" forState:UIControlStateNormal];
        [MBProgressHUD hudShowWithStatus:self :@"当前网络不可用，请检查您的网络设置"];
        
    }else{
        self.button.hidden = NO;
         [self.button setTitle:@"点击屏幕重新加载" forState:UIControlStateNormal];
        [MBProgressHUD hudShowWithStatus:self :@"网络比蜗牛还慢，挤不进去呀"];
    }
    [self stopActivityView];
}

#pragma mark活动指示器
-(void)startActivityView{
    if (self.activityIndicatorView == nil) {
        
        self.activityIndicatorView= [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0,0, 50, 50)];
        self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        self.activityIndicatorView.center = CGPointMake([UIApplication sharedApplication].keyWindow.center.x, [UIApplication sharedApplication].keyWindow.center.y-20);
        //        self.activityIndicatorView.color = [UIColor redColor];
        [self.button addSubview: self.activityIndicatorView];
        
    }
    [self.activityIndicatorView startAnimating];
    self.view.userInteractionEnabled = NO;
    
    
}
-(void)stopActivityView{
    [  self.activityIndicatorView stopAnimating];
    self.view.userInteractionEnabled = YES;
    
   
}
@end
