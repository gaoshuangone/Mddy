//
//  RechQueRenViewController.m
//  merchant
//
//  Created by gs on 15/5/26.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "RechQueRenViewController.h"
#import "WebViewJavascriptBridge.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthV2Info.h"
#import "AccountRechargeViewController.h"
#import "JianHangWebView.h"


@interface RechQueRenViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIWebViewDelegate>
@property (strong, nonatomic)UIImageView* imageView1 ;
@property (strong, nonatomic)UIImageView* imageView2 ;
@property (assign, nonatomic)BOOL isAiLiPay;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,strong) UILabel* labelTime;
@property (assign, nonatomic) BOOL isCanPay;
@property (assign, nonatomic) NSInteger timerShengYU;


@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property (nonatomic, strong) UIWebView *webView;
@property (assign, nonatomic) BOOL isCanAlert;//在支付宝支付的时候是否弹出倒计时结束的

@end

@implementation RechQueRenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHex:0xededed];
    self.navigationItem.hidesBackButton = YES;
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"backWithTitle.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 53, 19);
    UIBarButtonItem* rithtBarItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = rithtBarItem ;
    button = nil;
    rithtBarItem = nil;
    
    self.title = @"充值确认";
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.isAiLiPay = YES;
    
    UIButton* buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonCancel addTarget:self action:@selector(buttonPressedQueRen) forControlEvents:UIControlEventTouchUpInside];
    [buttonCancel setTitle:@"确认支付" forState:UIControlStateNormal];
    float red = 252/255.0;
    float green = 102/255.0;
    float blue = 5/255.0;
    [buttonCancel setBackgroundColor: [UIColor colorWithRed:red green:green blue:blue alpha:1.0]];
    buttonCancel.layer.cornerRadius = 3;
//    buttonCancel.frame = CGRectMake(16, 195+80+50, WINDOW_WIDTH-32, 44);
//    [self.tableView addSubview:buttonCancel];
    buttonCancel.frame = CGRectMake(16, WINDOW_HEIGHT-44-64-10, WINDOW_WIDTH-32, 44);
    [self.view addSubview:buttonCancel];
    self.tableView.bounces = NO;
    self.isCanPay = YES;
    self.isCanAlert =YES;
   
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(zhifuResult:) name:ZHIDURESULT object:nil];
    // Do any additional setup after loading the view.
}


-(void)alert{//从支付宝返回的时候如果
    if (self.timerShengYU<=1) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"订单超时，请重新提交" message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        alert.tag=2;
        [alert show];
    }

}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    return 2;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell* cell = nil;
    if (indexPath.section == 0) {
        static NSString* strINTI = @"cell";
        UITableViewCell* cell1 = [tableView dequeueReusableCellWithIdentifier:strINTI];
        if (!cell1) {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strINTI];
            
        
        UILabel* labelZhiFu = [[UILabel alloc]init];
        labelZhiFu.font = [UIFont systemFontOfSize:16];
        labelZhiFu.text = @"支付金额";
        [labelZhiFu sizeToFit];
        labelZhiFu.center = CGPointMake(25+labelZhiFu.boundsWide/2, 16+labelZhiFu.boundsHeight/2);
        [cell1 addSubview:labelZhiFu];
            
        UILabel* labelZHiFuPrice  = [[UILabel alloc]init];
        labelZHiFuPrice.font = [UIFont systemFontOfSize:16];
            labelZHiFuPrice.text = [NSString stringWithFormat:@"%@元",self.strMoney];
        [labelZHiFuPrice sizeToFit];
        labelZHiFuPrice.center = CGPointMake(25+labelZhiFu.boundsWide/2, CGRectGetMaxY(labelZhiFu.frame)+10+labelZHiFuPrice.boundsHeight/2);
        [cell1 addSubview:labelZHiFuPrice];
    
        
        UIView* line = [[UIView alloc]init];
        line.bounds = CGRectMake(0, 0, WINDOW_WIDTH-CGRectGetMaxX(labelZhiFu.frame)*2-20, 1);
        line.center = CGPointMake(WINDOW_WIDTH/2, labelZhiFu.center.y);
        line.backgroundColor =[UIColor lightGrayColor];
        line.alpha = 0.35;
        [cell1 addSubview:line];
            
            if ([[self.dict valueForKey:@"rewordDetail"] toString].length>0) {
                
        
        UILabel* labeActity = [[UILabel alloc]init];
        labeActity.text = @"活动";
        labeActity.backgroundColor = [UIColor whiteColor ];
        labeActity.textColor = [UIColor grayColor];
        labeActity.textAlignment = NSTextAlignmentCenter;
        labeActity.font =[UIFont systemFontOfSize:14];
        labeActity.bounds = CGRectMake(0, 0, 60, 30);
        labeActity.center =CGPointMake(WINDOW_WIDTH/2, labelZhiFu.center.y);
        [cell1 addSubview:labeActity];
            
        UILabel* labeActityDetail = [[UILabel alloc]init];
        labeActityDetail.text =  [NSString stringWithFormat:@"%@",[self.dict valueForKey:@"rewordDetail"]];
        labeActityDetail.textColor = [UIColor grayColor];
        labeActityDetail.textAlignment = NSTextAlignmentCenter;
        labeActityDetail.font =[UIFont systemFontOfSize:14];
        [labeActityDetail sizeToFit];
        labeActityDetail.center =CGPointMake(WINDOW_WIDTH/2, CGRectGetMaxY(labelZhiFu.frame)+10+labelZHiFuPrice.boundsHeight/2);
        [cell1 addSubview:labeActityDetail];
            }
            
            
            
        
        UILabel* labelDaoZhang = [[UILabel alloc]init];
        labelDaoZhang.font = [UIFont systemFontOfSize:16];
        labelDaoZhang.text = @"到账金额";
        [labelDaoZhang sizeToFit];
        labelDaoZhang.center = CGPointMake(10+CGRectGetMaxX(line.frame)+labelDaoZhang.boundsWide/2, 16+labelZhiFu.boundsHeight/2);
        [cell1 addSubview:labelDaoZhang];
            
        UILabel* labelDaoZhangPrice  = [[UILabel alloc]init];
        labelDaoZhangPrice.font = [UIFont systemFontOfSize:16];
        labelDaoZhangPrice.text = [NSString stringWithFormat:@"%@元",[self.dict valueForKey:@"realMoney"]];
        [labelDaoZhangPrice sizeToFit];
        labelDaoZhangPrice.center = CGPointMake(10+CGRectGetMaxX(line.frame)+labelDaoZhang.boundsWide/2, CGRectGetMaxY(labelZhiFu.frame)+10+labelZHiFuPrice.boundsHeight/2);
        [cell1 addSubview:labelDaoZhangPrice];
            
        
        }

        
        cell = cell1;
    }else if(indexPath.section == 1) {
        static NSString* strINTI = @"cell";
        UITableViewCell* cell2= [tableView dequeueReusableCellWithIdentifier:strINTI];
        if (!cell2) {
            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strINTI];
            
            
        }
        if (indexPath.row==0) {
            
            if (self.imageView1== nil) {
           
            UILabel* label =[[UILabel alloc]init];
            label.text = @"支付宝支付";
            label.font = [UIFont systemFontOfSize:16];
            [label sizeToFit];
            label.center = CGPointMake(22+label.boundsWide/2, 20);
            [cell2 addSubview:label];
            
            self.imageView1 = [[UIImageView alloc]init];
            self.imageView1.image = [UIImage imageNamed:@"duihao.png"];
            self.imageView1.bounds = CGRectMake(0, 0, 76/2/2, 72/2/2);
             self.imageView1.center = CGPointMake(WINDOW_WIDTH-35, 195/4/2);
            [cell2 addSubview:self.imageView1];
            }
    
        }else if(indexPath.row==1){
            
            if (self.imageView2 == nil) {
            UILabel* label =[[UILabel alloc]init];
            label.text = @"建行卡支付";
            label.font = [UIFont systemFontOfSize:16];
            [label sizeToFit];
            label.center = CGPointMake(22+label.boundsWide/2, 20);
            [cell2 addSubview:label];
            
            self.imageView2 = [[UIImageView alloc]init];
            self.imageView2.image = [UIImage imageNamed:@"cuowu.png"];
            self.imageView2.bounds = CGRectMake(0, 0, 76/2/2, 72/2/2);
            self.imageView2.center = CGPointMake(WINDOW_WIDTH-35, 195/4/2);
            [cell2 addSubview:self.imageView2];
                
            }

        }
        
        cell = cell2;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view = nil;
    if (section == 0) {

        if (!self.labelTime) {
       
        view = [[UIView alloc]initWithFrame:[self.tableView  rectForHeaderInSection:section]];
        UILabel * lable = [[UILabel alloc]init];
        lable.numberOfLines = 0;
        lable.bounds  = CGRectMake(0, 0, WINDOW_WIDTH-32, 0);
        lable.font = [UIFont systemFontOfSize:16];
        lable.text = @"充值活动已成功锁定，请在           分钟内完成网上支付，否则系统将自动取消本次交易。";
        [lable sizeToFit];
        lable.center = CGPointMake(16+lable.boundsWide/2, view.center.y+4);
        [view addSubview:lable];
        
       
    
         self.labelTime = [[UILabel alloc]init];
         self.labelTime.bounds  = CGRectMake(0, 0, WINDOW_WIDTH-32, 0);
         self.labelTime.font = [UIFont systemFontOfSize:18];
         self.labelTime.textColor = UICOLOR(248, 78, 11, 1);
         self.labelTime.text = [NSString stringWithFormat:@"%@",[[self.dict valueForKey:@"limitTime"] toString]];
        [ self.labelTime sizeToFit];
         self.labelTime.center = CGPointMake(194+ self.labelTime.boundsWide/2,  self.labelTime.boundsHeight/2-2);
        [lable addSubview: self.labelTime];
        
     

        g_timeCount = [[self.dict valueForKey:@"limitTime"] integerValue]*60;
          
//              g_timeCount = 20;
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        self.timer =   [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(progressTimerChange) userInfo:nil repeats:YES];
        [self.timer fire];
        }
        return view;
    }else if (section == 1){
        
        view = [[UIView alloc]initWithFrame:[self.tableView  rectForHeaderInSection:section]];
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(22, 15, 100, 20)];
        label.text = @"支付方式";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor =[UIColor grayColor];
        [view addSubview:label];
        return view;
    }
    return view;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
                self.imageView1.image = [UIImage imageNamed:@"duihao.png"];
                self.imageView2.image = [UIImage imageNamed:@"cuowu.png"];
            self.isAiLiPay = YES;
        }else{
            self.imageView2.image = [UIImage imageNamed:@"duihao.png"];
            self.imageView1.image = [UIImage imageNamed:@"cuowu.png"];
            self.isAiLiPay = NO;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        if (iPhone4) {
            return 180/2;
        }
        
    return 156/2;
    }else{
        return 40;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else{
        return 195/4;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buttonPressedQueRen{
    self.isCanAlert = NO;
    if (self.isCanPay) {
        
        
        if (self.isAiLiPay) {
            [self apily];
        }else{

            JianHangWebView* jianWeb = [[JianHangWebView alloc]init];
            jianWeb.dict = [NSDictionary dictionaryWithDictionary:self.dict];
            jianWeb.strMoney = self.strMoney;
            jianWeb.timeShengYu = self.timerShengYU;
            [self.navigationController pushViewController:jianWeb animated:YES];

        }
    }else{
//        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:nil  message:@"订单超时，请重新提交" delegate:self cancelButtonTitle:@"知道了"otherButtonTitles:nil, nil];
//        alert.tag=2;
//        [alert show];
    }
}
-(void)progressTimerChange{
      NSInteger timer = --g_timeCount;
    self.timerShengYU = timer;
//    NSLog(@"%d",self.timerShengYU);
    if (timer<=1) {
        [self.timer invalidate];
        self.timer = nil;
        self.labelTime.text = @"00:00";
        [self.labelTime sizeToFit];
        self.isCanPay = NO;
        if (self.isCanAlert) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"订单超时，请重新提交" message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        alert.tag=2;
        [alert show];
        }
        
        return;
        
    }

    NSString* str1= nil;
    if (labs(timer/60)<10) {
        str1 = [NSString stringWithFormat:@"0%ld",labs(timer/60)];
    }else{
         str1 = [NSString stringWithFormat:@"%ld",labs(timer/60)]; 
    }
     NSString* str2= nil;
    if (timer%60<10) {
        str2 = [NSString stringWithFormat:@"0%ld",(long)(timer%60)];

    }else{
          str2 = [NSString stringWithFormat:@"%ld",(long)(timer%60)];
    }
    self.labelTime.text = [NSString stringWithFormat:@"%@:%@",str1,str2];
    [self.labelTime sizeToFit];
    
}
-(void)back{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"放弃支付" message:@"是否放弃本次付款" delegate:self cancelButtonTitle:@"放弃" otherButtonTitles:@"继续支付", nil];
    alert.tag=1;
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
            if (self.timer) {
                [self.timer invalidate];
                self.timer = nil;
            }
        }else{
//            [self jianHangPay];
//            JianHangWebView* jianWeb = [[JianHangWebView alloc]init];
//            jianWeb.dict = [NSDictionary dictionaryWithDictionary:self.dict];
//            [self.navigationController pushViewController:jianWeb animated:YES];
        }
    }else{//订单超时
        if (alertView.tag == 2) {
            for (UIViewController* vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[AccountRechargeViewController class]]) {
                    [self.navigationController  popToViewController:vc animated:YES];
                    [[NSNotificationCenter defaultCenter]postNotificationName:XIADanREZHiFU object:self];
                    if (self.timer) {
                        [self.timer invalidate];
                        self.timer = nil;
                    }
                    
                }
            }

        }
    }
        
}
-(void)apily{
    
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */

    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Partner"];
    NSString *seller = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Seller"];
    NSString *privateKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA private key"];
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/

    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }

    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [self.dict valueForKey:@"orderNumber"]; //订单ID（由商家自行制定）
    order.productName =@"标题"; //商品标题
    order.productDescription = @"描述"; //商品描述
    order.amount =self.strMoney; //商品价格
//     order.amount =@"0.01"; //商品价格
    order.notifyURL = @"http://fhl.zuixiandao.cn:8081/phone/mddy/shopRechageRequestAlipayResult.htm"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay =[CommonUtils getDateForStringTime:[self.dict valueForKey:@"disableTime"] withFormat:nil];
    order.showUrl = @"m.alipay.com";

    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"mddy";

    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~orderSpec = %@",orderSpec);

    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];

    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];

        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"!!!!reslut = %@",resultDic);
             NSLog(@"@@@memo = %@,resultStatus =%@",[resultDic valueForKey:@"memo"],[resultDic valueForKey:@"resultStatus"]);
            
            if ([[[resultDic valueForKey:@"resultStatus"] toString]isEqualToString:@"9000"]) {
                
                [[NSNotificationCenter defaultCenter]postNotificationName:ZHIDURESULT object:self userInfo:@{@"info":@"1"}];
            }else{

                [[NSNotificationCenter defaultCenter]postNotificationName:ZHIDURESULT object:self userInfo:@{@"info":@"0"}];
//                [self alert];

            }

        }];



//        [[AlipaySDK defaultService] auth_V2WithInfo:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//         NSLog(@"reslut = %@",resultDic);
//             NSLog(@"memo = %@,resultStatus =%@",[resultDic valueForKey:@"memo"],[resultDic valueForKey:@"resultStatus"]);
//        }];

        
    }



}

//-(void)jianHangPay{
//     self.view.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
//    if (!self.webView) {
//        self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//        self.webView.backgroundColor = [UIColor whiteColor];
//        [self.view addSubview:self.webView];
//        
//
//        
//        [WebViewJavascriptBridge enableLogging];
//        
//        _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
//            FLDDLogDebug(@"ObjC received message from JS: %@", data);
//            responseCallback(@"Response for message from ObjC");
//        }];
//        
//        [_bridge registerHandler:@"reloadPage" handler:^(id data, WVJBResponseCallback responseCallback) {
//            FLDDLogDebug(@"reloadPage");
////            [self reLoginReloadPage];
//        }];
//        
//        [_bridge registerHandler:@"fhlSecondCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
//            FLDDLogDebug(@"testObjcCallback called: %@", data);
//            
//            
//            NSString *html = [data toString];
//            
//            responseCallback(@"Response from testObjcCallback");
//        }];
//        
//        [_bridge send:@"123"];
//        
//        NSURLRequest *request = [User getBookPageRequestWithOrderNumb:[self.dict valueForKey:@"orderNumber"]];
//        if(request != nil)
//        {
//            [self.webView loadRequest:request];
//        }
//
//    }
//

//}


//#pragma mark - UIWebViewDelegate
//
//- (void)webViewDidStartLoad:(UIWebView *)webView {
//    FLDDLogDebug(@"webViewDidStartLoad");
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    
//    FLDDLogDebug(@"webViewDidFinishLoad");
// 
//    
//    [_bridge send:@"123"];
//}
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    
//    FLDDLogDebug(@"instruction wevView load error:%@", error);
//
//    
// 
//}


-(void)zhifuResult:(NSNotification*)noti{
    
    NSLog(@"%@",noti.userInfo);
    
    if ([[noti.userInfo valueForKey:@"info"]isEqualToString:@"1"]) {
        for (UIViewController* vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[AccountRechargeViewController class]]) {
                [self.navigationController  popToViewController:vc animated:YES];
            }
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:ZHIFUSUCCESS object:self];
    }else{
    
    [MBProgressHUD hudShowWithStatus :self : @"支付失败，请重新支付"];
    self.isCanAlert = YES;
    [self alert];
    }
 
    
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
