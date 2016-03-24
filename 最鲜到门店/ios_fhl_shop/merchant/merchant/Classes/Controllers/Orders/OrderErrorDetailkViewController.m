//
//  OrderErrorDetailkViewController.m
//  merchant
//
//  Created by gs on 14/11/5.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "OrderErrorDetailkViewController.h"
#import "CExpandPicViewController.h"
#import "AnimatedView.h"
#import "CouriesViewController.h"

@interface OrderErrorDetailkViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,AnimateDelegate>
@property (strong, nonatomic)NSMutableDictionary* dictData;
@property (strong, nonatomic) UITableView* tableView;
@property (nonatomic, strong) UIImage *firstImage;
@property (nonatomic, strong) UIImage *secondImage;
@property (strong, nonatomic)AnimatedView* animatedView ;
@end

@implementation OrderErrorDetailkViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    self.title = @"订单详情";
    self.navigationItem.hidesBackButton = YES;
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"backWithTitle.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 53, 19);
    
    UIBarButtonItem* rithtBarItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = rithtBarItem ;
    button=nil;
    rithtBarItem = nil;
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, WINDOW_WIDTH, WINDOW_HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
    [self.view addSubview:self.tableView];
    
    
    [self getData];
    self.animatedView = [[AnimatedView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT) imageName:@"logo_watermark_run" remark:@"正在努力加载中"];
    self.animatedView.delegate11 = self;
//    __weak __typeof(self)weakSelf = self;
//    self.animatedView.touchAction = ^(void){
//        [weakSelf getData
//         ];
//    };
    [self.view addSubview:self.animatedView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(noti:) name:@"OrderErrorDetailkViewController" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(noti:) name:@"OrderErrorDetailkViewController111" object:nil];

}
-(void)doChangeAnimate{
    [self getData];
}

-(void)noti:(NSNotification*)noti{
    self.isDonig = YES;
    if ([[noti.userInfo valueForKey:@"status"] isEqualToString:@"cancel"]) {
        self.orderStatus = ORDER_ERROR_STATUS_WAIT_CANCEL;
        self.orderStatusED = ORDER_CANCEL;
       
    }else{
        self.orderStatus = ORDER_ERROR_STATUS_WAIT_JUSHOU;
//        if ([[noti.userInfo allKeys]containsObject:@"statusED"]) {
               self.orderStatus = ORDER_ERROR_STATUS_WAIT_JUSHOU;
                      self.orderStatusED = ORDER_JUSHOU;
//        }
        
    }
    
    
    self.strWayBillld = [noti.userInfo valueForKey:@"billld"];
    [self getData];
    
}
-(void)getData{
    NSString* mothod = nil;
    if (self.orderStatus == ORDER_ERROR_STATUS_WAIT_CANCEL) {
        
        if (self.orderStatusED == ORDER_CANCEL) {
            mothod = @"hasEndWaybillDetailJsonPhone.htm";
        }else{
            mothod = @"toCancelWaybillDetailJsonPhone.htm";
        }
    }else{
        if (  self.orderStatusED== ORDER_JUSHOU) {
            mothod = @"hasEndWaybillDetailJsonPhone.htm";
        }else{
            mothod = @"toDealWaybillDetailJsonPhone.htm";
        }
    }
    
//    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeBlack];
          [SelfUser hudShowWithViewcontroller:self];
    
    NSLog(@"%@",self.strWayBillld);
    __weak __typeof(self)weakSelf = self;
    [SelfUser mddyRequestWithMethodName:mothod withParams:@{@"waybillId":self.strWayBillld} withBlock:^(id responseObject, NSError *error) {
//        [SVProgressHUD dismiss ];
        [SelfUser hudHideWithViewcontroller:weakSelf];
        weakSelf.dictData = nil;
        if (!error) {
            @try {
                NSLog(@"%@订单详情%@",mothod,responseObject);
                self.dictData = responseObject;
                [weakSelf.animatedView removeFromSuperview];
                weakSelf.animatedView = nil;
                
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            
            
            NSLog(@"~~~%@",self.dictData);
            [weakSelf.tableView reloadData];
            
        }else{
            [weakSelf.animatedView stopAnimate];
//            [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
            [MBProgressHUD hudShowWithStatus:weakSelf :[SelfUser currentSelfUser].ErrorMessage];
        }
        
        
    }];
    
    
}


// Do any additional setup after loading the view from its nib.

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.dictData allKeys].count >0) {
        return 1;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    static NSString* strINTI = @"cellC";
    UITableViewCell* cellView = [tableView dequeueReusableCellWithIdentifier:strINTI];
        for (UIView* view in cellView.subviews) {
            [view removeFromSuperview];
//            view = nil;
        }
    if (!cellView) {
     cellView = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strINTI];
    }


//    UITableViewCell* cell = [[UITableViewCell alloc
//                              ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cellView.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView* imageView = [[UIImageView alloc  ] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 30)];
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(WINDOW_WIDTH/2-80, 0, 160, 30)];
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:label];
    imageView.image = [UIImage imageNamed:@"doing.png"];
    if (self.orderStatus == ORDER_ERROR_STATUS_WAIT_CANCEL) {
        
        if (self.orderStatusED == ORDER_CANCEL) {
            label.text = @"订单已被取消";
        }else{
            label.text = @"订单取消中";
        }
        
        if (!self.isDonig) {
            label.text = @"订单已被取消";
        }else{
            label.text = @"订单取消中";
        }
        
      UIImageView* cellImageView1 =[UIImageView circleImageViewFrame:CGRectMake(10, 40, 40,40) Radius:40/2];
        
       __weak UIImageView* cellImageView = cellImageView1;
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
//        [SelfUser mddyRequestWIthImageWithBrandID:[self.dictData valueForKey:@"brandIdUrl"] withBlock:^(UIImage * image, NSError *error) {
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
        [cellView.contentView addSubview:cellImageView];
        
        UILabel* labelTitel = [[UILabel alloc]init];
        //        labelTitel.text  =@"绝味鸭脖（天目山路店）";
        labelTitel.text = [[self.dictData valueForKey:@"shopName"] toString];
//        [labelTitel sizeToFit];
      
        labelTitel.font = UIFont(16);
        labelTitel.bounds = CGRectMake(0, 0,iPhone6? 230:160, 40);

        labelTitel.center = CGPointMake(CGRectGetMaxX(cellImageView.frame)+6+labelTitel.bounds.size.width/2, CGRectGetMidY(cellImageView.frame));
        [cellView  addSubview:labelTitel];
        
        UILabel* labelDanHao = [[UILabel alloc]init];
        //        labelDanHao.text = @"运单号：123456";
        labelDanHao.text = [NSString stringWithFormat:@"订单号:%@",[[self.dictData valueForKey:@"waybillCode"] toString]];
        
        [labelDanHao sizeToFit];
        labelDanHao.textColor = [UIColor darkGrayColor];
        labelDanHao.font = UIFont(13);
        labelDanHao.center = CGPointMake((WINDOW_WIDTH-40)+(iphone6_6P_isYES?:2), CGRectGetMidY(cellImageView.frame));
        [cellView  addSubview:labelDanHao];
        
        UIView* viewLine1 = [[UIView alloc]initWithFrame:CGRectMake(10, 82, WINDOW_WIDTH-20, 1)];
        viewLine1.backgroundColor = [UIColor lightGrayColor];
        viewLine1.alpha = 0.35;
        [cellView  addSubview:viewLine1];
        
        
        UILabel* labelJinE1 = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(viewLine1.frame)+10, iphone6_6P_isYES?69:59, 20)];
        labelJinE1.text = @"订单金额:";
        
        labelJinE1.font = UIFont(16);
        [cellView addSubview:labelJinE1];
        
        
        self.labelPrice = [[UILabel alloc]init];
        self.labelPrice.text = @"24.00元";
        self.labelPrice.text = [NSString stringWithFormat:@"%.2f元",[[self.dictData valueForKey:@"waybillPrice"]floatValue]/100];
        [self.labelPrice sizeToFit];
        self.labelPrice.font = UIFont(16);
        
        self.labelPrice.center =CGPointMake(CGRectGetMaxX(labelJinE1.frame)+15+self.labelPrice.bounds.size.width/2, CGRectGetMidY(labelJinE1.frame));
        
        [cellView addSubview:self.labelPrice];

        
        
        UILabel* labelJinE = [[UILabel alloc]init];
        labelJinE.text = @"发单时间:";
        labelJinE.font = UIFont(16);
        [labelJinE sizeToFit];
        labelJinE.center = CGPointMake(10+labelJinE.bounds.size.width/2, CGRectGetMaxY(labelJinE1.frame)+15);
        
        [cellView  addSubview:labelJinE];
        
        
        self.labelPrice = [[UILabel alloc]initWithFrame:CGRectMake(100, 90, 80, 20)];
        //        self.labelPrice.text = @"2014-12-10 12:12";
        if (self.isDonig) {
             self.labelPrice.text   = [CommonUtils getDateForStringTime:[self.dictData valueForKey:@"createTime"] withFormat:@"HH:mm"];
        }else{
            self.labelPrice.text   = [CommonUtils getDateForStringTime:[self.dictData valueForKey:@"createTime"] withFormat:@"MM月dd日 HH:mm"];
        }
//      self.labelPrice.text =  [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"createTime"] toString]withFormat:@"MM月dd日 HH:mm"];

//        self.labelPrice.text =[CommonUtils getDateForStringTime: [[self.dictData valueForKey:@"createTime"] toString]];
        [self.labelPrice sizeToFit];
        self.labelPrice.center = CGPointMake(CGRectGetMaxX(labelJinE.frame)+15+self.labelPrice.bounds.size.width/2, CGRectGetMidY(labelJinE.frame));
        
        self.labelPrice.font =UIFont(16);
        [cellView addSubview:self.labelPrice];
        
        
        
        UILabel* labelFaDan = [[UILabel alloc]init];
        if (self.orderStatusED == ORDER_CANCEL) {
            labelFaDan.text = @"完成时间:";
        }else{
            labelFaDan.text = @"取消时间:";
        }
        
        if (!self.isDonig) {
            labelFaDan.text = @"取消时间:";
        }else{
            labelFaDan.text = @"完成时间:";
        }
        labelFaDan.font = UIFont(16);
        [labelFaDan sizeToFit];
        labelFaDan.center = CGPointMake(10+labelFaDan.bounds.size.width/2, CGRectGetMaxY(labelJinE.frame)+10+labelFaDan.bounds.size.height/2);
        [cellView  addSubview:labelFaDan];
        
        self.labelSend = [[UILabel alloc]init];
        //        self.labelSend.text = @"2014-12-10 12:12";
        if (self.isDonig) {
            labelFaDan.text = @"取消时间:";
             self.labelSend.text =   [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"killedTime"] toString]withFormat:@"HH:mm"];
//           self.labelSend.text =   [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"killedTime"] toString]withFormat:@"MM月dd日 HH:mm"];
//            self.labelSend.text =[CommonUtils getDateForStringTime: [[self.dictData valueForKey:@"killedTime"] toString]];
            
        }else{
            labelFaDan.text = @"完成时间:";
          self.labelSend.text =   [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"receivingTime"] toString]withFormat:@"MM月dd日 HH:mm"];

//            self.labelSend.text =[CommonUtils getDateForStringTime: [[self.dictData valueForKey:@"receivingTime"] toString]];
        }
        
        
        
        self.labelSend.font =UIFont(16);
        [self.labelSend sizeToFit];
        self.labelSend.center = CGPointMake(CGRectGetMaxX(labelFaDan.frame)+15+self.labelSend.bounds.size.width/2, CGRectGetMidY(labelFaDan.frame));
        [cellView  addSubview:self.labelSend];
        
        
        UILabel* labelSuceessed = [[UILabel alloc]init];
        labelSuceessed.text = @"取消原因:";
        labelSuceessed.font =UIFont(16);
        [labelSuceessed sizeToFit];
        labelSuceessed.center = CGPointMake(10+labelSuceessed.bounds.size.width/2, CGRectGetMaxY(labelFaDan.frame)+8+labelSuceessed.bounds.size.height/2);
        [cellView  addSubview:labelSuceessed];
        
        self.labelSuccessed = [[UILabel alloc]init];
        //        self.labelSuccessed.text = @"买家自己配送，已于配送员协商一致";
        self.labelSuccessed.text = [[self.dictData valueForKey:@"killedReason"] toString];
        self.labelSuccessed.font = UIFont(16);
        [self.labelSuccessed sizeToFit];
        self.labelSuccessed.center = CGPointMake(CGRectGetMaxX(labelSuceessed.frame)+15+self.labelSuccessed.bounds.size.width/2, CGRectGetMidY(labelSuceessed.frame));
        [cellView  addSubview:self.labelSuccessed];
        
        UIView* viewLine2= nil;
        if ([[[self.dictData valueForKey:@"quickType"] toString] isEqualToString:@"2"]  && [[self.dictData valueForKey:@"content"] toString].length!=0) {
                    UILabel* labelAddress = [[UILabel alloc]init];
                    labelAddress.text = @"备       注:";
                    labelAddress.font = UIFont(16);
                    [labelAddress sizeToFit];
                    labelAddress.center = CGPointMake(10+labelAddress.bounds.size.width/2, CGRectGetMaxY(labelSuceessed.frame)+8+labelAddress.bounds.size.height/2);
                    [cellView addSubview:labelAddress];
            
                    self.labelAddressed = [[UILabel alloc]init];
//                    self.labelAddressed.text = @"热饮，小心烫口，先喝第一口汤，在啃鸭脖，然后再喝第二口汤。";
                     self.labelAddressed.text = [[self.dictData valueForKey:@"content"] toString];
                    self.labelAddressed.font = UIFont(16);
                    self.labelAddressed.numberOfLines = 2;
                    self.labelAddressed.lineBreakMode = NSLineBreakByWordWrapping;

//                    CGSize size2 = CGSizeMake(WINDOW_WIDTH-100,170);
//                    CGSize labelsize2 = [self.labelAddressed.text  sizeWithFont:self.labelAddressed.font constrainedToSize:size2 lineBreakMode:NSLineBreakByWordWrapping];
            NSAttributedString *attributedText =
            [[NSAttributedString alloc]
             initWithString:self.labelAddressed.text
             attributes:@
             {
             NSFontAttributeName: UIFont(16)
             }];
            CGRect rect = [attributedText boundingRectWithSize:(CGSize){WINDOW_WIDTH-100, 170}
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                       context:nil];
            CGSize labelsize2 = rect.size;
            
                    self.labelAddressed.frame = CGRectMake(CGRectGetMaxX(labelAddress.frame)+15,(iPhone6Plus?-2:0)+ CGRectGetMidY(labelAddress.frame)-2-6, labelsize2.width, labelsize2.height);
                    [cellView addSubview:self.labelAddressed];
  viewLine2   = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelAddressed.frame)+8, WINDOW_WIDTH-20, 01)];
        }else{
            
            viewLine2   = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(labelSuceessed.frame)+8, WINDOW_WIDTH-20, 01)];
        }
        viewLine2.backgroundColor = [UIColor lightGrayColor];
        viewLine2.alpha = 0.35;
        [cellView  addSubview:viewLine2];
        
        
        
        
        UILabel* labelAddr= [[UILabel alloc]init];
        labelAddr.text = @"买       家:";
        labelAddr.font = UIFont(16);
        [labelAddr sizeToFit];
        labelAddr.center = CGPointMake(10+labelAddr.bounds.size.width/2, CGRectGetMaxY(viewLine2.frame)+8+labelAddr.bounds.size.height/2);
        [cellView addSubview:labelAddr];
        
        self.labelAddr = [[UILabel alloc]init];
//                self.labelAddr.text = @"杭州市西湖区天目山路238号华鸿大厦A座302-董小姐";
        self.labelAddr.text =  [[self.dictData valueForKey:@"consigneeAddress"] toString];
        self.labelAddr.font =UIFont(16);
        
        self.labelAddr.numberOfLines = MAXFLOAT;
        self.labelAddr.lineBreakMode = NSLineBreakByWordWrapping;
//        CGSize size = CGSizeMake(WINDOW_WIDTH-100,MAXFLOAT);
//        CGSize labelsize = [self.labelAddr.text  sizeWithFont:self.labelAddr.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
//        self.labelAddr.frame = CGRectMake(CGRectGetMaxX(labelAddr.frame)+15, (iPhone6Plus?-2:0)+CGRectGetMidY(labelAddr.frame)-2-6, labelsize.width, labelsize.height);
        NSAttributedString *attributedText =
        [[NSAttributedString alloc]
         initWithString:self.labelAddr.text
         attributes:@
         {
         NSFontAttributeName: UIFont(16)
         }];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){WINDOW_WIDTH-100, CGFLOAT_MAX}
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        CGSize labelsize = rect.size;
        self.labelAddr.frame = CGRectMake(CGRectGetMaxX(labelAddr.frame)+15, (iPhone6Plus?-2:0)+CGRectGetMidY(labelAddr.frame)-2-6, labelsize.width, labelsize.height);
        [cellView addSubview:self.labelAddr];
        
        
        
        
        if ([[[self.dictData valueForKey:@"quickType"]toString]isEqualToString:@"1"]) {
            
            
               self.labelPhoneNumber = [[UILabel alloc]init];
            self.labelPhoneNumber.frame = self.labelAddr.frame;
        }else{
            
            if (Have) {
                
       
        UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.labelAddr.frame), CGRectGetMaxY(self.labelAddr.frame)+2, 24, 24)];
        imageView.image = [UIImage imageNamed:@"orderform_call_.png"];
        [cellView addSubview:imageView];
        
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
        [cellView addSubview:self.labelPhoneNumber];
            }else{
            //            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.labelAddr.frame), CGRectGetMaxY(self.labelAddr.frame)+5, 24, 24)];
            //            imageView.image = [UIImage imageNamed:@"orderform_call_.png"];
            //            [contentCell.contentView addSubview:imageView];
            
            self.labelPhoneNumber = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.labelAddr.frame), CGRectGetMaxY(self.labelAddr.frame)+8, 0, 0)];
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
            [cellView addSubview:self.labelPhoneNumber];
            
            
            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelPhoneNumber.frame), CGRectGetMaxY(self.labelAddr.frame)+3, 24, 24)];
            imageView.image = [UIImage imageNamed:@"orderform_call_.png"];
            [cellView addSubview:imageView];

            }
        
        UIButton* buttonMaiJiaTEL = [UIButton buttonWithType:UIButtonTypeCustom] ;
        buttonMaiJiaTEL.frame = CGRectMake(0, 0, 190, 35);
        buttonMaiJiaTEL.center =self.labelPhoneNumber.center;
        //            buttonMaiJiaTEL.backgroundColor = [UIColor redColor];
        [buttonMaiJiaTEL addTarget:self action:@selector(pressMaiJiaTEL) forControlEvents:UIControlEventTouchUpInside];
        [cellView addSubview:buttonMaiJiaTEL];
        
        }
        


        
        
        if ([[[self.dictData valueForKey:@"courierName"] toString] isEqualToString:@""]) {
            
        }else {
            UIView* viewLin = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelPhoneNumber.frame)+12, WINDOW_WIDTH-20, 01)];
            viewLin.backgroundColor = [UIColor lightGrayColor];
            viewLin.alpha = 0.35;
            [cellView addSubview:viewLin];
            
        self.buttonTEL = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.buttonTEL setTitle:[NSString stringWithFormat:@"配  送  员:   "] forState:UIControlStateNormal];
        self.buttonTEL.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.buttonTEL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      self.buttonTEL.titleLabel.font = UIFont(16);
//        [self.buttonTEL addTarget:self action:@selector(tel) forControlEvents:UIControlEventTouchUpInside];
        self.buttonTEL.frame = CGRectMake(10, CGRectGetMaxY(self.labelPhoneNumber.frame)+8, WINDOW_WIDTH, 40);
        [cellView addSubview:self.buttonTEL];
        
            
            UILabel* labelCourierName = [[UILabel alloc]init];
            labelCourierName.text = [[self.dictData valueForKey:@"courierName"] toString];
            labelCourierName.textColor =UICOLOR(249, 102, 34, 1);
            labelCourierName.font = UIFont(16);
            [labelCourierName sizeToFit];
            labelCourierName.center = CGPointMake(CGRectGetMaxX(labelJinE.frame)+15+labelCourierName.bounds.size.width/2, CGRectGetMidY(self.buttonTEL.frame));
            [cellView addSubview:labelCourierName];
            
              if ([[self.dictData valueForKey:@"courierRankIconUrl"] toString].length>1) {
            UIImageView* imageView = [[ UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labelCourierName.frame)+2, CGRectGetMaxY(self.labelPhoneNumber.frame)+8+14, 15, 15)];
            [SelfUser mddyRequestWIthImageWithWayQuickTypeIconUrl:[[self.dictData valueForKey:@"courierRankIconUrl"] toString] withMothed:@"downloadShopGroupICon.htm" withBlock:^(UIImage *image, NSError *error) {
                
                //                if (image) {
                
                imageView.image = image;
                imageView.bounds = CGRectMake(0, 0, 15, 15);
                imageView.contentMode = UIViewContentModeScaleToFill;
                //                }
                
                
            }];
            
            [cellView addSubview:imageView];
              }
            UIButton* buttonCourierName =[UIButton buttonWithType:UIButtonTypeCustom];
            buttonCourierName.frame = CGRectMake(0,CGRectGetMaxY(self.labelPhoneNumber.frame)+12, WINDOW_WIDTH-100, 40);
            [buttonCourierName addTarget:self action:@selector(buttonCourier) forControlEvents:UIControlEventTouchUpInside];
            [cellView addSubview:buttonCourierName];
             
        //            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-50,CGRectGetMidY(self.buttonTEL.frame)-15, 24, 24  )];
        //
        //            imageView.image = [UIImage imageNamed:@"orders_phone_n.png"];
        //
        //            [contentCell.contentView addSubview:imageView];
//            if (self.orderStatusED == ORDER_CANCEL) {//极速发单门店自己取消的判断
//            
//        }else{
            if (self.isDonig) {
                
          
                UIImageView* imageView1 =  [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-85-3+(iPhone6Plus?-7:0), CGRectGetMidY(self.buttonTEL.frame)-8, 16, 16)];

                imageView1.image = [UIImage imageNamed:@"map_card.png"];
        [cellView addSubview:imageView1];
        UILabel* labelLocation = [[UILabel alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-70-3+(iPhone6Plus?-7:0), CGRectGetMidY(self.buttonTEL.frame)-16, 70 , 32)] ;
                labelLocation.text = @"查看位置";
        labelLocation.font = UIFont(16);
        labelLocation.textColor =UICOLOR(249, 102, 34, 1);
        [cellView addSubview:labelLocation];
            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = labelLocation.frame;
            [button addTarget:self action:@selector(tel) forControlEvents:UIControlEventTouchUpInside];
            [cellView addSubview:button];
            
            }
//        }
        
        
            if (Have) {
                
       
        UIImageView* imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake((iPhone6?69: iPhone6Plus?69: 59)+25, CGRectGetMinY(self.buttonTEL.frame)+32, 24, 24)];
        imageView2.image = [UIImage imageNamed:@"orderform_call_.png"];
        [cellView addSubview:imageView2];
        
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
        [cellView addSubview:self.labelPhoneNumber];
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
                [cellView addSubview:self.labelPhoneNumber];
         
            
            UIImageView* imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelPhoneNumber.frame), CGRectGetMaxY(self.buttonTEL.frame)-8, 24, 24)];
            imageView2.image = [UIImage imageNamed:@"orderform_call_.png"];
            [cellView addSubview:imageView2];
                
                
            }
        UIButton* buttonPeiSongYuanTEL = [UIButton buttonWithType:UIButtonTypeCustom] ;
        buttonPeiSongYuanTEL.frame = CGRectMake(0, 0, 190, 35);
        buttonPeiSongYuanTEL.center =self.labelPhoneNumber.center;
        //                 buttonPeiSongYuanTEL.backgroundColor = [UIColor redColor];
        [buttonPeiSongYuanTEL addTarget:self action:@selector(buttonPeiSongYuanTEL) forControlEvents:UIControlEventTouchUpInside];
        [cellView addSubview:buttonPeiSongYuanTEL];
        
        }
        
//        UILabel*   labelAddr= [[UILabel alloc]init];
//        if (![[self.dictData valueForKey:@"consigneeTel"]  isEqualToString:@""]) {
//            
//            UILabel* labelLanShou= [[UILabel alloc]init];
//            labelLanShou.text = @"买家电话:";
//            labelLanShou.font = UIFont(16);
//            [labelLanShou sizeToFit];
//            labelLanShou.center = CGPointMake(10+labelLanShou.bounds.size.width/2, CGRectGetMaxY(viewLine2.frame)+11+labelLanShou.bounds.size.height/2);
//            [cell  addSubview:labelLanShou];
//            
//            self.labelLanShou = [[UILabel alloc]init];
//            //        self.labelLanShou.text = @"138 0057 0571";
//            if ([[self.dictData valueForKey:@"consigneeTel"] toString].length == 11 && [[[self.dictData valueForKey:@"consigneeTel"] toString] rangeOfString:@"-"].length==0) {
//                
//           
//            self.labelLanShou.text= [CommonUtils changePhoneNumberWithNumber:[self.dictData valueForKey:@"consigneeTel"] withType:@" "];
//            }else{
//                self.labelLanShou.text=[self.dictData valueForKey:@"consigneeTel"] ;
//
//            }
//            self.labelLanShou.font = UIFont(16);
//            [self.labelLanShou sizeToFit];
//            self.labelLanShou.center = CGPointMake(CGRectGetMaxX(labelLanShou.frame)+15+self.labelLanShou.bounds.size.width/2, CGRectGetMidY(labelLanShou.frame));
//            [cell addSubview:self.labelLanShou];
//            
//            
//            
//            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-50,CGRectGetMidY(self.labelLanShou.frame)-15, 24, 24  )];
//            imageView.userInteractionEnabled = YES;
//            imageView.image = [UIImage imageNamed:@"orders_phone_n.png"];
//            
//            [cell.contentView addSubview:imageView];
//            
//            self.buttonMaiJiaTEL = [UIButton buttonWithType:UIButtonTypeCustom];
//            self.buttonMaiJiaTEL.frame = CGRectMake(WINDOW_WIDTH-200,CGRectGetMidY(self.labelLanShou.frame)-15, 200, 35  );
//            [self.buttonMaiJiaTEL addTarget:self action:@selector(telMaiJia) forControlEvents:UIControlEventTouchUpInside];
//            [cell.contentView addSubview:self.buttonMaiJiaTEL];
//            
//            labelAddr.center = CGPointMake(10+labelAddr.bounds.size.width/2, CGRectGetMaxY(labelLanShou.frame)+8+labelAddr.bounds.size.height/2);
//            
//        }else{
//            labelAddr.center = CGPointMake(10+labelAddr.bounds.size.width/2, CGRectGetMaxY(viewLine2.frame)+8+labelAddr.bounds.size.height/2);
//            
//        }
//        
//        
//        labelAddr.text = @"收货地址:";
//        labelAddr.font = UIFont(16);
//        [labelAddr sizeToFit];
//        [cell addSubview:labelAddr];
//        
//        self.labelAddr = [[UILabel alloc]init];
//        //        self.labelAddr.text = @"杭州市西湖区天目山路238号华鸿大厦A座302-董小姐";
//        self.labelAddr.text = [[self.dictData valueForKey:@"consigneeAddress"] toString];
//        self.labelAddr.font = UIFont(16);
//        [self.labelAddr sizeToFit];
//        self.labelAddr.numberOfLines = MAXFLOAT;
//        self.labelAddr.lineBreakMode = NSLineBreakByWordWrapping;
//        CGSize size = CGSizeMake(WINDOW_WIDTH-100,MAXFLOAT);
//        CGSize labelsize = [self.labelAddr.text  sizeWithFont:self.labelAddr.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
//        self.labelAddr.frame = CGRectMake(CGRectGetMaxX(labelAddr.frame)+15, (iPhone6Plus?-2:0)+CGRectGetMidY(labelAddr.frame)-2-6, labelsize.width, labelsize.height);
//        [cell addSubview:self.labelAddr];
//        
//        
//        
//        
//        
////        if ( self.isDonig) {
//        if (![[[self.dictData valueForKey:@"courierName"] toString] isEqualToString:@""]) {
//            
//       
//            UIView* viewLin = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelAddr.frame)+8, WINDOW_WIDTH-20, 01)];
//            viewLin.backgroundColor = [UIColor lightGrayColor];
//            viewLin.alpha = 0.35;
//            [cell addSubview:viewLin];
//            self.buttonTEL = [UIButton buttonWithType:UIButtonTypeCustom];
//            [self.buttonTEL setTitle:[NSString stringWithFormat:@"配送员:  %@",[[self.dictData valueForKey:@"courierName"] toString]] forState:UIControlStateNormal];
//            _buttonTEL.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//            [self.buttonTEL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            self.buttonTEL.titleLabel.font = UIFont(16);
//            [self.buttonTEL addTarget:self action:@selector(tel) forControlEvents:UIControlEventTouchUpInside];
//            self.buttonTEL.frame = CGRectMake(10, CGRectGetMaxY(self.labelAddr.frame)+8, WINDOW_WIDTH, 40);
//            [cell addSubview:self.buttonTEL];
//            
//            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-50,CGRectGetMidY(self.buttonTEL.frame)-15, 24, 24  )];
//            
//            imageView.image = [UIImage imageNamed:@"orders_phone_n.png"];
//            
//            [cell addSubview:imageView];
//            
//            
////        }
//        }
        // Do any additional setup after loading the view from its nib.
        
        
        
        
    }else{
        if (self.orderStatusED == ORDER_JUSHOU) {
            label.text = @"订单已被拒收";
        }else{
            label.text = @"订单拒收中";
        }
        
        UIImageView* cellImageView1 = [UIImageView circleImageViewFrame:CGRectMake(10, 40, 40,40) Radius:40/2];
        __weak UIImageView* cellImageView =   cellImageView1;
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
//        [SelfUser mddyRequestWIthImageWithBrandID:[self.dictData valueForKey:@"brandIdUrl"] withBlock:^(UIImage * image, NSError *error) {
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
        [cellView addSubview:cellImageView];
        
        UILabel* labelTitel = [[UILabel alloc]init];
        //        labelTitel.text  =@"绝味鸭脖（天目山路店）";
        labelTitel.font = UIFont(16);
        labelTitel.text = [[self.dictData valueForKey:@"shopName"] toString];
        [labelTitel sizeToFit];
        labelTitel.bounds = CGRectMake(0, 0, 160, 40);
        labelTitel.center = CGPointMake(CGRectGetMaxX(cellImageView.frame)+6+labelTitel.bounds.size.width/2, CGRectGetMidY(cellImageView.frame));
        [cellView addSubview:labelTitel];
        
        UILabel* labelDanHao = [[UILabel alloc]init];
        //        labelDanHao.text = @"运单号：123456";
        labelDanHao.text = [NSString stringWithFormat:@"订单号:%@",[[self.dictData valueForKey:@"waybillCode"] toString]];
        [labelDanHao sizeToFit];
        labelDanHao.textColor = [UIColor darkGrayColor];
        labelDanHao.font = UIFont(13);
        labelDanHao.center = CGPointMake(WINDOW_WIDTH-40+(iphone6_6P_isYES?:2), CGRectGetMidY(cellImageView.frame));
        [cellView addSubview:labelDanHao];
        
        UIView* viewLine1 = [[UIView alloc]initWithFrame:CGRectMake(10, 82, WINDOW_WIDTH-20, 1)];
        viewLine1.backgroundColor = [UIColor lightGrayColor];
        viewLine1.alpha = 0.35;
        [cellView addSubview:viewLine1];
        
        
        
        
        UILabel* labelJinE = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, iphone6_6P_isYES?69:59, 0)];
        labelJinE.text = @"订单金额:";
        labelJinE.font = UIFont(16);
        [labelJinE sizeToFit];
        labelJinE.center = CGPointMake(10+labelJinE.bounds.size.width/2, CGRectGetMaxY(viewLine1.frame)+20);
        
        [cellView  addSubview:labelJinE];
        
        
        
        self.labelPrice = [[UILabel alloc]initWithFrame:CGRectMake(100, 90, 80, 20)];
        //        self.labelPrice.text = @"24.00元";
        self.labelPrice.text =[NSString stringWithFormat:@"%.2f元",[[self.dictData valueForKey:@"waybillPrice"] floatValue]/100];
        [self.labelPrice sizeToFit];
        self.labelPrice.font = UIFont(16);
        self.labelPrice.center = CGPointMake(CGRectGetMaxX(labelJinE.frame)+15+self.labelPrice.bounds.size.width/2, CGRectGetMidY(labelJinE.frame));
        [cellView addSubview:self.labelPrice];
        
        
        
        UILabel* labelFaDan = [[UILabel alloc]init];
        labelFaDan.text = @"发单时间:";
        labelFaDan.font = UIFont(16);
        [labelFaDan sizeToFit];
        labelFaDan.center = CGPointMake(10+labelFaDan.bounds.size.width/2, CGRectGetMaxY(labelJinE.frame)+8+labelFaDan.bounds.size.height/2);
        [cellView addSubview:labelFaDan];
        
        self.labelSend = [[UILabel alloc]init];
        //        self.labelSend.text = @"2014-12-10 12:12";
        if (self.isDonig) {
             self.labelSend.text =   [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"createTime"] toString]withFormat:@"HH:mm"];
        }else{
         self.labelSend.text =   [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"createTime"] toString]withFormat:@"MM月dd日 HH:mm"];
        }
//        self.labelSend.text = [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"createTime"]toString]];
        self.labelSend.font = UIFont(16);
        [self.labelSend sizeToFit];
        self.labelSend.center = CGPointMake(CGRectGetMaxX(labelFaDan.frame)+15+self.labelSend.bounds.size.width/2, CGRectGetMidY(labelFaDan.frame));
        [cellView addSubview:self.labelSend];
        
        
        UILabel* labelSuceessed = [[UILabel alloc]init];
        labelSuceessed.text = @"揽收时间:";
        labelSuceessed.font = UIFont(16);
        [labelSuceessed sizeToFit];
        labelSuceessed.center = CGPointMake(10+labelSuceessed.bounds.size.width/2, CGRectGetMaxY(labelFaDan.frame)+8+labelSuceessed.bounds.size.height/2);
        [cellView addSubview:labelSuceessed];
        
        self.labelSuccessed = [[UILabel alloc]init];
        //        self.labelSuccessed.text = @"2014-12-10 12:12";
         if (self.isDonig) {
               self.labelSuccessed.text =   [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"collectionTime"] toString]withFormat:@"HH:mm"];
         }else{
       self.labelSuccessed.text =   [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"collectionTime"] toString]withFormat:@"MM月dd日 HH:mm"];
         }
//        self.labelSuccessed.text = [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"collectionTime"]toString]];
        
        self.labelSuccessed.font = UIFont(16);
        [self.labelSuccessed sizeToFit];
        self.labelSuccessed.center = CGPointMake(CGRectGetMaxX(labelSuceessed.frame)+15+self.labelSuccessed.bounds.size.width/2, CGRectGetMidY(labelSuceessed.frame));
        [cellView addSubview:self.labelSuccessed];
        
        
        
        
        UILabel* labelQianShou= [[UILabel alloc]init];
        if (self.orderStatusED == ORDER_JUSHOU) {
            labelQianShou.text = @"完成时间:";
        }else{
            labelQianShou.text = @"拒收时间:";
        }
        labelQianShou.font = UIFont(16);
        [labelQianShou sizeToFit];
        labelQianShou.center = CGPointMake(10+labelQianShou.bounds.size.width/2, CGRectGetMaxY(self.labelSuccessed.frame)+8+labelQianShou.bounds.size.height/2);
        [cellView addSubview:labelQianShou];
        
        self.labelQianShou = [[UILabel alloc]init];
        //        self.labelQianShou.text = @"2014-12-10 12:12";
        
        if (self.orderStatusED == ORDER_JUSHOU) {
            labelQianShou.text = @"完成时间:";
            if (self.isDonig) {
                self.labelQianShou.text=   [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"receivingTime"] toString]withFormat:@"HH:mm"];

            }else{
            self.labelQianShou.text=   [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"receivingTime"] toString]withFormat:@"MM月dd日 HH:mm"];
            }
//            self.labelQianShou.text =[CommonUtils getDateForStringTime: [[self.dictData valueForKey:@"receivingTime"]toString]];
        }else{
            
            labelQianShou.text = @"拒收时间:";
              if (self.isDonig) {
              self.labelQianShou.text =   [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"killedTime"] toString]withFormat:@"HH:mm"];
              }else{
                  self.labelQianShou.text =   [CommonUtils getDateForStringTime:[[self.dictData valueForKey:@"killedTime"] toString]withFormat:@"MM月dd日 HH:mm"];

              }
//            self.labelQianShou.text =[CommonUtils getDateForStringTime: [[self.dictData valueForKey:@"killedTime"]toString]];
        }
        
        self.labelQianShou.font = UIFont(16);
        [self.labelQianShou sizeToFit];
        self.labelQianShou.center = CGPointMake(CGRectGetMaxX(labelQianShou.frame)+15+self.labelQianShou.bounds.size.width/2, CGRectGetMidY(labelQianShou.frame));
        [cellView addSubview:self.labelQianShou];
        
        UILabel* labelJuShouReason= [[UILabel alloc]init];
        labelJuShouReason.text = @"拒收原因:";
        labelJuShouReason.font = UIFont(16);
        [labelJuShouReason sizeToFit];
        labelJuShouReason.center = CGPointMake(10+labelQianShou.bounds.size.width/2, CGRectGetMaxY(labelQianShou.frame)+8+labelJuShouReason.bounds.size.height/2);
        [cellView addSubview:labelJuShouReason];
        
        self.labelJuShouReason = [[UILabel alloc]init];
        //        self.labelJuShouReason.text = @"2014-12-10 12:12";
        self.labelJuShouReason.text = [[self.dictData valueForKey:@"killedReason"] toString];
        self.labelJuShouReason.font = UIFont(16);
        self.labelJuShouReason.numberOfLines = MAXFLOAT;
        
        self.labelJuShouReason.lineBreakMode = NSLineBreakByWordWrapping;
//        CGSize size1 = CGSizeMake(WINDOW_WIDTH-100,MAXFLOAT);
//        CGSize labelsize1 = [self.labelJuShouReason.text  sizeWithFont:self.labelJuShouReason.font constrainedToSize:size1 lineBreakMode:NSLineBreakByWordWrapping];
        NSAttributedString *attributedText =
        [[NSAttributedString alloc]
         initWithString:self.labelJuShouReason.text
         attributes:@
         {
         NSFontAttributeName: UIFont(16)
         }];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){WINDOW_WIDTH-100, CGFLOAT_MAX}
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        CGSize labelsize1 = rect.size;
        self.labelJuShouReason.frame = CGRectMake(CGRectGetMaxX(labelJuShouReason.frame)+15,(iPhone6Plus?-2:0)+ CGRectGetMidY(labelJuShouReason.frame)-2-6, labelsize1.width,+ labelsize1.height);
        [cellView addSubview:self.labelJuShouReason];
        
           UIView* viewLine2 = nil;
        
        if ([[[self.dictData valueForKey:@"killedMemo"] toString] isEqualToString:@""]) {
            if ([[self.dictData valueForKey:@"rejectedPhotoCount"]intValue]>0 || [[self.dictData valueForKey:@"killedPhoto"]intValue]>0)  {
                
                
                UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labelJuShouReason.frame)+15, CGRectGetMaxY(self.labelJuShouReason.frame)+10, 98, 74)];
                //            imageView.image = [UIImage imageNamed:@"photo_dealing_bg.png"];
                
                
                [SelfUser mddyRequestWIthImageWithWaybillId:[[self.dictData valueForKey:@"waybillId"]toString] withIndex:@"1" withBlock:^(UIImage *image, NSError *error) {
                    
                    imageView.image = image;
                    imageView.userInteractionEnabled = YES;
                    _firstImage = image;
                    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFirstBigImageButtonPressed:)];
                    [imageView addGestureRecognizer:singleTap];
                    
                }];
                
                
                [cellView addSubview:imageView];
                if ([[self.dictData valueForKey:@"rejectedPhotoCount"] intValue] == 2 ||[[self.dictData valueForKey:@"killedPhoto"] intValue] == 2) {
                    
                    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labelJuShouReason.frame)+15 +98+5, CGRectGetMaxY(self.labelJuShouReason.frame)+10, 98, 74)];
                    //                imageView.image = [UIImage imageNamed:@"photo_dealing_bg.png"];
                    [SelfUser mddyRequestWIthImageWithWaybillId:[[self.dictData valueForKey:@"waybillId"]toString] withIndex:@"2" withBlock:^(UIImage *image, NSError *error) {
                        imageView.image = image;
                        
                        imageView.userInteractionEnabled = YES;
                        _secondImage = image;
                        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSecondBigImageButtonPressed:)];
                        [imageView addGestureRecognizer:singleTap];
                        
                    }];
                    [cellView addSubview:imageView];
                    
                }
                 viewLine2= [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame)+8, WINDOW_WIDTH-20, 01)];
//                labelAddress.center = CGPointMake(10+labelAddress.bounds.size.width/2, CGRectGetMaxY(imageView.frame)+8+labelAddress.bounds.size.height/2);
            }else{
                 viewLine2= [[UIView alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(labelJuShouReason.frame)+8, WINDOW_WIDTH-20, 01)];
//                labelAddress.center = CGPointMake(10+labelAddress.bounds.size.width/2, CGRectGetMaxY(labelJuShouReason.frame)+8+labelAddress.bounds.size.height/2);
            }
            
            

        }else{
        
        UILabel* labelAddress = [[UILabel alloc]init];
        labelAddress.text = @"备       注:";
        labelAddress.font = UIFont(16);
        [labelAddress sizeToFit];
        
        if ([[self.dictData valueForKey:@"rejectedPhotoCount"]intValue]>0 || [[self.dictData valueForKey:@"killedPhoto"]intValue]>0)  {
            
            
            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labelJuShouReason.frame)+15, CGRectGetMaxY(self.labelJuShouReason.frame)+10, 98, 74)];
            //            imageView.image = [UIImage imageNamed:@"photo_dealing_bg.png"];
            
            
            [SelfUser mddyRequestWIthImageWithWaybillId:[[self.dictData valueForKey:@"waybillId"]toString] withIndex:@"1" withBlock:^(UIImage *image, NSError *error) {
                
                imageView.image = image;
                imageView.userInteractionEnabled = YES;
                _firstImage = image;
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFirstBigImageButtonPressed:)];
                [imageView addGestureRecognizer:singleTap];
                
            }];
            
            
            [cellView addSubview:imageView];
            if ([[self.dictData valueForKey:@"rejectedPhotoCount"] intValue] == 2 ||[[self.dictData valueForKey:@"killedPhoto"] intValue] == 2) {
                
                UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labelJuShouReason.frame)+15 +98+5, CGRectGetMaxY(self.labelJuShouReason.frame)+10, 98, 74)];
                //                imageView.image = [UIImage imageNamed:@"photo_dealing_bg.png"];
                [SelfUser mddyRequestWIthImageWithWaybillId:[[self.dictData valueForKey:@"waybillId"]toString] withIndex:@"2" withBlock:^(UIImage *image, NSError *error) {
                    imageView.image = image;
                    
                    imageView.userInteractionEnabled = YES;
                    _secondImage = image;
                    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSecondBigImageButtonPressed:)];
                    [imageView addGestureRecognizer:singleTap];
                    
                }];
                [cellView addSubview:imageView];
                
            }
            
            labelAddress.center = CGPointMake(10+labelAddress.bounds.size.width/2, CGRectGetMaxY(imageView.frame)+8+labelAddress.bounds.size.height/2);
        }else{
            labelAddress.center = CGPointMake(10+labelAddress.bounds.size.width/2, CGRectGetMaxY(labelJuShouReason.frame)+8+labelAddress.bounds.size.height/2);
        }
        
        
        
        
        [cellView addSubview:labelAddress];
        
        self.labelAddressed = [[UILabel alloc]init];
//               self.labelAddressed.text = @"热饮，小心烫口，先喝第一口汤，在啃鸭脖，然后再喝第二口汤。";

            self.labelAddressed.text = [[self.dictData valueForKey:@"killedMemo"] toString];
            

      
        self.labelAddressed.font = UIFont(16);
        //        [self.labelAddressed sizeToFit];
        self.labelAddressed.numberOfLines = MAXFLOAT;
        self.labelAddressed.lineBreakMode = NSLineBreakByWordWrapping;
//        CGSize size2 = CGSizeMake(WINDOW_WIDTH-100,MAXFLOAT);
//        CGSize labelsize2 = [self.labelAddressed.text  sizeWithFont:self.labelAddressed.font constrainedToSize:size2 lineBreakMode:NSLineBreakByWordWrapping];
        NSAttributedString *attributedText =
        [[NSAttributedString alloc]
             initWithString:self.labelAddressed.text
             attributes:@
             {
             NSFontAttributeName: UIFont(16)
             }];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){WINDOW_WIDTH-100, CGFLOAT_MAX}
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                       context:nil];
        CGSize labelsize2 = rect.size;
        self.labelAddressed.frame = CGRectMake(CGRectGetMaxX(labelAddress.frame)+15,(iPhone6Plus?-2:0)+ CGRectGetMidY(labelAddress.frame)-2-6, labelsize2.width, labelsize2.height);
        [cellView addSubview:self.labelAddressed];
        
         viewLine2= [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelAddressed.frame)+8, WINDOW_WIDTH-20, 01)];
        }
     
     
     
        
        viewLine2.backgroundColor = [UIColor lightGrayColor];
        viewLine2.alpha = 0.35;
        [cellView addSubview:viewLine2];
        
        
        
        
        
//        UILabel* labelAddr= [[UILabel alloc]init];
//        if (![[self.dictData valueForKey:@"consigneeTel"]  isEqualToString:@""]) {
//            
//            UIImageView* imageView ;
//            
//            if ([[self.dictData allKeys]containsObject:@"consigneeTel"]) {
//                UILabel* labelPhoneNumber= [[UILabel alloc]init];
//                labelPhoneNumber.text = @"买家电话:";
//                labelPhoneNumber.font =UIFont(16);
//                [labelPhoneNumber sizeToFit];
//                labelPhoneNumber.center = CGPointMake(10+labelPhoneNumber.bounds.size.width/2, CGRectGetMaxY(viewLine2.frame)+11+labelPhoneNumber.bounds.size.height/2);
//                [cell addSubview:labelPhoneNumber];
//                
//                self.labelPhoneNumber = [[UILabel alloc]init];
//                //        self.labelPhoneNumber.text = @"138 0057 0571";
//                if ([[self.dictData valueForKey:@"consigneeTel"] toString].length == 11&& [[[self.dictData valueForKey:@"consigneeTel"] toString] rangeOfString:@"-"].length==0) {
//                    
//             
//                self.labelPhoneNumber.text = [CommonUtils changePhoneNumberWithNumber:[self.dictData valueForKey:@"consigneeTel"] withType:@" "];
//                }else{
//                    self.labelPhoneNumber.text = [self.dictData valueForKey:@"consigneeTel"]    ;
//                }
//                self.labelPhoneNumber.font = UIFont(16);
//                [self.labelPhoneNumber sizeToFit];
//                self.labelPhoneNumber.center = CGPointMake(CGRectGetMaxX(labelPhoneNumber.frame)+15+self.labelPhoneNumber.bounds.size.width/2, CGRectGetMidY(labelPhoneNumber.frame));
//                [cell addSubview:self.labelPhoneNumber];
//                imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-50,CGRectGetMidY(self.labelPhoneNumber.frame)-15, 24, 24  )];
//                
//            }else{
//                imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-50,CGRectGetMidY(viewLine2.frame)-15, 24, 24  )];
//            }
//            
//            
//            
//            
//            
//            
//            imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-50,CGRectGetMidY(self.labelPhoneNumber.frame)-15, 24, 24  )];
//            imageView.userInteractionEnabled = YES;
//            imageView.image = [UIImage imageNamed:@"orders_phone_n.png"];
//            
//            [cell.contentView addSubview:imageView];
//            
//            self.buttonMaiJiaTEL = [UIButton buttonWithType:UIButtonTypeCustom];
//            self.buttonMaiJiaTEL.frame = CGRectMake(WINDOW_WIDTH-200,CGRectGetMidY(self.labelPhoneNumber.frame)-15, 200, 35  );
//            [self.buttonMaiJiaTEL addTarget:self action:@selector(telMaiJia) forControlEvents:UIControlEventTouchUpInside];
//            [cell.contentView addSubview:self.buttonMaiJiaTEL];
//            labelAddr.center = CGPointMake(10+labelAddr.bounds.size.width/2, CGRectGetMaxY(self.labelPhoneNumber.frame)+8+labelAddr.bounds.size.height/2);
//        }else{
//            labelAddr.center = CGPointMake(10+labelAddr.bounds.size.width/2, CGRectGetMaxY(viewLine2.frame)+8+labelAddr.bounds.size.height/2);
//        }
//        
//        
//        labelAddr.text = @"收货地址:";
//        labelAddr.font = UIFont(16);
//        [labelAddr sizeToFit];
//        
//        [cell addSubview:labelAddr];
//        
//        self.labelAddr = [[UILabel alloc]init];
//        //        self.labelAddr.text = @"杭州市西湖区天目山路238号华鸿大厦A座302-董小姐";
//        self.labelAddr.text =  [[self.dictData valueForKey:@"consigneeAddress"] toString];
//        self.labelAddr.font =UIFont(16);
//        
//        self.labelAddr.numberOfLines = MAXFLOAT;
//        self.labelAddr.lineBreakMode = NSLineBreakByWordWrapping;
//        CGSize size = CGSizeMake(WINDOW_WIDTH-100,MAXFLOAT);
//        CGSize labelsize = [self.labelAddr.text  sizeWithFont:self.labelAddr.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
//        self.labelAddr.frame = CGRectMake(CGRectGetMaxX(labelAddr.frame)+15, (iPhone6Plus?-2:0)+CGRectGetMidY(labelAddr.frame)-2-6, labelsize.width, labelsize.height);
//        [cell addSubview:self.labelAddr];
//
                UILabel* labelAddr= [[UILabel alloc]init];
                labelAddr.text = @"买       家:";
                labelAddr.font = UIFont(16);
                [labelAddr sizeToFit];
                labelAddr.center = CGPointMake(10+labelAddr.bounds.size.width/2, CGRectGetMaxY(viewLine2.frame)+8+labelAddr.bounds.size.height/2);
                [cellView addSubview:labelAddr];
        
                self.labelAddr = [[UILabel alloc]init];
                //        self.labelAddr.text = @"杭州市西湖区天目山路238号华鸿大厦A座302-董小姐";
                self.labelAddr.text =  [[self.dictData valueForKey:@"consigneeAddress"] toString];
                self.labelAddr.font =UIFont(16);
        
                self.labelAddr.numberOfLines = MAXFLOAT;
                self.labelAddr.lineBreakMode = NSLineBreakByWordWrapping;
//                CGSize size = CGSizeMake(WINDOW_WIDTH-100,MAXFLOAT);
//                CGSize labelsize = [self.labelAddr.text  sizeWithFont:self.labelAddr.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        attributedText =
        [[NSAttributedString alloc]
         initWithString:self.labelAddr.text
         attributes:@
         {
         NSFontAttributeName: UIFont(16)
         }];
        rect = [attributedText boundingRectWithSize:(CGSize){WINDOW_WIDTH-100, CGFLOAT_MAX}
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        CGSize labelsize = rect.size;
                self.labelAddr.frame = CGRectMake(CGRectGetMaxX(labelAddr.frame)+15, (iPhone6Plus?-2:0)+CGRectGetMidY(labelAddr.frame)-2-6, labelsize.width, labelsize.height);
                [cellView addSubview:self.labelAddr];
        
        
        
        
        if (Have) {
            
    
        UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.labelAddr.frame), CGRectGetMinY(self.labelAddr.frame)+25, 24, 24)];
        imageView.image = [UIImage imageNamed:@"orderform_call_.png"];
        [cellView addSubview:imageView];
        
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
        [cellView addSubview:self.labelPhoneNumber];
        }else{
      
            
            self.labelPhoneNumber = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.labelAddr.frame), CGRectGetMaxY(self.labelAddr.frame)+8, 0, 0)];
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
            [cellView addSubview:self.labelPhoneNumber];
            
            
            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelPhoneNumber.frame), CGRectGetMaxY(self.labelAddr.frame)+3, 24, 24)];
            imageView.image = [UIImage imageNamed:@"orderform_call_.png"];
            [cellView addSubview:imageView];
        }
        
        UIButton* buttonMaiJiaTEL = [UIButton buttonWithType:UIButtonTypeCustom] ;
        buttonMaiJiaTEL.frame = CGRectMake(0, 0, 190, 35);
        buttonMaiJiaTEL.center =self.labelPhoneNumber.center;
        //            buttonMaiJiaTEL.backgroundColor = [UIColor redColor];
        [buttonMaiJiaTEL addTarget:self action:@selector(pressMaiJiaTEL) forControlEvents:UIControlEventTouchUpInside];
        [cellView addSubview:buttonMaiJiaTEL];


        
        
        
        
        
//        UIView* viewLin = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelPhoneNumber.frame)+8, WINDOW_WIDTH-20, 01)];
//        viewLin.backgroundColor = [UIColor lightGrayColor];
//        viewLin.alpha = 0.35;
//        [cell addSubview:viewLin];
        
        
//        self.buttonTEL = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.buttonTEL setTitle:[NSString stringWithFormat:@"配送员:  %@",[[self.dictData valueForKey:@"courierName"] toString]] forState:UIControlStateNormal];
//        _buttonTEL.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [self.buttonTEL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        self.buttonTEL.titleLabel.font = UIFont(16);
//        [self.buttonTEL addTarget:self action:@selector(tel) forControlEvents:UIControlEventTouchUpInside];
//        self.buttonTEL.frame = CGRectMake(10, CGRectGetMaxY(self.labelAddr.frame)+8, WINDOW_WIDTH, 40);
//        [cell addSubview:self.buttonTEL];
//        
//        UIImageView* imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-50,CGRectGetMidY(self.buttonTEL.frame)-15, 24, 24  )];
//        
//        imageView1.image = [UIImage imageNamed:@"orders_phone_n.png"];
//        
//        [cell addSubview:imageView1];
        
        UIView* viewLin = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.labelPhoneNumber.frame)+14, WINDOW_WIDTH-20, 01)];
        viewLin.backgroundColor = [UIColor lightGrayColor];
        viewLin.alpha = 0.35;
        [cellView addSubview:viewLin];
        
        
        self.buttonTEL = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.buttonTEL setTitle:[NSString stringWithFormat:@"配  送  员:   "] forState:UIControlStateNormal];
        _buttonTEL.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.buttonTEL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.buttonTEL.titleLabel.font = UIFont(16);
//        [self.buttonTEL addTarget:self action:@selector(tel) forControlEvents:UIControlEventTouchUpInside];
        self.buttonTEL.frame = CGRectMake(10, CGRectGetMaxY(self.labelPhoneNumber.frame)+12, WINDOW_WIDTH, 40);
        [cellView addSubview:self.buttonTEL];
        
        UILabel* labelCourierName = [[UILabel alloc]init];
        labelCourierName.text = [[self.dictData valueForKey:@"courierName"] toString];
        labelCourierName.textColor =UICOLOR(249, 102, 34, 1);
        labelCourierName.font = UIFont(16);
        [labelCourierName sizeToFit];
        labelCourierName.center = CGPointMake(CGRectGetMaxX(labelJinE.frame)+15+labelCourierName.bounds.size.width/2, CGRectGetMidY(self.buttonTEL.frame));
        [cellView addSubview:labelCourierName];
        
         if ([[self.dictData valueForKey:@"courierRankIconUrl"] toString].length>1) {
        UIImageView* imageView =[[ UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labelCourierName.frame)+2, CGRectGetMaxY(self.labelPhoneNumber.frame)+8+16, 15, 15)];
             [SelfUser mddyRequestWIthImageWithWayQuickTypeIconUrl:[[self.dictData valueForKey:@"courierRankIconUrl"] toString] withMothed:@"downloadShopGroupICon.htm" withBlock:^(UIImage *image, NSError *error) {
                 
                 //                if (image) {
                 
                 imageView.image = image;
                 imageView.bounds = CGRectMake(0, 0, 15, 15);
                 imageView.contentMode = UIViewContentModeScaleToFill;
                 //                }
                 
                 
             }];

        
        [cellView addSubview:imageView];
         }
        
        UIButton* buttonCourierName =[UIButton buttonWithType:UIButtonTypeCustom];
        buttonCourierName.frame = CGRectMake(0,CGRectGetMaxY(self.labelPhoneNumber.frame)+12, WINDOW_WIDTH-100, 40);
        [buttonCourierName addTarget:self action:@selector(buttonCourier) forControlEvents:UIControlEventTouchUpInside];
        [cellView addSubview:buttonCourierName];
        

        //            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-50,CGRectGetMidY(self.buttonTEL.frame)-15, 24, 24  )];
        //
        //            imageView.image = [UIImage imageNamed:@"orders_phone_n.png"];
        //
        //            [contentCell.contentView addSubview:imageView];
        
        
        if (self.orderStatusED == ORDER_JUSHOU) {
            
        }else{
        UIImageView* imageView1 =  [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-85, CGRectGetMidY(self.buttonTEL.frame)-8, 16, 16)];
        imageView1.image = [UIImage imageNamed:@"map_card.png"];
        [cellView addSubview:imageView1];
        UILabel* labelLocation = [[UILabel alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-70, CGRectGetMidY(self.buttonTEL.frame)-16, 70 , 32)] ;
        labelLocation.text = @"查看位置";
        labelLocation.font = UIFont(16);
        labelLocation.textColor =UICOLOR(249, 102, 34, 1);
        [cellView addSubview:labelLocation];
        
            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = labelLocation.frame;
            [button addTarget:self action:@selector(tel) forControlEvents:UIControlEventTouchUpInside];
            [cellView addSubview:button];
        }
        
        
        if (Have) {
            
        UIImageView* imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake((iPhone6?69: iPhone6Plus?69: 59)+25, CGRectGetMinY(self.buttonTEL.frame)+35, 24, 24)];
        imageView2.image = [UIImage imageNamed:@"orderform_call_.png"];
        [cellView addSubview:imageView2];
        
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
        [cellView addSubview:self.labelPhoneNumber];
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
            [cellView addSubview:self.labelPhoneNumber];
            
            
            UIImageView* imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.labelPhoneNumber.frame), CGRectGetMaxY(self.buttonTEL.frame)-8, 24, 24)];
            imageView2.image = [UIImage imageNamed:@"orderform_call_.png"];
            [cellView addSubview:imageView2];
        }
        UIButton* buttonPeiSongYuanTEL = [UIButton buttonWithType:UIButtonTypeCustom] ;
        buttonPeiSongYuanTEL.frame = CGRectMake(0, 0, 190, 35);
        buttonPeiSongYuanTEL.center =self.labelPhoneNumber.center;
//                 buttonPeiSongYuanTEL.backgroundColor = [UIColor redColor];
        [buttonPeiSongYuanTEL addTarget:self action:@selector(buttonPeiSongYuanTEL) forControlEvents:UIControlEventTouchUpInside];
        [cellView addSubview:buttonPeiSongYuanTEL];

        
        
        
        
    }
    
    
    
    [cellView addSubview:imageView];
    
    cell = cellView;
    [cellView  removeFromSuperview];
    cellView = nil;
    return cell;
}


- (IBAction)showFirstBigImageButtonPressed:(UIButton *)sender
{
    if (!_firstImage)
    {
        return;
    }
    else
    {
        NSString *aString = @"CExpandPicViewController";
        
        CExpandPicViewController *expandPicViewController = [[CExpandPicViewController alloc] initWithNibName:aString bundle:nil];
        expandPicViewController.image = _firstImage;
        
        [self presentViewController:expandPicViewController animated:NO completion:nil];
        expandPicViewController = nil;
    }
}

- (IBAction)showSecondBigImageButtonPressed:(UIButton *)sender
{
    if (!_secondImage)
    {
        return;
    }
    else
    {
        NSString *aString = @"CExpandPicViewController";
        
        CExpandPicViewController *expandPicViewController = [[CExpandPicViewController alloc] initWithNibName:aString bundle:nil];
        expandPicViewController.image = _secondImage;
        
        [self presentViewController:expandPicViewController animated:NO completion:nil];
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    CGSize size = CGSizeMake(WINDOW_WIDTH-100,MAXFLOAT);
//    NSLog(@"%@",[[[self.dictData valueForKey:@"killedMemo"] toString] stringByAppendingString:[[self.dictData valueForKey:@"killedReason"] toString]]  );
//    CGSize labelsize = [[[[self.dictData valueForKey:@"killedMemo"] toString] stringByAppendingString:[[self.dictData valueForKey:@"killedReason"] toString]]  sizeWithFont:UIFont(16) constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:[[[self.dictData valueForKey:@"killedMemo"] toString] stringByAppendingString:[[self.dictData valueForKey:@"killedReason"] toString]]
     attributes:@
     {
     NSFontAttributeName: UIFont(16)
     }];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){WINDOW_WIDTH-100, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize labelsize = rect.size;
    NSLog(@"%f",labelsize.height);
    
    
    if ([[self.dictData valueForKey:@"rejectedPhotoCount"] toString]==0) {
        
        return self.tableView.bounds.size.height+labelsize.height+20+13;
    }
//    if ([[self.dictData valueForKey:@"killedPhoto"]toInt] >=1) {
            return self.tableView.bounds.size.height+labelsize.height+13;
//    }
//    return self.tableView.bounds.size.height+labelsize.height+13-135;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.orderStatus == ORDER_ERROR_STATUS_WAIT_JUSHOU) {
        if (self.orderStatusED ==ORDER_JUSHOU) {
            return 0.01;
        }
        return 70;
    }else{
        return 0.01;
    }
    return 0.01;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView* cellView = nil;
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, WINDOW_WIDTH, 150)];
    
    if (self.orderStatus == ORDER_ERROR_STATUS_WAIT_JUSHOU) {
        if (self.orderStatusED ==ORDER_JUSHOU) {
            return view;
        }
        UIButton* buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonCancel addTarget:self action:@selector(juShouButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [buttonCancel setTitle:@"同意" forState:UIControlStateNormal];
        float red = 252/255.0;
        float green = 102/255.0;
        float blue = 5/255.0;
        [buttonCancel setBackgroundColor: [UIColor colorWithRed:red green:green blue:blue alpha:1.0]];
        buttonCancel.layer.cornerRadius = 3;
        buttonCancel.frame = CGRectMake(16, 23, WINDOW_WIDTH-32, 44);
        [view addSubview:buttonCancel];
        buttonCancel = nil;
    }
        
    cellView = view;
    [view removeFromSuperview];
    view = nil;
    return cellView;

}

-(void)setView{
    
    
    
    
    
      
    
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
-(void)back{
    [self.tableView removeFromSuperview];
    self.tableView = nil;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        
        if (alertView.tag == 102) {
         
            [SelfUser hudShowWithViewcontroller:self];
            
            NSLog(@"%@",self.strWayBillld);
            [SelfUser mddyRequestWithMethodName:@"confirmRejectedWaybillDetailJsonPhone.htm" withParams:@{@"waybillId":self.strWayBillld} withBlock:^(id responseObject, NSError *error) {
//                [SVProgressHUD dismiss ];
//                [SelfUser hudHideWithViewcontroller:self];
//                [MBProgressHUD hudHideWithViewcontroller:self];
                if (!error) {
                    @try {
                        
                        
                        [self.navigationController popViewControllerAnimated:YES];

                        
                    }
                    @catch (NSException *exception) {
                        
                    }
                    @finally {
                        
                    }
                    
                    
                }else{
                       [SelfUser hudHideWithViewcontroller:self];
//                    [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
                    [MBProgressHUD hudShowWithStatus:self :[SelfUser currentSelfUser].ErrorMessage];
                }
                
                
            }];

            
            return;
        }
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.strTEL]];
        
        [[UIApplication sharedApplication] openURL:url];
    }
    
}
-(void)tel{
//    NSString *telUrl = [NSString stringWithFormat:@"%@",[[self.dictData valueForKey:@"courierTel"] toString]];
//    self.strTEL = telUrl;
//    UIAlertView* alert  =[[UIAlertView alloc]initWithTitle:@"  确认拨打配送员电话？" message:telUrl delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
//    alert.tag = 101;
//    [alert show];
    MapViewController* map = [[MapViewController alloc]initWithNibName:nil bundle:nil];
        map.waybillId = self.strWayBillld;
    [self.navigationController pushViewController:map animated:YES];
    map = nil;
}
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
//        NSLog(@"%@",telUrl);
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
-(void)juShouButtonPressed{
    
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"订单拒收" message:@"确认同意拒收此笔订单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.tag = 102;
    [alert show];
    
    
}
-(void)pressMaiJiaTEL{
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
        NSLog(@"%@",telUrl);
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
