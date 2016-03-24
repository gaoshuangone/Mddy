//
//  AccoutRechDoingViewController.m
//  merchant
//
//  Created by gs on 15/5/21.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "AccoutRechDoingViewController.h"
#import "AccountActivityViewCell.h"
#import "AccountActivityView.h"
#import "RechQueRenViewController.h"

#define ButtonWide WINDOW_WIDTH/4
@interface AccoutRechDoingViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (strong, nonatomic) UITextField* textField;
@property (strong, nonatomic) UIButton* button1;
@property (strong, nonatomic) UIButton* button2;
@property (strong, nonatomic) UIButton* button3;
@property (strong, nonatomic) UILabel* labelJinE;
@property (strong, nonatomic) UIButton* buttonChongZhi;
@property (strong, nonatomic) NSDictionary* dictData;
@property (strong, nonatomic) NSDictionary* dictNextData;
@property (assign, nonatomic) BOOL isCanChongZhi;

@property (assign, nonatomic) BOOL isHasReword;


@end

@implementation AccoutRechDoingViewController

- (void)viewDidLoad {
    

    
    [super viewDidLoad];
    self.title = @"账户充值";
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
//                                                         forBarMetrics:UIBarMetricsDefault];
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBackGround)];
    [self.view addGestureRecognizer:singleTap];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notiKeyHid) name:UIKeyboardWillHideNotification object:nil];
    
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(zhifuResulted) name:XIADanREZHiFU object:nil];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: YES];
    [self getData];
    
    UIView* viewButtom = [[UIView alloc]initWithFrame:CGRectMake(0, WINDOW_HEIGHT-72-64, WINDOW_WIDTH, 72)];
    viewButtom.backgroundColor = [UIColor whiteColor];
    self.labelJinE = [[UILabel alloc]init];
    self.labelJinE .text = @"到账金额：--元";
    self.labelJinE .font = [UIFont systemFontOfSize:16];
    [self.labelJinE  sizeToFit];
    self.labelJinE .center = CGPointMake((WINDOW_WIDTH-ButtonWide*3)/4*1+self.labelJinE .bounds.size.width/2, 72/2);
    [viewButtom addSubview:self.labelJinE ];
    
    self.buttonChongZhi = [UIButton buttonWithType:UIButtonTypeCustom];
    [ self.buttonChongZhi setTitle:@"充值" forState:UIControlStateNormal];
    self.buttonChongZhi.bounds = CGRectMake(0, 0, 96, 44);
    self.buttonChongZhi.backgroundColor = [UIColor redColor];
    self.buttonChongZhi.center = CGPointMake(WINDOW_WIDTH-(WINDOW_WIDTH-ButtonWide*3)/4*1- self.buttonChongZhi.bounds.size.width/2, CGRectGetMidY(self.labelJinE .frame));
    self.buttonChongZhi.backgroundColor = UICOLOR(189, 189, 189, 1);
    self.buttonChongZhi.layer.cornerRadius = 3;
    [self.buttonChongZhi addTarget:self action:@selector(chongzhi) forControlEvents:UIControlEventTouchUpInside];
    self.buttonChongZhi.userInteractionEnabled = NO;
    [viewButtom addSubview: self.buttonChongZhi];
    
    [self.view addSubview:viewButtom];

}
-(void)getData{
        [SelfUser mddyRequestWithMethodName:@"shopActionJsonPhone.htm" withParams:@{@"cmdCode":g_shopAccountBlanceJsonPhoneCountCmd} withBlock:^(id responseObject, NSError *error) {
           FLDDLogDebug(@"%@",responseObject);
    
    
            if (!error) {
                @try {
                    self.dictData = responseObject;
                    if ([[responseObject valueForKey:@"actionDetail"] toString].length>=1) {
                        self.isHasReword = YES;
                    }else{
                         self.isHasReword = NO;
                    }
                    
                }
                @catch (NSException *exception) {
    
                }
                @finally {
    
                }
            }else{
             
            }
            [self.tableView reloadData];
        }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//        AccountActivityViewCell *cell = (AccountActivityViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
//        return cell.frame.size.height;
        return 114;
 

}
-(void)onClickBackGround{
    
    
//    if ([self.textField isFirstResponder]) {
   
    if (self.textField.text.length>0) {
//        self.labelJinE.text = [NSString stringWithFormat:@"到账金额：%@元",self.textField.text];
//        [self.labelJinE sizeToFit];
//         self.buttonChongZhi.backgroundColor = UICOLOR(252, 102, 5, 1);
        self.isCanChongZhi = YES;
        [self notiKeyHid];
    }
    else{
        self.labelJinE.text =  @"到账金额：--元";
        [self.labelJinE sizeToFit];
   self.buttonChongZhi.backgroundColor = UICOLOR(189, 189, 189, 1);
    }
//    }
    [self.textField resignFirstResponder];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dictData == nil) {
        return 0;
    }
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell;
        static NSString* strINTI = @"cell1";
        UITableViewCell* cell1 = [tableView dequeueReusableCellWithIdentifier:strINTI];
        if (!cell1) {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strINTI];
     
    
    UILabel* labelCZ = [[UILabel alloc]init];
    labelCZ.text = @"充值金额";
    labelCZ.font = [UIFont systemFontOfSize:16];
    labelCZ.center = CGPointMake((WINDOW_WIDTH-ButtonWide*3)/4*1+labelCZ.bounds.size.width/2, 18);
    [labelCZ sizeToFit];
    [cell1 addSubview:labelCZ];
    if (self.textField == nil) {
        
        
    self.textField = [[UITextField alloc]init];
    self.textField.bounds = CGRectMake(0, 0, WINDOW_WIDTH-100, 30);
    self.textField.center = CGPointMake(CGRectGetMaxX(labelCZ.frame)+10+self.textField.bounds.size.width/2, CGRectGetMidY(labelCZ.frame));
    self.textField.placeholder = @"输入充值金额";
    self.textField.delegate = self;
    self.textField.tintColor =[UIColor orangeColor];
    self.textField.font = [UIFont systemFontOfSize:16];
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    [cell1 addSubview:self.textField];
    
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 105/2, WINDOW_WIDTH, 1)];
    view.backgroundColor = [UIColor lightGrayColor];
    view.alpha = 0.35;
    [cell1 addSubview:view];
    
          
           
    self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button1.frame = CGRectMake((WINDOW_WIDTH-ButtonWide*3)/4*1, 65, ButtonWide, 36);
    [self.button1 setTitle:@"500元" forState:UIControlStateNormal];
    self.button1.tag = 1;
    self.button1.layer.cornerRadius = 3;
    [self.button1.layer setBorderWidth:1.0];   //边框宽0
    self.button1.layer.borderColor = [UICOLOR(248, 78, 11, 0.85) CGColor];
    [self.button1 setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
    [self.button1 addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [cell1 addSubview:self.button1];
    
    
    self.button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button2.frame = CGRectMake((WINDOW_WIDTH-ButtonWide*3)/4*2+ButtonWide, CGRectGetMinY(self.button1.frame), ButtonWide, 36);
    [self.button2 setTitle:@"1000元" forState:UIControlStateNormal];
    self.button2.tag = 2;
    [self.button2 setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
    self.button2.layer.cornerRadius = 2;
    [self.button2.layer setBorderWidth:1.0];   //边框宽0
    self.button2.layer.borderColor = [UICOLOR(248, 78, 11, 0.85) CGColor];
    [self.button2 addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [cell1 addSubview:self.button2];
    
    self.button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button3.frame = CGRectMake((WINDOW_WIDTH-ButtonWide*3)/4*3+ButtonWide*2, CGRectGetMinY(self.button1.frame), ButtonWide, 36);
    [self.button3 setTitle:@"2000元" forState:UIControlStateNormal];
    [self.button3 setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
    self.button3.layer.cornerRadius = 3;
    [self.button3 addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [self.button3.layer setBorderWidth:1.0];   //边框宽0
    self.button3.layer.borderColor = [UICOLOR(248, 78, 11, 0.85) CGColor];
    self.button3.tag = 3;
    
    [cell1 addSubview:self.button3];
            }
    
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = cell1;


    
    return cell;
    


}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* viewTempp = nil;
    if (self.isHasReword) {

    AccountActivityView * view =[[AccountActivityView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 200) WithDict:self.dictData withFramLeeft:(WINDOW_WIDTH-ButtonWide*3)/4*1];
    [view setText];
    return view;
    }
    return viewTempp ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 16;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return WINDOW_HEIGHT;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)button:(UIButton*)sender{
    UIButton* button = sender;
      button.backgroundColor = UICOLOR(252, 102, 5, 1);
     [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (button.tag ==1) {
        self.textField.text = @"500";
//        self.labelJinE.text = [NSString stringWithFormat:@"到账金额：%@元",@"500"];
   
        self.button2.backgroundColor = [UIColor clearColor];
        self.button3.backgroundColor = [UIColor clearColor];
        
        [self.button2 setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
        [self.button3 setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
    }else if (button.tag==2){
        
        self.textField.text = @"1000";
//         self.labelJinE.text = [NSString stringWithFormat:@"到账金额：%@元",@"1000"];
        
        self.button1.backgroundColor = [UIColor clearColor];
        self.button3.backgroundColor = [UIColor clearColor];
        
        [self.button1 setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
        [self.button3 setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
    }else{
       self.textField.text = @"2000";
//           self.labelJinE.text = [NSString stringWithFormat:@"到账金额：%@元",@"2000"];
        self.button1.backgroundColor = [UIColor clearColor];
        self.button2.backgroundColor = [UIColor clearColor];
        
        [self.button1 setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
        [self.button2 setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
    }
    if ([self.textField isFirstResponder]) {
         [self.textField resignFirstResponder];
    }else{
        self.isCanChongZhi = YES;
        [self notiKeyHid];
        
    }
   

   
    self.buttonChongZhi.backgroundColor = UICOLOR(252, 102, 5, 1);
    
  
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;{
    if (textField.text.length==0) {
        if ([string isEqualToString:@"0"]) {
            return NO;
        }
    }
    
    if ([textField.text stringByAppendingString:string].length>5) {
        return NO;
    }
    self.button1.backgroundColor = [UIColor clearColor];
    self.button2.backgroundColor = [UIColor clearColor];
    self.button3.backgroundColor = [UIColor clearColor];
    [self.button1 setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
    [self.button2 setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
    [self.button3 setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
    
    
    return YES;
}




-(void)notiKeyHid{
    if ([self.textField isFirstResponder]||self.isCanChongZhi) {
    self.isCanChongZhi = NO;
     [SelfUser hudShowWithViewcontroller:self];
    [SelfUser mddyRequestWithMethodName:@"getShopRealRechageJsonPhone.htm" withParams:@{@"cmdCode":g_shopAccountBlanceJsonPhoneCountCmd,@"money":self.textField.text} withBlock:^(id responseObject, NSError *error) {
         [SelfUser hudHideWithViewcontroller:self];
        FLDDLogDebug(@"%@",responseObject);
        
        if (!error) {
            @try {
                self.labelJinE.text =  [NSString stringWithFormat:@"到账金额：%@元",[responseObject valueForKey:@"realMoney"]];
                [self.labelJinE sizeToFit];
                 self.buttonChongZhi.backgroundColor = UICOLOR(252, 102, 5, 1);
                self.buttonChongZhi.userInteractionEnabled = YES;
                
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
        }else{
            
        }
    }];
    }

   
}

-(void)chongzhi{
    self.buttonChongZhi.userInteractionEnabled = NO;
    NSString* isHasReword = nil;
    if (self.isHasReword) {
        isHasReword = @"1";
    }else{
       isHasReword = @"0";
    }
       [SelfUser hudShowWithViewcontroller:self];
    
    [SelfUser mddyRequestWithMethodName:@"shopRechageRequestPayJsonPhone.htm" withParams:@{@"cmdCode":g_shopAccountBlanceJsonPhoneCountCmd,@"money":self.textField.text,@"isHasReword":isHasReword} withBlock:^(id responseObject, NSError *error) {
        
        FLDDLogDebug(@"%@",responseObject);
            [SelfUser hudHideWithViewcontroller:self];
        if (!error) {
            @try {
            
                if ([[[responseObject valueForKey:@"isActionPassed"]toString]isEqualToString:@"true"]) {//为true就要谈
                    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"活动已结束" message:@"活动已结束，是否继续充值" delegate:self cancelButtonTitle:@"放弃" otherButtonTitles:@"继续充值", nil];
                    [alert show];
                    self.dictNextData = responseObject;
                }else{
                
                RechQueRenViewController* rech = [[RechQueRenViewController alloc]init];
                rech.dict = [NSDictionary dictionaryWithDictionary:responseObject];
                    rech.strMoney = self.textField.text;
                [self.navigationController pushViewController:rech animated:YES];
                    
               
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
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        RechQueRenViewController* rech = [[RechQueRenViewController alloc]init];
        rech.dict = [NSDictionary dictionaryWithDictionary:self.dictNextData];
        rech.strMoney = self.textField.text;
        [self.navigationController pushViewController:rech animated:YES];
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.textField.text = @"";
    self.labelJinE.text = @"到账金额：--元";
    [self.labelJinE sizeToFit];
    
    self.button1.backgroundColor = [UIColor clearColor];
    self.button2.backgroundColor = [UIColor clearColor];
    self.button3.backgroundColor = [UIColor clearColor];
    [self.button1 setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
    [self.button2 setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
    [self.button3 setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
    

}
-(void)zhifuResulted{
     [MBProgressHUD hudShowWithStatus :self : @"支付失败，请重新支付"];
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
