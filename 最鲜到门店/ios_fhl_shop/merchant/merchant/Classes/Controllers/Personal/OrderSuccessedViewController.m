


//
//  OrderSuccessedViewController.m
//  merchant
//
//  Created by gs on 14/11/4.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "OrderSuccessedViewController.h"
#import "OrderSuccessdCell.h"
#import "OrderSuccessedDetailViewController.h"
#import "OrderErrorDetailkViewController.h"
#import "OrderColosedViewController.h"
@interface OrderSuccessedViewController ()
@property (assign, nonatomic)BOOL isFirst;
//@property (strong, nonatomic)NSDictionary* dictData;

@property (strong, nonatomic) NSMutableArray* arratData;
@property (assign, nonatomic) int currentPage;
@property (assign, nonatomic) NSInteger  currentTotal;
@property (assign, nonatomic) BOOL isHeaderRereshing;
@property (strong, nonatomic) UILabel* labelNOData;
@property (assign, nonatomic)BOOL isFooterRereshing;
@end

@implementation OrderSuccessedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHex:0xededed];
//    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], UITextAttributeTextColor ,nil];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName ,nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.title = @"已完成的订单";
    self.navigationItem.hidesBackButton = YES;
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"backWithTitle.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 53, 19);
    
    UIBarButtonItem* rithtBarItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = rithtBarItem ;
    button = nil;
    rithtBarItem = nil;
    //    self.tableView.frame = CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT  - 64) ;
    
   
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT  - 64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
    self.tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    
    
//    logo_watermark_home
  
    self.labelNOData = [[UILabel alloc]initWithFrame:CGRectMake(WINDOW_WIDTH/2-50, WINDOW_HEIGHT/2-20-64, 130, 40)];
     self.labelNOData .text = @"暂无已完成订单";
     self.labelNOData .textColor = [UIColor lightGrayColor  ];
     self.labelNOData .font = UIFont(16);
    self.labelNOData.hidden = YES;
    [self.view addSubview: self.labelNOData ];
    self.imageViewNoData = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH/2-50+10, WINDOW_HEIGHT/2-20-64-80, 100, 80)];
    self.imageViewNoData.image = [UIImage imageNamed:@"logo_watermark_home.png"];
    self.imageViewNoData.hidden = YES;
    [self.view addSubview:self.imageViewNoData];
    self.imageViewNoData = nil;
    self.isHeaderRereshing = YES;
    [self setupRefresh];
    [self getData];
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    self.arratData = [NSMutableArray array];
 [self.view addGestureRecognizer:self.swip];
    // Do any additional setup after loading the view from its nib.
}

-(void)headerRereshing{
    self.isFooterRereshing = YES;
    self.currentPage = 0;
//       self.tableView.footerHidden = NO;
      self.isHeaderRereshing = YES;
    [self getData];
  
    [self stopRereshing];
    
    
}
- (void)footerRereshing
{
    
    
    self.isHeaderRereshing = NO;
   
    
      if (self.currentTotal - [self.arratData count] >0) {
        
        [self getData];
    }else{
        self.tableView.footerHidden = YES;
//        [SVProgressHUD showErrorWithStatus:@"没有更多了..."];
    }
    [self stopRereshing];
}

-(void)stopRereshing{
    if (self.tableView.isHeaderRefreshing) {
        [self.tableView headerEndRefreshing];
    }
    
    if (self.tableView.isFooterRefreshing) {
        [self.tableView footerEndRefreshing];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
      self.navigationController.navigationBar.translucent = NO;
    if (self.isFirst) {
               [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
               self.currentPage = 0;
//        self.arratData= nil;
//          self.arratData = [NSMutableArray array];
         self.isHeaderRereshing = YES;
        [self getData];
        
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.isFirst = YES;
    
}
#pragma mark活动指示器
-(void)startActivityView{
    if (self.activityIndicatorView == nil) {
        
        self.activityIndicatorView= [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        self.activityIndicatorView.center = [UIApplication sharedApplication].keyWindow.center;
        //        self.activityIndicatorView.color = [UIColor redColor];
        [self.view addSubview: self.activityIndicatorView];
        
    }
    [self.activityIndicatorView startAnimating];
    self.tableView.userInteractionEnabled = NO;
    
}
-(void)stopActivityView{
    [  self.activityIndicatorView stopAnimating];
    self.tableView.userInteractionEnabled = YES;
}

-(void)getData{
//    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeBlack];
    self.isHeaderRereshing ? self.isFooterRereshing?NO :[self startActivityView]:NO  ;
    self.currentPage++;
    NSString* page =[NSString stringWithFormat:@"%d",self.currentPage]
    ;
    __weak __typeof(self)weakSelf = self;
    [SelfUser mddyRequestWithMethodName:@"hasEndWaybillListJsonPhone.htm" withParams:@{@"cmdCode":g_hasEndWaybillListCmd,@"page":page,@"rows":@"10"} withBlock:^(id responseObject, NSError *error) {
//        [SVProgressHUD dismiss ];
         [weakSelf stopRereshing];
        if (weakSelf.isHeaderRereshing == YES) {
            weakSelf.arratData = nil;
            weakSelf.arratData = [NSMutableArray array];
        }
        
        if (!error) {
            @try {
                FLDDLogDebug(@"2.1.11)已完成订单列表%@",responseObject);
                
                NSArray* array =[[responseObject valueForKey:@"hasEndWaybillList"] valueForKey:@"rows"];
                weakSelf.currentTotal =[[[responseObject valueForKey:@"hasEndWaybillList"]valueForKey:@"total"]toInt];
                for (NSDictionary* dict in array) {
                    [weakSelf.arratData addObject:dict];
                }
                FLDDLogDebug(@"****%@*************%ld",self.arratData,(unsigned long)[self.arratData count]);
                
                
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            
            
            
        }else{
//            [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
        }
        [weakSelf.tableView reloadData];
        
        if (weakSelf.isHeaderRereshing ) {
             FLDDLogDebug(@"~~~~111~~");
//            [self.tableView setContentOffset:CGPointMake(0,-18) animated:YES];
        }else{
            FLDDLogDebug(@"~~~~~~~~~");
//            [self.tableView setContentOffset:CGPointMake(0,460*(self.currentPage)) animated:YES];
        [weakSelf.tableView setContentOffset:CGPointMake(0, 115*6*(self.currentPage-1)) animated:YES];
        }
        weakSelf.isFooterRereshing = NO;
        
        [weakSelf stopActivityView];
    }];
    
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.arratData count] == 0) {
        self.labelNOData.hidden = NO;
        self.imageViewNoData.hidden  = NO;
        return 0;
    }else{
        self.labelNOData.hidden = YES;
        self.imageViewNoData.hidden = YES;
          return [self.arratData count];
    }

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    static NSString* strINTI = @"cell";
    OrderSuccessdCell* cellView = [tableView dequeueReusableCellWithIdentifier:strINTI];
    if (!cellView) {
        cellView = [[OrderSuccessdCell alloc  ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strINTI];
    }
//    
//    if (self.arratData.count < 0) {
//        <#statements#>
//    }
    
    cellView.labelPrice.text = [NSString stringWithFormat:@"%.2f元",[[[self.arratData objectAtIndex:indexPath.row] valueForKey:@"waybillPrice"] floatValue]/100];
    
    
//    cell.labelSend.text = [NSString stringWithFormat:@"%@",[CommonUtils getDateForStringTime:[[self.arratData objectAtIndex:indexPath.row] valueForKey:@"createTime"]]];
        cellView.labelSend.text = [NSString stringWithFormat:@"%@",[CommonUtils getDateForStringTime:[[self.arratData objectAtIndex:indexPath.row] valueForKey:@"createTime"] withFormat:@"yyyy年MM月dd日 HH:mm:ss"]];
//    cell.labelSuccessed.text = [NSString stringWithFormat:@"%@",[CommonUtils getDateForStringTime:[[self.arratData objectAtIndex:indexPath.row] valueForKey:@"receivingTime"]]];
      cellView.labelSuccessed.text = [NSString stringWithFormat:@"%@",[CommonUtils getDateForStringTime:[[self.arratData objectAtIndex:indexPath.row] valueForKey:@"receivingTime"] withFormat:@"yyyy年MM月dd日 HH:mm:ss"]];
    [cellView.labelSend sizeToFit];
    [cellView.labelSuccessed sizeToFit];
    cellView.labelAddressed.text = [NSString stringWithFormat:@"%@",[[self.arratData  objectAtIndex:indexPath.row] valueForKey:@"consigneeAddress"]];
    if ([[[[self.arratData  objectAtIndex:indexPath.row] valueForKey:@"status"] toString]isEqualToString:@"14"]) {
            cellView.imageViewStatus.image = [UIImage imageNamed:@"declined_seal_normal.png"];
    }else if ([[[[self.arratData  objectAtIndex:indexPath.row] valueForKey:@"status"] toString]isEqualToString:@"12"]){
            cellView.imageViewStatus.image = [UIImage imageNamed:@"cancelled_seal_normal.png"];
    }else if ([[[[self.arratData  objectAtIndex:indexPath.row] valueForKey:@"status"] toString]isEqualToString:@"16"]){
        cellView.imageViewStatus.image = [UIImage imageNamed:@"cancelled_seal_.png"];
    }else {
         cellView.imageViewStatus.image = [UIImage imageNamed:@"completed_seal_big.png"];
    }
    
    
    cell = cellView;
    [cellView removeFromSuperview];
    cellView = nil;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([[[[self.arratData  objectAtIndex:indexPath.row] valueForKey:@"status"] toString]isEqualToString:@"12"]) {
         OrderErrorDetailkViewController* errorDetail = [[OrderErrorDetailkViewController alloc ]initWithNibName:nil bundle:nil];
               errorDetail.orderStatus = ORDER_ERROR_STATUS_WAIT_CANCEL;
        errorDetail.orderStatusED= ORDER_CANCEL;
    
        errorDetail.strWayBillld =[[[self.arratData objectAtIndex:indexPath.row]valueForKey:@"waybillId"] toString];
        [self.navigationController pushViewController:errorDetail animated:YES];
    }else if ([[[[self.arratData  objectAtIndex:indexPath.row] valueForKey:@"status"] toString]isEqualToString:@"14"]){
    
        OrderErrorDetailkViewController* errorDetail = [[OrderErrorDetailkViewController alloc ]initWithNibName:nil bundle:nil];
        errorDetail.orderStatus = ORDER_ERROR_STATUS_WAIT_JUSHOU;
        errorDetail.orderStatusED= ORDER_JUSHOU;
        errorDetail.strWayBillld =[[[self.arratData objectAtIndex:indexPath.row]valueForKey:@"waybillId"] toString];
        [self.navigationController pushViewController:errorDetail animated:YES];
    }else if ([[[[self.arratData  objectAtIndex:indexPath.row] valueForKey:@"status"] toString]isEqualToString:@"16"]){
        
        OrderColosedViewController* errorDetail = [[OrderColosedViewController alloc ]initWithNibName:nil bundle:nil];
       
        errorDetail.strWayBillld =[[[self.arratData objectAtIndex:indexPath.row]valueForKey:@"waybillId"] toString];
        [self.navigationController pushViewController:errorDetail animated:YES];
    }else
    {

    OrderSuccessedDetailViewController* orderDetail = [[OrderSuccessedDetailViewController alloc]initWithNibName:nil bundle:nil];
    orderDetail.strWaybillId = [NSString stringWithFormat:@"%@",[[self.arratData  objectAtIndex:indexPath.row] valueForKey:@"waybillId"]];
    
    [self.navigationController pushViewController:orderDetail animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [OrderSuccessdCell cellHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back
{
    [self.tableView removeFromSuperview];
    self.tableView = nil;
    
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

