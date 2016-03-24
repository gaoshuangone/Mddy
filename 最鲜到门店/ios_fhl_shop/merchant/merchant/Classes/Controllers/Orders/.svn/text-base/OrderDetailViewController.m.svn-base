//
//  OrderDetailViewController.m
//  merchant
//
//  Created by gs on 14/11/5.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "AnimatedView.h"
#import "BMapKit.h"
#import "CouriesViewController.h"
#import "ButtonDetailH5.h"
#import "FeeWebViewController.h"

@interface OrderDetailViewController ()<BMKRouteSearchDelegate>
@property (strong, nonatomic)NSMutableDictionary* dictData;
@property (nonatomic, strong) AnimatedView *animatedView;
@property (nonatomic, strong) BMKRouteSearch *routeSearch;
@property (nonatomic, strong) ButtonDetailH5* buttonH5;
@property (assign, nonatomic) float fFreight;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self addTableViewWithStyle:UITableViewStylePlain];
    g_messageInfo = nil;
    self.title = @"订单详情";
    self.navigationItem.hidesBackButton = YES;
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"backWithTitle.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 53, 19);
    
    UIBarButtonItem* rithtBarItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = rithtBarItem ;
    
    self.tableView.frame = CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT  - 64) ;
    self.tableView.backgroundColor = [UIColor whiteColor];
   
 
    if (self.animatedView== nil) {
        

    self.animatedView = [[AnimatedView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT) imageName:@"logo_watermark_run" remark:@"正在努力加载中"];
     self.animatedView.delegate11 = self;
//    __weak __typeof(self)weakSelf = self;
//    self.animatedView.touchAction = ^(void){
//         [weakSelf getDictData];
//    };
    [self.view addSubview:self.animatedView];
       
    }
    
       [self getDictData];
    [self.view addGestureRecognizer:self.swip]; 
    
}

-(void)doChangeAnimate{
    [self getDictData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //      [[NSNotificationCenter defaultCenter]postNotificationName:@"OrderDetailViewController" object:nil userInfo:@{@"status":@"lanshou",@"billld":strBuillld}];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(noti:) name:@"OrderDetailViewController" object:nil];
    if(nil != g_messageInfo)
    {
        [MBProgressHUD hudShowWithStatus:self :g_messageInfo];
        g_messageInfo = nil;
        
    }
}
-(void)noti:(NSNotification*)noti{
    NSDictionary* dict = [[NSDictionary alloc]initWithDictionary:noti.userInfo];
    if ([[dict valueForKey:@"status"] isEqualToString:@"qiangdan"]) {
        self.order_status = ORDER_STATUS_WAIT_QIANGDAN;
    }else{
        self.order_status = ORDER_STATUS_WAIT_LANSHOU;
    }
    self.strWayBillld =[dict valueForKey:@"billld"];
    [self getDictData];
}
// Do any additional setup after loading the view from its nib.
//    UIButton* button = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    button.backgroundColor = [UIColor redColor];
//    button.frame = CGRectMake(100, 100, 100, 100);
//    [button addTarget:self action:@selector(buttonCeshi) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//
//
//}
//-(void)buttonCeshi{
//    [AppManager  addLocalNotificationWithTimeInterval:3 orderId:@"1" content:@"mddy_logout"];
//}
-(void)getDictData{
//    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeClear];

    NSString* strMethod = nil;
    NSString* strCmd = nil;
    if (self.order_status == ORDER_STATUS_WAIT_LANSHOU || self.order_status == ORDER_STATUS_WAIT_QIANGDAN) {
        strMethod =@"toHandoverWaybillDetailJsonPhone.htm";
        strCmd = (NSString *)g_handoverWaybillDetailCmd;
    }else{
        strMethod =@"toReceiveWaybillDetailJsonPhone.htm";//待签收
        strCmd = (NSString *)g_receiveWaybillDetailCmd;
    }
    UIActivityIndicatorView* activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    activity.center = [UIApplication sharedApplication].keyWindow.center;
//    activity.color = [UIColor redColor];
    [self.view addSubview:activity];
     [ activity startAnimating];
     __weak __typeof(self)weakSelf = self;
    [SelfUser mddyRequestWithMethodName:strMethod withParams:@{@"cmdCode":strCmd,@"waybillId":self.strWayBillld} withBlock:^(id responseObject, NSError *error) {
//        [SVProgressHUD dismiss ];
         [ activity stopAnimating];
    
        weakSelf.dictData = nil;
        
        if (!error) {
            @try {
                
                FLDDLogDebug(@"%@订单详情%@",strMethod,responseObject);
                weakSelf.dictData = nil;
                weakSelf.dictData = [NSMutableDictionary dictionary];
                weakSelf.dictData = responseObject;
                if (weakSelf.animatedView) {
                [weakSelf.animatedView removeFromSuperview];
              weakSelf.animatedView =  nil;
                }
                
//                 if (![[responseObject valueForKey:@"consigneeTel"]  isEqualToString:@""]) {
//                     
//
//                     
//                [self distanceInfo];
//                     
//                 }
                if(weakSelf.dictData.allKeys.count > 0)
                {
                    long lDistance = [[self.dictData valueForKey:@"walkingDistance"] integerValue];
//                    float latitude =  [[self.dictData valueForKey:@"consigneeLatitude"]  doubleValue];
//                    float longitude = [[self.dictData valueForKey:@"consigneeLongitude"]  doubleValue];
                    if(lDistance == 0)
                    {
                        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.dictData];
                        if(dic.allKeys.count > 0)
                        {
                            [dic setValue:@"-1" forKey:@"walkingDistance"];
                            self.dictData = dic;
                        }
//                        [weakSelf.dictData setValue:@"-1" forKey:@"walkingDistance"];
                        FLDDLogDebug(@"walkingDistance %ld", (long)[[weakSelf.dictData valueForKey:@"walkingDistance"] integerValue]);
                        [weakSelf distanceInfo];
                    }
                }

                
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            
            
            [weakSelf.tableView reloadData];
            FLDDLogDebug(@"~~~%@",self.dictData);
            
            
        }else{
              [weakSelf.animatedView stopAnimate];
             [MBProgressHUD hudShowWithStatus:weakSelf :[SelfUser currentSelfUser].ErrorMessage];
//            [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
        }
        
        
    }];
    
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.dictData allKeys].count >0) {
        return 2;
    }else{
        return 1;
    }
    //return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
// 滚动时，触发该函数
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.buttonH5.hidden = YES;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        
        static NSString* strINTI = @"ImageCell";
        UITableViewCell* imageCell = [tableView dequeueReusableCellWithIdentifier:strINTI];
        
        if (!imageCell) {
            imageCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strINTI];
        }
        
        for (UIView *subview in imageCell.contentView.subviews) {
            
            FLDDLogDebug(@"%@",subview);
            [subview removeFromSuperview];
           
            
        }
        imageCell.backgroundColor = UICOLOR(217, 217, 217, 1);
        
        UIImageView* imabeViewOrderSuccesss = [[UIImageView alloc]initWithFrame:CGRectMake(iPhone6Plus? 22+iphone4W_5W_6PlusW*22: 0.85*22, 20, iPhone4?0.85*330:iPhone5?0.85*330:330,iPhone4?0.85*58:iPhone5?0.85*58:58)];
        
        imabeViewOrderSuccesss.image = [self getImage];
        [imageCell.contentView addSubview:imabeViewOrderSuccesss];
        
        cell = imageCell;
        imageCell = nil;
      
        
    }else if (indexPath.section == 1){
        
        static NSString* strINTI = @"ContentCell";
        UITableViewCell* contentCell = [tableView dequeueReusableCellWithIdentifier:strINTI];
        
        if (!contentCell) {
            contentCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strINTI];
            contentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        for (UIView *subview in contentCell.contentView.subviews) {
            
            FLDDLogDebug(@"%@",subview);
            [subview removeFromSuperview];
          
            
        }
        
        UIImageView* cellImageView = [UIImageView circleImageViewFrame:CGRectMake(10, 10, 40,40) Radius:40/2];
        
        
        NSString* str = nil;
        if ([AppManager valueForKey:@"telephone"]!=nil) {
            str = [AppManager valueForKey:[AppManager valueForKey:@"telephone"]];
            NSLog(@"!@#%@",str);
        }
        if (str.length >0) {
            UIImage* imageLogo =[UIImage imageWithData:[AppManager readDataFromDocumentWithName:str]];
            if (imageLogo) {
               cellImageView.image =imageLogo;
            }else{
                 cellImageView.image = [UIImage imageNamed:@"business_default_photo_small"];
            }
            
        }else{
            cellImageView.image = [UIImage imageNamed:@"business_default_photo_small"];

        }
        


        
        
        //
//        [SelfUser mddyRequestWIthImageWithBrandID: [self.dictData valueForKey:@"brandIdUrl"] withBlock:^(UIImage * image, NSError *error) {
//            //         [SelfUser mddyRequestWIthImageWithBrandID: @"57" withBlock:^(UIImage * image, NSError *error) {
//            
//            if (!error) {
//                if (image == nil) {
//                    cellImageView.image = [UIImage imageNamed:@"business_default_photo_small"];
//                }
//                else {
//                    cellImageView.image =image;
//                    
//                    
//                }
//            }else {
//                cellImageView.image = [UIImage imageNamed:@"business_default_photo_small"];
//                
//            }
//            
//        }];
        [contentCell.contentView addSubview:cellImageView];
    
        
        
        NSInteger height;
        NSInteger wide;
        if (iPhone5 || iPhone4) {
            wide = -38;
            height = 2;
        }else {
            wide = 0;
            height = 0;
        }
        UILabel* labelTitel = [[UILabel alloc]init];
        //        labelTitel.text  =@"绝味鸭脖（天目山路店）wqeqwqewqeqw";
        //        labelTitel.text =@"他额外特阿塔";
        labelTitel.text = [self.dictData valueForKey:@"shopName"];
        labelTitel.font = UIFont(16);
        labelTitel.bounds = CGRectMake(0, 0,iPhone6? 230:160, 40);
        //         [labelTitel sizeToFit];
        labelTitel.center = CGPointMake(CGRectGetMaxX(cellImageView.frame)+6+labelTitel.bounds.size.width/2, CGRectGetMidY(cellImageView.frame)+height);
        [contentCell.contentView addSubview:labelTitel];

        
        UILabel* labelDanHao = [[UILabel alloc]init];
        //        labelDanHao.text = @"运单号:123456";
        labelDanHao.text = [NSString stringWithFormat:@"订单号:%@",[[self.dictData valueForKey:@"waybillCode"] toString]];
        [labelDanHao sizeToFit];
        labelDanHao.textColor = [UIColor darkGrayColor];
        labelDanHao.font =  UIFont(13);
        
     
        labelDanHao.center = CGPointMake((WINDOW_WIDTH-40)+(iphone6_6P_isYES?:2), CGRectGetMidY(cellImageView.frame)+2);
        [contentCell.contentView addSubview:labelDanHao];
        
        UIView* viewLine1 = [[UIView alloc]initWithFrame:CGRectMake(10, 52, WINDOW_WIDTH-20, 1)];
        viewLine1.backgroundColor = [UIColor lightGrayColor];
        viewLine1.alpha = 0.35;
        [contentCell.contentView addSubview:viewLine1];
        
        
        
        UILabel* labelJinE = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, iPhone6?69: iPhone6Plus?69: 59, 20)];
        labelJinE.text = @"订单金额:";
        
        labelJinE.font = UIFont(16);
        [contentCell.contentView addSubview:labelJinE];
        
        
        self.labelPrice = [[UILabel alloc]init];
        self.labelPrice.text = @"24.00元";
        self.labelPrice.text = [NSString stringWithFormat:@"%.2f元",[[self.dictData valueForKey:@"waybillPrice"]floatValue]/100];
        [self.labelPrice sizeToFit];
        self.labelPrice.font = UIFont(16);
        
        self.labelPrice.center =CGPointMake(CGRectGetMaxX(labelJinE.frame)+15+self.labelPrice.bounds.size.width/2, CGRectGetMidY(labelJinE.frame));
        
        [contentCell.contentView addSubview:self.labelPrice];
        
        
        if ([[[self.dictData valueForKey:@"isPaidAdvance"] toString] isEqualToString:@"1"]) {
            
            UILabel* labelOrange = [[UILabel alloc]init];
            labelOrange.text = @"(需垫付)";
            [labelOrange sizeToFit];
            labelOrange.font =  UIFont(16);
            labelOrange.textColor = UICOLOR(248, 78, 11, 1);
            labelOrange.center = CGPointMake(CGRectGetMaxX(self.labelPrice.frame)+6+labelOrange.bounds.size.width/2, CGRectGetMidY(self.labelPrice.frame));
            [contentCell.contentView addSubview:labelOrange];
        }
        
        NSInteger estimated = [[self.dictData objectForKey:@"estimated"] integerValue];
        
        
        UILabel* labelFaDan = [[UILabel alloc]init];
        if (estimated ==0) {
            labelFaDan.text = @"预估距离:";
        }
        else {

            labelFaDan.text = @"配送距离:";
        }
        labelFaDan.font =  UIFont(16);
        [labelFaDan sizeToFit];
        labelFaDan.center = CGPointMake(10+labelFaDan.bounds.size.width/2, CGRectGetMaxY(labelJinE.frame)+8+labelFaDan.bounds.size.height/2);
        [contentCell.contentView addSubview:labelFaDan];
        
        self.labelSend = [[UILabel alloc]init];
        //        self.labelSend.text = @"3KM";
        long lDistance = [[self.dictData valueForKey:@"walkingDistance"] integerValue];
        double dDistance = lDistance;
        if(lDistance >= 0)
        {
            _distance = lDistance;
            dDistance = lDistance;
            if(_distance >= 1000)
            {
                self.labelSend.text = [NSString stringWithFormat:@"%.2f公里",dDistance/1000];
            }
            else
            {
                self.labelSend.text = [NSString stringWithFormat:@"%ld米",(long)_distance];
            }
        }
        else if(_distance > 0)
        {
            dDistance = _distance;
            lDistance = _distance;
            if(_distance >= 1000)
            {
                self.labelSend.text = [NSString stringWithFormat:@"%.2f公里",dDistance/1000];
            }
            else
            {
                self.labelSend.text = [NSString stringWithFormat:@"%ld米",(long)_distance];
            }
        }
        else
        {
            _distance = lDistance;
            dDistance = lDistance;
            self.labelSend.text = @"--公里";
        }
        
        self.labelSend.font =  UIFont(16);
        [self.labelSend sizeToFit];
        self.labelSend.center = CGPointMake(CGRectGetMaxX(labelFaDan.frame)+15+self.labelSend.bounds.size.width/2, CGRectGetMidY(labelFaDan.frame));
        [contentCell.contentView addSubview:self.labelSend];
        
        
        UILabel* labelSuceessed = [[UILabel alloc]init];
        if (estimated == 0) {
            labelSuceessed.text = @"预估运费:";
        }
        else {
            if ([[[self.dictData valueForKey:@"quickType"] toString]isEqualToString:@"2"]) {
                          labelSuceessed.text = @"运       费:";
            }else{
            labelSuceessed.text = @"实际运费:";
            }
        
        }
        labelSuceessed.font =  UIFont(16);
        [labelSuceessed sizeToFit];
        labelSuceessed.center = CGPointMake(10+labelSuceessed.bounds.size.width/2, CGRectGetMaxY(labelFaDan.frame)+8+labelSuceessed.bounds.size.height/2);
        [contentCell.contentView addSubview:labelSuceessed];


        
         if (![[self.dictData valueForKey:@"consigneeTel"]  isEqualToString:@""])
//        if (2 == [[self.dictData valueForKey:@"quickType"] longValue])
        {
            //普通发单
            
//            if (1 == [[self.dictData valueForKey:@"quickType"] longValue])
            {
                UIButton* buttonDetail =[UIButton buttonWithType:UIButtonTypeCustom];
                buttonDetail.frame = CGRectMake(0, 0, 40 , 40);
                UIImage *image1 = [UIImage imageNamed:@"prompt_fare_card"];
                [buttonDetail setImage:image1 forState:UIControlStateNormal];
                [buttonDetail.imageView sizeToFit];
                [buttonDetail addTarget:self action:@selector(buttonDetail) forControlEvents:UIControlEventTouchUpInside];
                [buttonDetail setCenter:CGPointMake(WINDOW_WIDTH-18, labelSuceessed.center.y)];
                [contentCell addSubview:buttonDetail];
                
                
                long lEstimated = [[self.dictData valueForKey:@"estimated"] longValue];
                if(1 == lEstimated)
                {
                    self.buttonH5 = [[ButtonDetailH5 alloc]initWithFrame:CGRectMake(0, 0, 257, 44)];
                    self.buttonH5.center = CGPointMake(WINDOW_WIDTH-15-self.buttonH5.bounds.size.width/2, buttonDetail.center.y-25);
//                    float lDistance = [[self.dictData valueForKey:@"walkingDistance"] longValue];
//                    lDistance = lDistance/1000;
                    _fFreight = [[self.dictData valueForKey:@"freight"] longValue];
                    _fFreight = _fFreight/100;
                    if(_distance >= 1000)
                    {
                        dDistance = dDistance/1000;
                        self.buttonH5.labelBut.text = [NSString stringWithFormat:@"实际配送%.2f公里，应付运费%.2f元", dDistance, _fFreight];
                    }
                    else if(_distance >= 0)
                    {
                        self.buttonH5.labelBut.text = [NSString stringWithFormat:@"实际配送%ld米，应付运费%.2f元", (long)dDistance, _fFreight];
                    }
                    else
                    {
                        self.buttonH5.labelBut.text = [NSString stringWithFormat:@"实际配送--公里，应付运费%.2f元", _fFreight];
                    }
//                    self.buttonH5.labelBut.text = [NSString stringWithFormat:@"实际配送%.2f公里，应付运费%.2f元", lDistance, fFreight];
                }
                else
                {
                    self.buttonH5 = [[ButtonDetailH5 alloc]initWithFrame:CGRectMake(0, 0, 230, 44)];
                    self.buttonH5.center = CGPointMake(WINDOW_WIDTH-15-self.buttonH5.bounds.size.width/2, buttonDetail.center.y-25);
                    self.buttonH5.labelBut.text = @"具体运费最终由实际配送里程决定";
                    
                }
                self.buttonH5.hidden = YES;
                __weak __typeof(self)safeSelf = self;
                self.buttonH5.buttonPressed = ^(NSInteger tag){
                    //加载H5的位置
                    FeeWebViewController *feeWebViewController = [[FeeWebViewController alloc] init];
                    if(safeSelf.strWayBillld.length > 0)
                    {
                        feeWebViewController.waybillId = safeSelf.strWayBillld;
                        feeWebViewController.title = @"配送运费";
                        [safeSelf.navigationController pushViewController:feeWebViewController animated:YES];
                        safeSelf.buttonH5.hidden = YES;
                    }
                };
                [contentCell addSubview:self.buttonH5];
                
            }

            
            self.labelSuccessed = [[UILabel alloc]init];
            self.labelSuccessed.text = [NSString stringWithFormat:@"%.2f元",[[self.dictData valueForKey:@"freight"] floatValue]/100];
            self.labelSuccessed.font =  UIFont(16);
            [self.labelSuccessed sizeToFit];
            self.labelSuccessed.center = CGPointMake(CGRectGetMaxX(labelSuceessed.frame)+15+self.labelSuccessed.bounds.size.width/2, CGRectGetMidY(labelSuceessed.frame));
            [contentCell.contentView addSubview:self.labelSuccessed];
            
            if ([[self.dictData valueForKey:@"mdActivityName"] toString].length>0) {
                
          
            UILabel* labelActivity =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
            labelActivity.text = [self.dictData valueForKey:@"mdActivityName"];
                labelActivity.center = CGPointMake(CGRectGetMaxX(self.labelSuccessed.frame)+labelActivity.bounds.size.width/2, CGRectGetMidY(self.labelSuccessed.frame));
                labelActivity.textColor = UICOLOR(248, 78, 11, 1);
                labelActivity.font = UIFont(16);
                [contentCell.contentView addSubview:labelActivity];
            }
            
            UIView* viewLine2 =nil;
            
            if ([[[self.dictData valueForKey:@"content"]toString] isEqualToString:@""]) {
                viewLine2 = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(labelSuceessed.frame)+8, WINDOW_WIDTH-20, 01)];
            }else{
                
                
                
                UILabel* labelAddress = [[UILabel alloc]init];
                labelAddress.text = @"备       注:";
                labelAddress.font =  UIFont(16);
                [labelAddress sizeToFit];
                labelAddress.center = CGPointMake(10+labelAddress.bounds.size.width/2, CGRectGetMaxY(labelSuceessed.frame)+8+labelAddress.bounds.size.height/2);
                [contentCell.contentView addSubview:labelAddress];
                
                FLDDLogDebug(@"remark frame:%@", NSStringFromCGRect(labelAddress.frame));
                
                self.labelAddressed = [[UILabel alloc]init];
                //self.labelAddressed.text = @"热饮huhbuihuihoiuhiouhiouhiouhiouhioghuiyfgyug ，小心烫口，先喝第一口汤，在啃鸭脖，然后再喝第二口汤34热而温热温热温热温热热热热温热温热温热温热温热尔热我热我热污染别。";
                self.labelAddressed.text = [[self.dictData valueForKey:@"content"]toString];
                self.labelAddressed.font =  UIFont(16);
                //        [self.labelAddressed sizeToFit];
                self.labelAddressed.numberOfLines = MAXFLOAT;
                [self.labelAddressed setBackgroundColor: [UIColor clearColor]];
                //        self.labelAddressed.bounds = CGRectMake(0, 0, WINDOW_WIDTH-100, 45                                                                                                                                                                                 );
                //        self.labelAddressed.center = CGPointMake(CGRectGetMaxXNSLineBreakByWordWrapping(labelAddress.frame)+15+self.labelAddressed.bounds.size.width/2, CGRectGetMidY(labelAddress.frame)+10-height);
                //        [cell addSubview:self.labelAddressed];
                
                self.labelAddressed.lineBreakMode = NSLineBreakByWordWrapping;
                CGSize size1 = CGSizeMake(WINDOW_WIDTH-100,MAXFLOAT);
//                CGSize labelsize1 = [self.labelAddressed.text  sizeWithFont:self.labelAddressed.font constrainedToSize:size1 lineBreakMode:NSLineBreakByWordWrapping];
                CGRect rect = [self.labelAddressed.text boundingRectWithSize:size1 options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.labelAddressed.font,NSFontAttributeName, nil] context:nil];
                self.labelAddressed.frame = CGRectMake(CGRectGetMaxX(labelAddress.frame)+15,(iPhone6Plus?-2:0)+ CGRectGetMidY(labelAddress.frame)-2-6, rect.size.width, rect.size.height);
                
//                self.labelAddressed.frame = CGRectMake(CGRectGetMaxX(labelAddress.frame)+15, (iPhone6Plus?-2:0)+labelAddress.frame.origin.y, labelsize1.width, labelsize1.height);
                [contentCell.contentView addSubview:self.labelAddressed];
                viewLine2 = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelAddressed.frame)+8, WINDOW_WIDTH-20, 01)];
            }
            FLDDLogDebug(@"%f",CGRectGetMaxY(self.labelAddressed.frame));
            
            viewLine2.backgroundColor = [UIColor lightGrayColor];
            viewLine2.alpha = 0.35;
            [contentCell.contentView addSubview:viewLine2];
            
            UILabel* labelLanShou= [[UILabel alloc]init];
            labelLanShou.text = @"揽收时间:";
            labelLanShou.font =  UIFont(16);
            [labelLanShou sizeToFit];
            labelLanShou.center = CGPointMake(10+labelLanShou.bounds.size.width/2, CGRectGetMaxY(viewLine2.frame)+11+labelLanShou.bounds.size.height/2);
            [contentCell.contentView addSubview:labelLanShou];
            
            if (self.order_status == ORDER_STATUS_WAIT_QIANGDAN || self.order_status == ORDER_STATUS_WAIT_LANSHOU) {
                labelLanShou.frame =CGRectMake(10, CGRectGetMaxY(viewLine2.frame)+5, WINDOW_WIDTH-20, 01);
                labelLanShou.hidden = YES;
            }else{
                labelLanShou.hidden = NO;
                
            }
            
            
            self.labelLanShou = [[UILabel alloc]init];
            //        self.labelLanShou.text = @"2012-12-12 12:12";
            
//            self.labelLanShou.text = [CommonUtils getDateForStringTime:[self.dictData valueForKey:@"collectionTime"] withFormat:@"MM月dd日 HH:mm"];
            self.labelLanShou.text = [CommonUtils getDateForStringTime:[self.dictData valueForKey:@"collectionTime"] withFormat:@"HH:mm"];
            //        self.labelLanShou.text = [CommonUtils getDateForStringTime:[self.dictData valueForKey:@"collectionTime"]];
            self.labelLanShou.font =  UIFont(16);
            [self.labelLanShou sizeToFit];
            self.labelLanShou.center = CGPointMake(CGRectGetMaxX(labelLanShou.frame)+15+self.labelLanShou.bounds.size.width/2, CGRectGetMidY(labelLanShou.frame));
            [contentCell.contentView addSubview:self.labelLanShou];
            
            
            UILabel* labelWishShouHuo= [[UILabel alloc]init];
            labelWishShouHuo.text = @"送达时间:";
            labelWishShouHuo.font =  UIFont(16);
            [labelWishShouHuo sizeToFit];
            labelWishShouHuo.center = CGPointMake(10+labelWishShouHuo.bounds.size.width/2, CGRectGetMaxY(labelLanShou.frame)+8+labelWishShouHuo.bounds.size.height/2);
            
            [contentCell.contentView addSubview:labelWishShouHuo];
            
            self.labelWishShouHuo = [[UILabel alloc]init];
            self.labelWishShouHuo.text = @"2012-12-12 12:12";
            self.labelWishShouHuo.text =  [self.dictData valueForKey:@"needTimeRange"] ;
            
            //        self.labelWishShouHuo.text = [[self.dictData valueForKey:@"needTimeRange"]toString];
            //   self.labelWishShouHuo.text = [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"needTimeRange"]toString] withFormat:@"HH:mm"];
            
            NSInteger  tim;
            tim  =[[self.dictData valueForKey:@"needTimeRange"] intValue];
            
            
            self.labelWishShouHuo.font =  UIFont(16);
            [self.labelWishShouHuo sizeToFit];
            self.labelWishShouHuo.center = CGPointMake(CGRectGetMaxX(labelWishShouHuo.frame)+15+self.labelWishShouHuo.bounds.size.width/2, CGRectGetMidY(labelWishShouHuo.frame));
            [contentCell.contentView addSubview:self.labelWishShouHuo];
            
            
            UILabel* labelAddr= [[UILabel alloc]init];
            labelAddr.text = @"买       家:";
            labelAddr.font =  UIFont(16);
            [labelAddr sizeToFit];
            labelAddr.center = CGPointMake(10+labelAddr.bounds.size.width/2, CGRectGetMaxY(self.labelWishShouHuo.frame)+8+labelAddr.bounds.size.height/2);
            [contentCell.contentView addSubview:labelAddr];
            
            self.labelAddr = [[UILabel alloc]init];
            //        self.labelAddr.text = @"杭州市西湖区天目山路238号华鸿大厦A座302-董小姐";
            self.labelAddr.text = [[self.dictData valueForKey:@"consigneeAddress"]toString];
            self.labelAddr.font =  UIFont(16);
            self.labelAddr.numberOfLines = MAXFLOAT;
            self.labelAddr.lineBreakMode = NSLineBreakByWordWrapping;
            CGSize size = CGSizeMake(WINDOW_WIDTH-100, MAXFLOAT);
//            CGSize labelsize = [self.labelAddr.text  sizeWithFont:self.labelAddr.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
//            self.labelAddr.frame = CGRectMake(CGRectGetMaxX(labelAddr.frame)+15,(iPhone6Plus?-2:0)+ labelAddr.frame.origin.y, labelsize.width, labelsize.height);
            CGRect rect = [self.labelAddr.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.labelAddr.font,NSFontAttributeName, nil] context:nil];
            self.labelAddr.frame = CGRectMake(CGRectGetMaxX(labelAddr.frame)+15,(iPhone6Plus?-2:0)+ labelAddr.frame.origin.y, rect.size.width, rect.size.height);
            [contentCell.contentView addSubview:self.labelAddr];
            
            
            if (Have) {
                
       
            
            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.labelAddr.frame), CGRectGetMaxY(self.labelAddr.frame)+6, 24, 24)];
            imageView.image = [UIImage imageNamed:@"orderform_call_.png"];
            [contentCell.contentView addSubview:imageView];
            
            self.labelPhoneNumber = [[UILabel alloc]init];
            self.labelPhoneNumber.text = @"138 0057 0571";
            if ([[self.dictData valueForKey:@"consigneeTel"]toString].length == 11&& [[[self.dictData valueForKey:@"consigneeTel"] toString] rangeOfString:@"-"].length==0) {
                
                self.labelPhoneNumber.text = [CommonUtils changePhoneNumberWithNumber: [[self.dictData valueForKey:@"consigneeTel"]toString] withType:@" "];
            }else{
                self.labelPhoneNumber.text =  [[self.dictData valueForKey:@"consigneeTel"]toString] ;
            }
            self.labelPhoneNumber.font =  UIFont(16);
            [self.labelPhoneNumber sizeToFit];
//            [self.labelPhoneNumber setTextColor:UICOLOR(249, 102, 34, 1)];
            self.labelPhoneNumber.center = CGPointMake(CGRectGetMaxX(imageView.frame)+3+self.labelPhoneNumber.bounds.size.width/2, CGRectGetMidY(imageView.frame));
            [contentCell.contentView addSubview:self.labelPhoneNumber];
            
            }else{
                //            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.labelAddr.frame), CGRectGetMaxY(self.labelAddr.frame)+5, 24, 24)];
                //            imageView.image = [UIImage imageNamed:@"orderform_call_.png"];
                //            [contentCell.contentView addSubview:imageView];
                
                self.labelPhoneNumber = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.labelAddr.frame), CGRectGetMaxY(self.labelAddr.frame)+7, 0, 0)];
                self.labelPhoneNumber.text = @"138 0057 0571";
                if ([[self.dictData valueForKey:@"consigneeTel"]toString].length == 11&& [[[self.dictData valueForKey:@"consigneeTel"] toString] rangeOfString:@"-"].length==0) {
                    
                    self.labelPhoneNumber.text = [CommonUtils changePhoneNumberWithNumber: [[self.dictData valueForKey:@"consigneeTel"]toString] withType:@" "];
                }else{
                    self.labelPhoneNumber.text =  [[self.dictData valueForKey:@"consigneeTel"]toString] ;
                }
                self.labelPhoneNumber.font =  UIFont(16);
                [self.labelPhoneNumber sizeToFit];
                //            [self.labelPhoneNumber setTextColor:UICOLOR(249, 102, 34, 1)];
                //            self.labelPhoneNumber.center = CGPointMake(CGRectGetMaxX(imageView.frame)+3+self.labelPhoneNumber.bounds.size.width/2, CGRectGetMidY(imageView.frame));
                self.labelPhoneNumber.bounds =CGRectMake(0, 0, self.labelPhoneNumber.bounds.size.width, self.labelPhoneNumber.bounds.size.height);
                [contentCell.contentView addSubview:self.labelPhoneNumber];
                
                
                
                
                
                UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelPhoneNumber.frame), CGRectGetMaxY(self.labelAddr.frame)+2, 24, 24)];
                imageView.image = [UIImage imageNamed:@"orderform_call_.png"];
                [contentCell.contentView addSubview:imageView];
            }
            
            
            UIButton* buttonMaiJiaTEL = [UIButton buttonWithType:UIButtonTypeCustom] ;
            buttonMaiJiaTEL.frame = CGRectMake(0, 0, 190, 35);
            buttonMaiJiaTEL.center =self.labelPhoneNumber.center;
//            buttonMaiJiaTEL.backgroundColor = [UIColor redColor];
            [buttonMaiJiaTEL addTarget:self action:@selector(buttonMaiJiaTELPressed) forControlEvents:UIControlEventTouchUpInside];
            [contentCell.contentView addSubview:buttonMaiJiaTEL];
            
            


            
            
//            FLDDLogDebug(@"%@",[self.dictData valueForKey:@"status"]);
//            UILabel* labelPhoneNumber= [[UILabel alloc]init];
//            labelPhoneNumber.text = @"买家电话:";
//            labelPhoneNumber.font =  UIFont(16);
//            [labelPhoneNumber sizeToFit];
//            labelPhoneNumber.center = CGPointMake(10+labelPhoneNumber.bounds.size.width/2, CGRectGetMaxY(labelWishShouHuo.frame)+8+labelWishShouHuo.bounds.size.height/2);
//            [contentCell.contentView addSubview:labelPhoneNumber];
//            
//            self.labelPhoneNumber = [[UILabel alloc]init];
//            //        self.labelPhoneNumber.text = @"138 0057 0571";
//            if ([[self.dictData valueForKey:@"consigneeTel"]toString].length == 11&& [[[self.dictData valueForKey:@"consigneeTel"] toString] rangeOfString:@"-"].length==0) {
//                
//                self.labelPhoneNumber.text = [CommonUtils changePhoneNumberWithNumber: [[self.dictData valueForKey:@"consigneeTel"]toString] withType:@" "];
//            }else{
//                self.labelPhoneNumber.text =  [[self.dictData valueForKey:@"consigneeTel"]toString] ;
//            }
//            self.labelPhoneNumber.font =  UIFont(16);
//            [self.labelPhoneNumber sizeToFit];
//            self.labelPhoneNumber.center = CGPointMake(CGRectGetMaxX(labelPhoneNumber.frame)+15+self.labelPhoneNumber.bounds.size.width/2, CGRectGetMidY(labelPhoneNumber.frame));
//            [contentCell.contentView addSubview:self.labelPhoneNumber];
//            
//            
//            
//            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-50,CGRectGetMidY(self.labelPhoneNumber.frame)-15, 24, 24  )];
//            imageView.userInteractionEnabled = YES;
//            imageView.image = [UIImage imageNamed:@"orders_phone_n.png"];
//            
//            [contentCell.contentView addSubview:imageView];
//            
//            self.buttonMaiJiaTEL = [UIButton buttonWithType:UIButtonTypeCustom];
//            self.buttonMaiJiaTEL.frame = CGRectMake(WINDOW_WIDTH-200,CGRectGetMidY(self.labelPhoneNumber.frame)-15, 200, 35  );
//            [self.buttonMaiJiaTEL addTarget:self action:@selector(telMaiJia) forControlEvents:UIControlEventTouchUpInside];
//            [contentCell.contentView addSubview:self.buttonMaiJiaTEL];
//            
//            
//            
//            UILabel* labelAddr= [[UILabel alloc]init];
//            labelAddr.text = @"收货地址:";
//            labelAddr.font =  UIFont(16);
//            [labelAddr sizeToFit];
//            labelAddr.center = CGPointMake(10+labelAddr.bounds.size.width/2, CGRectGetMaxY(self.labelPhoneNumber.frame)+8+labelAddr.bounds.size.height/2);
//            [contentCell.contentView addSubview:labelAddr];
//            
//            self.labelAddr = [[UILabel alloc]init];
//            //        self.labelAddr.text = @"杭州市西湖区天目山路238号华鸿大厦A座302-董小姐";
//            self.labelAddr.text = [[self.dictData valueForKey:@"consigneeAddress"]toString];
//            self.labelAddr.font =  UIFont(16);
//            self.labelAddr.numberOfLines = MAXFLOAT;
//            self.labelAddr.lineBreakMode = NSLineBreakByWordWrapping;
//            CGSize size = CGSizeMake(WINDOW_WIDTH-100, MAXFLOAT);
//            CGSize labelsize = [self.labelAddr.text  sizeWithFont:self.labelAddr.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
//            
//            self.labelAddr.frame = CGRectMake(CGRectGetMaxX(labelAddr.frame)+15,(iPhone6Plus?-2:0)+ labelAddr.frame.origin.y, labelsize.width, labelsize.height);
//            [contentCell.contentView addSubview:self.labelAddr];
             cellImageView = nil;
        }else{//极速发单
            
          
            
//            UILabel* labelSuceessed = [[UILabel alloc]init];
//            labelSuceessed.text = @"运       费:";
//            labelSuceessed.font =  UIFont(16);
//            [labelSuceessed sizeToFit];
//            labelSuceessed.center = CGPointMake(10+labelSuceessed.bounds.size.width/2, CGRectGetMaxY(labelJinE.frame)+8+labelSuceessed.bounds.size.height/2);
//            [contentCell.contentView addSubview:labelSuceessed];
            
            self.labelSuccessed = [[UILabel alloc]init];
            self.labelSuccessed.text = [NSString stringWithFormat:@"%.2f元",[[self.dictData valueForKey:@"freight"] floatValue]/100];
            self.labelSuccessed.font =  UIFont(16);
            [self.labelSuccessed sizeToFit];
            self.labelSuccessed.center = CGPointMake(CGRectGetMaxX(labelSuceessed.frame)+15+self.labelSuccessed.bounds.size.width/2, CGRectGetMidY(labelSuceessed.frame));
            [contentCell.contentView addSubview:self.labelSuccessed];
            if ([[self.dictData valueForKey:@"mdActivityName"] toString].length>0) {
                
                
                UILabel* labelActivity =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
                labelActivity.text = [self.dictData valueForKey:@"mdActivityName"];
                labelActivity.center = CGPointMake(CGRectGetMaxX(self.labelSuccessed.frame)+labelActivity.bounds.size.width/2, CGRectGetMidY(self.labelSuccessed.frame));
                labelActivity.textColor = UICOLOR(248, 78, 11, 1);
                labelActivity.font = UIFont(16);
                [contentCell.contentView addSubview:labelActivity];
            }
            
            
            
            UIButton* buttonDetail =[UIButton buttonWithType:UIButtonTypeCustom];
            buttonDetail.frame = CGRectMake(0, 0, 40 , 40);
            UIImage *image1 = [UIImage imageNamed:@"prompt_fare_card"];
            [buttonDetail setImage:image1 forState:UIControlStateNormal];
            [buttonDetail.imageView sizeToFit];
            [buttonDetail addTarget:self action:@selector(buttonDetail) forControlEvents:UIControlEventTouchUpInside];
            [buttonDetail setCenter:CGPointMake(WINDOW_WIDTH-18, self.labelSuccessed.center.y)];
            [contentCell addSubview:buttonDetail];
            

            long lEstimated = [[self.dictData valueForKey:@"estimated"] longValue];
            if(1 == lEstimated)
            {
                self.buttonH5 = [[ButtonDetailH5 alloc]initWithFrame:CGRectMake(0, 0, 257, 44)];
                self.buttonH5.center = CGPointMake(WINDOW_WIDTH-15-self.buttonH5.bounds.size.width/2, buttonDetail.center.y-25);
//                float lDistance = [[self.dictData valueForKey:@"walkingDistance"] longValue];
                lDistance = lDistance/1000;
                _fFreight = [[self.dictData valueForKey:@"freight"] longValue];
                _fFreight = _fFreight/100;
                if(_distance >= 1000)
                {
                    lDistance = lDistance/1000;
                    self.buttonH5.labelBut.text = [NSString stringWithFormat:@"实际配送%.2f公里，应付运费%.2f元", dDistance, _fFreight];
                }
                else if(_distance >= 0)
                {
                    self.buttonH5.labelBut.text = [NSString stringWithFormat:@"实际配送%ld米，应付运费%.2f元", (long)dDistance, _fFreight];
                }
                else
                {
                    self.buttonH5.labelBut.text = [NSString stringWithFormat:@"实际配送--公里，应付运费%.2f元", _fFreight];
                }
//                self.buttonH5.labelBut.text = [NSString stringWithFormat:@"实际配送%.2f公里，应付运费%.2f元", lDistance, fFreight];
            }
            else
            {
                self.buttonH5 = [[ButtonDetailH5 alloc]initWithFrame:CGRectMake(0, 0, 230, 44)];
                self.buttonH5.center = CGPointMake(WINDOW_WIDTH-15-self.buttonH5.bounds.size.width/2, buttonDetail.center.y-25);
                self.buttonH5.labelBut.text = @"具体运费最终由实际配送里程决定";
                
            }
            self.buttonH5.hidden = YES;
              __weak __typeof(self)safeSelf = self;
            self.buttonH5.buttonPressed = ^(NSInteger tag){
                //加载H5的位置
                FeeWebViewController *feeWebViewController = [[FeeWebViewController alloc] init];
                if(safeSelf.strWayBillld.length > 0)
                {
                    feeWebViewController.waybillId = safeSelf.strWayBillld;
                    feeWebViewController.title = @"配送运费";
                    [safeSelf.navigationController pushViewController:feeWebViewController animated:YES];
                    safeSelf.buttonH5.hidden = YES;
                }
            };
            [contentCell addSubview:self.buttonH5];
            
            
            
            
            UIView* viewLine2 = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelSuccessed.frame)+8, WINDOW_WIDTH-20, 01)];
            viewLine2.backgroundColor = [UIColor lightGrayColor];
            viewLine2.alpha = 0.35;
            [contentCell.contentView addSubview:viewLine2];
            
            
            UILabel* labelLanShou= [[UILabel alloc]init];
            labelLanShou.text = @"揽收时间:";
            labelLanShou.font =  UIFont(16);
            [labelLanShou sizeToFit];
            labelLanShou.center = CGPointMake(10+labelLanShou.bounds.size.width/2, CGRectGetMaxY(viewLine2.frame)+11+labelLanShou.bounds.size.height/2);
            [contentCell.contentView addSubview:labelLanShou];
            
            if (self.order_status != ORDER_STATUS_WAIT_QIANSHOU ) {
                labelLanShou.frame =CGRectMake(10, CGRectGetMaxY(self.labelAddressed.frame)+5, WINDOW_WIDTH-20, 01);
                labelLanShou.hidden = YES;
            }else{
                labelLanShou.hidden = NO;
                
            }
            
            
            self.labelLanShou = [[UILabel alloc]init];
            //        self.labelLanShou.text = @"2012-12-12 12:12";
            self.labelLanShou.text  = [CommonUtils getDateForStringTime:[self.dictData valueForKey:@"collectionTime"] withFormat:@"HH:mm"];
            
            //            self.labelLanShou.text = [CommonUtils getDateForStringTime:[self.dictData valueForKey:@"collectionTime"]];
            self.labelLanShou.font =  UIFont(16);
            [self.labelLanShou sizeToFit];
            self.labelLanShou.center = CGPointMake(CGRectGetMaxX(labelLanShou.frame)+15+self.labelLanShou.bounds.size.width/2, CGRectGetMidY(labelLanShou.frame));
            [contentCell.contentView addSubview:self.labelLanShou];
            
            
            UILabel* labelWishShouHuo= [[UILabel alloc]init];
            labelWishShouHuo.text = @"送达时间:";
            labelWishShouHuo.font =  UIFont(16);
            [labelWishShouHuo sizeToFit];
//                FLDDLogDebug(@"%d",self.status);
            if (self.order_status == ORDER_STATUS_WAIT_QIANSHOU ) {
                labelWishShouHuo.center = CGPointMake(10+labelWishShouHuo.bounds.size.width/2, CGRectGetMaxY(self.labelLanShou.frame)+8+labelWishShouHuo.bounds.size.height/2);
                
            }else{
                labelWishShouHuo.center = CGPointMake(10+labelWishShouHuo.bounds.size.width/2, CGRectGetMaxY(viewLine2.frame)+8+labelWishShouHuo.bounds.size.height/2);
            }
            [contentCell.contentView addSubview:labelWishShouHuo];
            
            self.labelWishShouHuo = [[UILabel alloc]init];
            self.labelWishShouHuo.text = @"2012-12-12 12:12";
            FLDDLogDebug(@"%@",[[self.dictData valueForKey:@"needTimeRange"]toString]);
            self.labelWishShouHuo.text = [[self.dictData valueForKey:@"needTimeRange"]toString];
            //             self.labelWishShouHuo.text  = [CommonUtils getDateForStringTime:[self.dictData valueForKey:@"needTimeRange"] withFormat:@"MM月dd日 HH:mm"];
            //   self.labelWishShouHuo.text = [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"needTimeRange"]toString] withFormat:@"HH:mm"];
            
            NSInteger  tim;
            tim  =[[self.dictData valueForKey:@"needTimeRange"] intValue];
            
            
            self.labelWishShouHuo.font =  UIFont(16);
            [self.labelWishShouHuo sizeToFit];
            self.labelWishShouHuo.center = CGPointMake(CGRectGetMaxX(labelWishShouHuo.frame)+15+self.labelWishShouHuo.bounds.size.width/2, CGRectGetMidY(labelWishShouHuo.frame));
            [contentCell.contentView addSubview:self.labelWishShouHuo];
            
            
            
            UILabel* labelAddr= [[UILabel alloc]init];
            labelAddr.text = @"买       家:";
            labelAddr.font =  UIFont(16);
            [labelAddr sizeToFit];
            labelAddr.center = CGPointMake(10+labelAddr.bounds.size.width/2, CGRectGetMaxY(self.labelWishShouHuo.frame)+8+labelAddr.bounds.size.height/2);
            [contentCell.contentView addSubview:labelAddr];
            
            
                     if (self.order_status == ORDER_STATUS_WAIT_QIANGDAN ||[[self.dictData valueForKey:@"consigneeTel"]toString].length<3) {
                         
                         self.labelPhoneNumber = [[UILabel alloc]init];
                         //        self.labelAddr.text = @"杭州市西湖区天目山路238号华鸿大厦A座302-董小姐";
                         self.labelPhoneNumber.text = [[self.dictData valueForKey:@"consigneeAddress"]toString];
                         self.labelPhoneNumber.font =  UIFont(16);
                         self.labelPhoneNumber.numberOfLines = MAXFLOAT;
                         self.labelPhoneNumber.lineBreakMode = NSLineBreakByWordWrapping;
                         CGSize size = CGSizeMake(WINDOW_WIDTH-100, MAXFLOAT);
//                         CGSize labelsize = [self.labelPhoneNumber.text  sizeWithFont:self.labelPhoneNumber.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
//                         self.self.labelPhoneNumber.frame = CGRectMake(CGRectGetMaxX(labelAddr.frame)+15,(iPhone6Plus?-2:0)+ labelAddr.frame.origin.y, labelsize.width, labelsize.height);
                         CGRect rect = [self.labelPhoneNumber.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:   [NSDictionary dictionaryWithObjectsAndKeys:self.labelPhoneNumber.font,NSFontAttributeName, nil] context:nil];
//                         [NSDictionary dictionaryWithObjectsAndKeys:policyButton.titleLabel.font,NSFontAttributeName, nil]
                         self.labelPhoneNumber.frame = CGRectMake(CGRectGetMaxX(labelAddr.frame)+15,(iPhone6Plus?-2:0)+ labelAddr.frame.origin.y, rect.size.width, rect.size.height);
                         [contentCell.contentView addSubview:self.labelPhoneNumber];

                     }else{
                         
                         
                         
                     }

            
//            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.labelAddr.frame), CGRectGetMinY(self.labelAddr.frame)+22, 24, 24)];
//            imageView.image = [UIImage imageNamed:@"orderform_call_.png"];
//            [contentCell.contentView addSubview:imageView];
//            
//            self.labelPhoneNumber = [[UILabel alloc]init];
//            self.labelPhoneNumber.text = @"138 0057 0571";
//            if ([[self.dictData valueForKey:@"consigneeTel"]toString].length == 11&& [[[self.dictData valueForKey:@"consigneeTel"] toString] rangeOfString:@"-"].length==0) {
//                
//                self.labelPhoneNumber.text = [CommonUtils changePhoneNumberWithNumber: [[self.dictData valueForKey:@"consigneeTel"]toString] withType:@" "];
//            }else{
//                self.labelPhoneNumber.text =  [[self.dictData valueForKey:@"consigneeTel"]toString] ;
//            }
//            self.labelPhoneNumber.font =  UIFont(16);
//            [self.labelPhoneNumber sizeToFit];
//            [self.labelPhoneNumber setTextColor:UICOLOR(131, 185, 68, 1)];
//            self.labelPhoneNumber.center = CGPointMake(CGRectGetMaxX(imageView.frame)+3+self.labelPhoneNumber.bounds.size.width/2, CGRectGetMidY(imageView.frame));
//            [contentCell.contentView addSubview:self.labelPhoneNumber];
//            
//            
//            UIButton* buttonMaiJiaTEL = [UIButton buttonWithType:UIButtonTypeCustom] ;
//            buttonMaiJiaTEL.frame = CGRectMake(0, 0, 150, 35);
//            buttonMaiJiaTEL.center =self.labelPhoneNumber.center;
//            //            buttonMaiJiaTEL.backgroundColor = [UIColor redColor];
//            [buttonMaiJiaTEL addTarget:self action:@selector(buttonMaiJiaTEL) forControlEvents:UIControlEventTouchUpInside];
//            [contentCell.contentView addSubview:buttonMaiJiaTEL];

            
            
            
            
            
            
            
            
            
            
            
//            UILabel* labelAddr= [[UILabel alloc]init];
//            labelAddr.text = @"收货地址:";
//            labelAddr.font =  UIFont(16);
//            [labelAddr sizeToFit];
//            
//            FLDDLogDebug(@"%d",self.status);
//            if (self.order_status == ORDER_STATUS_WAIT_QIANGDAN ||[[self.dictData valueForKey:@"consigneeTel"]toString].length<3) {
//             labelAddr.center = CGPointMake(10+labelAddr.bounds.size.width/2, CGRectGetMaxY(self.labelWishShouHuo.frame)+8+labelAddr.bounds.size.height/2);
//            }else{
//                            UILabel* labelPhoneNumber= [[UILabel alloc]init];
//                            labelPhoneNumber.text = @"买家电话:";
//                            labelPhoneNumber.font =  UIFont(16);
//                            [labelPhoneNumber sizeToFit];
//                            labelPhoneNumber.center = CGPointMake(10+labelPhoneNumber.bounds.size.width/2, CGRectGetMaxY(labelWishShouHuo.frame)+8+labelWishShouHuo.bounds.size.height/2-2);
//                            [contentCell.contentView addSubview:labelPhoneNumber];
//                
//                            self.labelPhoneNumber = [[UILabel alloc]init];
//                            //        self.labelPhoneNumber.text = @"138 0057 0571";
//                            if ([[self.dictData valueForKey:@"consigneeTel"]toString].length == 11&& [[[self.dictData valueForKey:@"consigneeTel"] toString] rangeOfString:@"-"].length==0) {
//                
//                                self.labelPhoneNumber.text = [CommonUtils changePhoneNumberWithNumber: [[self.dictData valueForKey:@"consigneeTel"]toString] withType:@" "];
//                            }else{
//                                self.labelPhoneNumber.text =  [[self.dictData valueForKey:@"consigneeTel"]toString] ;
//                            }
//                            self.labelPhoneNumber.font =  UIFont(16);
//                            [self.labelPhoneNumber sizeToFit];
//                            self.labelPhoneNumber.center = CGPointMake(CGRectGetMaxX(labelPhoneNumber.frame)+15+self.labelPhoneNumber.bounds.size.width/2, CGRectGetMidY(labelPhoneNumber.frame));
//                            [contentCell.contentView addSubview:self.labelPhoneNumber];
//                
//               
//                
//                            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-50,CGRectGetMidY(self.labelWishShouHuo.frame)-15, 24, 24  )];
//                            imageView.userInteractionEnabled = YES;
//                            imageView.image = [UIImage imageNamed:@"orders_phone_n.png"];
//                
//                            [contentCell.contentView addSubview:imageView];
//                
//                            self.buttonMaiJiaTEL = [UIButton buttonWithType:UIButtonTypeCustom];
//                            self.buttonMaiJiaTEL.frame = CGRectMake(WINDOW_WIDTH-200,CGRectGetMidY(self.labelPhoneNumber.frame)-15, 200, 35  );
//                            [self.buttonMaiJiaTEL addTarget:self action:@selector(telMaiJia) forControlEvents:UIControlEventTouchUpInside];
//                            [contentCell.contentView addSubview:self.buttonMaiJiaTEL];
//                
//                 labelAddr.center = CGPointMake(10+labelAddr.bounds.size.width/2, CGRectGetMaxY(self.labelPhoneNumber.frame)+8+labelAddr.bounds.size.height/2+5);
//            }
//            
//
//            
//          
//            
//        
//           
//            [contentCell.contentView addSubview:labelAddr];
//            
//            self.labelAddr = [[UILabel alloc]init];
//            //        self.labelAddr.text = @"杭州市西湖区天目山路238号华鸿大厦A座302-董小姐";
//            self.labelAddr.text = [[self.dictData valueForKey:@"consigneeAddress"]toString];
//            self.labelAddr.font =  UIFont(16);
//            self.labelAddr.numberOfLines = MAXFLOAT;
//            self.labelAddr.lineBreakMode = NSLineBreakByWordWrapping;
//            CGSize size = CGSizeMake(WINDOW_WIDTH-100, MAXFLOAT);
//            CGSize labelsize = [self.labelAddr.text  sizeWithFont:self.labelAddr.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
//            
//            
//            self.labelAddr.frame = CGRectMake(CGRectGetMaxX(labelAddr.frame)+15, (iPhone6Plus?-2:0)+labelAddr.frame.origin.y, labelsize.width, labelsize.height);
//            [contentCell.contentView addSubview:self.labelAddr];
            
      
        }
        
        
        
        
        
        
        
        UIButton* buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonCancel addTarget:self action:@selector(buttonPressedCancel) forControlEvents:UIControlEventTouchUpInside];
        [buttonCancel setTitle:@"取消订单" forState:UIControlStateNormal];
        float red = 252/255.0;
        float green = 102/255.0;
        float blue = 5/255.0;
        [buttonCancel setBackgroundColor: [UIColor colorWithRed:red green:green blue:blue alpha:1.0]];
        buttonCancel.layer.cornerRadius = 3;
        buttonCancel.frame = CGRectMake(16, WINDOW_HEIGHT -64-49-10, WINDOW_WIDTH-32, 44);
        [self.view addSubview:buttonCancel];
        
        if (self.order_status == ORDER_STATUS_WAIT_QIANGDAN || self.order_status == ORDER_STATUS_WAIT_LANSHOU) {
            
            buttonCancel.hidden = NO;
        }else{
            buttonCancel.hidden = YES;
            
        }
        
        if (self.order_status == ORDER_STATUS_WAIT_LANSHOU || self.order_status == ORDER_STATUS_WAIT_QIANSHOU) {
            
            
            
            UIView* viewLin = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelPhoneNumber.frame)+12, WINDOW_WIDTH-20, 01)];
            viewLin.backgroundColor = [UIColor lightGrayColor];
            viewLin.alpha = 0.35;
            [contentCell.contentView addSubview:viewLin];
            
            
            self.buttonTEL = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.buttonTEL setTitle:[NSString stringWithFormat:@"配  送  员:   "] forState:UIControlStateNormal];
            _buttonTEL.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [self.buttonTEL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.buttonTEL.titleLabel.font = UIFont(16);
//            [self.buttonTEL addTarget:self action:@selector(tel) forControlEvents:UIControlEventTouchUpInside];
            self.buttonTEL.frame = CGRectMake(10, CGRectGetMaxY(self.labelPhoneNumber.frame)+10, WINDOW_WIDTH, 40);
            [contentCell.contentView addSubview:self.buttonTEL];
            
            
            UILabel* labelCourierName = [[UILabel alloc]init];
            labelCourierName.text = [[self.dictData valueForKey:@"courierName"] toString];
            labelCourierName.textColor =UICOLOR(249, 102, 34, 1);
            labelCourierName.font = UIFont(16);
            [labelCourierName sizeToFit];
            labelCourierName.center = CGPointMake(CGRectGetMaxX(labelJinE.frame)+15+labelCourierName.bounds.size.width/2, CGRectGetMidY(self.buttonTEL.frame));
            [contentCell addSubview:labelCourierName];
            
            if ([[self.dictData valueForKey:@"courierRankIconUrl"] toString].length>1) {
                
            UIImageView* imageView = [[ UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labelCourierName.frame)+2, CGRectGetMaxY(self.labelPhoneNumber.frame)+8+14, 15, 15)];
//            imageView.image = [UIImage imageNamed:@"grade_card_v2"];
            
            [SelfUser mddyRequestWIthImageWithWayQuickTypeIconUrl:[[self.dictData valueForKey:@"courierRankIconUrl"] toString] withMothed:@"downloadShopGroupICon.htm" withBlock:^(UIImage *image, NSError *error) {
                
                //                if (image) {
                
                imageView.image = image;
                imageView.bounds = CGRectMake(0, 0, 15, 15);
                imageView.contentMode = UIViewContentModeScaleToFill;
                //                }
                
                
            }];

            [contentCell addSubview:imageView];
              }
            UIButton* buttonCourierName =[UIButton buttonWithType:UIButtonTypeCustom];
            buttonCourierName.frame = CGRectMake(0,CGRectGetMaxY(self.labelPhoneNumber.frame)+12, WINDOW_WIDTH-100, 40);
            [buttonCourierName addTarget:self action:@selector(buttonCourier) forControlEvents:UIControlEventTouchUpInside];
            [contentCell addSubview:buttonCourierName];
          
//            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-50,CGRectGetMidY(self.buttonTEL.frame)-15, 24, 24  )];
//            
//            imageView.image = [UIImage imageNamed:@"orders_phone_n.png"];
//            
//            [contentCell.contentView addSubview:imageView];
            
            UIImageView* imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-85-3+(iPhone6Plus?-7:0), CGRectGetMidY(self.buttonTEL.frame)-8, 16, 16)];
            imageView1.image = [UIImage imageNamed:@"map_card.png"];
            [contentCell.contentView addSubview:imageView1];
            
            
            
            UILabel* labelLocation = [[UILabel alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-70-3+(iPhone6Plus?-7:0), CGRectGetMidY(self.buttonTEL.frame)-16, 70 , 32)] ;
            labelLocation.text = @"查看位置";
            labelLocation.font = UIFont(16);
            labelLocation.textColor =UICOLOR(249, 102, 34, 1);
            [contentCell.contentView addSubview:labelLocation];
            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = labelLocation.frame;
               [button addTarget:self action:@selector(tel) forControlEvents:UIControlEventTouchUpInside];
            [contentCell.contentView addSubview:button];
            
                                   
            if (Have) {
                
        
            
            
            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake((iPhone6?69: iPhone6Plus?69: 59)+25, CGRectGetMinY(self.buttonTEL.frame)+35, 24, 24)];
            imageView.image = [UIImage imageNamed:@"orderform_call_.png"];
            [contentCell.contentView addSubview:imageView];
            
            self.labelPhoneNumber = [[UILabel alloc]init];
            self.labelPhoneNumber.text = @"138 0057 0571";
            if ([[self.dictData valueForKey:@"consigneeTel"]toString].length == 11&& [[[self.dictData valueForKey:@"courierTel"] toString] rangeOfString:@"-"].length==0) {
                
                self.labelPhoneNumber.text = [CommonUtils changePhoneNumberWithNumber: [[self.dictData valueForKey:@"courierTel"]toString] withType:@" "];
            }else{
                self.labelPhoneNumber.text =  [[self.dictData valueForKey:@"courierTel"]toString] ;
            }
            self.labelPhoneNumber.font =  UIFont(16);
            [self.labelPhoneNumber sizeToFit];
//            [self.labelPhoneNumber setTextColor:UICOLOR(249, 102, 34, 1)];
            self.labelPhoneNumber.center = CGPointMake(CGRectGetMaxX(imageView.frame)+3+self.labelPhoneNumber.bounds.size.width/2, CGRectGetMidY(imageView.frame));
            [contentCell.contentView addSubview:self.labelPhoneNumber];
            
  }else{
            
//                        UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.labelAddr.frame), CGRectGetMaxY(self.labelAddr.frame)+5, 24, 24)];
//                        imageView.image = [UIImage imageNamed:@"orderform_call_.png"];
//                        [contentCell.contentView addSubview:imageView];
          
            self.labelPhoneNumber = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.labelWishShouHuo.frame), CGRectGetMaxY(labelLocation.frame), 0, 0)];
            self.labelPhoneNumber.text = @"138 0057 0571";
            if ([[self.dictData valueForKey:@"courierTel"]toString].length == 11&& [[[self.dictData valueForKey:@"courierTel"] toString] rangeOfString:@"-"].length==0) {
                
                self.labelPhoneNumber.text = [CommonUtils changePhoneNumberWithNumber: [[self.dictData valueForKey:@"courierTel"]toString] withType:@" "];
            }else{
                self.labelPhoneNumber.text =  [[self.dictData valueForKey:@"courierTel"]toString] ;
            }
            self.labelPhoneNumber.font =  UIFont(16);
            [self.labelPhoneNumber sizeToFit];
            //            [self.labelPhoneNumber setTextColor:UICOLOR(249, 102, 34, 1)];
            //            self.labelPhoneNumber.center = CGPointMake(CGRectGetMaxX(imageView.frame)+3+self.labelPhoneNumber.bounds.size.width/2, CGRectGetMidY(imageView.frame));
            self.labelPhoneNumber.bounds =CGRectMake(0, 0, self.labelPhoneNumber.bounds.size.width, self.labelPhoneNumber.bounds.size.height);
            [contentCell.contentView addSubview:self.labelPhoneNumber];
            }
            
            UIImageView* imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelPhoneNumber.frame), CGRectGetMaxY(labelLocation.frame)-5, 24, 24)];
            imageView2.image = [UIImage imageNamed:@"orderform_call_.png"];
            [contentCell.contentView addSubview:imageView2];
            
            
            UIButton* buttonPeiSongYuanTEL = [UIButton buttonWithType:UIButtonTypeCustom] ;
            buttonPeiSongYuanTEL.frame = CGRectMake(0, 0, 190, 35);
            buttonPeiSongYuanTEL.center =self.labelPhoneNumber.center;
            //            buttonMaiJiaTEL.backgroundColor = [UIColor redColor];
            [buttonPeiSongYuanTEL addTarget:self action:@selector(buttonPeiSongYuanTEL) forControlEvents:UIControlEventTouchUpInside];
            [contentCell.contentView addSubview:buttonPeiSongYuanTEL];
        }
       
        cell = contentCell;
        contentCell = nil;
        
    }
    
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    self.buttonH5.hidden = YES;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section== 0) {
        return 88;
    }
    return 500;
}
-(UIImage*)getImage{
    if (self.order_status == ORDER_STATUS_WAIT_QIANGDAN) {
        return [UIImage imageNamed:@"grab_status.png"];
    }else if(self.order_status == ORDER_STATUS_WAIT_LANSHOU){
        return [UIImage imageNamed:@"pick_status.png"];
    }else{
        return [UIImage imageNamed:@"receipt_status.png"];
    }
}
-(NSString*)getLabelOrabetText
{
    if (self.order_status == ORDER_STATUS_WAIT_QIANGDAN) {
        return @"需垫付";
    }else if(self.order_status == ORDER_STATUS_WAIT_LANSHOU){
        return @"需垫付";
    }else{
        return @"配送员已垫付";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
} 
-(void)back{
    [self.tableView removeFromSuperview];
    self.tableView = nil;
    self.dictData = nil;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)buttonPressedCancel{
//    FLDDLogDebug(@"!!~~~%@",[self.dictData valueForKey:@"status"]);
//    FLDDLogDebug(@"!!~~~%@",[self.dictData valueForKey:@"shopName"]);
    
    self.buttonH5.hidden = YES;
    
    if(IOS_VERSION_LARGE_OR_EQUAL(8)){
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"取消原因" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction*rea1Action = [UIAlertAction actionWithTitle:@"买家取消订单"style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
//            [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeBlack];
            
            [SelfUser mddyRequestWithMethodName:@"cancelWaybillDetailJsonPhone.htm" withParams:@{@"cmdCode" : g_cancelWaybillDetailCmd, @"waybillId":self.strWayBillld,@"killedReasonId":@"1"} withBlock:^(id responseObject, NSError *error) {
//                [SVProgressHUD dismiss ];
                [SelfUser hudHideWithViewcontroller:self];
//                [MBProgressHUD hudHideWithViewcontroller:self];
                
                if (!error) {
                    @try {
                        FLDDLogDebug(@"%@",responseObject);
                        
                    }
                    @catch (NSException *exception) {
                        
                    }
                    @finally {
                        
                    }
                    
//                    [SVProgressHUD showSuccessWithStatus:@"取消成功"];
                    [MBProgressHUD hudShowWithStatus:self :@"取消成功"];
                    [self performSelector:@selector(hid) withObject:self afterDelay:1.2];
                }else{
//                    [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
                    [MBProgressHUD hudShowWithStatus:self :[SelfUser currentSelfUser].ErrorMessage];
                }
                
            }];
            
            
        }];
        
        UIAlertAction*rea2Action = [UIAlertAction actionWithTitle:@"门店自己配送"style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
//            [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeBlack];
                [SelfUser hudShowWithViewcontroller:self];
            
            [SelfUser mddyRequestWithMethodName:@"cancelWaybillDetailJsonPhone.htm" withParams:@{@"cmdCode" : g_cancelWaybillDetailCmd, @"waybillId":self.strWayBillld,@"killedReasonId":@"2"} withBlock:^(id responseObject, NSError *error) {
//                [SVProgressHUD dismiss ];
                [SelfUser hudHideWithViewcontroller:self];
//                [MBProgressHUD hudHideWithViewcontroller:self];
                
                if (!error) {
                    @try {
                        FLDDLogDebug(@"%@",responseObject);
                        
                    }
                    @catch (NSException *exception) {
                        
                    }
                    @finally {
                        
                    }
                    
//                    [SVProgressHUD showSuccessWithStatus:@"取消成功"];
                    [MBProgressHUD hudShowWithStatus:self :@"取消成功"];
                    [self performSelector:@selector(hid) withObject:self afterDelay:1.2];
                }else{
//                    [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
                    [MBProgressHUD hudShowWithStatus:self :[SelfUser currentSelfUser].ErrorMessage];
                }
                
            }];
            
        }];
        
        
        
        UIAlertAction*rea3Action = [UIAlertAction actionWithTitle:@"配送员揽收不及时"style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {
            
//            [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeBlack];
                  [SelfUser hudShowWithViewcontroller:self];
            
            [SelfUser mddyRequestWithMethodName:@"cancelWaybillDetailJsonPhone.htm" withParams:@{@"cmdCode" : g_cancelWaybillDetailCmd, @"waybillId":self.strWayBillld,@"killedReasonId":@"3"} withBlock:^(id responseObject, NSError *error) {
//                [SVProgressHUD dismiss ];
//                [SelfUser hudHideWithViewcontroller:self];
                [SelfUser hudHideWithViewcontroller:self];
                
                if (!error) {
                    @try {
                        FLDDLogDebug(@"%@",responseObject);
                        
                    }
                    @catch (NSException *exception) {
                        
                    }
                    @finally {
                        
                    }
                    
                    [MBProgressHUD hudShowWithStatus:self :@"取消成功"];
                    [self performSelector:@selector(hid) withObject:self afterDelay:1.2];
                }else{
//                    [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
                    [MBProgressHUD hudShowWithStatus:self :[SelfUser currentSelfUser].ErrorMessage];
                }
                
            }];
            
        }];
        
        UIAlertAction*rea5Action = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction*action) {
            
            
            
        }];
        
        
        [alertController addAction:rea1Action];
        [alertController addAction:rea2Action];
        if (self.order_status == ORDER_STATUS_WAIT_QIANGDAN) {
            
        }else{
            [alertController addAction:rea3Action];
        }
        [alertController addAction:rea5Action];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        if (self.order_status == ORDER_STATUS_WAIT_QIANGDAN) {
            UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择取消原因" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"买家取消订单",@"门店自己配送", nil];
            [actionSheet showInView:self.view];
        }else{
            UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择取消原因" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"买家取消订单",@"门店自己配送",@"配送员揽收不及时", nil];
            [actionSheet showInView:self.view];
        }
        
    }
    //UIActionSheet
    
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    self.buttonH5.hidden = YES;
    
//    FLDDLogDebug(@"%ld",buttonIndex);
    NSString* strRes =nil;
    if(buttonIndex==0 || buttonIndex == 1||buttonIndex==2){
        if (buttonIndex==0) {
            strRes = @"1";
        }else if(buttonIndex==1){
            strRes = @"2";
        }else{
            if (self.order_status == ORDER_STATUS_WAIT_QIANGDAN) {
                return;
            }
            strRes = @"3";
        }
        
//        [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeBlack];
              [SelfUser hudShowWithViewcontroller:self];
        
        [SelfUser mddyRequestWithMethodName:@"cancelWaybillDetailJsonPhone.htm" withParams:@{@"cmdCode" : g_cancelWaybillDetailCmd, @"waybillId":self.strWayBillld,@"killedReasonId":strRes} withBlock:^(id responseObject, NSError *error) {
//            [SVProgressHUD dismiss ];
            [SelfUser hudHideWithViewcontroller:self];
            
            if (!error) {
                @try {
                    FLDDLogDebug(@"%@",responseObject);
                    
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
        
//                [SVProgressHUD showSuccessWithStatus:@"取消成功"];
                [MBProgressHUD hudShowWithStatus:self :@"取消成功"];
                [self performSelector:@selector(hid) withObject:self afterDelay:1.2];
             
            }else{
                  [SelfUser hudHideWithViewcontroller:self];
//                [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
                [MBProgressHUD hudShowWithStatus:self :[SelfUser currentSelfUser].ErrorMessage];
            }
            
        }];
    }
    
    
    
}
-(void)hid{
    [self.tableView removeFromSuperview];
    self.tableView = nil;
     [self.navigationController popViewControllerAnimated:YES];  
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        FLDDLogDebug(@"%@",self.strTEL);
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.strTEL]];
        
        [[UIApplication sharedApplication] openURL:url];
    }
    
}
-(void)tel{


    self.buttonH5.hidden = YES;
    
    MapViewController* map = [[MapViewController alloc]initWithNibName:nil bundle:nil];
    map.waybillId = self.strWayBillld;
    if (self.order_status==ORDER_STATUS_WAIT_LANSHOU) {
          map.isWaitLanShou = YES;
    }
  
    [self.navigationController pushViewController:map animated:YES];
    map = nil;
}
-(void)telMaiJia{
    self.buttonH5.hidden = YES;
    
    NSString *telUrl = @"";
    if ([[self.dictData valueForKey:@"consigneeTel"]toString].length == 11&& [[[self.dictData valueForKey:@"consigneeTel"] toString] rangeOfString:@"-"].length==0) {
        telUrl = [NSString stringWithFormat:@"%@",[[self.dictData valueForKey:@"consigneeTel"]toString]];
        if ([telUrl rangeOfString:@" "].length>0) {
            telUrl = [telUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
    }else{
        telUrl = [[self.dictData valueForKey:@"consigneeTel"]toString];
         NSString* strQuhao = nil;
        if ([telUrl rangeOfString:@"-"].length>0) {
            if ([telUrl rangeOfString:@"-"].location<7) {
                  strQuhao = [telUrl substringToIndex:[telUrl rangeOfString:@"-"].location];
                telUrl =  [telUrl substringFromIndex:[telUrl rangeOfString:@"-"].location+1];
            }}
        FLDDLogDebug(@"%@",telUrl);
        if ([telUrl rangeOfString:@"-"].length>0) {
              telUrl = [strQuhao stringByAppendingString:[telUrl substringToIndex:[telUrl rangeOfString:@"-"].location]];
        }
        if ([telUrl rangeOfString:@" "].length>0) {
            telUrl = [telUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        
        
    }
    self.strTEL = telUrl;
    UIAlertView* alert  =[[UIAlertView alloc]initWithTitle:@"  确认拨打买家电话？" message:telUrl delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
    alert.tag = 100;
    [alert show];
    
    
}
-(IBAction)buttonMaiJiaTELPressed{
    self.buttonH5.hidden = YES;
    FLDDLogDebug(@"%@",[self.dictData valueForKey:@"consigneeTel"]);
    NSString *telUrl = @"";
    if ([[self.dictData valueForKey:@"consigneeTel"]toString].length == 11&& [[[self.dictData valueForKey:@"consigneeTel"] toString] rangeOfString:@"-"].length==0) {
        telUrl = [NSString stringWithFormat:@"%@",[[self.dictData valueForKey:@"consigneeTel"]toString]];
        if ([telUrl rangeOfString:@" "].length>0) {
            telUrl = [telUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
    }else{
        telUrl = [[self.dictData valueForKey:@"consigneeTel"]toString];
        NSString* strQuhao = nil;
        if ([telUrl rangeOfString:@"-"].length>0) {
            
            if ([telUrl rangeOfString:@"-"].location<7) {
                strQuhao = [telUrl substringToIndex:[telUrl rangeOfString:@"-"].location];
                telUrl =  [telUrl substringFromIndex:[telUrl rangeOfString:@"-"].location+1];
            }
        }
        FLDDLogDebug(@"%@",telUrl);
        if ([telUrl rangeOfString:@"-"].length>0) {
        
            telUrl = [strQuhao stringByAppendingString:[telUrl substringToIndex:[telUrl rangeOfString:@"-"].location]];
        }
        if ([telUrl rangeOfString:@" "].length>0) {
            telUrl = [telUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        
    }
        self.strTEL = telUrl;
    UIAlertView* alert  =[[UIAlertView alloc]initWithTitle:@"  确认拨打买家电话？" message:telUrl delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
    alert.tag = 100;
    [alert show];
    
}
-(void)buttonPeiSongYuanTEL{
    self.buttonH5.hidden = YES;
        NSString *telUrl = [NSString stringWithFormat:@"%@",[[self.dictData valueForKey:@"courierTel"] toString]];
        self.strTEL = telUrl;
        UIAlertView* alert  =[[UIAlertView alloc]initWithTitle:@"  确认拨打配送员电话？" message:telUrl delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
        alert.tag = 101;
        [alert show];
}
-(void)distanceInfo{
    if (!self.routeSearch) {
        self.routeSearch = [[BMKRouteSearch alloc] init];
        self.routeSearch.delegate = self;
    }
    
    
    BMKPlanNode *start = [[BMKPlanNode alloc] init];
    CLLocationCoordinate2D cloStart;
    cloStart.latitude = [SelfUser currentSelfUser].mddyAdderssedLocationcoorDinate2D.latitude;
    cloStart.longitude = [SelfUser currentSelfUser].mddyAdderssedLocationcoorDinate2D.longitude;
    start.pt = cloStart;
    //              [self.mapView setCenterCoordinate:start.pt animated:YES];
    
    
    
    BMKPlanNode *end = [[BMKPlanNode alloc] init];
    CLLocationCoordinate2D cloEnd;
    
    cloEnd.latitude =  [[self.dictData valueForKey:@"consigneeLatitude"]  doubleValue];
    cloEnd.longitude = [[self.dictData valueForKey:@"consigneeLongitude"]  doubleValue];
 
    end.pt = cloEnd;
    
    BMKWalkingRoutePlanOption *walkingRoutePlanOption = [[BMKWalkingRoutePlanOption alloc] init];
    walkingRoutePlanOption.from = start;
    walkingRoutePlanOption.to = end;
    FLDDLogDebug(@"cloStart.latitude : %f, cloStart.longitude : %f,cloEnd.latitude : %f,cloEnd.longitude : %f", cloStart.latitude, cloStart.longitude, cloEnd.latitude, cloEnd.longitude);
    BOOL flg = [self.routeSearch walkingSearch:walkingRoutePlanOption];
    
    if (flg) {
        FLDDLogDebug(@"success");
    }
    else {
        FLDDLogInfo(@"failed");
    }
    walkingRoutePlanOption = nil;
    end = nil;
    start= nil;
    
}
#pragma mark -BMKRouteSearchDelegate

- (void)onGetWalkingRouteResult:(BMKRouteSearch *)searcher result:(BMKWalkingRouteResult *)result errorCode:(BMKSearchErrorCode)error
{
    
    if (error == BMK_SEARCH_NO_ERROR) {
        
        BMKWalkingRouteLine *walkingLine = (BMKWalkingRouteLine *)[result.routes objectAtIndex:0];
        NSString* distance=[NSString stringWithFormat:@"%d",walkingLine.distance];
        FLDDLogDebug(@"distance:%d", walkingLine.distance);
        
        self.labelSend.text = [NSString stringWithFormat:@"%.2f公里",[distance floatValue]/1000];
        [self.labelSend sizeToFit];

        long lDistance = walkingLine.distance;
        double dDistance = lDistance;
        FLDDLogDebug(@"dDistance:%d", walkingLine.distance);
        _distance = lDistance;
//        FLDDLogDebug(@"self.dictData:%ld", self.dictData);
        FLDDLogDebug(@"walkingDistance:%ld", (long)[[self.dictData valueForKey:@"walkingDistance"] integerValue]);
        if([[self.dictData valueForKey:@"walkingDistance"] integerValue] < 0)
        {
//            [self.dictData setValue:[NSString stringWithFormat:@"%ld", lDistance] forKey:@"walkingDistance"];
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.dictData];
            if(dic.allKeys.count > 0)
            {
                [dic setValue:[NSString stringWithFormat:@"%ld", lDistance] forKey:@"walkingDistance"];
                self.dictData = dic;
            }
            
        }
            
        
        
        if(lDistance >= 1000)
        {
            dDistance = dDistance/1000;
            self.buttonH5.labelBut.text = [NSString stringWithFormat:@"实际配送%.2f公里，应付运费%.2f元", dDistance, _fFreight];
        }
        else
        {
            self.buttonH5.labelBut.text = [NSString stringWithFormat:@"实际配送%ld米，应付运费%.2f元", (long)dDistance, _fFreight];
        }
        
        walkingLine = nil;
    }
    
    FLDDLogDebug(@"%u",error);
    
}
-(void)buttonCourier{
    self.buttonH5.hidden = YES;
    CouriesViewController* cour = [[CouriesViewController alloc]init];
    cour.strTel =[[self.dictData valueForKey:@"courierTel"] toString];
    [self.navigationController pushViewController:cour animated:YES];
}
-(void)buttonDetail{
  
    if (self.buttonH5.hidden==NO) {
          self.buttonH5.hidden = YES;
    }else{
         self.buttonH5.hidden = NO;
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
