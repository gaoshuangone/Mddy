//
//  Resetpassword.m
//  merchant
//
//  Created by gs on 15/1/28.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "Resetpassword.h"
#import "LoginViewController.h"
@interface Resetpassword ()

@end

@implementation Resetpassword

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置密码";
    self.navigationItem.hidesBackButton = YES;
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"backWithTitle.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 53, 19);
    UIBarButtonItem* rithtBarItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = rithtBarItem ;
    
    self.textField1.delegate = self;
    self.textField2.delegate =self;
     self.textField1.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.textField2.clearButtonMode=UITextFieldViewModeWhileEditing;
     [self.textField1 setBorderStyle:UITextBorderStyleNone];
    [self.textField1 setSecureTextEntry:YES];
    self.textField2.secureTextEntry = YES;
    self.textField1.tintColor = [UIColor orangeColor];
    self.textField2.tintColor = [UIColor orangeColor];
    
    UIImage *image = [UIImage imageNamed:@"buttonnormal_n"];
    //UIEdgeInsets insets = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
    NSInteger leftCapWidth = image.size.width * 0.5f;
    // 顶端盖高度
    NSInteger topCapHeight = image.size.height * 0.5f;
    // 重新赋值
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    //[image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    [self.button setBackgroundImage:image forState:UIControlStateNormal];
    
    
    image = [UIImage imageNamed:@"buttonnormal_p"];
    leftCapWidth = image.size.width * 0.5f;
    // 顶端盖高度
    topCapHeight = image.size.height * 0.5f;
    // 重新赋值
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    [self.button setBackgroundImage:image forState:UIControlStateHighlighted];
    
    image = [UIImage imageNamed:@"buttonnormal_d"];
    leftCapWidth = image.size.width * 0.5f;
    // 顶端盖高度
    topCapHeight = image.size.height * 0.5f;
    // 重新赋值
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    [self.button setBackgroundImage:image forState:UIControlStateDisabled];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(noti) name:UITextFieldTextDidChangeNotification object:nil];
     [self.view addGestureRecognizer:self.swip];
    // Do any additional setup after loading the view from its nib.
}
-(void)noti{
    if (self.textField1.text.length==0 || self.textField2.text.length==0) {
            self.button.enabled =NO;
    }
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    self.button.enabled =NO;
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    FLDDLogDebug(@"qqqqqq%@",string);
    if ([string isEqualToString:@" "]) {
//        [SVProgressHUD showErrorWithStatus:@"密码只限数字和英文"];
        [MBProgressHUD hudShowWithStatus:self :@"密码只限数字和英文"];
        return NO;
    }
    if ([self.textField1 isFirstResponder]) {
//        if (self.textField1.text.length==1) {
//            
//            if ([string isEqualToString:@""]) {
//                self.button.enabled =NO;
//            }else{
//                     if (self.textField2.text.length!=0) {
//                self.button.enabled =YES;
//                     }
//            }
//
//        }else{
//            if (self.textField2.text.length!=0) {
//                self.button.enabled =YES;
//            }
//          
//        }
        if (self.textField2.text.length !=0 && ![string isEqualToString:@""]) {
            self.button.enabled =YES;
        }else{
            if (self.textField1.text.length==1 && [string isEqualToString:@""]) {
                self.button.enabled =NO;
            }
            
        }
        if ([string isEqualToString:@""]) {
            return YES;
        }
        
    }
    if ([self.textField2 isFirstResponder]) {
        if (self.textField1.text.length !=0 && ![string isEqualToString:@""]) {
            self.button.enabled =YES;
        }else{
            if (self.textField2.text.length==1 && [string isEqualToString:@""]) {
                self.button.enabled =NO;
            }
       
        }
        if ([string isEqualToString:@""]) {
            
            return YES;
        }
//        if (self.textField2.text.length==1) {
//            
//            if ([string isEqualToString:@""]) {
//                self.button.enabled =NO;
//            }else{
//                if (self.textField1.text.length!=0) {
//                     self.button.enabled =YES;
//                }
//               
//            }
//            
//        }else{
//                 if (self.textField1.text.length!=0) {
//            self.button.enabled =YES;
//                 }
//            
//        }
    }
    
    if (![CommonUtils checkStringNumbersWithlettersWithString:string] || [string isEqualToString:@""]) {
        
        if (textField.text.length>19) {
            return NO;
        }
        return YES;
    }else{
//        [SVProgressHUD showErrorWithStatus:@"密码只限数字和英文"];
        [MBProgressHUD hudShowWithStatus:self :@"密码只限数字和英文"];
    }

    return YES;
}

-(void)back{
    
    if (self.textField1.text.length>0||self.textField2.text.length>0) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:nil message:@"是否确认返回" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];
    }else{
        for (UIViewController* viewController in self.navigationController.viewControllers) {
            if ([viewController isKindOfClass:[LoginViewController class]]) {
                [self.navigationController popToViewController:viewController animated:YES];
            }
        }
 
    }



}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        for (UIViewController* viewController in self.navigationController.viewControllers) {
            if ([viewController isKindOfClass:[LoginViewController class]]) {
                [self.navigationController popToViewController:viewController animated:YES];
            }
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)queRenButtonPressed:(id)sender {
    if (self.textField1.text.length<6 || self.textField2.text.length<6 ) {
        
//        [SVProgressHUD showErrorWithStatus:@"密码至少为6位"];
        [MBProgressHUD hudShowWithStatus:self :@"密码至少为6位"];
        return;
    }
    if(![self.textField1.text isEqualToString:self.textField2.text]){
//        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一致"];
        [MBProgressHUD hudShowWithStatus:self :@"两次输入的密码不一致"];
        return;
    }
//    [AppManager setUserDefaultsValue:[CGeneralFunction passwordGetDecodeConfusionKey:MD5(self.textField2.text)] key:@"password"];
    NSString * str =[CGeneralFunction passwordGetDecodeConfusionKey:MD5(self.textField2.text)];
    [SelfUser mddyRequestWithMethodName:@"setPasswordWithOutOldJsonPhone.htm" withParams:@{@"newPassword":str} withBlock:^(id responseObject, NSError *error) {
        
     
        if (!error) {
            @try {
//                FLDDLogDebug(@"%@",responseObject);
//                   [SVProgressHUD showErrorWithStatus:@"重置成功，请重新登录"];
//                [MBProgressHUD hudShowWithStatus:self :@"您还没有登录，请先登录"];
                [MBProgressHUD hudShowWithStatus:self :@"重置成功，请重新登录"];
                [self performSelector:@selector(success) withObject:self afterDelay:0.8];
                

                
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            
            
        }else{
            
  [ MBProgressHUD hudShowWithStatus:self : [SelfUser currentSelfUser].ErrorMessage];
        }
        
        
    }];
    


}
-(void)success{
    
    
        for (UIViewController* viewController in self.navigationController.viewControllers) {
            if ([viewController isKindOfClass:[LoginViewController class]]) {
                [self.navigationController popToViewController:viewController animated:YES];
            }
        }
 

}
@end
