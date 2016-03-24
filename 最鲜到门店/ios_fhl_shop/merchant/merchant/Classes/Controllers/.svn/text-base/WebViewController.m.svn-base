//
//  WebViewController.m
//  FHL
//
//  Created by panume on 14-10-20.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "WebViewController.h"
#include "Reachability.h"
@interface WebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation WebViewController

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
    
    
    if (NotReachable == [SelfUser currentSelfUser].networkStatus) {
        self.button.hidden = NO;
        [self.button setTitle:@"点击屏幕重新加载" forState:UIControlStateNormal];
        
        [MBProgressHUD hudShowWithStatus:self :@"当前网络不可用，请检查您的网络设置"];
            [self stopActivityView];
        return;
    }
    NSURLRequest *request = [User getUserPlicyPageRequest];
    if(request != nil)
    {
        [self.webView loadRequest:request];
    }
     [self.view addGestureRecognizer:self.swip];
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
    
    
    
    
    
    
    
    NSURLRequest *request = [User getUserPlicyPageRequest];
    if(request != nil)
    {
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
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if (NotReachable == [SelfUser currentSelfUser].networkStatus) {
      self.button.hidden = NO;
         [self.button setTitle:@"点击屏幕重新加载" forState:UIControlStateNormal];
//        [MBProgressHUD hudShowWithStatus:self :@"网络连接失败，请检查网络"];
          [MBProgressHUD hudShowWithStatus:self :[SelfUser currentSelfUser].ErrorMessage];
    }else{
         self.button.hidden = YES;
    }
    [self stopActivityView];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    if (NotReachable == [SelfUser currentSelfUser].networkStatus) {
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
