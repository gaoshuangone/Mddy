 //
//  AuthCodeViewController.m
//  FHL
//
//  Created by panume on 14-9-22.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "AuthCodeViewController.h"
#import "RegisterViewController.h"
#import "User.h"
#import "WebViewController.h"
//#import "SecondWebViewController.h"
#import "HomeViewController.h"
//#import "GlobalVariable.h"
#import "Resetpassword.h"
//#import "ResetPwdViewController.h"

@interface AuthCodeViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, strong) NSString *authCode;

@end

@implementation AuthCodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
        self.title = @"重置密码";
    
    
    [AppManager setUserBoolValue:YES key:@"refreshCode"];
    self.navigationItem.hidesBackButton = YES;
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"backWithTitle.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 53, 19);
    UIBarButtonItem* rithtBarItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = rithtBarItem ;
//    self.navigationItem.leftBarButtonItem = [UIManager barButtonWithTarget:self action:@selector(backBarButtonPressed:) title:@"取消"];

    _phoneTextField.delegate = self;
    _checkCodeText.delegate = self;
    if (iphone6_6P_isYES) {
        
        
    _checkCodeText.frame = CGRectMake(_checkCodeText.frame.origin.x, _checkCodeText.frame.origin.y, _checkCodeText.frame.size.width+15, _checkCodeText.frame.size.height);
    }
    
    self.getCheckCodeBtn.layer.cornerRadius = 10;
    self.getCheckCodeBtn.layer.masksToBounds = YES;
    self.getCheckCodeBtn.layer.borderColor = [UIColor colorWithHex:0x7f8c99].CGColor;
    self.getCheckCodeBtn.layer.borderWidth = 1;
 
    
    UIImage *image = [UIImage imageNamed:@"buttonnormal_n"];
    //UIEdgeInsets insets = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
    NSInteger leftCapWidth = image.size.width * 0.5f;
    // 顶端盖高度
    NSInteger topCapHeight = image.size.height * 0.5f;
    // 重新赋值
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    //[image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    [self.nextBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    
    image = [UIImage imageNamed:@"buttonnormal_p"];
    leftCapWidth = image.size.width * 0.5f;
    // 顶端盖高度
    topCapHeight = image.size.height * 0.5f;
    // 重新赋值
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    [self.nextBtn setBackgroundImage:image forState:UIControlStateHighlighted];
    
    image = [UIImage imageNamed:@"buttonnormal_d"];
    leftCapWidth = image.size.width * 0.5f;
    // 顶端盖高度
    topCapHeight = image.size.height * 0.5f;
    // 重新赋值
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    [self.nextBtn setBackgroundImage:image forState:UIControlStateDisabled];
    [self.nextBtn addTarget:self action:@selector(nextButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.getCheckCodeBtn addTarget:self action:@selector(freshCheckCodeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    FLDDLogDebug(@"g_timeCount : %lu", (unsigned long)g_timeCount);
    
    if(g_timeCount == 0)
    {
        _getCheckCodeBtn.hidden = NO;
    }
    else
    {
        _getCheckCodeBtn.hidden = YES;
    }
 self.phoneTextField.tintColor =[UIColor orangeColor];
   self.phoneTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
   self.checkCodeText.clearButtonMode=UITextFieldViewModeWhileEditing;
     self.checkCodeText.tintColor =[UIColor orangeColor];
    self.label.frame = self.getCheckCodeBtn.frame;
//    self.label.hidden = YES;
     _getCheckCodeBtn.hidden = NO;
    self.label.textColor = [UIColor colorWithHex:0x7f8c99];
    if (self.strPhone.length == 13) {
        
    self.phoneTextField.text = [CommonUtils changePhoneNumberWithNumber:self.strPhone withType:@""];
    }
    [self.view addGestureRecognizer:self.swip]; 
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

   
 
    self.view.frame = CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT);
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = YES;
    if(g_getCheckCodeTimer != nil)
    {
        [g_getCheckCodeTimer setFireDate:[NSDate distantFuture]];
    }
    FLDDLogDebug(@"g_timeCount : %lu", (unsigned long)g_timeCount);

//    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(progressTimerChange) userInfo:nil repeats:YES];
//
//    [_timer setFireDate:[NSDate distantFuture]];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString *status = [User currentUser].state;
    
    if ([status isEqualToString:@"1"]) {
//        SecondWebViewController *webViewController = [[SecondWebViewController alloc] init];
//        webViewController.type = WebViewTypeLearn;
//        webViewController.title = @"在线学习";
//        [self.navigationController pushViewController:webViewController animated:YES];
    }
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;

    if(_timer != nil)
    {
        [_timer invalidate];
        _timer = nil;
    }
    
    if(g_getCheckCodeTimer != nil)
    {
        [g_getCheckCodeTimer setFireDate:[NSDate date]];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
   
}

#pragma mark - Private

- (IBAction)backBarButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (IBAction)backBarButtonPressed:(id)sender
//{
//    if(_bTimeEffect)
//    {
////        g_freshCheckCodePage = YES;
////        g_telephone = _telephoneStr;
//        //g_checkCode = _checkCodeText.text;
//        //g_timecount = _timeCount;
//    }
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    //返回一个BOOL值指明是否允许根据用户请求清除内容
    //可以设置在特定条件下才允许清除内容
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (([textField.text length] <= 1) && [string isEqualToString:@""])
    {
        _nextBtn.enabled = NO;
    }
    else
    {
        if (textField == self.phoneTextField) {
            if (self.checkCodeText.text.length > 0) {
                _nextBtn.enabled = YES;
                
            }
        }
        else if (textField == self.checkCodeText) {
            if (self.phoneTextField.text.length > 0) {
                
                if ([AppManager isPasswordValid:string]) {
                    _nextBtn.enabled = YES;
                }
            }
        }
    }
    
    if(textField == _phoneTextField)
    {
        return [CGeneralFunction inputTelephone: textField : range : string];
    }
    else {
        if (string.length > 0) {
            if (![AppManager isPasswordValid:string]) {
                return NO;
            }
            
            if (textField.text.length  + string.length > 6)
            {
                return NO;
            }
        }
    }
    return YES;
}
//{
//    
//    if (([textField.text length] <= 1) && [string isEqualToString:@""])
//    {
//        _nextBtn.enabled = NO;
//    }
//    else
//    {
//        
//        if (textField == self.phoneTextField) {
//            if (self.checkCodeText.text.length > 0) {
//                _nextBtn.enabled = YES;
//                
//            }
//        }
//        else if (textField == self.checkCodeText) {
//            if (self.phoneTextField.text.length > 0) {
//                _nextBtn.enabled = YES;
//            }
//        }
//    }
//    
//    
//    
//    if (self.phoneTextField == textField) {
//        NSString *phone = textField.text;
//        if (string.length > 0) {//input
//            if (phone.length >= 13) {
//                
//                return NO;
//            }
//            else {
//                if (phone.length == 2 || phone.length == 7 ) {
//                    
//                    NSString *addition = [NSString stringWithFormat:@"%@ ", string];
//                    textField.text = [phone stringByAppendingString:addition];
//                    return NO;
//                }
//            }
//            
//        }
//        else {//delete
//            
//            if (phone.length > 2) {
//                NSString *str = [phone substringWithRange:NSMakeRange(range.location, 1)];
//                if ([str isEqualToString:@" "]) {
//                    str = [phone substringWithRange:NSMakeRange(0, phone.length - 2)];
//                    textField.text = str;
//                    return NO;
//                    
//                }
//            }
//        }
//    }
//    else {
//        if ((string != nil) && ([_checkCodeText.text length] + [string length] > g_checkCodeLength))
//        {
//            return NO;
//        }
//    }
//    return YES;
//}

/*****************************************************************************
 函数:   (IBAction)nextButtonPressed:(id)sender
 描述:   键盘响应事件，请求服务发送请求效验码
 调用:
 被调用:
 返回值:
 其它:
 ******************************************************************************/
- (IBAction)nextButtonPressed:(id)sender
{
    [self.view endEditing:YES];
    self.authCode = self.checkCodeText.text;
    NSString *checkCodeStr  = _checkCodeText.text;
    if(checkCodeStr.length != 6)
    {
        [MBProgressHUD hudShowWithStatus:self : @"请输入六位数字验证码"];
        return;
    }
    NSMutableDictionary *paramsList = [NSMutableDictionary dictionary];
    NSString *telephone = [self.phoneTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];

    [paramsList setObject:telephone forKey:@"clerkTel"];
    [paramsList setObject:[CGeneralFunction passwordGetDecodeConfusionKey:MD5(checkCodeStr)] forKey:@"identifyingCode"];
    
    FLDDLogDebug(@"密码＝authcode:%@", checkCodeStr);
    FLDDLogDebug(@"MD加密后的密码＝authCode:%@", MD5(checkCodeStr));
    
    [AppManager setUserDefaultsValue:telephone key:@"telephone"];
//    [AppManager setUserDefaultsValue:[CGeneralFunction passwordGetDecodeConfusionKey:MD5(checkCodeStr)] key:@"password"];
//    FLDDLogDebug(@"储存md5过混淆后的密码key＝ password:%@", [AppManager valueForKey:@"identifyingCode"]);
    
    if(paramsList == nil)
    {
        return;
    }
    
 
    [SelfUser hudShowWithViewcontroller:self];
    [User validPasswordIdentifyingJsonPhone:paramsList block:^(NSError *error) {
        [SelfUser hudHideWithViewcontroller:self];
        
        
        if (!error) {
            self.getCheckCodeBtn.frame = CGRectMake(WINDOW_WIDTH - 16 - 90, self.getCheckCodeBtn.frame.origin.y, 90, self.getCheckCodeBtn.bounds.size.height);
            self.checkCodeText.frame=CGRectMake(self.checkCodeText.frame.origin.x, self.checkCodeText.frame.origin.y,WINDOW_WIDTH-16-90-42, self.checkCodeText.bounds.size.height);
            self.label.frame = self.getCheckCodeBtn.frame;
            
            [self.timer invalidate];
            self.checkCodeText.text = @"";
            self.label.text = @"重新发送";
            self.label.textColor = [UIColor colorWithHex:0x7f8c99];
            self.getCheckCodeBtn.layer.borderColor = [UIColor colorWithHex:0x7f8c99].CGColor;
         self.getCheckCodeBtn.userInteractionEnabled = YES;
            
            Resetpassword *resetPwdViewController = [[Resetpassword alloc] initWithNibName:@"Resetpassword" bundle:nil];
       
            [self.navigationController pushViewController:resetPwdViewController animated:YES];

        }
        else {
  [ MBProgressHUD hudShowWithStatus:self : [SelfUser currentSelfUser].ErrorMessage];
        }
    }];
 
    
    
    
    
}


//- (void)hudHide
//{
//    MBProgressHUD* hud =(MBProgressHUD*)[self.view viewWithTag:101];
//    
//    if(!hud)
//    {
//        return;
//        
//    }
//    [hud hide:YES];
//    [hud removeFromSuperview];
//    hud = nil;
//}
//
//#pragma mark 显示活动指示器
//- (void)hudShow :(NSString *)string
//{
//    MBProgressHUD* hud =(MBProgressHUD*)[self.view viewWithTag:101];
//    
//    if(hud)
//    {
//        [self hudHide];
//    }
//    
//    
//    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.labelText = string;
//    HUD.mode = MBProgressHUDModeText;
//    
//    
//    [HUD showAnimated:YES whileExecutingBlock:^{
//        sleep(2);
//    } completionBlock:^{
//        [HUD removeFromSuperview];
//        [self HUDDisappearedHandle];
//        //        HUD = nil;
//    }];
//    
//}
//
//
//
//- (void)HUDDisappearedHandle
//{
//    
//    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:SVProgressHUDDidAppearNotification object:nil];
//    
//    if ([[User currentUser].state isEqualToString:@"3"]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:WORK_STATUS_DID_CHANGE_NOTIFICATION object:nil];
//        
//    }
//    BOOL isPop = NO;
//    
//    for (UIViewController *viewController in self.navigationController.viewControllers) {
//        if ([viewController isKindOfClass:[UITabBarController class]]) {
//            isPop = YES;
//        }
//    }
//    
//    if (isPop) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
//    else {
//        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//        
//    }
//}

- (void)progressTimerChange
{
    FLDDLogDebug(@"!!!!!");
    if (g_timeCount == 60) {
        [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            self.getCheckCodeBtn.frame = CGRectMake(WINDOW_WIDTH - 16 - 45, self.getCheckCodeBtn.frame.origin.y, 45, self.getCheckCodeBtn.bounds.size.height);
            self.label.frame = self.getCheckCodeBtn.frame;;
            self.checkCodeText.frame=CGRectMake(self.checkCodeText.frame.origin.x, self.checkCodeText.frame.origin.y,WINDOW_WIDTH-16-45-43, self.checkCodeText.bounds.size.height);
//            self.label.textColor = [UIColor lightGrayColor];
//            self.getCheckCodeBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        } completion:^(BOOL finished) {
            self.getCheckCodeBtn.userInteractionEnabled = NO;
            
        }];
    }
    
    if(g_timeCount == 0)
    {
        if(_timer != nil)
        {
            [_timer setFireDate:[NSDate distantFuture]];
            self.timer=nil;
        }
        
        return;
    }
    else if(g_timeCount == 1)
    {
        g_timeCount--;
        
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
             self.getCheckCodeBtn.frame = CGRectMake(WINDOW_WIDTH - 16 - 90, self.getCheckCodeBtn.frame.origin.y, 90, self.getCheckCodeBtn.bounds.size.height);
                self.checkCodeText.frame=CGRectMake(self.checkCodeText.frame.origin.x, self.checkCodeText.frame.origin.y,WINDOW_WIDTH-16-90-42, self.checkCodeText.bounds.size.height);
               self.label.frame = self.getCheckCodeBtn.frame;
        } completion:^(BOOL finished) {
//            [self.getCheckCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
//
            self.label.text = @"重新发送";
            self.getCheckCodeBtn.userInteractionEnabled = YES;
//            self.label.textColor = [UIColor colorWithHex:0x7f8c99];
//            self.getCheckCodeBtn.layer.borderColor = [UIColor colorWithHex:0x7f8c99].CGColor;
        }];
        
        if(_timer != nil)
        {
            [_timer setFireDate:[NSDate distantFuture]];
        }
    }
    else
    {
        g_timeCount--;
        [self setTimerChanged];
    }
}


- (void)setTimerChanged
{
//    self.getCheckCodeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//    self.getCheckCodeBtn.titleLabel.text = [NSString stringWithFormat:@"%lds", (unsigned long)g_timeCount];
//    [self.getCheckCodeBtn setTitle:[NSString stringWithFormat:@"%lds", (unsigned long)g_timeCount] forState:UIControlStateNormal];
     self.label.text = [NSString stringWithFormat:@"%lds", (unsigned long)g_timeCount];

//    FLDDLogDebug(@"%@", self.label.text );
}

/*****************************************************************************
 函数:   (IBAction)freshCheckCodeButtonPressed:(id)sender
 描述:   键盘响应事件，重新请求服务发送请求效验码
 调用:
 被调用:
 返回值:
 其它:
 ******************************************************************************/
- (IBAction)freshCheckCodeButtonPressed:(id)sender
{
//    [self.view endEditing:YES];
    

//    NSMutableDictionary *paramsList = [NSMutableDictionary dictionary];
//    
    NSString *blankPhone = [self.phoneTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
//
    if (![AppManager isValidateMobile:blankPhone]) {
        
        [MBProgressHUD hudShowWithStatus:self : @"请输入正确的手机号码"];

        return;
    }
//
//    [paramsList setObject:blankPhone forKey:@"courierTel"];
//
//    
//    NSString *latitude =  [AppManager valueForKey:@"latitude"];
//    NSString *longitude = [AppManager valueForKey:@"longitude"];
//    
//    [paramsList setObject:latitude forKey:@"latitude"];
//    [paramsList setObject:longitude forKey:@"longitude"];
    
    [MBProgressHUD hudShowWithViewcontroller:self];
    
    [SelfUser mddyRequestWithMethodName:@"findPasswordIdentifyingJsonPhone.htm" withParams:@{@"clerkTel":blankPhone} withBlock:^(id responseObject, NSError *error) {
        
        [MBProgressHUD  hudHideWithViewcontroller:self];
        if (!error) {
            @try {
                
                g_timeCount = 60 ;
//                [self.timer fire];
                [MBProgressHUD hudShowWithStatus:self :@"验证码已发送，请注意查收"];
//                if (self.timer==nil) {
           self.timer =   [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(progressTimerChange) userInfo:nil repeats:YES];
//                }
                [self.timer fire];
                
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            
            
            
        }else{
            
            
            [MBProgressHUD hudShowWithStatus:self : [SelfUser currentSelfUser].ErrorMessage];

        }
        
        
    }];
    

}


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
////        [SVProgressHUD showErrorWithStatus:(NSString *)g_loginNetError];
//        [MBProgressHUD hudShowWithStatus:self : (NSString *)g_loginNetError];
//        return NO;
//    }
//    @try
//    {
//        NSDictionary *head = [responseObject objectForKey:@"head"];
//        if(head == nil)
//        {
////            [SVProgressHUD showErrorWithStatus:(NSString *)g_loginNetError];
//            [MBProgressHUD hudShowWithStatus:self : (NSString *)g_loginNetError];
//            return NO;
//        }
//        FLDDLogDebug(@"head = %@", head);
//        
//        //        CAnalyzeResult *analyzeHead =[[CGeneralFunction shareFun]analyzeHead : head];
//        CAnalyzeResult *analyzeHead =[CGeneralFunction analyzeHead : head];
//        
//        
//        if((analyzeHead == nil) || (!(analyzeHead.result)) || (analyzeHead.cmdCode == nil))
//        {
////            [SVProgressHUD showErrorWithStatus:(NSString *)g_loginNetError];
//            [MBProgressHUD hudShowWithStatus:self : (NSString *)g_loginNetError];
//            return NO;
//        }
//        
//        if([analyzeHead.cmdCode isEqualToString:(NSString *)g_loginCmd])
//        {
////            [SVProgressHUD showErrorWithStatus:(NSString *)g_loginNetError];
//            [MBProgressHUD hudShowWithStatus:self : (NSString *)g_loginNetError];
//            return NO;
//        }
//        FLDDLogDebug(@"send check code sucess!");
//        return YES;
//        
//    }
//    @catch (NSException *exception) {
//        FLDDLogError("exception:%@", exception);
////        [SVProgressHUD showErrorWithStatus:(NSString *)g_loginNetError];
//        [MBProgressHUD hudShowWithStatus:self : (NSString *)g_loginNetError];
//        return NO;
//    }
//    
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)HUDDisappeared:(NSNotification *)notification
//{
//    
////    [[NSNotificationCenter defaultCenter] removeObserver:self name:SVProgressHUDDidAppearNotification object:nil];
//    
//    if ([[User currentUser].state isEqualToString:@"3"]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:WORK_STATUS_DID_CHANGE_NOTIFICATION object:nil];
//        
//    }
//    BOOL isPop = NO;
//    
//    for (UIViewController *viewController in self.navigationController.viewControllers) {
//        if ([viewController isKindOfClass:[UITabBarController class]]) {
//            isPop = YES;
//        }
//    }
//    
//    if (isPop) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
//    else {
//        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//        
//    }
//}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
