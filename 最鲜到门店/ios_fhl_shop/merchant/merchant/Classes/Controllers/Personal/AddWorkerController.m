//
//  AddWorkerController.m
//  merchant
//
//  Created by gs on 14/11/3.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "AddWorkerController.h"

@interface AddWorkerController ()

@end

@implementation AddWorkerController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self addTableViewWithStyle:UITableViewStylePlain];
    self.title = @"新增店员";
    self.navigationItem.hidesBackButton = YES;
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"backWithTitle.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 53, 19);
    
    UIBarButtonItem* rithtBarItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    self.navigationItem.leftBarButtonItem = rithtBarItem ;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(addBarButtonPressed)];
     [self.view addGestureRecognizer:self.swip];
    // Do any additional setup aftebr loading the view from its nib.
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* strINTI = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:strINTI];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strINTI];
        UILabel* labelName = [[UILabel alloc]initWithFrame:CGRectMake((iPhone6Plus?+5:0)+15, 0, 100, 44)];
        labelName.font = [UIFont systemFontOfSize:16];
        labelName.tag = 101;
        [cell addSubview:labelName];
    }
 
    if (indexPath.row == 0) {
        
        UILabel* labelName=(UILabel*)[cell viewWithTag:101];
        labelName.text = @"姓       名";
        if (self.textFieldName== nil) {
            
    
    
        self.textFieldName = [[UITextField alloc]initWithFrame:CGRectMake((iPhone6Plus?+5:0)+90, 0, 250, 44)];
        self.textFieldName.placeholder = @"请输入真实姓名";
            self.textFieldName.font =[UIFont systemFontOfSize:16];
        self.textFieldName.delegate = self;
        [cell addSubview:self.textFieldName];
        }
    }else{
          UILabel* labelName=(UILabel*)[cell viewWithTag:101];
        labelName.text = @"手机号码";
        if (self.textFiledPhoneNumber==nil) {
      
        self.textFiledPhoneNumber = [[UITextField alloc]initWithFrame:CGRectMake((iPhone6Plus?+5:0)+90, 0, 200, 44)];
        self.textFiledPhoneNumber.placeholder = @"请输入手机号码";
            self.textFiledPhoneNumber.font = [UIFont systemFontOfSize:16];
        self.textFiledPhoneNumber.delegate = self;
        self.textFiledPhoneNumber.keyboardType = UIKeyboardTypeNumberPad;
        [cell addSubview:self.textFiledPhoneNumber];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(BOOL)checkMobile:(NSString *)_text
{
    NSString *Regex = @"1\\d{10}";
    NSPredicate *Test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [Test evaluateWithObject:_text];
}


-(BOOL)checkName:(NSString *)_text
{
    NSString *Regex = @"^[A-Za-z\u4e00-\u9fa5]*$";
    NSPredicate *Test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [Test evaluateWithObject:_text];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 16;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
//    if (([textField.text length] <= 1) && [string isEqualToString:@""])
//    {
//        _nextBtn.enabled = NO;
//    }
//    else
//    {
//        if (textField == self.phoneTextField) {
//            if (self.checkCodeText.text.length > 0) {
//                _nextBtn.enabled = YES;
//                
//            }
//        }
//        else if (textField == self.checkCodeText) {
//            if (self.textFiledPhoneNumber.text.length > 0) {
//                
//                if ([AppManager isPasswordValid:string]) {
//                    _nextBtn.enabled = YES;
//                }
//            }
//        }
//    }
    
    if(textField == self.textFiledPhoneNumber)
    {
        return [CGeneralFunction inputTelephone: textField : range : string];
    }
    else if (textField == self.textFieldName) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
     
        
        //        NSString *regex=@"^[A-Za-z /\u4e00-\u9fa5]+$";
        //        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        //        if (![predicate evaluateWithObject:string]) {
        //            [SVProgressHUD showErrorWithStatus:@"姓名不能含有数字或标点"];
        //            return  NO;
        //        }
        if (textField.text.length + string.length <=10) {
            if ([string isEqualToString:@"➋"]||[string isEqualToString:@"➌"]||[string isEqualToString:@"➍"]||[string isEqualToString:@"➎"]||[string isEqualToString:@"➏"]||[string isEqualToString:@"➐"]||[string isEqualToString:@"➑"]||[string isEqualToString:@"➒"]) {
                return YES;
                
            }
            if ([self checkName:string]) {
                return YES;
            }else{
                return NO;
            }
        }else{
//            [SVProgressHUD showErrorWithStatus:@"姓名长度2-10位"];
            [MBProgressHUD hudShowWithStatus:self :@"姓名长度2-10位"];
            return NO;
        }
    }
    return YES;
}
//{
//    
// 
//    
//    if (textField == self.textFiledPhoneNumber) {
//        if ((textField.text.length==3&&range.length != 1)  ||(textField.text.length==8 &&range.length != 1)) {
//            textField.text =[textField.text stringByAppendingFormat:@" "];
//        }
//        if (textField.text.length<=13) {
//            
//            if (textField.text.length == 13) {
//                if ([string isEqualToString:@""]) {
//                    return YES;
//                }else{
//                    [SVProgressHUD showErrorWithStatus:@"手机号位数超过限制"];
//                    return NO;
//                }
//            }
//            
//            return YES;
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"手机号位数超过限制"];
//            return NO;
//        }
//    }
//    
//    if (textField == self.textFieldName) {
//        if ([string isEqualToString:@""]) {
//            return YES;
//        }
//        
//        
////        NSString *regex=@"^[A-Za-z /\u4e00-\u9fa5]+$";
////        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
////        if (![predicate evaluateWithObject:string]) {
////            [SVProgressHUD showErrorWithStatus:@"姓名不能含有数字或标点"];
////            return  NO;
////        }
//        if (textField.text.length + string.length <=10) {
//            return YES;
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"姓名长度2-10位"];
//            return NO;
//        }
//    }
//
//    return YES;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addBarButtonPressed
{
   
    NSString* strPhone = [self.textFiledPhoneNumber.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([self checkName:self.textFieldName.text]) {
        
    }
    
    if ( [CommonUtils checkMobile:strPhone]) {
            if (self.textFieldName.text.length >=2&&self.textFieldName.text.length <=10) {
//                [SVProgressHUD showWithStatus:@"请稍候..."];
//                [MBProgressHUD hudShowWithViewcontroller:self.view];
                NSDictionary *params = @{@"clerkName":self.textFieldName.text,@"clerkTel":strPhone,@"cmdCode":g_clerkAddCmd};
                
                [[API shareAPI]POST:@"clerkAddJsonPhone.htm" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                    
                } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    FLDDLogDebug(@"success");
//                    [SVProgressHUD dismiss ];
//                    [SelfUser hudHideWithViewcontroller:self];
//                      [MBProgressHUD hudHideWithViewcontroller:self.view];
//                    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:nil message:@"新增店员成功，登陆密码已发送到店员手机中，请注意查收" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                  
//                    [alert show];
//                    [MBProgressHUD hudShowWithStatus:self :@"新增店员成功！"];
//                      [self.navigationController popViewControllerAnimated:YES];
//                      [ MBProgressHUD hudShowWithStatus:self : [SelfUser currentSelfUser].ErrorMessage];
                    
//
                 
//                     [SVProgressHUD showSuccessWithStatus:[SelfUser currentSelfUser].ErrorMessage];
                    [MBProgressHUD hudShowWithStatus:self :[SelfUser currentSelfUser].ErrorMessage];
                    
                    [self performSelector:@selector(backTouch) withObject:self afterDelay:1.2];
              
                 
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    FLDDLogInfo(@"failure");
//                    [MBProgressHUD hudShowWithViewcontroller:self];
//                       [SelfUser hudHideWithViewcontroller:self];
//                       [SVProgressHUD dismiss ];
//                         [SVProgressHUD showSuccessWithStatus:[SelfUser currentSelfUser].ErrorMessage];
                    [MBProgressHUD hudShowWithStatus:self :[SelfUser currentSelfUser].ErrorMessage];
                }];

            }else{
//                [SVProgressHUD showErrorWithStatus:@"姓名长度2-10位"];
                [MBProgressHUD hudShowWithStatus:self :@"姓名长度2-10位"];
            }
      

           }else{
//        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
               [MBProgressHUD hudShowWithStatus:self :@"请输入正确手机号"];
        
    }
}
-(void)backTouch{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   [self.navigationController popViewControllerAnimated:YES];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
