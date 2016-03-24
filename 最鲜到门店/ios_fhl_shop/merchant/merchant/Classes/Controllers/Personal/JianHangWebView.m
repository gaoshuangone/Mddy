//
//  JianHangWebView.m
//  merchant
//
//  Created by gs on 15/5/28.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "JianHangWebView.h"
#import "WebViewJavascriptBridge.h"
#import "AccountRechargeViewController.h"
#import "AccoutRechDoingViewController.h"
@interface JianHangWebView()<UIWebViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSTimer *timer;
@property (strong, nonatomic) UIButton* button;

@end
@implementation JianHangWebView

- (void)viewDidLoad {
    self.title = @"建行卡支付";
    [self jianHangPay];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHex:0xededed];
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setTitle:@"00:00" forState:UIControlStateNormal];
    [self.button setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
    self.button.frame = CGRectMake(0, 0, 53, 19);
    UIBarButtonItem* rithtBarItem = [[UIBarButtonItem alloc]initWithCustomView:self.button];
    self.navigationItem.rightBarButtonItem = rithtBarItem ;
    rithtBarItem = nil;
    
    
    self.navigationItem.hidesBackButton = YES;
    UIButton* button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setImage:[UIImage imageNamed:@"backWithTitle.png"] forState:UIControlStateNormal];
    button1.frame = CGRectMake(0, 0, 53, 19);
    UIBarButtonItem* leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
    [button1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = leftBarItem ;
    button1 = nil;
    leftBarItem = nil;
    
   
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer =   [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(progressTimerChangeJianHang) userInfo:nil repeats:YES];
    [self.timer fire];

}
-(void)jianHangPay{
    self.view.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
    if (!self.webView) {
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT-64)];
        self.webView.backgroundColor = [UIColor whiteColor];
        [self.webView setScalesPageToFit:YES];
        [self.view addSubview:self.webView];
        
        
        
        [WebViewJavascriptBridge enableLogging];
        
        _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
            FLDDLogDebug(@"ObjC received message from JS: %@", data);
            responseCallback(@"Response for message from ObjC");
        }];
        
//        [_bridge registerHandler:@"testJavascriptHandler" handler:^(id data, WVJBResponseCallback responseCallback) {
//            FLDDLogDebug(@"reloadPage");
//            //            [self reLoginReloadPage];
//        }];
        
        [_bridge registerHandler:@"mddyCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
            FLDDLogDebug(@"testObjcCallback called: %@", data);
            
            
            NSString *html = [data toString];
//            NSLog(@"%@",html);
            if ([html isEqualToString:@"true"]) {
                [self zhifuResult:@"1"];
            }else{
//                 [self resultFailReXiaDan];
                [self zhifuResult:@"0"];
                

            }
           
            
            responseCallback(@"Response from testObjcCallback");
        }];
        
//        [_bridge registerHandler:@"WebViewJavascriptBridgeReady" handler:^(id data, WVJBResponseCallback responseCallback) {
//            FLDDLogDebug(@"testObjcCallback called: %@", data);
//            
//            
//            NSString *html = [data toString];c
//            NSLog(@"%@",html);
//            
//            responseCallback(@"Response from testObjcCallback");
//        }];
        
        [_bridge send:@"123"];
        
//        [_bridge send:@"A string sent from ObjC to JS" responseCallback:^(id response) {
//            NSLog(@"sendMessage got response: %@", response);
//        }];
        
        NSURLRequest *request = [User getBookPageRequestWithOrderNumb:[self.dict valueForKey:@"orderNumber"]];
        if(request != nil)
        {
            [self.webView loadRequest:request];
        }
        
    }
    
    
}
#pragma mark - UIWebViewDelegate
-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType{
    
//    NSString *requestString = [[request URL]absoluteString];//获取请求的绝对路径.
//    NSLog(@"~~~~~~~~~~%@",requestString);
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {

  
    NSLog(@"webView.request=%@",webView.request);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
      FLDDLogDebug(@"~~~~~~~~webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
//    NSString *currentURL = [webVitringByEvaluatingJavaScriptFromString:@"document.location.href"];
//    NSLog(@"currentURL=%@",currentURL);
//    NSLog(@"webView.request=%@",webVieew sw.request.URL);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    FLDDLogDebug(@"~~~~~~~~~~webViewDidFinishLoad");
    
    
    [_bridge send:@"123"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    FLDDLogDebug(@"instruction wevView load error:%@", error);
    
    
    
}
-(void)zhifuResult:(NSString*)result{
    
  
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    if ([result isEqualToString:@"1"]) {
        for (UIViewController* vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[AccountRechargeViewController class]]) {
                [self.navigationController  popToViewController:vc animated:YES];
                
            }
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:ZHIFUSUCCESS object:self];
    }else{//建行支付失败，返回到支付页面，进行提示
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:ZHIDURESULT object:self userInfo:@{@"info":@"0"}];
//        for (UIViewController* vc in self.navigationController.viewControllers) {
//            if ([vc isKindOfClass:[AccoutRechDoingViewController class]]) {
//                [self.navigationController  popToViewController:vc animated:YES];
//                
//            }
//        }

        
    }
  

    
}
-(void)progressTimerChangeJianHang{
    NSInteger timer = --self.timeShengYu;
    if (timer==1) {
        [self.timer invalidate];
        self.timer = nil;
        [self.button setTitle:@"00:00" forState:UIControlStateNormal];
            
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"订单超时，请重新提交" message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            alert.tag=1;
            [alert show];

        return;
        
    }
    
    NSString* str1= nil;
    if (labs(timer/60)<10) {
        str1 = [NSString stringWithFormat:@"0%ld",(long)labs(timer/60)];
    }else{
        str1 = [NSString stringWithFormat:@"%ld",labs(timer/60)];
    }
    NSString* str2= nil;
    if (timer%60<10) {
        str2 = [NSString stringWithFormat:@"0%ld",(long)(timer%60)];
        
    }else{
        str2 = [NSString stringWithFormat:@"%ld",(long)(timer%60)];
    }
    [self.button setTitle:[NSString stringWithFormat:@"%@:%@",str1,str2] forState:UIControlStateNormal];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        if (buttonIndex==0) {
            for (UIViewController* vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[AccountRechargeViewController class]]) {
                    [self.navigationController  popToViewController:vc animated:YES];
                    if (self.timer) {
                        [self.timer invalidate];
                        self.timer = nil;
                    }

                    
                }
            }

        }
    }
    
}
-(void)back{
    [SelfUser hudShowWithViewcontroller:self];
    [SelfUser mddyRequestWithMethodName:@"judgeAlipayResultJsonPhone.htm" withParams:@{@"cmdCode":g_shopAccountBlanceJsonPhoneCountCmd,@"orderNumber":[self.dict valueForKey:@"orderNumber"]} withBlock:^(id responseObject, NSError *error) {
        FLDDLogDebug(@"%@",responseObject);
            [SelfUser hudHideWithViewcontroller:self];
        
        if (!error) {
            @try {
                if ([[[responseObject valueForKey:@"statusId"] toString] isEqualToString:@"1"]) {//支付成功
                    [self zhifuResult:@"1"];
                }
                if ([[[responseObject valueForKey:@"statusId"] toString] isEqualToString:@"2"]) {//充值中
                  
                       [self zhifuResult:@"0"];
                }
                if ([[[responseObject valueForKey:@"statusId"] toString] isEqualToString:@"3"]) {//代表充值失败,重新下单
//                    [self resultFailReXiaDan];
                        [self zhifuResult:@"0"];
                }
                
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
        }else{
            
        }
        
    }];
}
-(void)resultFailReXiaDan{//代表充值失败,重新下单
    for (UIViewController* vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[AccoutRechDoingViewController class]]) {
            [self.navigationController  popToViewController:vc animated:YES];
            [[NSNotificationCenter defaultCenter]postNotificationName:XIADanREZHiFU object:self];
            if (self.timer) {
                [self.timer invalidate];
                self.timer = nil;
            }

        }
    }
}
@end
