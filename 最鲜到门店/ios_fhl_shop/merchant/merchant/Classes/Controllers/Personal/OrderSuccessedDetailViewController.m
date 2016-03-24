//
//  OrderSuccessedDetailViewController.m
//  merchant
//
//  Created by gs on 14/11/4.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "OrderSuccessedDetailViewController.h"
#import "AnimatedView.h"
#import "CouriesViewController.h"
@interface OrderSuccessedDetailViewController () <UIAlertViewDelegate,AnimateDelegate>
@property (strong, nonatomic)NSDictionary* dictData;
@property (strong, nonatomic)AnimatedView* animatedView;
@end

@implementation OrderSuccessedDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self addTableViewWithStyle:UITableViewStylePlain];
    self.animatedView = [[AnimatedView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT) imageName:@"logo_watermark_run" remark:@"正在努力加载中"];
    self.animatedView.delegate11 = self;
//    __weak __typeof(self)weakSelf = self;
//    self.animatedView.touchAction = ^(void){
//        [weakSelf getDictData];
//    };
    [self.view addSubview:self.animatedView];
    self.buttonTEL = nil;
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
    // Do any additional setup after loading the view from its nib
    
    [self getDictData];
     [self.view addGestureRecognizer:self.swip];
    // Do any additional setup after loading the view from its nib.
}
-(void)doChangeAnimate{
    [self getDictData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"OrderSuccessedDetailViewController" object:nil userInfo:@{@"billld":strBuillld}];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(noti:) name:@"OrderSuccessedDetailViewController" object:self];
    
}
-(void)noti:(NSNotification*)noti{
    
    self.strWaybillId = [noti.userInfo valueForKey:@"billld"];
    [self getDictData];
}
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
-(void)getDictData{
//    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeBlack];
    [self startActivityView];
__weak __typeof(self)weakSelf = self;
    [SelfUser mddyRequestWithMethodName:@"hasEndWaybillDetailJsonPhone.htm" withParams:@{@"cmdCode":g_hasEndWaybillDetailCmd,@"waybillId":self.strWaybillId} withBlock:^(id responseObject, NSError *error) {
//        [SVProgressHUD dismiss ];
        [MBProgressHUD hudHideWithViewcontroller:weakSelf];
        weakSelf.dictData = nil;
        if (!error) {
            @try {
                FLDDLogDebug(@"已完成订单详情%@",responseObject);
                weakSelf.dictData = responseObject;
                [weakSelf.animatedView removeFromSuperview];
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            
            
            [weakSelf.tableView reloadData];
            FLDDLogDebug(@"~~~%@",self.dictData);
            
            
        }else{
            [weakSelf.animatedView stopAnimate];
//            [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
            [MBProgressHUD hudShowWithStatus:weakSelf :[SelfUser currentSelfUser].ErrorMessage];
        }
        
        [weakSelf stopActivityView];
    }];
    
    


}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.dictData allKeys].count >0) {
        return 2;
    }else {
        return 1;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = nil;
    
    
    if (indexPath.section == 0) {
        
        static NSString* strINTI = @"TitleCell";
        UITableViewCell* titleCell = [tableView dequeueReusableCellWithIdentifier:strINTI];
        if (!titleCell) {
            titleCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strINTI];
        }
        
        for (UIView *view in titleCell.contentView.subviews) {
            [view removeFromSuperview];
        }

        titleCell.contentView.backgroundColor = UICOLOR(217, 217, 217, 1);
        
        UIImageView* imabeViewOrderSuccesss = [[UIImageView alloc]initWithFrame:CGRectMake( iPhone6Plus? 22+iphone4W_5W_6PlusW*22: 0.85*22, 20, iPhone4?0.85*330:iPhone5?0.85*330:330,iPhone4?0.85*58:iPhone5? 0.85*58:58)];
        imabeViewOrderSuccesss.image = [UIImage imageNamed:@"completed_status.png"];
        [titleCell.contentView addSubview:imabeViewOrderSuccesss];
        
        cell = titleCell;
    }else{
        static NSString* strINTI = @"ContentCell";
        UITableViewCell* contentCell = [tableView dequeueReusableCellWithIdentifier:strINTI];
        if (!contentCell) {
            contentCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strINTI];
        }

        for (UIView *view in contentCell.contentView.subviews) {
            [view removeFromSuperview];
        }
        UIImageView* cellImageView1 = [UIImageView circleImageViewFrame:CGRectMake(10, 10, 40,40) Radius:40/2];
      __weak  UIImageView* cellImageView= cellImageView1;
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
//        [SelfUser mddyRequestWIthImageWithBrandID:[self.dictData valueForKey:@"brandIdUrl"] withBlock:^(UIImage *image, NSError *error) {
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
//        }];
     
        [contentCell.contentView addSubview:cellImageView];
        
        
        
        NSInteger height;
        NSInteger wide;
        if (iPhone5 || iPhone4) {
            wide = -38;
            height = 2;
        }else{
            wide = 0;
            height = 0;
        }
        
        UILabel* labelTitel = [[UILabel alloc]init];
//        labelTitel.text  =@"绝味鸭脖（天目山路店）";
        labelTitel.text = [self.dictData valueForKey:@"shopName"];
//        [labelTitel sizeToFit];
        labelTitel.bounds = CGRectMake(0, 0,iPhone6? 230:160, 40);

        labelTitel.font = UIFont(16);
        labelTitel.center = CGPointMake(CGRectGetMaxX(cellImageView.frame)+6+labelTitel.bounds.size.width/2, CGRectGetMidY(cellImageView.frame)+height);
        [contentCell.contentView addSubview:labelTitel];
        
        
        
        UILabel* labelDanHao = [[UILabel alloc]init];
        labelDanHao.text = @"订单号:123456";
         labelDanHao.text = [NSString stringWithFormat:@"订单号:%@",[[self.dictData valueForKey:@"waybillCode"] toString]];
        [labelDanHao sizeToFit];
        labelDanHao.textColor = [UIColor darkGrayColor];
        labelDanHao.font =  UIFont(13);
        labelDanHao.center = CGPointMake(iphone6_6P_isYES? 330:280, CGRectGetMidY(cellImageView.frame)+height);
        [contentCell.contentView addSubview:labelDanHao];
        
        UIView* viewLine1 = [[UIView alloc]initWithFrame:CGRectMake(10, 52, WINDOW_WIDTH-20, 1)];
        viewLine1.backgroundColor = [UIColor lightGrayColor];
        viewLine1.alpha = 0.35;
        [contentCell.contentView addSubview:viewLine1];
        
        
        UILabel* labelJinE = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, iPhone6?69: iPhone6Plus?69: 59, 20)];
        labelJinE.text = @"订单金额:";
        labelJinE.font = UIFont(16);
        [contentCell.contentView addSubview:labelJinE];
      
        
        self.labelPrice = [[UILabel alloc]initWithFrame:CGRectMake(iPhone4?83:iPhone5?83: 100, 60, 80, 20)];
//        self.labelPrice.text = @"24.00元";
        self.labelPrice.text = [NSString stringWithFormat:@"%.2f元",[[self.dictData valueForKey:@"waybillPrice"]floatValue]/100];
     self.labelPrice.center =CGPointMake(CGRectGetMaxX(labelJinE.frame)+15+self.labelPrice.bounds.size.width/2, CGRectGetMidY(labelJinE.frame));
        [self.labelPrice sizeToFit];
        self.labelPrice.font = UIFont(16);
        [contentCell.contentView addSubview:self.labelPrice];
        
        
        
        UILabel* labelFaDan = [[UILabel alloc]init];
        labelFaDan.text = @"发单时间:";
        labelFaDan.font = UIFont(16);
        [labelFaDan sizeToFit];
        labelFaDan.center = CGPointMake(10+labelFaDan.bounds.size.width/2, CGRectGetMaxY(labelJinE.frame)+10+labelFaDan.bounds.size.height/2-3);
        [contentCell.contentView addSubview:labelFaDan];
        
        self.labelSend = [[UILabel alloc]init];
//        self.labelSend.text = @"2014-12-10 12:10";
         self.labelSend.text =   [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"createTime"] toString]withFormat:@"MM月dd日 HH:mm"];

//        self.labelSend.text =    [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"createTime"]toString] ];
        self.labelSend.font = UIFont(16);
        [self.labelSend sizeToFit];
        self.labelSend.center = CGPointMake(CGRectGetMaxX(labelFaDan.frame)+15+self.labelSend.bounds.size.width/2, CGRectGetMidY(labelFaDan.frame));
        [contentCell.contentView addSubview:self.labelSend];
        
     
        UILabel* labelSuceessed = [[UILabel alloc]init];
        labelSuceessed.text = @"揽收时间:";
        labelSuceessed.font =UIFont(16);
        [labelSuceessed sizeToFit];
        labelSuceessed.center = CGPointMake(10+labelSuceessed.bounds.size.width/2, CGRectGetMaxY(labelFaDan.frame)+8+labelSuceessed.bounds.size.height/2);
        [contentCell.contentView addSubview:labelSuceessed];
        
        self.labelSuccessed = [[UILabel alloc]init];
//        self.labelSuccessed.text = @"2014-12-10 12:12";
//        =[[self.dictData valueForKey:@"collectionTime"]toString];
            self.labelSuccessed.text =   [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"collectionTime"] toString]withFormat:@"MM月dd日 HH:mm"];

//        self.labelSuccessed.text=    [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"collectionTime"]toString] ];
        self.labelSuccessed.font = UIFont(16);
        [self.labelSuccessed sizeToFit];
        self.labelSuccessed.center = CGPointMake(CGRectGetMaxX(labelSuceessed.frame)+15+self.labelSuccessed.bounds.size.width/2, CGRectGetMidY(labelSuceessed.frame));
        [contentCell.contentView addSubview:self.labelSuccessed];
        
        
        UILabel* labelQianShou= [[UILabel alloc]init];
        labelQianShou.text = @"签收时间:";
        labelQianShou.font = UIFont(16);
        [labelQianShou sizeToFit];
        labelQianShou.center = CGPointMake(10+labelQianShou.bounds.size.width/2, CGRectGetMaxY(labelSuceessed.frame)+8+labelQianShou.bounds.size.height/2);
        [contentCell.contentView addSubview:labelQianShou];
        
        self.labelQianShou = [[UILabel alloc]init];
          self.labelQianShou.text =   [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"receivingTime"] toString]withFormat:@"MM月dd日 HH:mm"];

//     self.labelQianShou.text = [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"receivingTime"]toString] ];
//         self.labelQianShou.text = [[self.dictData valueForKey:@"receivingTime"]toString];
        self.labelQianShou.font = UIFont(16);
        [self.labelQianShou sizeToFit];
        self.labelQianShou.center = CGPointMake(CGRectGetMaxX(labelQianShou.frame)+15+self.labelQianShou.bounds.size.width/2, CGRectGetMidY(labelQianShou.frame));
        [contentCell.contentView addSubview:self.labelQianShou];
        
        
   
        UIView* viewLine2=nil;
        if ([[[self.dictData valueForKey:@"content"]toString] isEqualToString:@""]) {
            viewLine2 = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelQianShou.frame)+8, WINDOW_WIDTH-20, 01)];

       }else{
        
        UILabel* labelAddress = [[UILabel alloc]init];
        labelAddress.text = @"备       注:";
        labelAddress.font =UIFont(16);
        [labelAddress sizeToFit];
        labelAddress.center = CGPointMake(10+labelAddress.bounds.size.width/2, CGRectGetMaxY(labelQianShou.frame)+8+labelAddress.bounds.size.height/2-height);
        [contentCell.contentView addSubview:labelAddress];
        
        self.labelAddressed = [[UILabel alloc]init];
        self.labelAddressed.text = [[self.dictData valueForKey:@"content"]toString];
        self.labelAddressed.font =  UIFont(16);
        self.labelAddressed.numberOfLines = MAXFLOAT;
        self.labelAddressed.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size1 = CGSizeMake(WINDOW_WIDTH-100,MAXFLOAT);
//        CGSize labelsize1 = [self.labelAddressed.text  sizeWithFont:self.labelAddressed.font constrainedToSize:size1 lineBreakMode:NSLineBreakByWordWrapping];
           
        CGRect rect = [labelAddress.text boundingRectWithSize:size1 options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.labelAddressed.font} context:nil];
//        self.labelAddressed.frame = CGRectMake(CGRectGetMaxX(labelAddress.frame)+15,CGRectGetMinY(labelAddress.frame), labelsize1.width, labelsize1.height);
        self.labelAddressed.frame = CGRectMake(CGRectGetMaxX(labelAddress.frame)+15,CGRectGetMinY(labelAddress.frame), rect.size.width, rect.size.height);
        [contentCell.contentView addSubview:self.labelAddressed];
         viewLine2 = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelAddressed.frame)+5, WINDOW_WIDTH-20, 01)];
  
    
       
        
    }
        viewLine2.backgroundColor = [UIColor lightGrayColor];
        viewLine2.alpha = 0.35;
        [contentCell.contentView addSubview:viewLine2];
//        UILabel* labelAddr= [[UILabel alloc]init];

//        if (![[self.dictData valueForKey:@"consigneeTel"]  isEqualToString:@""]) {
        UILabel* labelAddr= [[UILabel alloc]init];
        labelAddr.text = @"买       家:";
        labelAddr.font =  UIFont(16);
        [labelAddr sizeToFit];
        labelAddr.center = CGPointMake(10+labelAddr.bounds.size.width/2, CGRectGetMaxY(viewLine2.frame)+8+labelAddr.bounds.size.height/2);
        [contentCell.contentView addSubview:labelAddr];
        
        self.labelAddr = [[UILabel alloc]init];
        //        self.labelAddr.text = @"杭州市西湖区天目山路238号华鸿大厦A座302-董小姐";
        self.labelAddr.text = [[self.dictData valueForKey:@"consigneeAddress"]toString];
        self.labelAddr.font =  UIFont(16);
        self.labelAddr.numberOfLines = MAXFLOAT;
        self.labelAddr.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = CGSizeMake(WINDOW_WIDTH-100, MAXFLOAT);
//        CGSize labelsize = [self.labelAddr.text  sizeWithFont:self.labelAddr.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        CGRect rect = [self.labelAddr.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.labelAddr.font} context:nil];
        self.labelAddr.frame = CGRectMake(CGRectGetMaxX(labelAddr.frame)+15,(iPhone6Plus?-2:0)+ labelAddr.frame.origin.y, rect.size.width, rect.size.height);
//        self.labelAddr.frame = CGRectMake(CGRectGetMaxX(labelAddr.frame)+15,(iPhone6Plus?-2:0)+ labelAddr.frame.origin.y, labelsize.width, labelsize.height);
        [contentCell.contentView addSubview:self.labelAddr];
        
        if (Have) {
            
        
        UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.labelAddr.frame), CGRectGetMaxY(self.labelAddr.frame)+5, 24, 24)];
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
//        [self.labelPhoneNumber setTextColor:UICOLOR(249, 102, 34, 1)];
        self.labelPhoneNumber.center = CGPointMake(CGRectGetMaxX(imageView.frame)+3+self.labelPhoneNumber.bounds.size.width/2, CGRectGetMidY(imageView.frame));
        [contentCell.contentView addSubview:self.labelPhoneNumber];
        }else{
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

        
//        UILabel* labelPhoneNumber= [[UILabel alloc]init];
//        labelPhoneNumber.text = @"买家电话:";
//        labelPhoneNumber.font = UIFont(16);
//        [labelPhoneNumber sizeToFit];
//        labelPhoneNumber.center = CGPointMake(10+labelPhoneNumber.bounds.size.width/2, CGRectGetMaxY(viewLine2.frame)+8+labelPhoneNumber.bounds.size.height/2-3);
//        [contentCell.contentView addSubview:labelPhoneNumber];
//        
//        self.labelPhoneNumber = [[UILabel alloc]init];
////        self.labelPhoneNumber.text = @"138 0057 0571";
//        
//        if ([[self.dictData valueForKey:@"consigneeTel"]toString].length == 11&& [[[self.dictData valueForKey:@"consigneeTel"] toString] rangeOfString:@"-"].length==0) {
//            
//            self.labelPhoneNumber.text = [CommonUtils changePhoneNumberWithNumber: [[self.dictData valueForKey:@"consigneeTel"]toString] withType:@" "];
//        }else{
//            self.labelPhoneNumber.text =  [[self.dictData valueForKey:@"consigneeTel"]toString] ;
//        }
//        
//        self.labelPhoneNumber.font = UIFont(16);
//        [self.labelPhoneNumber sizeToFit];
//        self.labelPhoneNumber.center = CGPointMake(CGRectGetMaxX(labelPhoneNumber.frame)+15+self.labelPhoneNumber.bounds.size.width/2, CGRectGetMidY(labelPhoneNumber.frame));
//        [contentCell.contentView addSubview:self.labelPhoneNumber];
//        
//        
//        
//        UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-50,CGRectGetMidY(self.labelPhoneNumber.frame)-15, 24, 24  )];
//        imageView.userInteractionEnabled = YES;
//        imageView.image = [UIImage imageNamed:@"orders_phone_n.png"];
//        
//        [contentCell.contentView addSubview:imageView];
//        
//        self.buttonMaiJiaTEL = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.buttonMaiJiaTEL.frame = CGRectMake(WINDOW_WIDTH-200,CGRectGetMidY(self.labelPhoneNumber.frame)-15, 200, 35  );
//        [self.buttonMaiJiaTEL addTarget:self action:@selector(telMaiJia) forControlEvents:UIControlEventTouchUpInside];
//        [contentCell.contentView addSubview:self.buttonMaiJiaTEL];
//            labelAddr.center = CGPointMake(10+labelAddr.bounds.size.width/2, CGRectGetMaxY(self.labelPhoneNumber.frame)+8+labelAddr.bounds.size.height/2+2);
//
////        }else{
////            labelAddr.center = CGPointMake(10+labelAddr.bounds.size.width/2, CGRectGetMaxY(viewLine2.frame)+8+labelAddr.bounds.size.height/2);
////
////        }
//        
//        
//        
//            labelAddr.text = @"收货地址:";
//        labelAddr.font = UIFont(16);
//        [labelAddr sizeToFit];
//               [contentCell.contentView addSubview:labelAddr];
//        
//        
//        
//        self.labelAddr = [[UILabel alloc]init];
//        self.labelAddr.text = [[self.dictData valueForKey:@"consigneeAddress"]toString];
//        self.labelAddr.font =  UIFont(16);
//        self.labelAddr.numberOfLines = MAXFLOAT;
//        self.labelAddr.lineBreakMode = NSLineBreakByWordWrapping;
//        CGSize size = CGSizeMake(WINDOW_WIDTH-100, MAXFLOAT);
//        CGSize labelsize = [self.labelAddr.text  sizeWithFont:self.labelAddr.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
//        
//        self.labelAddr.frame = CGRectMake(CGRectGetMaxX(labelAddr.frame)+17, (iPhone6Plus?-2:0)+CGRectGetMidY(labelAddr.frame)-height-6, labelsize.width, labelsize.height);
//        [contentCell.contentView addSubview:self.labelAddr];
//        
//        
        UIView* viewLin = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelPhoneNumber.frame)+13, WINDOW_WIDTH-20, 01)];
        viewLin.backgroundColor = [UIColor lightGrayColor];
        viewLin.alpha = 0.35;
        [contentCell.contentView addSubview:viewLin];
        
        self.buttonTEL = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.buttonTEL setTitle:[NSString stringWithFormat:@"配  送  员:   "] forState:UIControlStateNormal];
        _buttonTEL.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.buttonTEL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.buttonTEL.titleLabel.font = UIFont(16);
//        [self.buttonTEL addTarget:self action:@selector(tel) forControlEvents:UIControlEventTouchUpInside];
        self.buttonTEL.frame = CGRectMake(10, CGRectGetMaxY(self.labelPhoneNumber.frame)+8, WINDOW_WIDTH, 40);
        [contentCell.contentView addSubview:self.buttonTEL];
        
        UILabel* labelCourierName = [[UILabel alloc]init];
        labelCourierName.text = [[self.dictData valueForKey:@"courierName"] toString];
        labelCourierName.textColor =UICOLOR(249, 102, 34, 1);
        labelCourierName.font = UIFont(16);
        [labelCourierName sizeToFit];
        labelCourierName.center = CGPointMake(CGRectGetMaxX(labelJinE.frame)+15+labelCourierName.bounds.size.width/2, CGRectGetMidY(self.buttonTEL.frame));
        [contentCell addSubview:labelCourierName];
        
          if ([[self.dictData valueForKey:@"courierRankIconUrl"] toString].length>1) {
      UIImageView* imageView = [[ UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labelCourierName.frame)+2, CGRectGetMaxY(self.labelPhoneNumber.frame)+8+12, 15, 15)];
        imageView.image = [UIImage imageNamed:@"grade_card_v2"];
        
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
        
//        UIImageView* imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-70, CGRectGetMidY(self.buttonTEL.frame)-8, 16, 16)];
//        imageView1.image = [UIImage imageNamed:@"map_card.png"];
//        [contentCell.contentView addSubview:imageView1];
//        UILabel* labelLocation = [[UILabel alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-50, CGRectGetMidY(self.buttonTEL.frame)-16, 50, 32)] ;
//        labelLocation.text = @"定位";
//        labelLocation.font = UIFont(16);
//        labelLocation.textColor =UICOLOR(131, 185, 68, 1);
//        [contentCell.contentView addSubview:labelLocation];
        
        
        
        
        if (Have) {
       
        UIImageView* imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake((iPhone6?69: iPhone6Plus?69: 59)+25, CGRectGetMinY(self.buttonTEL.frame)+35, 24, 24)];
        imageView2.image = [UIImage imageNamed:@"orderform_call_.png"];
        [contentCell.contentView addSubview:imageView2];
        
        self.labelPhoneNumber = [[UILabel alloc]init];
        self.labelPhoneNumber.text = @"138 0057 0571";
        if ([[self.dictData valueForKey:@"consigneeTel"]toString].length == 11&& [[[self.dictData valueForKey:@"courierTel"] toString] rangeOfString:@"-"].length==0) {
            
            self.labelPhoneNumber.text = [CommonUtils changePhoneNumberWithNumber: [[self.dictData valueForKey:@"courierTel"]toString] withType:@" "];
        }else{
            self.labelPhoneNumber.text =  [[self.dictData valueForKey:@"courierTel"]toString] ;
        }
        self.labelPhoneNumber.font =  UIFont(16);
        [self.labelPhoneNumber sizeToFit];
//        [self.labelPhoneNumber setTextColor:UICOLOR(249, 102, 34, 1)];
        self.labelPhoneNumber.center = CGPointMake(CGRectGetMaxX(imageView2.frame)+3+self.labelPhoneNumber.bounds.size.width/2, CGRectGetMidY(imageView2.frame));
        [contentCell.contentView addSubview:self.labelPhoneNumber];
      
        }else{
            self.labelPhoneNumber = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.labelAddr.frame), CGRectGetMaxY(self.buttonTEL.frame)-3, 0, 0)];
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
            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelPhoneNumber.frame), CGRectGetMaxY(self.buttonTEL.frame)-8, 24, 24)];
            imageView.image = [UIImage imageNamed:@"orderform_call_.png"];
            [contentCell.contentView addSubview:imageView];
        }
            
            
        UIButton* buttonPeiSongYuanTEL = [UIButton buttonWithType:UIButtonTypeCustom] ;
        buttonPeiSongYuanTEL.frame = CGRectMake(0, 0, 190, 35);
        buttonPeiSongYuanTEL.center =self.labelPhoneNumber.center;
        //            buttonMaiJiaTEL.backgroundColor = [UIColor redColor];
        [buttonPeiSongYuanTEL addTarget:self action:@selector(buttonPeiSongYuanTEL) forControlEvents:UIControlEventTouchUpInside];
        [contentCell.contentView addSubview:buttonPeiSongYuanTEL];
        
        
//        if(self.buttonTEL == nil)
//        {
//            self.buttonTEL = [UIButton buttonWithType:UIButtonTypeCustom];
//        }
//
//        
//        [self.buttonTEL setTitle:[NSString stringWithFormat:@"配送员:  %@",[[self.dictData valueForKey:@"courierName"] toString]] forState:UIControlStateNormal];
//        _buttonTEL.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [self.buttonTEL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        self.buttonTEL.titleLabel.font = UIFont(16);
////        self.buttonTEL.backgroundColor = [UIColor redColor];
////        [self.buttonTEL setImage:[UIImage imageNamed:@"orders_phone_n.png"] forState:UIControlStateNormal];
//        
//        self.buttonTEL.frame = CGRectMake(10, CGRectGetMaxY(viewLin.frame)+8, WINDOW_WIDTH, 40);
//        [contentCell.contentView addSubview:self.buttonTEL];
//        [self.buttonTEL addTarget:self action:@selector(tel:) forControlEvents:UIControlEventTouchUpInside];
//        
//
////        UIButton *telButton = [UIButton buttonWithType:UIButtonTypeCustom];
////        telButton.backgroundColor = [UIColor greenColor];
////        telButton.frame = self.buttonTEL.frame;
////        [telButton addTarget:self action:@selector(tel:) forControlEvents:UIControlEventTouchUpInside];
////        [contentCell.contentView addSubview:telButton];
//        
//        
//        UIImageView* imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-50,CGRectGetMidY(self.buttonTEL.frame)-15, 24, 24  )];
//        
//        imageView1.image = [UIImage imageNamed:@"orders_phone_n.png"];
//        
//        [contentCell.contentView addSubview:imageView1];
        
        cell = contentCell;
        [contentCell removeFromSuperview];
        contentCell = nil;
    }
    
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    return 560;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back{
    [self.tableView removeFromSuperview];
    self.tableView =nil;
    self.dictData = nil;
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.strTEL]];
        
        [[UIApplication sharedApplication] openURL:url];
    }
    
}
#define mark - UIAlertViewDelegate

//-(void)tel:(id)sender{
//    NSString *telUrl = [NSString stringWithFormat:@"%@",[[self.dictData valueForKey:@"courierTel"] toString]];
//    self.strTEL = telUrl;
//    UIAlertView* alert  =[[UIAlertView alloc]initWithTitle:@"  确认拨打配送员电话？" message:telUrl delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
//    alert.tag = 101;
//    [alert show];
//}
//-(void)telMaiJia{
//    NSString *telUrl = @"";
//    if ([[self.dictData valueForKey:@"consigneeTel"]toString].length == 11&& [[[self.dictData valueForKey:@"consigneeTel"] toString] rangeOfString:@"-"].length==0) {
//        telUrl = [NSString stringWithFormat:@"%@",[[self.dictData valueForKey:@"consigneeTel"]toString]];
//    }else{
//        telUrl = [[self.dictData valueForKey:@"consigneeTel"]toString];
//        if ([telUrl rangeOfString:@"-"].length>0) {
//            if ([telUrl rangeOfString:@"-"].location<7) {
//                telUrl =  [telUrl substringFromIndex:[telUrl rangeOfString:@"-"].location+1];
//            }}
//        FLDDLogDebug(@"%@",telUrl);
//        if ([telUrl rangeOfString:@"-"].length>0) {
//            telUrl = [telUrl substringToIndex:[telUrl rangeOfString:@"-"].location];
//        }
//        
//        
//    }
//    self.strTEL = telUrl;
//    UIAlertView* alert  =[[UIAlertView alloc]initWithTitle:@"  确认拨打买家电话？" message:telUrl delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
//    alert.tag = 100;
//    [alert show];
//    
//    
//}
-(IBAction)buttonMaiJiaTELPressed{
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
-(void)buttonPeiSongYuanTEL{
    NSString *telUrl = [NSString stringWithFormat:@"%@",[[self.dictData valueForKey:@"courierTel"] toString]];
    self.strTEL = telUrl;
    UIAlertView* alert  =[[UIAlertView alloc]initWithTitle:@"  确认拨打配送员电话？" message:telUrl delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
    alert.tag = 101;
    [alert show];
}
-(void)buttonCourier{
    CouriesViewController* cour = [[CouriesViewController alloc]init];
    cour.strTel =[[self.dictData valueForKey:@"courierTel"] toString];
    [self.navigationController pushViewController:cour animated:YES];
}
@end
