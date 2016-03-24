//
//  ChangePwd.m
//  merchant
//
//  Created by gs on 15/1/28.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "ChangePwd.h"

@interface ChangePwd ()
@property (assign, nonatomic)BOOL isNoLianXiang;
@end

@implementation ChangePwd

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem* rithtBarItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = rithtBarItem ;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(addBarButtonPressed)];
    self.tableView.frame = CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT  - 64) ;


 [self.view addGestureRecognizer:self.swip];
    // Do any additional setup after loading the view from its nib.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* strINTI = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:strINTI];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strINTI];
        UILabel* label =[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 44)];
        label.tag = 101;
           [cell addSubview:label];
        
        UITextField* textField =[[UITextField alloc]initWithFrame:CGRectMake(100, 0, WINDOW_WIDTH-100-20, 44)];
        textField.tag = 102;
        [textField  setSecureTextEntry:YES];
//        textField.backgroundColor = [UIColor redColor];
//        textField.font = [UIFont systemFontOfSize:15];
        textField.clearButtonMode=UITextFieldViewModeWhileEditing;
        [cell addSubview:textField];
      
    }
    if (indexPath.row == 0) {
        UILabel* label =(UILabel*)[cell viewWithTag:101];
        label.text  =@"原密码";
       
        UITextField* textField =(UITextField*)[cell viewWithTag:102];
        textField.placeholder =@"输入原有密码";
//        textField.clearsOnBeginEditing = YES;
        self.textField1 = textField;
        self.textField1.delegate= self;
      

   
    }else if (indexPath.row == 1){
        UILabel* label =(UILabel*)[cell viewWithTag:101];
        label.text  =@"新密码";

        UITextField* textField =(UITextField*)[cell viewWithTag:102];
        textField.placeholder =@"输入新密码";
        self.textField2 = textField;
         self.textField2.delegate= self;
        
    }else if (indexPath.row == 2){
        UILabel* label =(UILabel*)[cell viewWithTag:101];
        label.text  =@"确认密码";
        
        UITextField* textField =(UITextField*)[cell viewWithTag:102];
        textField.placeholder =@"确认新密码";
        self.textField3 = textField;
         self.textField3.delegate= self;
//        self.textField1.text = @"234567";
//        self.textField2.text =@"345678";
//        self.textField3.text =@"345678";
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
//    UIView* view =[[UIView alloc]initWithFrame:CGRectMake(15, 0, WINDOW_WIDTH-30, 44)];
//    view.backgroundColor = [UIColor clearColor];
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(30, 0, WINDOW_WIDTH-30, 44)];
    label.text = @"    密码只限数字和英文，长度为6至20位";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:13];
    return label;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

//    self.isNoLianXiang = YES;
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([string isEqualToString:@" "]) {
//            [SVProgressHUD showErrorWithStatus:@"密码只限数字和英文"];
        [MBProgressHUD hudShowWithStatus:self :@"密码只限数字和英文"];
        return NO;
    }
    if (![CommonUtils checkStringNumbersWithlettersWithString:string] || [string isEqualToString:@""]) {
        
        if (textField.text.length>19) {
            return NO;
        }
        return YES;
    }else{
//    [SVProgressHUD showErrorWithStatus:@"密码只限数字和英文"];
        [MBProgressHUD hudShowWithStatus:self :@"密码只限数字和英文"];
    }
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back{
    
    if (self.textField1.text.length>0||self.textField2.text.length>0||self.textField3.text.length>0) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:nil message:@"是否确认返回" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alert show];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
   
   
          [self.navigationController popViewControllerAnimated:YES];
        
        
    }
}
-(void)addBarButtonPressed{
    
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
    [self.textField3 resignFirstResponder];
    if ([CommonUtils checkStringNumbersWithlettersWithString:self.textField2.text]) {
//        [SVProgressHUD dismiss];
//        [SVProgressHUD showErrorWithStatus:@"密码只限数字和英文"];
        [MBProgressHUD hudShowWithStatus:self :@"密码只限数字和英文"];
        return;
 
    }
    if (self.textField1.text.length<6 || self.textField2.text.length<6 || self.textField3.text.length <6) {
//       [SVProgressHUD dismiss];
//        [SVProgressHUD showErrorWithStatus:@"密码至少为6位"];
        [MBProgressHUD hudShowWithStatus:self :@"密码至少为6位"];
     return;
    }
    if(![self.textField2.text isEqualToString:self.textField3.text]){
//         [SVProgressHUD dismiss];
//        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一致"];
        [MBProgressHUD hudShowWithStatus:self :@"两次输入的密码不一致"];
        return;
    }
    
    [SelfUser mddyRequestWithMethodName:@"resetPasswordJsonPhone.htm" withParams:@{@"oldPassword":[CGeneralFunction passwordGetDecodeConfusionKey:MD5(self.textField1.text)],@"newPassword":[CGeneralFunction passwordGetDecodeConfusionKey:MD5(self.textField3.text)]} withBlock:^(id responseObject, NSError *error) {
        
        
        if (!error) {
            @try {
                 [AppManager setUserDefaultsValue:[CGeneralFunction passwordGetDecodeConfusionKey:MD5(self.textField3.text)] key:@"password"];
                [MBProgressHUD hudShowWithStatus:self :@"修改成功！"];
               
          

                [self performSelector:@selector(backkk) withObject:self afterDelay:1.2];
                
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            
            
        }else{
             [ MBProgressHUD hudShowWithStatus:self : [SelfUser currentSelfUser].ErrorMessage];
//            [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
        }
        
        
    }];

    
}
-(void)backkk{
    
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
