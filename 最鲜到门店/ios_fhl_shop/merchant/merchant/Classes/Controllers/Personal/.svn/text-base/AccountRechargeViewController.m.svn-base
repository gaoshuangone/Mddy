//
//  AccountRechargeViewController.m
//  merchant
//
//  Created by gs on 15/5/19.
//  Copyright (c) 2015年 JUEWEI. All rights reserved.
//

#import "AccountRechargeViewController.h"
#import "AccountRechTableViewCell.h"
#import "AccoutRechDoingViewController.h"
#import "UIView+convenience.h"
@interface AccountRechargeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)UIView* headerView;
@property (strong, nonatomic)UILabel* labelYuE;
@property (strong, nonatomic)UIButton* buttonChongZhi;
@property (strong, nonatomic)NSDictionary* dictData;
@property (strong, nonatomic)NSMutableArray* arrayData;
@property (assign, nonatomic)BOOL isHasRewordPower;
@property (assign, nonatomic)BOOL  isClerktype;


@property (assign, nonatomic) int currentPage;
@property (assign, nonatomic) NSInteger  currentTotal;
@property (assign, nonatomic) BOOL isHeaderRereshing;
@property (assign, nonatomic) BOOL isFooterRereshing;
@property (assign, nonatomic)BOOL isHeadRunIng;
@property (strong, nonatomic) UILabel* labelNOData;


@end

@implementation AccountRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户余额";
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT-64) style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    [self.view addSubview:self.tableView];
    self.arrayData = [NSMutableArray array];
//
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
//
//    //第一次获取揽收列表
    [self setupRefresh];//添加下拉刷新
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(noti) name:ZHIFUSUCCESS object:nil];
    
    
    self.labelNOData = [[UILabel alloc]initWithFrame:CGRectMake(WINDOW_WIDTH/2-50, WINDOW_HEIGHT/2, 130, 40)];
    self.labelNOData .text = @"暂无收支明细";
    self.labelNOData .textColor = [UIColor lightGrayColor  ];
    self.labelNOData .font = UIFont(16);
    self.labelNOData.hidden = YES;
    [self.tableView addSubview: self.labelNOData ];
   
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.isClerktype = NO;
     self.currentPage = 0;
    self.isHeaderRereshing = YES;
    [self getOrderList];
 
}
-(void)headerRereshing{
    
    self.tableView.footerHidden = NO;
    self.isFooterRereshing = NO;
    self.isHeadRunIng = YES;
    self.currentPage = 0;
    self.isHeaderRereshing = YES;
    //    [self getOrderCount];
    [self getOrderList];
    
    //    [self stopRereshing];
    if (self.tableView.isFooterRefreshing) {
        [self.tableView footerEndRefreshing];
    }
    
    
}
- (void)footerRereshing
{
    
    
    self.isHeaderRereshing = NO;
    self.isFooterRereshing = YES;
    
    
    //    FLDDLogDebug(@"%lu",self.currentTotal-[self.arratData count]);
    //    FLDDLogDebug(@"%d,%ld",self.currentTotal,[self.arratData count]);
    if (self.currentTotal - [self.arrayData count] >0) {
        //         [self getOrderCount];
        
        [self getOrderList];
    }else{
        self.tableView.footerHidden = YES;
        //        [SVProgressHUD showErrorWithStatus:@"没有更多了..."];
    }
    [self stopRereshing];
}
-(void)getOrderList{

    if ([[[SelfUser currentSelfUser].Clerktype toString] isEqualToString:@"1"]) {
        self.isClerktype = YES;
    }
    

    
    self.currentPage++;
    NSString* page =[NSString stringWithFormat:@"%d",self.currentPage]
    ;
        __weak __typeof(self)safeSelf = self;
    [SelfUser mddyRequestWithMethodName:@"shopAccountBlanceLogJsonPhone.htm" withParams:@{@"cmdCode":g_shopAccountBlanceJsonPhoneCountCmd,@"rows":@"15",@"page":page} withBlock:^(id responseObject, NSError *error) {
//        FLDDLogDebug(@"~~%@",responseObject);
        
        if ([[[responseObject valueForKey:@"isHasRewordPower"] toString] isEqualToString:@"1"]) {
            self.isHasRewordPower = YES;
        }else{
            self.isHasRewordPower = NO;

        }
        if (safeSelf.isHeaderRereshing == YES ) {
            if (safeSelf.arrayData) {
            [safeSelf.arrayData removeAllObjects];
            safeSelf.arrayData = nil;
            safeSelf.arrayData = [NSMutableArray array];
            }
            
        }

        
        if (!error) {
            @try {
                
                __weak      NSArray* array =[[responseObject valueForKey:@"accountBlanceLogList"] valueForKey:@"rows"];
                self.currentTotal =[[[responseObject valueForKey:@"accountBlanceLogList"]valueForKey:@"total"]toInt];
                for (NSDictionary* dict in array) {
//                     NSLog(@"!!!%@",self.arrayData);
                    if ([safeSelf.arrayData containsObject:dict]) {
//                        NSLog(@"212%@",dict);
                    }else{
//                        NSLog(@"~~~~~~~~~%@",dict);
                        [safeSelf.arrayData addObject:dict];
                    }
             
                }
//                NSLog(@"%@",self.arrayData);
                
                self.dictData = responseObject;
            
                [self.tableView reloadData];
                
                if (safeSelf.isHeaderRereshing == YES) {
                    
                }else{
//                    [safeSelf.tableView setContentOffset:CGPointMake(0,460*(self.currentPage)) animated:YES];
                    
                }

                
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
        }else{
            
        }
        [self stopRereshing];
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section== 0) {
        
        if (self.isHasRewordPower&&self.isClerktype) {
            
        UIView* view =[[UIView alloc ]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 40)];
        view.backgroundColor =UICOLOR(246, 236, 209, 1);
            
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 40)];
        label.backgroundColor = UICOLOR(246, 236, 209, 1);
        label.textColor = [UIColor colorWithHex:0xf7563c];
        label.text = @"活动公告：亲，现在充值有优惠哦";
        label.textAlignment=  NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
      
        [view addSubview:label];
            return view;
        }else{
            UIView* view =[[UIView alloc ]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 16)];
            
//            UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 20)];
//            label.backgroundColor = UICOLOR(246, 236, 209, 1);
//            label.textColor = [UIColor colorWithHex:0xf7563c];
//            label.text = @"活动公告：亲，现在充值有优惠哦";
//            label.textAlignment=  NSTextAlignmentCenter;
//            label.font = [UIFont systemFontOfSize:12];
//            
//            [view addSubview:label];
            return view;

        }
        
        
        

        
        
    }
    else{
    
    
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 40)];
    
    UILabel* labelAccount = [[UILabel alloc]init];
    labelAccount.text = @"收支明细";
    labelAccount.center = CGPointMake(16+labelAccount.frameWidth/2, 16+labelAccount.frameHeight/2);
    [labelAccount sizeToFit];
        labelAccount.font = [UIFont systemFontOfSize:12];
        labelAccount.textColor = [UIColor lightGrayColor];
    [view addSubview:labelAccount];
    return  view;
        
    }
    

   

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
 
        if (self.isHasRewordPower&&self.isClerktype) {
              return 40;
        }else{
            return 16;
        }
      
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 137;
    }
    return [AccountRechTableViewCell cellHeight];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.arrayData count]==0) {
        return 1;
    }
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.arrayData count]==0) {
        self.labelNOData.hidden = NO;
    }else{
       self.labelNOData.hidden = YES;
    }
    if (section==0) {
        
       
        return 1;
    }
  
    return [self.arrayData count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell* cell = nil;
    if (indexPath.section==0) {
        static NSString* strINTI = @"cell";
            UITableViewCell* cellOne = [tableView dequeueReusableCellWithIdentifier:strINTI];
            if (!cellOne) {
                cellOne = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strINTI];
                UILabel* labelAccount = [[UILabel alloc]init];
                labelAccount.text = @"我的余额（元）";
                labelAccount.textColor = [UIColor darkGrayColor];
                labelAccount.font = [UIFont systemFontOfSize:12];
                labelAccount.center = CGPointMake(16+labelAccount.frameWidth/2, 16+labelAccount.frameHeight/2);
                [labelAccount sizeToFit];
                [cellOne addSubview:labelAccount];
            }
        
        
   
        
        if (self.labelYuE== nil) {
            
     
        self.labelYuE= [[UILabel alloc]init];
        self.labelYuE.text =  @"--";
            
        self.labelYuE.font =  [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
 
        [self.labelYuE sizeToFit];
        self.labelYuE.center = CGPointMake(16+self.labelYuE.frameWidth/2,55+self.labelYuE.frameHeight/2);
        [cellOne addSubview:self.labelYuE];
        
        }
         self.labelYuE.text = [[self.dictData valueForKey:@"accountBlance"] toString];
        [self.labelYuE sizeToFit];
      
        if (self.buttonChongZhi == nil) {
        UIButton* buttonChongZhi = [UIButton buttonWithType:UIButtonTypeCustom];
             buttonChongZhi.bounds = CGRectMake(0, 0, 75, 35);
        buttonChongZhi.center =CGPointMake(WINDOW_WIDTH-16-37,CGRectGetMidY(self.labelYuE.frame)+25);
//            buttonChongZhi.center =CGPointMake(WINDOW_WIDTH-16-37,CGRectGetMidY(self.labelYuE.frame));
        [buttonChongZhi setTitle:@"充值" forState:UIControlStateNormal];
        [buttonChongZhi addTarget:self action:@selector(chongzhi) forControlEvents:UIControlEventTouchUpInside];
        UIImage* image = [UIImage imageNamed:@"buttonnormal_n"];
            
          
        image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5f topCapHeight:image.size.height * 0.5f];
        [buttonChongZhi setBackgroundImage:image forState:UIControlStateNormal];

       
        [cellOne addSubview:buttonChongZhi];
            
            if (!self.isClerktype) {
                buttonChongZhi.hidden = YES;
            }
        self.buttonChongZhi = buttonChongZhi;
        }
        
        cell = cellOne;
    }else{
     static NSString* strINTI = @"cellTwo";
    AccountRechTableViewCell* cellTwo = (AccountRechTableViewCell*)[tableView dequeueReusableCellWithIdentifier:strINTI];
    if (!cell) {
        UINib* nib = [UINib nibWithNibName:@"AccountRechTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:strINTI];
        cellTwo = (AccountRechTableViewCell*)[tableView dequeueReusableCellWithIdentifier:strINTI];
        
    }
        if ([[[[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"money"] toString]substringToIndex:1] isEqualToString:@"+"]) {
            cellTwo.isAdd = YES;
          
            cellTwo.label3.textColor = [UIColor colorWithHex:0xf7563c];
        }else{
            
             cellTwo.label3.textColor = [UIColor colorWithHex:0x81bb3b];;
        }
        
        cellTwo.label3.text = [[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"money"] toString];
        cellTwo.label4.text = [CommonUtils getDateForStringTime:[[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"operTime"] toString] withFormat:@"MM-dd HH:mm"]; 
        cellTwo.label1.text = [[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"operTypeName"] toString];
        
        
        if ([[[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"orderNumber"] toString]  isEqualToString:@""]) {
           cellTwo.label2.text =@" ";
        }else{
         cellTwo.label2.text = [NSString stringWithFormat:@"订单号：%@",[[[self.arrayData objectAtIndex:indexPath.row] valueForKey:@"orderNumber"] toString]];
        }
//        [cellTwo changeColor];
        cell = cellTwo;
    
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)chongzhi{
    AccoutRechDoingViewController* account = [[AccoutRechDoingViewController alloc]init];
    [self.navigationController pushViewController:account animated:YES];
}
-(void)stopRereshing{
    if (self.tableView.isHeaderRefreshing) {
        
        [self.tableView headerEndRefreshing];
    }
    
    if (self.tableView.isFooterRefreshing) {
        [self.tableView footerEndRefreshing];
    }
    
}
-(void)noti{
     [MBProgressHUD hudShowWithStatus :self : @"充值成功"];
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
