//
//  DeleteWorderViewController.m
//  merchant
//
//  Created by gs on 14/11/3.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "DeleteWorderViewController.h"

@interface DeleteWorderViewController ()

@end

@implementation DeleteWorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self addTableViewWithStyle:UITableViewStylePlain];
    self.navigationItem.hidesBackButton = YES;
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"backWithTitle.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 53, 19);
    
    UIBarButtonItem* rithtBarItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = rithtBarItem ;
    self.tableView.frame = CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT - 64) ;
 [self.view addGestureRecognizer:self.swip];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    if ([[[self.dictData valueForKey:@"clerkType"] toString] isEqualToString:@"1"]) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* strINTI = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:strINTI];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strINTI];
    }
    UILabel* labelName = [[UILabel alloc]initWithFrame:CGRectMake((iPhone6Plus?+5:0)+15, 0, 60, 44)];
    labelName.font = [UIFont systemFontOfSize:15];
    [cell addSubview:labelName];
    
    UILabel* labeNameValue = [[UILabel alloc]initWithFrame:CGRectMake((iPhone6Plus?+5:0)+WINDOW_WIDTH-200, 0, 185, 44)];
    labeNameValue.textAlignment = NSTextAlignmentRight;
    labeNameValue.font = [UIFont systemFontOfSize:15];
    labeNameValue.textColor = [UIColor darkGrayColor];
    [cell addSubview:labeNameValue];
    
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            labelName.text = @"姓名";
              labeNameValue.text = self.title;
            
        }else{
            labelName.text = @"手机号码";
          
            NSString* str = [CommonUtils changePhoneNumberWithNumber:[self.dictData valueForKey:@"clerkTel"] withType:@" "];
           
            NSString* str1 =[str substringToIndex:2];
            NSString* str2 =[[str substringFromIndex:3] substringToIndex:4];
            NSString* str3 =[str substringFromIndex:7] ;
            if ( [self checkMobile:str]) {
         
                str =[NSString stringWithFormat:@"%@ %@ %@",str1,str2,str3];
            }
            labeNameValue.text = str;
            
        }
    }
    else{
        labelName.text = @"删除";
        labelName.textColor = [UIColor redColor];
        
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
    NSString *Regex = @"^\\w{2,16}{1}quot;";
    NSPredicate *Test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [Test evaluateWithObject:_text];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 16;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     return [[UIView alloc] init];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1)
    {
    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil];
    [actionSheet showInView:self.view];
    }
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        FLDDLogDebug(@"删除");
        
        if ([[[self.dictData valueForKey:@"clerkType"] toString] isEqualToString:@"1"]) {
//            [SVProgressHUD showErrorWithStatus:@"店长不可删除"];
            [MBProgressHUD hudShowWithStatus:self :@"店长不可删除"];

        }else{
        
//        [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeBlack];
                  [SelfUser hudShowWithViewcontroller:self];
        FLDDLogDebug(@"%@",[self.dictData valueForKey:@"clerkId"]);
        [SelfUser mddyRequestWithMethodName:@"clerkDelJsonPhone.htm" withParams:@{@"cmdCode" : g_clerkDelCmd, @"clerkId":[self.dictData valueForKey:@"clerkId"]} withBlock:^(id responseObject, NSError *error) {
//            [SVProgressHUD dismiss ];
//            [SelfUser hudHideWithViewcontroller:self];
            
            [MBProgressHUD hudHideWithViewcontroller:self];
            
            if (!error) {
                @try {
                    FLDDLogDebug(@"%@",responseObject);
                    
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
               [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SelfUser hudHideWithViewcontroller:self];

//                [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
                [MBProgressHUD hudShowWithStatus:self :[SelfUser currentSelfUser].ErrorMessage];
            }
            
        }];

        
       
    }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back{
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
