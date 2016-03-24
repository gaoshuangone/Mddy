//
//  BaseTableViewController.m
//  merchant
//
//  Created by panume on 14-11-2.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "BaseTableViewController.h"
#import "LoginViewController.h"
@interface BaseTableViewController () <UITableViewDataSource, UITableViewDelegate,UIActionSheetDelegate>
@property (strong,nonatomic)UIView* viewShack;

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    if (iPhone4) {
//        self.imageViewBG = [[UIImageView alloc]initWithFrame:CGRectMake(100, 0-64, 375*0.6,667*0.6)];
//        self.imageViewBG.image = [UIImage imageNamed:@"noOrder.png"];
//        [self.view addSubview:self.imageViewBG];
//    }else{
//    
//        self.imageViewBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0-64, WINDOW_WIDTH,iPhone4? 618*0.85:iPhone5?618*0.85:WINDOW_HEIGHT)];
//        self.imageViewBG.image = [UIImage imageNamed:@"noOrder.png"];
//        [self.view addSubview:self.imageViewBG];
//    }

//    if(self.status == ORDER_STATUS_WAIT_LANSHOU)
//    {
//        
//    }
//    }

//    if(_status == 0)
//    {
//        [self modifyLanShouBG];
//    }
//    else if(_status == 1)
//    {
//        [self modifyQianShouBG];
//    }
//    else
//    {
//        [self modifyDoingBG];
//        
//    }
    //[self modifyLanShouBG];
    [self modifyLanShouBG];
 

    
    self.swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipLeft)];
    [self.swip setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    
    
    #ifdef DEBUG
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    #else
    #endif
//     Do any additional setup after loading the view.
}
-(void)addTableViewWithStyle:(UITableViewStyle)style{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT - 49 - 64) style:style];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
    [self.view addSubview:self.tableView];
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    //摇动结束
    
    if (event.subtype == UIEventSubtypeMotionShake) {
        
        if ([[AppManager valueForKey:@"RootUrlIndex"] isEqualToString:@"测试test"]||[[AppManager valueForKey:@"RootUrlIndex"] isEqualToString:@"小芳芳"]||[[AppManager valueForKey:@"RootUrlIndex"] isEqualToString:@"小灰灰"]||[[AppManager valueForKey:@"RootUrlIndex"] isEqualToString:@"预发"]||[[AppManager valueForKey:@"RootUrlIndex"] isEqualToString:@"测试98"]) {
            UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:[NSString stringWithFormat:@"目前－%@",[AppManager valueForKey:@"RootUrlIndex"]] delegate:self cancelButtonTitle:@"cancel"  destructiveButtonTitle:nil otherButtonTitles:@"http://test.zuixiandao.cn",@"http://172.16.28.163:8081",@"http://172.16.28.165:8080" ,@"http://pre.zuixiandao.cn",@"http://172.16.28.98/fhl",nil];
            [actionSheet showInView:self.view];
        }
    }
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [AppManager setUserDefaultsValue:@"http://test.zuixiandao.cn/fhl/phone/mddy/" key:@"RootUrl"];
        [AppManager setUserDefaultsValue:@"测试test" key:@"RootUrlIndex"];
        
    }
    else if(buttonIndex == 1){
        [AppManager setUserDefaultsValue:@"http://172.16.28.163:8081/fhl/phone/mddy/" key:@"RootUrl"];
        [AppManager setUserDefaultsValue:@"小芳芳" key:@"RootUrlIndex"];
        
    }else if (buttonIndex == 2){
        [AppManager setUserDefaultsValue:@"http://172.16.28.165:8080/fhl/phone/mddy/" key:@"RootUrl"];
        [AppManager setUserDefaultsValue:@"小灰灰" key:@"RootUrlIndex"];
        
    }else if (buttonIndex == 3){
        [AppManager setUserDefaultsValue:@"http://pre.zuixiandao.cn/fhl/phone/mddy/" key:@"RootUrl"];
        [AppManager setUserDefaultsValue:@"预发" key:@"RootUrlIndex"];
        
    }else if(buttonIndex == 4){
        [AppManager setUserDefaultsValue:@"http://172.16.28.98/fhl/phone/mddy/" key:@"RootUrl"];
        [AppManager setUserDefaultsValue:@"测试98" key:@"RootUrlIndex"];
        
    }
    
    
    if (buttonIndex != 5) {
        sleep(2);
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        delegate.baseTabBarController.selectedIndex = 0;
        self.tabBarController.selectedIndex = 0;
        LoginViewController* login = [[LoginViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:login animated:YES];
        exit(0);
    }
    
}

-(void)swipLeft{
    [self.navigationController popViewControllerAnimated:YES];
    
}

//- (void)modifyBGDisplay
//{
//    _prompLabelC.hidden = YES;
//    _imageViewLineC.hidden = YES;
//    _imageViewIconC.hidden = YES;
//    _prompLabelQ.hidden = YES;
//    _imageViewLineQ.hidden = YES;
//    _imageViewIconQ.hidden = YES;
//    _prompLabel.hidden = YES;
////    _imageViewLine.hidden = YES;
//    _imageViewIcon.hidden = YES;
//    _imageViewBG.hidden = YES;
//    [self.view setNeedsDisplay];
//}

- (void)modifyLanShouBG
{
    //self.hView.hidden = NO;
    if(self.imageViewBG == nil)
    {
        self.imageViewBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT - pageBtnHeight)];
        //self.imageViewBG.image = [UIImage imageNamed:@"noOrder.png"];
        //self.imageViewBG.backgroundColor = [UIColor redColor];
//        float red = ((float)242)/255.0;
//        float green = ((float)242)/255.0;
//        float blue = ((float)242)/255.0;
//        //UIView *viewBackGround = [UIView alloc];
//        self.imageViewBG.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        self.imageViewBG.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
        [self.view addSubview:self.imageViewBG];
    }
    
    
    self.prompLabelC.hidden = YES;
    self.imageViewLineC.hidden = YES;
    self.imageViewIconC.hidden = YES;
    self.prompLabelQ.hidden = YES;
    self.imageViewLineQ.hidden = YES;
    self.imageViewIconQ.hidden = YES;
    
    
    
    CGFloat height = WINDOW_HEIGHT - 49;
//    CGFloat imageHeight = 0;
//    CGFloat imageViewLineOriD = 70;
//    CGFloat prompLabelOriD = 60;
//    CGFloat imageViewIconOriD = 20;
    UIImage *image;
    
//    if(iPhone6)
//    {
//        imageViewLineOriD = 160;
//        prompLabelOriD = 100;
//        imageViewIconOriD = 10;
//        
//        if(self.imageViewLine == nil)
//        {
//            image = [UIImage imageNamed:@"arrow_watermark_home"];
//            self.imageViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH - 150, height - imageViewLineOriD - image.size.height, image.size.width, image.size.height)];
//            imageHeight = image.size.height;
//            self.imageViewLine.image = image;
//            [self.view addSubview:self.imageViewLine];
//            self.imageViewLine.hidden = YES;
//        }
//    }
//    else if(iPhone5)
//    {
//        imageViewLineOriD = 140;
//        prompLabelOriD = 50;
//        imageViewIconOriD = 10;
//        if(self.imageViewLine == nil)
//        {
//            image = [UIImage imageNamed:@"arrow_watermark_home"];
//            self.imageViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH - 150, height - imageViewLineOriD - image.size.height, image.size.width, image.size.height)];
//            imageHeight = image.size.height;
//            self.imageViewLine.image = image;
//            [self.view addSubview:self.imageViewLine];
//            self.imageViewLine.hidden = YES;
//        }
//        
//    }
//    else
//    {
//        imageViewLineOriD = 150;
//        prompLabelOriD = imageViewIconOriD * 480/667 - 10;
//        imageViewIconOriD = imageViewIconOriD * 480/667 - 10;
//        image = [UIImage imageNamed:@"arrow_watermark_home"];
//        
//        if(self.imageViewLine == nil)
//        {
//            image = [UIImage imageNamed:@"arrow_watermark_home"];
//            self.imageViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH - 105, height - imageViewLineOriD - image.size.height/2, image.size.width/2, image.size.height/2)];
//            imageHeight = image.size.height/2;
//            self.imageViewLine.image = image;
//            [self.view addSubview:self.imageViewLine];
//            self.imageViewLine.hidden = YES;
//        }
//        
//    }
    

    
    if(self.prompLabel == nil)
    {
        //self.prompLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, height - imageViewLineOriD - imageHeight - prompLabelOriD - 30, WINDOW_WIDTH - 32, 30)];
        self.prompLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, height/2 - 15, WINDOW_WIDTH - 32, 30)];
        self.prompLabel.backgroundColor = [UIColor clearColor];
        self.prompLabel.font = [UIFont systemFontOfSize:16];
        //_prompLabel.textColor = [UIColor blackColor];
        self.prompLabel.textAlignment = NSTextAlignmentCenter;
        self.prompLabel.text = @"暂无订单信息，赶快发布新订单吧";
        self.prompLabel.textColor = [UIColor colorWithHex:0x949494];
        [self.view addSubview:self.prompLabel];
    }
    
    if(self.imageViewIcon == nil)
    {
        image = [UIImage imageNamed:@"logo_watermark_home.png"];
        //self.imageViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake((WINDOW_WIDTH - image.size.width)/2, height - imageViewLineOriD - prompLabelOriD - imageViewIconOriD - imageHeight - 30 - image.size.height, image.size.width, image.size.height)];
        self.imageViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake((WINDOW_WIDTH - image.size.width)/2, height/2 - 15 - g_iconLable - image.size.height, image.size.width, image.size.height)];
        self.imageViewIcon.image = image;
        [self.view addSubview:self.imageViewIcon];
        
    }
    
//    self.imageViewLine.hidden = YES;
    self.imageViewIcon.hidden = NO;
    self.prompLabel.hidden = NO;
    self.imageViewBG.hidden = NO;
}
//{
//    self.imageViewBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64 + 18, WINDOW_WIDTH, WINDOW_HEIGHT - 64 - 18 - 49)];
//    //self.imageViewBG.image = [UIImage imageNamed:@"noOrder.png"];
//    //self.imageViewBG.backgroundColor = [UIColor redColor];
//    float red = ((float)242)/255.0;
//    float green = ((float)242)/255.0;
//    float blue = ((float)242)/255.0;
//    //UIView *viewBackGround = [UIView alloc];
//    self.imageViewBG.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//    [self.view addSubview:self.imageViewBG];
//    
//    _prompLabelC.hidden = YES;
//    _imageViewLineC.hidden = YES;
//    _imageViewIconC.hidden = YES;
//    _prompLabelQ.hidden = YES;
//    _imageViewLineQ.hidden = YES;
//    _imageViewIconQ.hidden = YES;
//    
//    CGFloat height = WINDOW_HEIGHT - 64 - 18 - 49;
//    CGFloat imageHeight = 0;
//    CGFloat imageViewLineOriD = 70;
//    CGFloat prompLabelOriD = 60;
//    CGFloat imageViewIconOriD = 20;
//    UIImage *image;
//    
//    if(iPhone6)
//    {
//        imageViewLineOriD = 80;
//        prompLabelOriD = 100;
//        imageViewIconOriD = 10;
//    }
//    else if(iPhone5)
//    {
//        imageViewLineOriD = 75;
//        prompLabelOriD = 50;
//        imageViewIconOriD = 10;
//    }
//    else
//    {
//        imageViewLineOriD = 70;
//        prompLabelOriD = imageViewIconOriD * 480/667 - 10;
//        imageViewIconOriD = imageViewIconOriD * 480/667 - 10;
//    }
//    
//    image = [UIImage imageNamed:@"arrow_watermark_home"];
//    _imageViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH - 105, height - imageViewLineOriD - image.size.height/2, image.size.width/2, image.size.height/2)];
//    imageHeight = image.size.height/2;
//    _imageViewLine.image = image;
//    [self.view addSubview:_imageViewLine];
//    
//    _prompLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, height - imageViewLineOriD - imageHeight - prompLabelOriD - 30, WINDOW_WIDTH - 32, 30)];
//    _prompLabel.backgroundColor = [UIColor clearColor];
//    _prompLabel.font = [UIFont systemFontOfSize:16];
//    //_prompLabel.textColor = [UIColor blackColor];
//    _prompLabel.textAlignment = NSTextAlignmentCenter;
//    _prompLabel.text = @"暂无运单信息，赶快发布新运单吧";
//    _prompLabel.textColor = [UIColor colorWithHex:0x949494];
//    [self.view addSubview:_prompLabel];
//    
//    image = [UIImage imageNamed:@"logo_watermark_home.png"];
//    _imageViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake((WINDOW_WIDTH - image.size.width/2)/2, height - imageViewLineOriD - prompLabelOriD - imageViewIconOriD - imageHeight - 30 - image.size.height/2, image.size.width/2, image.size.height/2)];
//    _imageViewIcon.image = image;
//    [self.view addSubview:_imageViewIcon];
//    
//}

//- (void)modifyQianShouBG
//{
//
////    if(self.imageViewBG == nil)
////    {
////        self.imageViewBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT - pageBtnHeight)];
////        //self.imageViewBG.image = [UIImage imageNamed:@"noOrder.png"];
////        //self.imageViewBG.backgroundColor = [UIColor redColor];
//////        float red = ((float)242)/255.0;
//////        float green = ((float)242)/255.0;
//////        float blue = ((float)242)/255.0;
//////        //UIView *viewBackGround = [UIView alloc];
//////        self.imageViewBG.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
////        self.imageViewBG.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
////        [self.view addSubview:self.imageViewBG];
////        
////    }
//
//    _prompLabel.hidden = YES;
////    _imageViewLine.hidden = YES;
//    _imageViewIcon.hidden = YES;
//    _prompLabelC.hidden = YES;
//    _imageViewLineC.hidden = YES;
//    _imageViewIconC.hidden = YES;
//    
//    CGFloat height = WINDOW_HEIGHT - 64 - 18 - 49;
//    CGFloat imageHeight = 0;
//    CGFloat imageViewLineOriD = 70;
//    CGFloat prompLabelOriD = 60;
//    CGFloat imageViewIconOriD = 20;
//    UIImage *image;
//    
//    if(iPhone6)
//    {
//        imageViewLineOriD = 80;
//        prompLabelOriD = 100;
//        imageViewIconOriD = 10;
//    }
//    else if(iPhone5)
//    {
//        imageViewLineOriD = 75;
//        prompLabelOriD = 50;
//        imageViewIconOriD = 10;
//    }
//    else
//    {
//        imageViewLineOriD = 70;
//        prompLabelOriD = imageViewIconOriD * 480/667 - 10;
//        imageViewIconOriD = imageViewIconOriD * 480/667 - 10;
//    }
//    
////    if(_imageViewLine == nil)
////    {
////        image = [UIImage imageNamed:@"arrow_watermark_home"];
////        _imageViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH - 105, height - imageViewLineOriD - image.size.height/2, image.size.width/2, image.size.height/2)];
////        imageHeight = image.size.height/2;
////        _imageViewLine.image = image;
////        [self.view addSubview:_imageViewLine];
////        self.imageViewLine.hidden = YES;
////    }
//
//    
//    image = [UIImage imageNamed:@"arrow_watermark_home"];
//    imageHeight = image.size.height/2;
//    
////    if(_prompLabel == nil)
////    {
////        _prompLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, height/2 - 15, WINDOW_WIDTH - 32, 30)];
////        _prompLabel.backgroundColor = [UIColor clearColor];
////        _prompLabel.font = [UIFont systemFontOfSize:16];
////        //_prompLabel.textColor = [UIColor blackColor];
////        _prompLabel.textAlignment = NSTextAlignmentCenter;
////        _prompLabel.text = @"暂无运单信息";
////        _prompLabel.textColor = [UIColor colorWithHex:0x949494];
////        [self.view addSubview:_prompLabel];
////    }
////
////    if(_imageViewIcon == nil)
////    {
////        image = [UIImage imageNamed:@"logo_watermark_home.png"];
////        _imageViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake((WINDOW_WIDTH - image.size.width)/2, height/2 - 15 - g_iconLable - image.size.height, image.size.width, image.size.height)];
////        _imageViewIcon.image = image;
////        [self.view addSubview:_imageViewIcon];
////    }
//}
//
//- (void)modifyDoingBG
//{
////    if(self.imageViewBG == nil)
////    {
////        self.imageViewBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT - pageBtnHeight)];
////        //self.imageViewBG.image = [UIImage imageNamed:@"noOrder.png"];
////        //self.imageViewBG.backgroundColor = [UIColor redColor];
//////        float red = ((float)242)/255.0;
//////        float green = ((float)242)/255.0;
//////        float blue = ((float)242)/255.0;
//////        //UIView *viewBackGround = [UIView alloc];
//////        self.imageViewBG.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
////        self.imageViewBG.backgroundColor = [UIColor colorWithHex:0xf5f5f5];
////        [self.view addSubview:self.imageViewBG];
////        
////    }
//    _prompLabel.hidden = YES;
////    _imageViewLine.hidden = YES;
//    _imageViewIcon.hidden = YES;
//    _prompLabelQ.hidden = YES;
//    _imageViewLineQ.hidden = YES;
//    _imageViewIconQ.hidden = YES;
//    
//    CGFloat height = WINDOW_HEIGHT - 64 - 18 - 49;
//    CGFloat imageHeight = 0;
//    CGFloat imageViewLineOriD = 70;
//    CGFloat prompLabelOriD = 60;
//    CGFloat imageViewIconOriD = 20;
//    UIImage *image;
//    
//    if(iPhone6)
//    {
//        imageViewLineOriD = 80;
//        prompLabelOriD = 100;
//        imageViewIconOriD = 10;
//    }
//    else if(iPhone5)
//    {
//        imageViewLineOriD = 75;
//        prompLabelOriD = 50;
//        imageViewIconOriD = 10;
//    }
//    else
//    {
//        imageViewLineOriD = 70;
//        prompLabelOriD = imageViewIconOriD * 480/667 - 10;
//        imageViewIconOriD = imageViewIconOriD * 480/667 - 10;
//    }
//    
//    
//    //    image = [UIImage imageNamed:@"arrow_watermark_home"];
//    //    _imageViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOW_WIDTH - 105, height - imageViewLineOriD - image.size.height/2, image.size.width/2, image.size.height/2)];
//    //    imageHeight = image.size.height/2;
//    //    _imageViewLine.image = image;
//    //    [self.view addSubview:_imageViewLine];
//    image = [UIImage imageNamed:@"arrow_watermark_home"];
//    imageHeight = image.size.height/2;
////    if(self.prompLabel == nil)
////    {
////        self.prompLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, height/2 - 15, WINDOW_WIDTH - 32, 30)];
////        self.prompLabel.backgroundColor = [UIColor clearColor];
////        self.prompLabel.font = [UIFont systemFontOfSize:16];
////        //_prompLabel.textColor = [UIColor blackColor];
////        self.prompLabel.textAlignment = NSTextAlignmentCenter;
////        self.prompLabel.textColor = [UIColor colorWithHex:0x949494];
////        [self.view addSubview:_prompLabel];
////    }
////    self.prompLabel.text = @"恭喜，没有要处理的运单";
////
////    if(self.imageViewIcon == nil)
////    {
////        image = [UIImage imageNamed:@"logo_watermark_home.png"];
////        self.imageViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake((WINDOW_WIDTH - image.size.width)/2, height/2 - 15 - g_iconLable - image.size.height, image.size.width, image.size.height)];
////        self.imageViewIcon.image = image;
////        [self.view addSubview:_imageViewIcon];
////    }
//
//    self.imageViewBG.hidden = NO;
//    self.prompLabel.hidden = NO;
//    self.imageViewIcon.hidden = NO;
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
//    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    //    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
//    self.tableView.headerPullToRefreshText = @"下拉开始刷新";
//    self.tableView.headerReleaseToRefreshText = @"松开马上刷新";
   
//    self.tableView.headerRefreshingText = @"刷新中...";
    
//    self.tableView.footerPullToRefreshText = @"上拉加载更多";
//    self.tableView.footerReleaseToRefreshText = @"松开加载更多";
//    self.tableView.footerRefreshingText = @"加载中...";
    
    self.tableView.footerPullToRefreshText = @"";
    self.tableView.footerReleaseToRefreshText = @"";
    self.tableView.footerRefreshingText = @"                                                 ";
    
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"松开并刷新";
}

- (void)headerRereshing
{
    FLDDLogDebug(@"refresh");
}

- (void)footerRereshing
{
    FLDDLogDebug(@"loadMore");
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}


@end
