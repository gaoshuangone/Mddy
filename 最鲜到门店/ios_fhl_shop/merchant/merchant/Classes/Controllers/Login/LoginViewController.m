//
//  LoginViewController.m
//  FHL
//
//  Created by panume on 14-9-22.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//
#define CELL_HEIGHT     140
#define PORTRAIT_SIZE   140
#import "LoginViewController.h"
#import "AuthCodeViewController.h"
#import "User.h"
//#import "Config.h"
#import "CGeneralFunction.h"
//#import "paste"
#import "Reachability.h"
#import "DirectionView.h"
//#import "GlobalVariable.h"
#import "Resetpassword.h"
#import "HomeViewController.h"
#include <sys/sysctl.h>

#import "DirectionView1.h"
@interface LoginViewController () <UITextFieldDelegate>

@property (nonatomic, strong) NSTimer *timer;
//@property (nonatomic, strong) UIButton *nextButton;
@property (assign,nonatomic) BOOL isHavedUser;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"登录";
        
    }
    return self;
}
//
//- (UIStatusBarStyle)preferredStatusBarStyle
//
//{
//
//    return UIStatusBarStyleLightContent;
//
//}
//
//- (BOOL)prefersStatusBarHidden
//
//{
//
//    return NO;
//
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    g_loginStat = LOGIN_STATE_UNAUTO_LOGIN;
    [SelfUser currentSelfUser].busyLoginIn = NO;
    //  [UIApplication sharedApplication].statusBarHidden = YES;
    self.imageViewGuid.hidden = YES;
    // Do any additional setup after loading the view.
//    //欢迎页
//    if (![AppManager valueForKey:@"HasLaunchedOnce"]) {
//        
//        //下拉样式
//        self.navigationController.navigationBar.hidden = YES;
//                DirectionView1* direction1 =[[DirectionView1 alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT) withImageArray:iPhone4?[NSArray arrayWithObjects:@"number_first_business_wel_4.png",@"number_second_business_wel_4.png",@"number_third_business_wel_4.png", nil] :[NSArray arrayWithObjects:@"number_first_business_wel(1).png",@"number_second_business_wel(1).png",@"number_third_business_wel(1).png", nil]];;
//        [self.view addSubview:direction1];
//        
//        [UIApplication sharedApplication].statusBarHidden = YES;
//    
//        direction1.DismissAction = ^(void){
//            [UIApplication sharedApplication].statusBarHidden = NO;
//            self.navigationController.navigationBar.hidden = NO;
//       
//            self.view.frame = CGRectMake(0, 44, WINDOW_WIDTH, WINDOW_HEIGHT);
//        
//        };
//        
//    }
    
    //欢迎页
    if (![AppManager valueForKey:@"HasLaunchedOnce"]) {
        
        //下拉样式
        self.navigationController.navigationBar.hidden = YES;
        NSArray *images = @[iPhone4?[UIImage imageNamed:@"商家引导页-iOS-V1_4.png"]:[UIImage imageNamed:@"商家引导页-iOS-V1_6.png"],iPhone4?[UIImage imageNamed:@"商家引导页-iOS-V2_4.png"]:[UIImage imageNamed:@"商家引导页-iOS-V2_6.png"]];
        DirectionView* direction1 =[[DirectionView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT) images:images contents:nil];
//    initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT) withImageArray:iPhone4?[NSArray arrayWithObjects:@"number_first_business_wel_4.png",@"number_second_business_wel_4.png",@"number_third_business_wel_4.png", nil] :[NSArray arrayWithObjects:@"number_first_business_wel(1).png",@"number_second_business_wel(1).png",@"number_third_business_wel(1).png", nil]];;
        [self.view addSubview:direction1];
        
        [UIApplication sharedApplication].statusBarHidden = YES;
        
        direction1.DismissAction = ^(void){
            [UIApplication sharedApplication].statusBarHidden = NO;
            self.navigationController.navigationBar.hidden = NO;
            
            self.view.frame = CGRectMake(0, 44, WINDOW_WIDTH, WINDOW_HEIGHT);
            
        };
        
    }
    
    CGPoint centerPoint = self.imageViewIcon.center;
    centerPoint.x = WINDOW_WIDTH/2;
    self.imageViewIcon.center = centerPoint;
    //    self.nextBtn.frame = CGRectMake(self.nextBtn.frame.origin.x, self.nextBtn.frame.origin.y, WINDOW_WIDTH-32, 44);
    centerPoint = self.imageViewPhone.center;
    centerPoint.x = 16 + 8 + self.imageViewPhone.frame.size.width/2;
    self.imageViewPhone.center = centerPoint;
    //    self.telText.frame = CGRectMake(self.telText.frame.origin.x, self.telText.frame.origin.y, WINDOW_WIDTH - 48 - self.imageViewPhone.frame.size.width, 22);
    self.underlinedImageView.frame  = CGRectMake(self.underlinedImageView.frame.origin.x, self.underlinedImageView.frame.origin.y, WINDOW_WIDTH-32, 1);
    self.navigationItem.leftBarButtonItem = nil;
    
    
    _telText.delegate = self;
    g_freshCheckCodePage = NO;
    
    [_underlinedImageView setBackgroundColor: [UIColor colorWithHex:0x000000 alpha:0.54]];
    
    
    UIImage *image = [UIImage imageNamed:@"buttonnormal_n"];
    //UIEdgeInsets insets = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
    NSInteger leftCapWidth = image.size.width * 0.5f;
    // 顶端盖高度
    NSInteger topCapHeight = image.size.height * 0.5f;
    // 重新赋值
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    //[image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    [_nextBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    
    image = [UIImage imageNamed:@"buttonnormal_p"];
    leftCapWidth = image.size.width * 0.5f;
    // 顶端盖高度
    topCapHeight = image.size.height * 0.5f;
    // 重新赋值
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    [_nextBtn setBackgroundImage:image forState:UIControlStateHighlighted];
    
    image = [UIImage imageNamed:@"buttonnormal_d"];
    leftCapWidth = image.size.width * 0.5f;
    // 顶端盖高度
    topCapHeight = image.size.height * 0.5f;
    // 重新赋值
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    [_nextBtn setBackgroundImage:image forState:UIControlStateDisabled];
    
    
    
    //   if(iPhone5){
    //       self.imageViewIcon.frame = CGRectMake(320/2-112, 80+20, 228, 74);
    //        self.nextBtn.frame = CGRectMake(16, 247+44, 320-32, 44 );
    //        self.telText.frame = CGRectMake(45, 186+10, 320-45, 22);
    //        self.underlinedImageView.frame  = CGRectMake(16, 230, 320-32, 2);
    //    }
    //    if(iPhone4){
    //        self.imageViewIcon.frame = CGRectMake(320/2-112, 80+20+12, 228, 74);
    //        self.nextBtn.frame = CGRectMake(16, 247+44+64, 320-32, 44 );
    //        self.telText.frame = CGRectMake(45, 186+10, 320-45, 22);
    //        self.underlinedImageView.frame  = CGRectMake(16, 230, 320-32, 2);
    //    }
    
    [self.nextBtn addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    
    //    self.showPasswordButton.layer.cornerRadius = 10;
    //    self.showPasswordButton.layer.masksToBounds = YES;
    // self.showPasswordButton.layer.borderColor = [UIColor colorWithHex:0x7f8c99].CGColor;
    //    self.showPasswordButton.layer.borderWidth = 1;
    
    
    _bFirst = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBackGround)];
    [self.view addGestureRecognizer:singleTap];
    UITapGestureRecognizer *logoSingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBackGround)];
    [self.imageViewPhone addGestureRecognizer:logoSingleTap];
    UITapGestureRecognizer *backGroundSingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBackGround)];
    [self.imageViewkBackGround addGestureRecognizer:backGroundSingleTap];
    //     [(UIControl *)self.view addTarget:self action:@selector(onClickBackGround) forControlEvents:UIControlEventTouchDown];
    _timeCount = 61;
    
    //    if (WINDOW_HEIGHT == WIN_HEI_4) {
    //
    //        [self.baseScrollView setContentSize:CGSizeMake(WINDOW_WIDTH, WINDOW_HEIGHT + 40)];
    //        FLDDLogDebug(@"scrollView contentsize:%@",NSStringFromCGSize(self.baseScrollView.contentSize));
    //        FLDDLogDebug(@"scrollView:%@",NSStringFromCGPoint(self.baseScrollView.contentOffset));
    //        [self.baseScrollView setContentOffset:CGPointMake(0, 40)];
    //        FLDDLogDebug(@"scrollView:%@",NSStringFromCGPoint(self.baseScrollView.contentOffset));
    //
    //
    //    }else{
    //
    //
    //    }
    
    self.telText.tintColor = [UIColor orangeColor];
    self.passwordTextField.tintColor =[UIColor orangeColor];
    //    [self.showPasswordButton setTitleColor:[UIColor colorWithHex:0x7f8c99] forState:UIControlStateNormal];
    //    self.passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;                                                                                      ;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(noti) name:UITextFieldTextDidChangeNotification object:nil];
    //    self.imageView = [UIImageView circleImageViewFrame:self.imageView.frame Radius:PORTRAIT_SIZE / 2];
    
    //     self.imageView.layer.cornerRadius = 35;
    //     self.imageView.layer.masksToBounds = YES;
    
    //    UIImage* imageLogo =[UIImage imageWithData:[AppManager readDataFromDocumentWithName:@"logo.jpg"]];
    //    if (imageLogo) {
    //        self.imageView.image = imageLogo;
    //             self.imageView.layer.cornerRadius = 35;
    //             self.imageView.layer.masksToBounds = YES;
    //    }
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)noti{
    if (self.telText.text.length==0 || self.passwordTextField.text.length==0) {
        self.nextBtn.enabled =NO;
    }
}
-(void)appWillEnterForegroundNotification{
    //    [self.passwordTextField resignFirstResponder];
}
-(void)appWillEnterNotification{
    if (iPhone4) {
        
        [self.passwordTextField resignFirstResponder];
    }
}
//-(void)but{
//    Resetpassword* map= [[Resetpassword alloc]initWithNibName:@"Resetpassword" bundle:nil];
//
//    [self.navigationController pushViewController:map animated:YES];
//}

- (IBAction)reSetPasswordButtonPressed:(id)sender
{
    AuthCodeViewController *authCodeViewController = [[AuthCodeViewController alloc] initWithNibName:@"AuthCodeViewController" bundle:nil];
    
    if (self.telText.text.length == 13) {
        authCodeViewController.strPhone = self.telText.text;
    }
    
    [self.navigationController pushViewController:authCodeViewController animated:YES];
    
}
- (IBAction)showOrHidePasswordButtonPressed:(id)sender
{
    [self.passwordTextField resignFirstResponder];
    
    if(_paramsList != nil)
    {
        [_paramsList removeAllObjects];
    }
    else
    {
        _paramsList = [NSMutableDictionary dictionary];
    }
    
    NSString *latitude =   [AppManager valueForKey:@"latitude"];
    NSString *longitude = [AppManager valueForKey:@"longitude"];
    [_paramsList setObject:latitude forKey:@"latitude"];
    [_paramsList setObject:longitude forKey:@"longitude"];
    
    NSString *telephone = [_telText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (![AppManager isValidateMobile:telephone]) {
        if(_telText.text != nil)
        {
            [MBProgressHUD hudShowWithStatus:self :@"手机号码无效，请重新输入"];
            return;
        }
    }
    else {
        g_telephone = telephone;
    }
    
    [_paramsList setObject:g_telephone forKey:@"clerkTel"];
    
    NSLog(@"%@",_paramsList);
    [MBProgressHUD hudShowWithViewcontrollerStatus:self :@"发送中..."];
    [User autoCodeWithParams:_paramsList block:^(NSError *error) {
        
        [MBProgressHUD hudHideWithViewcontroller:self];
        if (!error) {
            g_timeCount = 60 ;
            [MBProgressHUD hudShowWithStatus :self : @"验证码已发送请注意查收"];
            if (self.timer) {
                
                
                [self.timer invalidate];
            }
            self.timer =   [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(progressTimerChange) userInfo:nil repeats:YES];
            //                }
            [self.timer fire];
            
        }
        else {
            LogInfo(@"error = %@, error.userInfo = %@", error, error.userInfo);
            [MBProgressHUD hudShowWithStatus :self : [SelfUser currentSelfUser].ErrorMessage];
        }
    }];
    
    
    
    
    
    
    
    //    NSString *messageStr = [[NSString alloc] initWithString:[NSString stringWithFormat:@"我们将发送验证码到这个手机号码：\n%@", _telText.text]];
    //    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"确认手机号码"
    //                                                 message:messageStr
    //                                                delegate:self
    //                                       cancelButtonTitle:@"取消"
    //                                       otherButtonTitles:@"确定",nil];
    //    [alert show];
    
    //    if (self.passwordTextField.text.length == 0) {
    //        return;
    //    }
    //
    //    UIButton *button = (UIButton *)sender;
    //    if (self.passwordTextField.secureTextEntry) {
    //        [self.passwordTextField setSecureTextEntry:NO];
    ////        self.passwordTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    //        [button setTitle:@"隐藏密码" forState:UIControlStateNormal];
    //
    //    }
    //    else {
    //        [self.passwordTextField setSecureTextEntry:YES];
    ////           self.passwordTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    //        [button setTitle:@"显示密码" forState:UIControlStateNormal];
    //
    //    }
}
- (void)progressTimerChange{
    if (g_timeCount == 60) {
        [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            //            self.getCheckCodeBtn.frame = CGRectMake(WINDOW_WIDTH - 16 - 45, self.getCheckCodeBtn.frame.origin.y, 45, self.getCheckCodeBtn.bounds.size.height);
            //            self.label.frame = self.getCheckCodeBtn.frame;;
            self.passwordTextField.frame=CGRectMake(self.passwordTextField.frame.origin.x, self.passwordTextField.frame.origin.y,WINDOW_WIDTH-16-45-43, self.passwordTextField.bounds.size.height);
            [self.showPasswordButton setTitle:@"" forState:UIControlStateNormal];
            self.labelTime.text = @"60s";
            
            
        } completion:^(BOOL finished) {
            self.showPasswordButton.userInteractionEnabled = NO;
            
        }];
    }
    if(g_timeCount == 0)
    {
        if(_timer != nil)
        {
            //            [_timer setFireDate:[NSDate distantFuture]];
            [self.showPasswordButton setTitle:@"重新获取" forState:UIControlStateNormal];
            self.showPasswordButton.userInteractionEnabled = YES;
            self.labelTime.text =@"";
            [self.timer invalidate];
            
            
        }
        
        return;
    }else if(g_timeCount == 1)
    {
        g_timeCount--;
        
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //            self.getCheckCodeBtn.frame = CGRectMake(WINDOW_WIDTH - 16 - 90, self.getCheckCodeBtn.frame.origin.y, 90, self.getCheckCodeBtn.bounds.size.height);
            self.passwordTextField.frame=CGRectMake(self.passwordTextField.frame.origin.x, self.passwordTextField.frame.origin.y,WINDOW_WIDTH-16-90-42, self.passwordTextField.bounds.size.height);
            //            self.label.frame = self.getCheckCodeBtn.frame;
        } completion:^(BOOL finished) {
            //            [self.getCheckCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
            //
            //       [self.showPasswordButton setTitle:@"重新获取" forState:UIControlStateNormal];
            //            self.showPasswordButton.userInteractionEnabled = YES;
            //            self.labelTime.text =@"";
            //            self.label.textColor = [UIColor colorWithHex:0x7f8c99];
            //            self.getCheckCodeBtn.layer.borderColor = [UIColor colorWithHex:0x7f8c99].CGColor;
        }];
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        
        [self.showPasswordButton setTitle:@"重新获取" forState:UIControlStateNormal];
        self.showPasswordButton.userInteractionEnabled = YES;
        self.labelTime.text =@"";
        //        if(_timer != nil)
        //        {
        //            [_timer setFireDate:[NSDate distantFuture]];
        //        }
    }
    else
    {
        g_timeCount--;
        //         [self.showPasswordButton setTitle:[NSString stringWithFormat:@"%dS",g_timeCount] forState:UIControlStateNormal];
        self.labelTime.text = [NSString stringWithFormat:@"%lus",(unsigned long)g_timeCount];
        //        [self setTimerChanged];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0: //YES应该做的事
            break;
        case 1://NO应该做的事
        {
            
            NSLog(@"%@",_paramsList);
            [User autoCodeWithParams:_paramsList block:^(NSError *error) {
                
                if (!error) {
                    
                    
                    
                    
                }
                else {
                    LogInfo(@"error = %@, error.userInfo = %@", error, error.userInfo);
                    
                    //                    [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
                }
            }];
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)guidButtonPressed:(id)sender {
    [UIApplication sharedApplication].statusBarHidden = NO;
    [self.imageViewGuid removeFromSuperview];
}
- (void)onClickBackGround
{
    [self.view endEditing:YES];
}
//- (void)viewWillLayoutSubviews
//{
//
//    if (!iPhone4) {
////        if (![AppManager valueForKey:@"HasLaunchedOnce"]) {
////              self.view.frame = CGRectMake(0, 20, WINDOW_WIDTH, WINDOW_HEIGHT);
////        }else{
////
////        NSLog(@"@@!!%@",NSStringFromCGRect(self.view.frame));
////        NSLog(@"%f",self.view.frame.origin.y);
//        NSInteger intt =self.view.frame.origin.y;
//        NSLog(@"%ld",(long)intt);
//            self.view.frame = CGRectMake(0, 36, WINDOW_WIDTH, WINDOW_HEIGHT);
//        if (intt == 0) {
//               self.view.frame = CGRectMake(0, 20, WINDOW_WIDTH, WINDOW_HEIGHT);
//        }
////
////                NSLog(@"__%@",NSStringFromCGRect(self.view.frame));
////        }
//    }
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    //    self.navigationController.navigationBar.hidden = YES;
    ////
    float red = 252/255.0;
    float green = 102/255.0;
    float blue = 5/255.0;
    self.navigationItem.hidesBackButton = YES;
    ////    [buttonSoonSend setBackgroundColor: [UIColor colorWithRed:red green:green blue:blue alpha:1.0]];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName ,nil];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.title  = @"最鲜到";
    //    self.tabBarView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    if([AppManager valueForKey:@"telephone"].length>0){
        self.telText.text = [CommonUtils changePhoneNumberWithNumber:[AppManager valueForKey:@"telephone"] withType:@" "];
        
    }
    if (self.telText.text.length > 0 && self.passwordTextField.text.length>0) {
        self.nextBtn.enabled = YES;
    }
    
    
    
    [self setImageWithTel:nil];
    
}
-(void)setImageWithTel:(NSString*)tel{
    NSString* str = nil;
    if (tel ==nil) {
        
        if ([AppManager valueForKey:@"telephone"]!=nil) {
            NSLog(@"%@",[AppManager valueForKey:@"telephone"]);
            str = [AppManager valueForKey:[AppManager valueForKey:@"telephone"]];
            NSLog(@"!@#%@",str);
        }
        
    }else{
        str = [AppManager valueForKey:tel];
        
    }
    if (str.length >0) {
        UIImage* imageLogo =[UIImage imageWithData:[AppManager readDataFromDocumentWithName:str]];
        if (imageLogo) {
            self.imageView.image = imageLogo;
            self.imageView.layer.cornerRadius = 35;
            self.imageView.layer.masksToBounds = YES;
        }
        
    }
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    self.navigationController.navigationBar.hidden = NO;
    
}
-(void)btn{
    
    //    NSArray *array = [NSArray arrayWithObjects:@"", nil];
    //    NSString *value = [array objectAtIndex:10];
    //    FLDDLogDebug(@"The value at index 10 is: %@", value);
    
    
    [self.view endEditing:YES];
    
    
    
    if(_paramsList != nil)
    {
        [_paramsList removeAllObjects];
    }
    else
    {
        _paramsList = [NSMutableDictionary dictionary];
    }
    
    //    NSString *latitude =   [AppManager valueForKey:@"latitude"];
    //    NSString *longitude = [AppManager valueForKey:@"longitude"];
    //    [_paramsList setObject:latitude forKey:@"latitude"];
    //    [_paramsList setObject:longitude forKey:@"longitude"];
    
    NSString *telephone = [_telText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (![AppManager isValidateMobile:telephone]) {
        if(_telText.text != nil)
        {
            //            [SVProgressHUD showErrorWithStatus:@"手机号码无效，请重新输入"];
            [MBProgressHUD hudShowWithStatus:self :@"请输入正确的手机号码"];
            return;
        }
    }
    else {
        g_telephone = telephone;
    }
    
    //    [_paramsList setObject:g_telephone forKey:@"clerkTel"];
    
    
    if ((self.passwordTextField.text.length < 6) || ((self.passwordTextField.text.length > 20))) {
        //        [SVProgressHUD showErrorWithStatus:@"请输入正确密码"];
        [MBProgressHUD hudShowWithStatus:self :@"请输入正确密码"];
        
        return;
    }
    
    
    
    
    
    
    
    
    [_paramsList setObject:telephone forKey:@"clerkTel"];
    [_paramsList setObject:[CGeneralFunction passwordGetDecodeConfusionKey:MD5(self.passwordTextField.text)] forKey:@"passwd"];
    //      [_paramsList setObject:[CGeneralFunction passwordGetDecodeConfusionKey:MD5(@"345678")] forKey:@"passwd"];
    //     [_paramsList setObject:@"3B1A2DE3E26DC597DCB84D3202A89146" forKey:@"passwd"];
    
    //    if ( [AppManager valueForKey:@"phoneType"]==nil) {
    [self getSystemInfo];
    //    }
    [_paramsList setObject:[AppManager valueForKey:@"phoneType"] forKey:@"phoneType"];
    
    [_paramsList setObject:[AppManager valueForKey:@"phoneSystem"] forKey:@"phoneSystem"];
    [_paramsList setObject:[AppManager valueForKey:@"version"] forKey:@"version"];
    //    [AppManager setUserDefaultsValue:[CGeneralFunction passwordGetDecodeConfusionKey:MD5(checkCodeStr)] key:@"password"];
    //    FLDDLogDebug(@"储存md5过混淆后的密码key＝ password:%@", [AppManager valueForKey:@"identifyingCode"]);
    
    if(_paramsList == nil)
    {
        return;
    }
    
    
    //    [SelfUser hudShowWithViewcontroller:self];
    //    UIViewController* viewc=viewcontroller;
    
    MBProgressHUD* hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = @"登录中...";
    hud.tag =101;
    [hud show:YES];
    
    [AppManager setUserDefaultsValue:telephone key:@"telephone"];//本机的手机号

    //    [MBProgressHUD hudShowWithStatus :self : @"登录中..."];
    [User loginWithFixedPasswordJsonPhone:_paramsList block:^(NSError *error) {
        
        [AppManager setUserDefaultsValue:[CGeneralFunction passwordGetDecodeConfusionKey:MD5(self.passwordTextField.text)] key:@"password"];
        //            [AppManager setUserDefaultsValue:@"3B1A2DE3E26DC597DCB84D3202A89146" key:@"password"];
        [SelfUser hudHideWithViewcontroller:self];
        
        //        [MBProgressHUD hudHideWithViewcontroller:self];
         
        if (!error) {
                     FLDDLogDebug(@"login success");
            g_loginStat = LOGIN_STATE_LOGIN_SUCESS;
            [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_VERSION_NOTIFICATION object:nil];
            [AppManager setUserDefaultsValue:@"2" key:@"isFirst"];
            //退出登录后，再次登录
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)]) {
                if ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
                    //                    [AppDelegate registerForRemoteNotification];
                }
            }
            else {
                //                [AppDelegate registerForRemoteNotification];
            }
            
            //            [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_LOCATION_NOTIFICATION object:nil];
            
            //            [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_VERSION_NOTIFICATION object:nil];
            //              [[NSNotificationCenter defaultCenter] postNotificationName:XINTIAO object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:HIT_HEART_NOTIFICATION object:nil userInfo:@{@"beginHit" : @(YES)}];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            
            
        }else {
            [ MBProgressHUD hudShowWithStatus:self : [SelfUser currentSelfUser].ErrorMessage];
        }
    }];
    
    
    //    NSString *password = [AppManager valueForKey:@"password"];
    //    FLDDLogDebug(@"取到密码%@",password);
    //    [User reLoginWithFixedPasswordJsonPhone:_paramsList block:^(NSError *error) {
    //        if (!error) {
    //            [self.navigationController popToRootViewControllerAnimated:YES];
    //        }
    //        else {
    //
    //        }
    //    }];
    
    
    
    
    
    
    
    
}
-(void)getSystemInfo{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    NSString *strSysName = [[UIDevice currentDevice] systemVersion];
    
    
    [AppManager setUserDefaultsValue:platform key:@"phoneType"];
    [AppManager setUserDefaultsValue:strSysName key:@"phoneSystem"];
    [AppManager setUserDefaultsValue:g_versionSNO key:@"version"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


#pragma mark -
#pragma mark - Private


//- (void)autoLogin
//{
////     [SVProgressHUD showWithStatus:@"自动登录中，请稍候..." maskType:SVProgressHUDMaskTypeBlack];
//    NSString *phone = [AppManager valueForKey:@"telephone"];
//    NSString *password = [AppManager valueForKey:@"password"];
//    FLDDLogDebug(@"取到密码%@",password);
//    if (phone == nil || password == nil|| [phone isEqualToString:@""]) {
//           [SVProgressHUD dismiss];
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
//       [SVProgressHUD dismiss];
//        if (!error) {
//
////            NSString *status = [User currentUser].state;
////
////            if (![status isEqualToString:@"0"] || ![status isEqualToString:@"1"] || status != nil) {
////                [self.navigationController dismissViewControllerAnimated:NO completion:nil];
//
//            if ([self  isKindOfClass:[ LoginViewController class]]) {
//                [AppManager setUserDefaultsValue:@"2" key:@"isFirst"];
////            [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_VERSION_NOTIFICATION object:nil];
//                [[NSNotificationCenter defaultCenter] postNotificationName:PUSH_CONFIG_NOTIFICATION object:nil];
////                  [[NSNotificationCenter defaultCenter] postNotificationName:XINTIAO object:nil];
//                [[NSNotificationCenter defaultCenter] postNotificationName:HIT_HEART_NOTIFICATION object:nil userInfo:@{@"beginHit" : @(YES)}];
//                [self.navigationController popViewControllerAnimated:YES ];
//            }
//
//
//            self.isHavedUser = YES;
////            }
//
//
//        }
//        else
//        {
//            FLDDLogDebug(@"error = %@, error.userInfo = %@", error, error.userInfo);
////            [User currentUser].state = @"-1";
//            @try {
//                if(error != nil && error.userInfo != nil && error.userInfo.count >= 6)
//                {
//                    NSString *failStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
//                    FLDDLogDebug(@"fail:%@", failStr);
//                    if(([g_connectServerOffine isEqualToString: failStr]) || ([g_connectServerFail isEqualToString: failStr]))
//                    {
//                        [SVProgressHUD showErrorWithStatus:@"当前网络不可用，请检查您的网络设置"];
//                    }
//                    else
//                    {
//                        [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
//                    }
//                }
//                else
//                {
//                    [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
//                }
//
//            }
//            @catch (NSException *exception) {
//                [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
//            }
//            //[SVProgressHUD showErrorWithStatus:@"自动登录失败，请重新登录"];
//        }
//    }];
//}


///*****************************************************************************
// 函数:   (Boolean)checkTelFormat : (NSString *)string
// 描述:   检查字符串是否为指定的格式
// 调用:
// 被调用: ((NSString *)getTextFieldStr : (NSString *)string : (NSString *)textFieldValue
// 返回值: 是指定格式返回真，否则为假
// 其它:   调用者保证字符串为空的情况，减少重复检查参数
// ******************************************************************************/
//- (Boolean)checkTelFormat : (NSString *)string
//{
//    char *tel_char = (char *)[string UTF8String];
//    NSInteger i;
//    i = strlen(tel_char);
//    if(i >= 9)
//    {
//        if((tel_char[3] != ' ') || (tel_char[8] != ' '))
//        {
//            return NO;
//        }
//
//    }
//    if(i >= 4)
//    {
//        if(tel_char[3] != ' ')
//        {
//            return NO;
//        }
//
//    }
//
//    if(i == 3)
//    {
//        return NO;
//    }
//    else if(i == 8)
//    {
//        return NO;
//    }
//
//    return YES;
//
//}
//
//
///*****************************************************************************
// 函数:   (NSString *)getCorrectTelStr : (NSString *)string
// 描述:   字符串格式化处理
// 调用:
// 被调用: ((NSString *)getTextFieldStr : (NSString *)string : (NSString *)textFieldValue
// 返回值:
// 其它:   调用者保证字符串为空的情况，减少重复检查参数
// ******************************************************************************/
//- (NSString *)getCorrectTelStr : (NSString *)string
//{
//    //多一个字符位为了保证能放下增加空格的字符串
//    NSString *str = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%@", string, @"1"]];
//    char *tel_char = (char *)[str UTF8String];
//    char *newTel_char = (char *)[string UTF8String];
//    char c;
//    NSInteger i, j, len;
//    memset(newTel_char, 0, strlen(newTel_char));
//    len = strlen(tel_char);
//
//    j = 0;
//    for(i = 0; i < len - 1; i++)
//    {
//        c = tel_char[i];
//        if(c != ' ')
//        {
//            newTel_char[j++] = c;
//        }
//
//    }
//
//    memset(tel_char, 0, len);
//    j = 0;
//    for(i = 0; i < strlen(newTel_char); i++)
//    {
//        c = newTel_char[i];
//        tel_char[j++] = c;
////        if(c != ' ')
////        {
////            tel_char[j++] = c;
////        }
//        if((i == 2) || (i == 6))
//        {
//            tel_char[j++] = ' ';
//        }
//    }
//
//
//    return [[NSString alloc] initWithString:[NSString stringWithFormat:@"%s", tel_char]];
//
//}
//
///*****************************************************************************
// 函数:   (NSString *)getTextFieldStr : (NSString *)string : (NSString *)textFieldValue
// 描述:   字符串拼接，判断字符串是否为指定格式，字符串格式化
// 调用:   (Boolean)checkTelFormat1 : (NSString *)string,
//        (NSString *)getCorrectTelStr : (NSString *)string
// 被调用: (BOOL)textField:(UITextField *)textField
// shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
// 返回值:
// 其它:
// ******************************************************************************/
//- (NSString *)getTextFieldStr : (NSString *)string : (NSString *)textFieldValue
//{
//    char *tel_char = (char *)[string UTF8String];
//    char *textFieldValue_char = (char *)[textFieldValue UTF8String];
//    NSString *resultStr = nil;
//    NSInteger len1, len2;
//    len1 = strlen(textFieldValue_char);
//    len2 = strlen(tel_char);
//    if((len1 == 0) && (len2 == 1))
//    {
//        return string;
//    }
//    if((len1 == 1) && (len2 == 0))
//    {
//        return @"";
//    }
//    else if((textFieldValue_char[len1 - 1] == ' ') && (tel_char[len2 - 1] != ' ') && (len1 > len2) && (len1 != len2 + 2))
//    {
//        tel_char[len2 - 1] = '\0';
//        return [[NSString alloc] initWithString:[NSString stringWithFormat:@"%s", tel_char]];
//    }
//
//
//    //NSString *telStr = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    if((string == nil) || ([string isEqualToString:@""]))
//    {
//        return @"";
//    }
//
//    if([self checkTelFormat:string])
//    {
//        return string;
//    }
//
////    if([self checkTelStrBlankSpace:string])
////    {
////        resultStr = [self getNewTelStr:string];
////        return resultStr;
////    }
////    else
////    {
//        resultStr = [self getCorrectTelStr:string];
//        return resultStr;
////    }
//
//}
//
///*****************************************************************************
// 函数:   (NSString *)getNewStr : (NSString *)string : (NSString *)textFieldValue : (NSInteger)index
// 描述:   中间增加字符处理
// 调用:
// 被调用: (BOOL)textField:(UITextField *)textField
//        shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
// 返回值:
// 其它:
// ******************************************************************************/
//- (NSString *)getNewStr : (NSString *)string : (NSString *)textFieldValue : (NSInteger)index
//{
//    if((string == nil) || (textFieldValue == nil) || (index < 0) || (index > [textFieldValue length]))
//    {
//        return nil;
//    }
//
//
//    char c;
//    NSInteger i, j;
//    NSString *str = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%@", textFieldValue, @"1"]];
//    char *tel_char = (char *)[str UTF8String];
//    char *new_char = (char *)[string UTF8String];
//    char *textFieldValue_char = (char *)[textFieldValue UTF8String];
//    NSInteger len1, len2;
//    len1 = strlen(textFieldValue_char);
//    len2 = strlen(tel_char);
//    if((len1 == 0) && (len2 == 0))
//    {
//        return string;
//    }
//
//    memset(tel_char, 0, len2);
//
//    j = 0;
//    for(i = 0; i < len1; i++)
//    {
//        if(i == index)
//        {
//            tel_char[j++] = new_char[0];
//        }
//        c = textFieldValue_char[i];
//        tel_char[j++] = c;
//    }
//
//    return [[NSString alloc] initWithString:[NSString stringWithFormat:@"%s", tel_char]];
//}
//
///*****************************************************************************
// 函数:   (BOOL)checkNewStrLength : (NSString *)string : (NSString *)textFieldValue
// 描述:   检查复制的字符串和文本种的字符串拼接在一起的字符串已经超过了最大手机号长度字符串13
// 调用:
// 被调用:
// 返回值:
// 其它:
// ******************************************************************************/
//- (BOOL)checkNewStrLength : (NSString *)string : (NSString *)textFieldValue
//{
//    long i, j, m, n;
//    m = [string length];
//    if(m > 13)
//    {
//        return NO;
//    }
//
//    n =[textFieldValue length];
//    if(m + n > 13)
//    {
//        return NO;
//    }
//    j = 0;
//    //NSString *str = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%@", textFieldValue, @"1"]];
//    char *tel_char = (char *)[string UTF8String];
//    for(i = 0; i < m; i++)
//    {
//        if(tel_char[i] == ' ')
//        {
//            j++;
//        }
//    }
//
//    if(j > 2)
//    {
//        return NO;
//    }
//
//
//    if(n > 0)
//    {
//        char *textFieldValue_char = (char *)[textFieldValue UTF8String];
//        for(i = 0; i < n; i++)
//        {
//            if(textFieldValue_char[i] == ' ')
//            {
//                j++;
//            }
//        }
//
//        if(j > 2)
//        {
//            return NO;
//        }
//        else if(m + (2 - j) + n > 13)
//        {
//            return NO;
//        }
//
//    }
//
//
//    return YES;
//}


- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    //返回一个BOOL值指明是否允许根据用户请求清除内容
    //可以设置在特定条件下才允许清除内容
    [_underlinedImageView setBackgroundColor: [UIColor colorWithHex:0x000000  alpha:0.54]];
    _nextBtn.enabled = NO;
    return YES;
}

/*****************************************************************************
 函数:   (BOOL)textField:(UITextField *)textField
 shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 描述:   文本内容改变事件，负责取消非模态提示框，文本内容的长度限制，格式化显示，格式化增，删
 调用:
 被调用:
 返回值:
 其它:
 ******************************************************************************/

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (iPhone4 && textField == self.passwordTextField) {
        
        NSLog(@"!!!~~%@",NSStringFromCGRect(self.view.frame));
//        CGRect frame = textField.frame;
//        int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        //    float width = self.view.frame.size.width;
        //    float height = self.view.frame.size.height;
        //    if(offset > 0)
        //    {
        //        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        CGRect rect = CGRectMake(0, -28, WINDOW_WIDTH, WINDOW_HEIGHT);
        self.view.frame = rect;
        //    }else{
        //        CGRect rect = CGRectMake(0, -42, WINDOW_WIDTH, WINDOW_HEIGHT);
        //        self.view.frame = rect;
        //    }
        NSLog(@"!!!~~%@",NSStringFromCGRect(self.view.frame));
        [UIView commitAnimations];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (iPhone4 && textField == self.passwordTextField) {
        //    NSTimeInterval animationDuration = 0.3f;
        //    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        //    [UIView setAnimationDuration:animationDuration];
        CGRect rect = CGRectMake(0.0f, 64, self.view.frame.size.width, self.view.frame.size.height);
        self.view.frame = rect;
        //    [UIView commitAnimations];
        //    [textField resignFirstResponder];
    }
    return YES;
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (iPhone4 && textField == self.passwordTextField) {
        
        
        
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        CGRect rect = CGRectMake(0.0f, 44, self.view.frame.size.width, self.view.frame.size.height);
        self.view.frame = rect;
        [UIView commitAnimations];
        [textField resignFirstResponder];
    }
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (([textField.text length] <= 1) && [string isEqualToString:@""])
    {
        _nextBtn.enabled = NO;
    }
    else
    {
        if (textField == self.telText) {
            if (self.passwordTextField.text.length > 0) {
                _nextBtn.enabled = YES;
                
            }
        }
        else if (textField == self.passwordTextField) {
            if (self.telText.text.length > 0) {
                
                if ([AppManager isPasswordValid:string]) {
                    _nextBtn.enabled = YES;
                }
            }
        }
    }
    
    if(textField == _telText)
    {
        
        if ([CGeneralFunction inputTelephone: textField : range : string] == YES) {
            
            [self.showPasswordButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            if (self.timer) {
                [self.timer invalidate];
                self.timer = nil;
                [self.showPasswordButton setTitle:@"重新获取" forState:UIControlStateNormal];
                self.showPasswordButton.userInteractionEnabled = YES;
                self.labelTime.text =@"";
                
            }
            self.passwordTextField.frame=CGRectMake(self.passwordTextField.frame.origin.x, self.passwordTextField.frame.origin.y,WINDOW_WIDTH-16-90-42, self.passwordTextField.bounds.size.height);
            
            
            self.imageView.image = [UIImage imageNamed:@"photo_nomal_bg.png"];
            //            self.imageView.layer.cornerRadius = 35;
            //            self.imageView.layer.masksToBounds = YES;
            
            return YES;
        }else{
            
            NSLog(@"%@",_telText.text);
            NSString *telephone = [_telText.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            [self setImageWithTel:telephone];
            return NO;
        }
        
        //        return [CGeneralFunction inputTelephone: textField : range : string];
    }else {
        if (string.length > 0) {
            if (![AppManager isPasswordValid:string]) {
                return NO;
            }
            
            if (textField.text.length  + string.length > 20)
            {
                return NO;
            }
            
        }
    }
    
    if (textField == self.passwordTextField) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        
        if (textField.text.length+string.length >6) {
            return NO;
        }
    }
    
    
    return YES;
}
//{
//
//    if ([self.telText isFirstResponder]) {
//        if (self.telText.text.length==1) {
//            if ([string isEqualToString:@""]) {
//                self.nextBtn.enabled = NO;
//                return YES;
//            }
//        }
//
//    }
//
//
//
//
//
//    if ([string isEqualToString:@" "]) {
//        return NO;
//    }
//
//if ([self.passwordTextField isFirstResponder]) {
//    if (self.passwordTextField.text.length !=0&&![string isEqualToString:@""]) {
//        if (self.telText.text.length==0) {
//            self.nextBtn.enabled =NO;
//        }else{
//
//        self.nextBtn.enabled =YES;
//        }
//    }else{
//        if (![string isEqualToString:@""]) {
//            if (self.telText.text.length==0) {
//                self.nextBtn.enabled =NO;
//            }else{
//           self.nextBtn.enabled =YES;
//            }
//        }else{
//        self.nextBtn.enabled =NO;
//        }
//    }
//}
//    if ([string isEqualToString:@""]) {
//        return YES;
//    }
//    [_underlinedImageView setBackgroundColor: [UIColor colorWithHex:0xfc6605  alpha:0.54]];
//    if (textField == self.passwordTextField) {
//
//
//        if (textField.text.length>19) {
//            return NO;
//        }else{
//            return YES;
//        }
//    }
////    //发送消息，取消非模态提示框
////    NSNotification *cn = [NSNotification notificationWithName:(NSString *)g_closeHud
////                                                       object:self];
////    [[NSNotificationCenter defaultCenter] postNotification: cn];
//    if (([_telText.text length] <= 1) && [string isEqualToString:@""])
//    {
//        [_underlinedImageView setBackgroundColor: [UIColor colorWithHex:0x000000  alpha:0.54]];
//        _nextBtn.enabled = NO;
//    }
//    else
//    {
//        if (self.passwordTextField.text.length==0) {
//
//        }else{
//            if (self.telText.text.length==0) {
//                self.nextBtn.enabled =NO;
//            }else{
//        _nextBtn.enabled = YES;
//            }
//        }
//    }
//
//    if(textField == _telText)
//    {
//        //文本内容的长度限制
//        if((range.location > 12) || (([_telText.text length] >= 13) && (![string isEqualToString:@""])))
//        {
//
//            return NO;
//        }
//
//        else
//        {
//            //限制粘贴成的字符串超过手机号的长度
//            if ((string != nil) && (![string isEqualToString:@""]))
//            {
//                if(![self checkNewStrLength:string :_telText.text])
//                {
//                    return NO;
//                }
//            }
//
//            NSString *newStr = nil;
//            if(![string isEqualToString:@""])  //增加字符操作时
//            {
//                //判断是否是在尾部增加
//                if([_telText.text length] == range.location)
//                {
//                    //判断是否是输入的第一个字符
//                    if(_telText.text != nil)
//                    {
//                        //组装非格式的字符串
//                        newStr = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%@", _telText.text, string]];
//                    }
//                    else
//                    {
//                        newStr = string;
//                    }
//                }
//                else
//                {
//                    //中间增加字符处理
//                    newStr = [self getNewStr:string:_telText.text:(range.location)];
//                    if(newStr == nil)
//                    {
//                        return NO;
//                    }
//
//                }
//
//            }
//            else //删除字符操作时
//            {
//                NSUInteger len = [_telText.text length];
//                //当只有一个字符，采用系统文本框删除处理
//                if(len == 1)
//                {
//                    return YES;
//                }
//                char *tel_char = (char *)[_telText.text UTF8String];
//                char *textFieldValue_char = (char *)[_telText.text UTF8String];
//                NSInteger i, j, k;
//                memset(tel_char, 0, len);
//                j = 0;
//                k = range.location;
//                //当是删除空格时连带删除前面的字符
//                if(k == 3)
//                {
//                    textFieldValue_char[3] = '\0';
//                    textFieldValue_char[2] = '\0';
//                }
//                else if(k == 8)
//                {
//                    textFieldValue_char[8] = '\0';
//                    textFieldValue_char[7] = '\0';
//                }
//                //删除对应的字符，并生成新的非格式化的字符串
//                for(i = 0; i < len; i++)
//                {
//                    if((i != k) && (textFieldValue_char[i] != '\0'))
//                    {
//                        tel_char[j++] = textFieldValue_char[i];
//                    }
//                }
//
//                newStr = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%s", tel_char]];
//            }
//
//            //字符串格式化
//            string = [self getTextFieldStr : newStr : _telText.text];
//            textField.text = string;
////            FLDDLogDebug("text value string: %@", string);
//            return NO;
//        }
//    }
//    return YES;
//}


/*****************************************************************************
 函数:   (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
 描述:   弹出模态对框话事件，请求服务发送请求效验码
 调用:
 被调用:
 返回值:
 其它:
 ******************************************************************************/
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//
//    switch (buttonIndex) {
//        case 0: //YES应该做的事
//            break;
//        case 1://NO应该做的事
//        {
////            [SVProgressHUD showWithStatus:(NSString *)g_hudStatus];
//                [SelfUser hudShowWithViewcontroller:self];
//            FLDDLogDebug(@"%@",_paramsList);
//            [User autoCodeWithParams:_paramsList block:^(NSError *error) {
//                [SelfUser hudHideWithViewcontroller:self];
//
//                if (!error) {
//                    [SVProgressHUD dismiss];
//                    [SelfUser hudHideWithViewcontroller:self];
//  [AppManager setUserDefaultsValue:@"2" key:@"isFirst"];
//                    AuthCodeViewController *authCodeViewController = [[AuthCodeViewController alloc] initWithNibName:@"AuthCodeViewController" bundle:nil];
//
////                    authCodeViewController.telephoneStr = _telText.text;
////                    g_telephone = _telText.text;
////                    [AppManager setUserDefaultsValue:_telText.text key:@"blankPhone"];
////                    g_timeCount = 59;
//////                    authCodeViewController.checkCodeTimeLabel.text = @"重新获取校验码大约需要59秒";
//                     authCodeViewController.type = AuthCodeTypeResetPassword;
//                    [self.navigationController pushViewController:authCodeViewController animated:YES];
//                }
//                else {
//                    FLDDLogDebug(@"error = %@, error.userInfo = %@", error, error.userInfo);
////                    AuthCodeViewController *authCodeViewController = [[AuthCodeViewController alloc] initWithNibName:@"AuthCodeViewController" bundle:nil];
////                    authCodeViewController.telephoneStr = _telT3ext.text;
////                    g_telephone = _telText.text;
////                    [AppManager setUserDefaultsValue:_telText.text key:@"blankPhone"];
////                    g_timeCount = 59;
////
////                    [self.navigationController pushViewController:authCodeViewController animated:YES];
//                    //[SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
////                    @try {
////                        if(error != nil && error.userInfo != nil && error.userInfo.count >= 6)
////                        {
////                            NSString *failStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
////                            FLDDLogDebug(@"fail:%@", failStr);
////                            if(([g_connectServerOffine isEqualToString: failStr]) || ([g_connectServerFail isEqualToString: failStr]))
////                            {
////                                [SVProgressHUD showErrorWithStatus:@"当前网络不可用，请检查您的网络设置"];
////                            }
////                            else
////                            {
////                                [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
////                            }
////                        }
////                        else
////                        {
////                            [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
////                        }
////
////                    }
////                    @catch (NSException *exception) {
////                        [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
////                    }
//                    [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
//                }
//            }];
//        }
//            break;
//
//            default:
//            break;
//        }
//}

/*****************************************************************************
 函数:   (IBAction)nextButtonPressed:(id)sender
 描述:   键盘响应事件，请求服务发送请求效验码
 调用:
 被调用:
 返回值:
 其它:
 ******************************************************************************/



/*****************************************************************************
 函数:   (Boolean)analyzeMessage:(id) responseObject
 描述:   解析服务器响应消息
 调用:
 被调用:
 返回值:
 其它:
 ******************************************************************************/
//- (BOOL)analyzeMessage:(id) responseObject
//{
//    if(responseObject == nil)
//    {
//        [SVProgressHUD showErrorWithStatus:(NSString *)g_loginNetError];
//        return NO;
//    }
//    @try
//    {
//        NSDictionary *head = [responseObject objectForKey:@"head"];
//        if(head == nil)
//        {
//            [SVProgressHUD showErrorWithStatus:(NSString *)g_loginNetError];
//            return NO;
//        }
//        FLDDLogDebug(@"head = %@", head);
//        
////        CAnalyzeResult *analyzeHead =[[CGeneralFunction shareFun]analyzeHead : head];
//        CAnalyzeResult *analyzeHead =[CGeneralFunction  analyzeHead : head];
//
//        
//        if((analyzeHead == nil) || (!(analyzeHead.result)) || (analyzeHead.cmdCode == nil))
//        {
//            [SVProgressHUD showErrorWithStatus:(NSString *)g_loginNetError];
//            return NO;
//        }
//        
//        if([analyzeHead.cmdCode isEqualToString:(NSString *)g_loginCmd])
//        {
//            [SVProgressHUD showErrorWithStatus:(NSString *)g_loginNetError];
//            return NO;
//        }
//        FLDDLogDebug(@"send check code sucess!");
//        return YES;
//        
//    }
//    @catch (NSException *exception) {
//        FLDDLogError("exception:%@", exception);
//        [SVProgressHUD showErrorWithStatus:(NSString *)g_loginNetError];
//        return NO;
//    }
//
//}





@end
