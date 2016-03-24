 //
//  HomeViewController.m
//  merchant
//
//  Created by panume on 14-11-1.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "HomeViewController.h"
#import "OrderWaitLanShouCell.h"
#import "OrderWaitQianShouCell.h"
#import "OrderDoingCell.h"
#import "SoonSendOrderViewController.h"
#import "OrderDetailViewController.h"
#import "OrderErrorDetailkViewController.h"
#import "SoonSendOrderViewController.h"
#import "Reachability.h"
#import "LoginViewController.h"
#import "AccountRechargeViewController.h"
#import "PersonalViewController.h"
#import "LaunchImageView.h"

#import "MapViewController.h"

#import"BMapKit.h"
#import "PromptView.h"
#import "OrderWaitLanTableViewCell.h"
#import "OrderWaitLanLanTableViewCell.h"

#import "OrderQianShouTableViewCell.h"
#import "OrderDoingJuShouTableViewCell.h"
#import "OrderDoingCancelTableViewCell.h"
#import "FeeWebViewController.h"
@interface ButtonRightItem : UIButton;
@property (strong, nonatomic) UILabel* label;
@property (strong, nonatomic) UIImageView* imageView1;
@end

static NSString * const ErrrorNoNetDes = @"当前网络不可用，请检查您的网络设置";

@implementation ButtonRightItem

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
      
       self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(26, 5,18, 18)];
        self.imageView1.hidden = YES;
        self.imageView1 .image = [UIImage imageNamed:@"new_message.png"];
        [self addSubview:self.imageView1 ];
        
        
        
//        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, 22, 18)];
        self.label.textColor = [UIColor colorWithHex:0xfc6605];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:12];
//        [self.imageView1  addSubview:self.label];
         [self addSubview:self.label ];
        
    }
    return self;
}
-(void)setLabeNumber:(NSInteger)number{
    self.label.text = [NSString stringWithFormat:@"%ld",(long)number];
}

@end
#pragma mark - TableSectionHeadView
@interface SectionHeadView : UIView

@property (nonatomic, strong) NSString *receiveNum;
@property (nonatomic, strong) NSString *sendNum;

@property (nonatomic, strong) UIButton *receiveButton;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UIButton *handleButton;

@property (nonatomic, strong) UILabel *receiveLabel;
@property (nonatomic, strong) UILabel *sendLabel;
@property ( nonatomic, strong) UILabel* handleLabel;

@property (nonatomic, strong) UIImageView* imageViewLine;
@property (strong, nonatomic) UILabel* label1;//待揽收数字
@property (strong, nonatomic) UILabel* label2;//待签收数字
@property (strong, nonatomic) UILabel* label3;//处理中数字


@end

@implementation SectionHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    
        
        UIImage *receviedIcon = [UIImage imageNamed:@"dailanshou_icon_home.png"];
        self.receiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.receiveButton setBackgroundImage:receviedIcon forState:UIControlStateNormal];
        self.receiveButton.frame = CGRectMake(0, 0, receviedIcon.size.width, receviedIcon.size.height);
        self.receiveButton.tag = 1;
        NSInteger distance;
        if (iPhone4 ||iPhone5) {
            distance=15;
        }else{
            distance = 0;
        }
        self.receiveButton.center = CGPointMake(50-distance + self.receiveButton.bounds.size.width / 2, 8 + self.receiveButton.bounds.size.height / 2);
        [self addSubview:self.receiveButton];
        
        self.receiveLabel = [[UILabel alloc] init];
        self.receiveLabel.text = @"待揽收(  )";
        self.receiveLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.receiveLabel sizeToFit];
        self.receiveLabel.textColor = UICOLOR(248, 78, 11, 1);
        self.receiveLabel.center = CGPointMake(self.receiveButton.center.x, CGRectGetMaxY(self.receiveButton.frame) + 8 + self.receiveLabel.bounds.size.height / 2);
        [self addSubview:self.receiveLabel];
        
        self.label1 = [[UILabel alloc]init];
        self.label1.text = @"3";
        self.label1.textColor = UICOLOR(248, 78, 11, 1);
        [self.label1 sizeToFit];
        self.label1.font = [UIFont systemFontOfSize:14.0f];
        self.label1.center = CGPointMake(self.receiveLabel.bounds.size.width/2+self.label1.bounds.size.width/2+16,self.receiveLabel.bounds.size.height/2);
        [self.receiveLabel addSubview:self.label1];
        
        
        UIImage *sendIcon = [UIImage imageNamed:@"daiqianshou_icon_home.png"];
        self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.sendButton setBackgroundImage:sendIcon forState:UIControlStateNormal];
        self.sendButton.tag = 2;
        self.sendButton.frame = CGRectMake(0, 0, sendIcon.size.width, sendIcon.size.height);
        self.sendButton.center = CGPointMake(WINDOW_WIDTH / 2, self.receiveButton.center.y);
        [self addSubview:self.sendButton];
        
        self.sendLabel = [[UILabel alloc] init];
        self.sendLabel.text = @"待签收(  )";
        self.sendLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.sendLabel sizeToFit];
        self.sendLabel.backgroundColor = [UIColor clearColor];
        self.sendLabel.center = CGPointMake(self.sendButton.center.x, self.receiveLabel.center.y);
        [self addSubview:self.sendLabel];
        
        self.label2 = [[UILabel alloc]init];
        self.label2.text = @"3";
        self.label2.textColor = UICOLOR(248, 78, 11, 1);
        [self.label2 sizeToFit];
        self.label2.font = [UIFont systemFontOfSize:14.0f];
        self.label2.center = CGPointMake(self.sendLabel.bounds.size.width/2+self.label1.bounds.size.width/2+16,self.sendLabel.bounds.size.height/2);
        [self.sendLabel addSubview:self.label2];
        
        
        
        
        
        UIImage *handleIcon = [UIImage imageNamed:@"daichuli_icon_home.png"];
        self.handleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.handleButton.tag = 3;
        [self.handleButton setBackgroundImage:handleIcon forState:UIControlStateNormal];
        self.handleButton.frame = CGRectMake(0, 0, handleIcon.size.width, handleIcon.size.height);
        self.handleButton.center = CGPointMake(WINDOW_WIDTH - 50 - self.handleButton.bounds.size.width / 2+distance, self.receiveButton.center.y);
        [self addSubview:self.handleButton];
        
        self.handleLabel = [[UILabel alloc] init];
        self.handleLabel.text = @"处理中(  )";
        self.handleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.handleLabel sizeToFit];
        self.handleLabel.backgroundColor = [UIColor clearColor];
        self.handleLabel.center = CGPointMake(self.handleButton.center.x, self.receiveLabel.center.y);
        [self addSubview:self.handleLabel];
        
        self.label3 = [[UILabel alloc]init];
        self.label3.text = @"3";
        self.label3.textColor = UICOLOR(248, 78, 11, 1);
        [self.label3 sizeToFit];
        self.label3.font = [UIFont systemFontOfSize:14.0f];
        self.label3.center = CGPointMake(self.handleLabel.bounds.size.width/2+self.label3.bounds.size.width/2+16,self.handleLabel.bounds.size.height/2);
        [self.handleLabel addSubview:self.label3];
        
        
        
        self.imageViewLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sendLabel.frame)+1, WINDOW_WIDTH/3, 3)];
        self.imageViewLine.backgroundColor = UICOLOR(250, 156, 102, 1);
        [self addSubview:self.imageViewLine];
//        self.imageViewLine.hidden = YES;
        
        UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sendLabel.frame)+4, WINDOW_WIDTH, 1)];        imageView.backgroundColor = [UIColor lightGrayColor];
        imageView.alpha = 0.25;
        [self addSubview:imageView];
        imageView = nil;
    }
    
    return self;
}

- (void)setReceiveNum:(NSString *)receiveNum
{
    _receiveNum = receiveNum;
    self.receiveLabel.text = [NSString stringWithFormat:@"待揽收(%@)",_receiveNum];
}

- (void)setSendNum:(NSString *)sendNum
{
    _sendNum = sendNum;
    self.sendLabel.text = [NSString stringWithFormat:@"待签收(%@)", _sendNum];
}

@end

typedef NS_ENUM(NSUInteger, STATUS) {
    statusWaitLanshou,
    statusWaitQianShou,
    statusWaitDoing,
    
    
};
@interface HomeViewController ()<UITextFieldDelegate,UIAlertViewDelegate, BMKRouteSearchDelegate>
@property (nonatomic, strong) SectionHeadView *sectionHeadView;
@property (strong, nonatomic) ButtonRightItem* buttonRightItem;
@property (nonatomic,assign) STATUS orderBtnStatus;
@property (strong, nonatomic) UIImageView* imageViewIconIcon;
@property (strong, nonatomic) UILabel* labelTitle;
@property (strong, nonatomic) UIImageView* imageVioewNotNet;
@property (strong, nonatomic) UIView* viewBG;
@property (assign ,nonatomic) BOOL isFirst;
@property (strong, nonatomic) NSMutableDictionary* dictData;
@property (strong, nonatomic) NSMutableArray* arratData;

@property (assign, nonatomic) BOOL needSendNotice;
@property (assign, nonatomic) BOOL isLogin;
@property (assign, nonatomic)CGFloat oldOffSet;
@property (strong, nonatomic)UIButton* buttonSend;
@property (assign, nonatomic) int currentPage;
@property (assign, nonatomic) NSInteger  currentTotal;
@property (assign, nonatomic) BOOL isHeaderRereshing;
@property (strong, nonatomic)NSDictionary* dictMddy;
@property (strong, nonatomic) UIView *hView;
@property (strong, nonatomic) UITextField* textField;

@property (strong, nonatomic) UIView* viewAlphaBG;
@property (strong, nonatomic) UIImageView* imageViewNavAlpha;

@property (strong, nonatomic) UIView* viewImageControlBG;
@property (strong, nonatomic) NSString* strTEL;
@property (nonatomic, strong) LaunchImageView *launchView;
@property ( assign,nonatomic) BOOL isHaveNet;
@property (strong,nonatomic)UIAlertView* alertView;
@property (assign, nonatomic)BOOL isAlertCherkNet;//是否是点击alert的检查网络方法
@property (assign, nonatomic)BOOL isAlertSrvFail;//是否弹出自动登录时服务器返回失败alert
@property (assign, nonatomic)BOOL isHeadRunIng;
@property (assign, nonatomic)BOOL isFooterRereshing;
@property (nonatomic, strong) UILabel *noticeLabel;

@property (nonatomic,assign) BOOL isJISuButton;//极速发单页面弹出来，区别appleate的定位和本页面调的
@property (strong,nonatomic) NSString* strType;;
//@property (strong, nonatomic) UIButton *arrowButtonHVBtn;
//@property (strong, nonatomic) UIButton *contentButtonHVBtn;
//@property (strong, nonatomic) UIButton *arrowSecondBtnHVBtn;
//@property (strong, nonatomic) UIButton *contentSecondBtnHVBtn;
@property (strong, nonatomic) UIView *contentHVView;
@property (strong, nonatomic) UIView *contentSecondHVView;
@property (nonatomic, assign) NSInteger iRow;
@property (nonatomic, assign) BOOL bHidden;
@property (nonatomic, strong) NSMutableArray *fetchingIconArr;
@property (nonatomic, strong) NSMutableArray *fetchingOrderTypeIconArr;
@property (nonatomic, assign) NSInteger remainOrder;
@property (nonatomic, assign) NSInteger remainQuickOrder;
@property (nonatomic, strong) PromptView *promptView;

@property (nonatomic, strong) UIButton *buttonSoonSend;
@property (nonatomic, strong) UILabel *remindLabel;
@property (nonatomic, assign) NSInteger routesIndex;
@end

@implementation HomeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
  self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
//    [self hiddenDetail];
    if(nil != g_messageInfo)
    {
        [MBProgressHUD hudShowWithStatus:self :g_messageInfo];
        g_messageInfo = nil;
        
    }
    [self showPrompt];
    
    [self addNavBarView];//加入navBar的Icon
    
    if(LOGIN_STATE_LOGIN_SUCESS == g_loginStat)
    {
        [self showNoticeView];
    }
//    if (!self.isLogin)
    if(LOGIN_STATE_EXIT_LOGIN == g_loginStat)
    {
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        navigationController.navigationBar.barTintColor = [UIColor colorWithHex:0xf5f5f5];
        
//        if (![AppManager valueForKey:@"HasLaunchedOnce"]) {
//            [self.navigationController pushViewController:loginViewController animated:NO];
//        }
//        else {
//            [self.navigationController presentViewController:navigationController animated:NO completion:nil];
//        }
        
        [self.navigationController pushViewController:loginViewController animated:NO];
        loginViewController = nil;
        return;
    }
    else if(LOGIN_STATE_LOGIN_SUCESS != g_loginStat)
    {
        if (STATE_INIT != g_getNetState)
        {
            return;
        }

//        self.isLogin = YES;
//        NSString *phone = [AppManager valueForKey:@"telephone"];
//        if (phone.length > 0) {
        NSString *phone = [AppManager valueForKey:@"telephone"];
        NSString *password = [AppManager valueForKey:@"password"];
        
        if (phone.length != 0 && password.length != 0)
        {
            if(nil == self.launchView )
            {
                
                self.launchView = [[LaunchImageView  alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT) remind:@"登录中"];
                [self.navigationController.view addSubview:self.launchView];
                
            }
            return;

        }
        else
        {
            LoginViewController *loginViewController = [[LoginViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
            navigationController.navigationBar.barTintColor = [UIColor colorWithHex:0xf5f5f5];
            [self.navigationController pushViewController:loginViewController animated:NO];
            loginViewController = nil;
            return;
        }

        
        
    }
    
//    手动登录过来的
    [HomeViewController checkGPS];
        self.isHeaderRereshing = YES;
//        [self  getPresonalInfo];
        self.currentPage = 0;
        if ([SelfUser currentSelfUser].isNeedReturnLanShou) {
            [SelfUser currentSelfUser].isNeedReturnLanShou = NO;
            self.orderBtnStatus =statusWaitLanshou;
            [SelfUser currentSelfUser].strStatus = @"lanshou";
            [self ordersButtonPressed:self.sectionHeadView.receiveButton];
        }else{
            
            [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
            
            
            
//            [self getOrderCount];
            [self getOrderList ];
        }
        
    
    


    
}
#pragma mark 登陆

- (void)setRemainOrder:(NSInteger)remainOrder
{
    _remainOrder = remainOrder;
    [SelfUser currentSelfUser].remainOrder = _remainOrder;
}

- (void)setRemainQuickOrder:(NSInteger)remainQuickOrder
{
    _remainQuickOrder = remainQuickOrder;
    [SelfUser currentSelfUser].remainQuickOrder = _remainQuickOrder;

}
- (void)showRemainOrderNumber
{

    if (self.remainQuickOrder >= 0) {

        [self.buttonSoonSend setTitle:[NSString stringWithFormat:@"极速发单(%ld)", (long)self.remainQuickOrder] forState:UIControlStateNormal];
    }
    
    if (self.remainOrder >= 0) {
        self.remindLabel.text = [NSString stringWithFormat:@"今日剩余%ld单", (long)self.remainOrder];
    }
}

//ONLY use at version 1.9.1
- (void)showPrompt
{
    BOOL hasPrompt = [AppManager boolValueForKey:@"HasPrompt"];
    if (!hasPrompt) {
        if (!self.promptView.superview) {
            if (g_loginStat == LOGIN_STATE_LOGIN_SUCESS) {
                if (!self.promptView) {
                    self.promptView = [[PromptView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)];
                }
                [self.navigationController.view addSubview:self.promptView];
            }
        }
    }
}

- (void) displayLoginView
{
    if(self.launchView != nil)
    {
        [self.launchView removeFromSuperview];
        self.launchView = nil;
    }
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginViewController animated:NO];
    loginViewController = nil;
    g_loginStat = LOGIN_STATE_UNAUTO_LOGIN;
    [self showNoticeView];
}



- (void)showNoticeView
{

    
    if(NO == self.isHaveNet)
    {
        self.imageVioewNotNet.hidden = NO;
        _noticeLabel.text = @"当前网络不可用，请检查你的网络设置";
        g_showNoNetNotice = YES;
        self.sectionHeadView.frame = CGRectMake(0, 30, WINDOW_WIDTH, 82);
        self.tableView.frame = CGRectMake(0, 80+30, WINDOW_WIDTH, WINDOW_HEIGHT - 49 - 64-80-30-18);
        return;

    }
    else if ((LOGIN_STATE_LOGINING != g_loginStat) && (LOGIN_STATE_INIT != g_loginStat))
    {
        self.imageVioewNotNet.hidden = YES;
        self.sectionHeadView.frame = CGRectMake(0, 0, WINDOW_WIDTH, 82);
        self.tableView.frame = CGRectMake(0, 80, WINDOW_WIDTH, WINDOW_HEIGHT - 49 - 64-80-18);
    }
    
}

- (void)autoLogin
{
    NSString *phone = [AppManager valueForKey:@"telephone"];
    NSString *password = [AppManager valueForKey:@"password"];
    FLDDLogDebug(@"取到密码%@",password);

    NSMutableDictionary* paramsList=[[NSMutableDictionary alloc]init];
    [paramsList setObject:[AppManager valueForKey:@"phoneType"] forKey:@"phoneType"];
    [paramsList setObject:[AppManager valueForKey:@"phoneSystem"] forKey:@"phoneSystem"];
    [paramsList setObject:[AppManager valueForKey:@"version"] forKey:@"version"];
    [paramsList setObject:phone forKey:@"clerkTel"];
    [paramsList setObject:password forKey:@"passwd"];
    
    if(LOGIN_STATE_LOGINING == g_loginStat)
    {
        return;
    }
    
       __weak __typeof(self)safeSelf = self;
    g_loginStat = LOGIN_STATE_LOGINING;
    [User reLoginWithFixedPasswordJsonPhone:paramsList block:^(NSError *error) {
        self.isLogin = YES;
        if(safeSelf.launchView != nil)
        {
            [safeSelf.launchView removeFromSuperview];
            safeSelf.launchView = nil;
        }
        //        [SVProgressHUD dismiss];
        if (!error)
        {
                 [AppManager setUserDefaultsValue:@"2" key:@"isFirst"];
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)]) {
                if ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
//                    [AppDelegate registerForRemoteNotification];
                }
            }
            else {
//                [AppDelegate registerForRemoteNotification];
            }
            
          
            
            [[NSNotificationCenter defaultCenter] postNotificationName:HIT_HEART_NOTIFICATION object:nil userInfo:@{@"beginHit" : @(YES)}];
//            [safeSelf  getPresonalInfo];
            [safeSelf.tableView setContentOffset:CGPointMake(0,0) animated:YES];
            
            safeSelf.currentPage = 0;
            
            safeSelf.isHeaderRereshing = YES;
//            [safeSelf getOrderCount];
            [safeSelf getOrderList ];
            g_loginStat = LOGIN_STATE_LOGIN_SUCESS;
            [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_VERSION_NOTIFICATION object:nil];
            [safeSelf showNoticeView];
            
                [HomeViewController checkGPS];
            
        }
        else {
            FLDDLogInfo(@"autoLogin fail.")
            
            NSString *reason = [error localizedFailureReason];
            
            if(!reason || (![reason isEqualToString:g_errorReLoginFail]))
            {
                if(self.isHaveNet)
                {
                    //                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"网络比蜗牛还慢，挤不进去呀" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"再试一次",nil];
                    [MBProgressHUD hudShowWithStatus:self : @"网络比蜗牛还慢，挤不进去呀"];
                }
                else
                {
                    //                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"当前无网络，请打开网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    
                    [MBProgressHUD hudShowWithStatus:self : g_errorReLoginFail];
                }
                
                g_loginStat = LOGIN_STATE_UNNET_LOGIN;
                [safeSelf showNoticeView];
                [safeSelf modifyGetFailBGH];
          
                return;
            }
            
            [safeSelf displayLoginView];
            
    
            
            
        }
        [safeSelf showPrompt];
    }];
    
    
    

}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
//    [HomeViewController checkNetWork];
    self.isFirst = YES;
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.imageViewIconIcon.hidden = YES;
    self.labelTitle.hidden = YES;
        self.buttonRightItem.hidden = YES;
    self.imageViewNavView.hidden = YES;
    _viewImageControlBG = nil;
    [self.remindLabel removeFromSuperview];
    [self hiddenDetail];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   [HomeViewController checkNetWork];
    g_messageInfo = nil;
//    _arrowButtonHVBtn = nil;
//    _contentButtonHVBtn = nil;
//    _arrowSecondBtnHVBtn = nil;
    _contentHVView = nil;
    _contentSecondHVView = nil;
    _iRow = -1;
    _bHidden = YES;
    _routesIndex = 0;
    self.remainQuickOrder = [SelfUser currentSelfUser].remainQuickOrder;
    self.remainOrder = [SelfUser currentSelfUser].remainOrder;
    [self showRemainOrderNumber];

    [self addImageViewNotNet];//没有网络时的标志
    _isAlertCherkNet = NO;
    _needSendNotice = YES;
    _isAlertSrvFail = NO;
    _fetchingIconArr = [NSMutableArray array];
    _fetchingOrderTypeIconArr = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];//网络改变时的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityRecove) name:REACHABILITY_RECOVE_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderDistance) name:MBK_PERMISSION_SUCCESS_NOTIFICATION object:nil];
 
    
    [self addTableViewWithStyle:UITableViewStyleGrouped];
   
    
    self.arratData = [NSMutableArray array ];
    self.orderBtnStatus = statusWaitLanshou;
     [SelfUser currentSelfUser].strStatus = @"lanshou";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.orderBtnStatus = statusWaitLanshou;
    self.sectionHeadView = [[SectionHeadView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 82)];
    [self.sectionHeadView.receiveButton addTarget:self action:@selector(ordersButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.sectionHeadView.sendButton addTarget:self action:@selector(ordersButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.sectionHeadView.handleButton addTarget:self action:@selector(ordersButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sectionHeadView];

  
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];

    //第一次获取揽收列表
    [self setupRefresh];//添加下拉刷新
  
    self.isHeaderRereshing = YES;//1.防止点击headerRereshing马上清空数据点击cell时崩溃，2.tableView滚动到固定位置
    
     self.tabBarController.tabBar.hidden = YES;
    
      UIView* viewSendBG = [[UIView alloc]initWithFrame:CGRectMake(0, WINDOW_HEIGHT-64-65, WINDOW_WIDTH, 65)];
    viewSendBG.backgroundColor =  [UIColor colorWithHex:0xf5f5f5];
    [self.view addSubview:viewSendBG];
    viewSendBG = nil;
    
    
     UIButton* buttonNorSend = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonNorSend setBackgroundColor:[UIColor whiteColor]];
    buttonNorSend.layer.cornerRadius = 1;
     [ buttonNorSend addTarget:self action:@selector(buttonSendPressed) forControlEvents:UIControlEventTouchUpInside];
    [buttonNorSend setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
    buttonNorSend.frame = CGRectMake(9, WINDOW_HEIGHT-64-55, (WINDOW_WIDTH - 26) / 2, 44);
    [buttonNorSend setTitle:@"普通发单" forState:UIControlStateNormal];
    buttonNorSend.layer.borderColor = [[UIColor colorWithHex:0xb6b6b6 alpha:0.2] CGColor];
    buttonNorSend.layer.borderWidth = 1;
    [self.view addSubview:buttonNorSend];

    
    self.buttonSoonSend = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonSoonSend.backgroundColor = [UIColor orangeColor];
    [self.buttonSoonSend addTarget:self action:@selector(buttonSoonSendPressed) forControlEvents:UIControlEventTouchUpInside];
    self.buttonSoonSend.frame = CGRectMake(CGRectGetMaxX(buttonNorSend.frame) + 8, WINDOW_HEIGHT-55-64, (WINDOW_WIDTH - 26) / 2, 44);
    [self.buttonSoonSend setTitle:@"极速发单(0)" forState:UIControlStateNormal];
    float red = 252/255.0;
    float green = 102/255.0;
    float blue = 5/255.0;
     [self.buttonSoonSend setBackgroundColor: [UIColor colorWithRed:red green:green blue:blue alpha:1.0]];
    self.buttonSoonSend.layer.cornerRadius = 1;
    [self.view addSubview:self.buttonSoonSend];
    buttonNorSend = nil;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPresonalInfo) name:GETIFFO object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginNotification:) name:LOGIN_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(locationNoti) name:LOCATIONNOTI object:nil];//接收到定位的通知
    
}
-(void)headerRereshing{
//    [self  hiddenDetail];
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
  
//    [self  hiddenDetail];
    self.isHeaderRereshing = NO;
    self.isFooterRereshing = YES;
    
//    FLDDLogDebug(@"%lu",self.currentTotal-[self.arratData count]);
//    FLDDLogDebug(@"%d,%ld",self.currentTotal,[self.arratData count]);
    if (self.currentTotal - [self.arratData count] >0) {
//         [self getOrderCount];
        [self getOrderList];
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

// 滚动时，触发该函数
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self hiddenDetail];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.arratData .count>0) {
        //        self.tableView.hidden  = NO;
        //        return 0;
        return [self.arratData  count];
    }else{
        //        self.tableView.hidden  = YES;
        return 0;
        
    }
    return 0;
    
//    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
//    if (self.arratData .count>0) {
////        self.tableView.hidden  = NO;
////        return 0;
//        return [self.arratData  count];
//    }else{
////        self.tableView.hidden  = YES;
//        return 0;
//        
//    }
//    return 0;
    return 1;
    
    
}

-(void) loadIcon : (UIImageView *)imageViewCellIcon  withWayQuickTypeIconUrl:(NSString *)quickTypeIconUrl withTableViewcell:(TableViewCellValue *)cell
{
    if((nil == cell) || (nil == imageViewCellIcon))
    {
        return;
    }
    cell.imageViewIcon = imageViewCellIcon;
//    if((0 != quickTypeIconUrl.length) && (!(!(cell.bNeedGetIcon)  && (nil != cell.imageViewIcon.image))))
    if(0 != quickTypeIconUrl.length)
    {
        NSString *fileName  = [SelfUser mddyGetFileNameWithIconUrl:quickTypeIconUrl];
        if(0 < fileName.length)
        {
            cell.iconFileName = fileName;
            [SelfUser mddyRequestWithImageWithFileName:fileName withWayQuickTypeIconUrl:quickTypeIconUrl withTableViewcell:cell withIconArr:_fetchingIconArr withMothed:@"downloadShopGroupICon.htm" withBlock:^(UIImage *imageIcon, NSError *error, bool bDefault)
             {
                 if(nil != imageIcon)
                 {
                     NSMutableArray *fetchingIconArrTemp = [NSMutableArray array];
                     NSData *imageDataTemp = [AppManager readDataFromDocumentWithName:fileName];
                     for (TableViewCellValue * cellTemp in self.fetchingIconArr)
                     {
                         if ((cellTemp.bNeedGetIcon) && [cellTemp.iconFileName isEqualToString:cell.iconFileName])
                         {
                             cell.imageViewIcon.image = [UIImage imageWithData:imageDataTemp];
                             cell.imageViewIcon.bounds = CGRectMake(0, 0, 15, 15);
                             cell.imageViewIcon.contentMode = UIViewContentModeScaleToFill;
                             if(bDefault)
                             {
                                 cell.bNeedGetIcon = YES;
                             }
                             else
                             {
                                 cell.bNeedGetIcon = NO;
                             }
                         }
                         else
                         {
                             [fetchingIconArrTemp addObject:cellTemp];
                         }
                     }
                     [self.fetchingIconArr removeAllObjects];
                     self.fetchingIconArr = fetchingIconArrTemp;
                     [self.tableView reloadData];
                 }

             }];
        }
    }
}

-(void) loadOrderTypeIcon : (UIImageView *)imageViewCellIcon  withWayQuickTypeIconUrl:(NSString *)quickTypeIconUrl withTableViewcell:(TableViewCellValue *)cell
{
    if((nil == cell) || (nil == imageViewCellIcon))
    {
        return;
    }
    cell.imageViewOrderTypeIcon = imageViewCellIcon;
//    if((0 != quickTypeIconUrl.length) && (!(!(cell.bNeedGetOrderTypeIcon)  && (nil != cell.imageViewOrderTypeIcon.image))))
    if(0 != quickTypeIconUrl.length)
    {
        NSString *fileName  = [SelfUser mddyGetFileNameWithIconUrl:quickTypeIconUrl];
        if(0 < fileName.length)
        {
            cell.orderTypeIconFileName = fileName;
            [SelfUser mddyRequestWithOrderTypeImageWithFileName:fileName withWayQuickTypeIconUrl:quickTypeIconUrl withTableViewcell:cell withIconArr:_fetchingOrderTypeIconArr withMothed:@"downloadShopGroupICon.htm" withBlock:^(UIImage *imageIcon, NSError *error, bool bDefault)
             {
                 if(nil != imageIcon)
                 {
                     NSMutableArray *fetchingIconArrTemp = [NSMutableArray array];
                     NSData *imageDataTemp = [AppManager readDataFromDocumentWithName:fileName];
                     for (TableViewCellValue * cellTemp in self.fetchingOrderTypeIconArr)
                     {
                         if ((cellTemp.bNeedGetOrderTypeIcon) && [cellTemp.orderTypeIconFileName isEqualToString:cell.orderTypeIconFileName])
                         {
                             cell.imageViewOrderTypeIcon.image = [UIImage imageWithData:imageDataTemp];
                             cell.imageViewOrderTypeIcon.bounds = CGRectMake(0, 0, 15, 15);
                             cell.imageViewOrderTypeIcon.contentMode = UIViewContentModeScaleToFill;
                             if(bDefault)
                             {
                                 cell.bNeedGetOrderTypeIcon = YES;
                             }
                             else
                             {
                                 cell.bNeedGetOrderTypeIcon = NO;
                             }
                         }
                         else
                         {
                             [fetchingIconArrTemp addObject:cellTemp];
                         }
                     }
                     [self.fetchingOrderTypeIconArr removeAllObjects];
                     self.fetchingOrderTypeIconArr = fetchingIconArrTemp;
                     [self.tableView reloadData];
                 }

             }];
        }
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self hiddenDetail];
    //OrderWaitQianShouCell  待接单
    //    OrderWaitLanShouCell   if statusWaitLanshou待揽收   statusWaitQianShou待签收
    if((self.arratData.count <= indexPath.section) || (0== self.arratData.count))
    {
        return nil;
    }
    UITableViewCell* cell = nil;
//    NSString *consigneeAddressStr = nil;
    long lEstimated =  0;
    double lDistance = 1001.0;
    long lQuickType = 2;
    float fFreight = 0.0;
//    NSString * fFreightStr = nil;
    double consigneeLogitude = 0.0;
    double consigneeLatitude = 0.0;
//    NSString *consigneeLogitudeStr = nil;
//    NSString *consigneeLatitudeStr = nil;
//    NSString *walkingRouteDistanceStr = nil;
//    NSString *contentTitle = nil;
    if(indexPath.section == 2)
    {
        
        FLDDLogDebug(@"indexPath.section = %ld", (long)indexPath.section);
    }

//    @try {

    if ([self.strType isEqualToString:@"lanshou"]) {
        
        
        NSString* strStatus =[[self.arratData objectAtIndex:indexPath.section]valueForKey:@"status"];
        if ([strStatus isEqualToString:@"待揽收"]) {
            static NSString *cellIdentifier = @"OrderWaitLanLanTableViewCell";
            OrderWaitLanLanTableViewCell *cellLanShou =(OrderWaitLanLanTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (!cellLanShou) {
                UINib* nib =[UINib nibWithNibName:@"OrderWaitLanLanTableViewCell" bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
                cellLanShou = (OrderWaitLanLanTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            }
            cellLanShou.labelJInE.text =[NSString stringWithFormat:@"订单金额  %.2f元",[[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"waybillPrice"] floatValue]/100];
            cellLanShou.labelTime.text =[NSString stringWithFormat:@"发单时间  %@",[CommonUtils getDateForStringTime:[NSString stringWithFormat:@"%@",[[self.arratData  objectAtIndex:indexPath.section] valueForKey:@"createTime"]] withFormat:@"HH:mm"]];
            cellLanShou.labelPeiSongYuan.text =[NSString stringWithFormat:@"配送员:  %@ %@",[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"courierName"],[CommonUtils changePhoneNumberWithNumber:[[self.arratData  objectAtIndex:indexPath.section] valueForKey:@"courierTel"] withType:@" "]];
            cellLanShou.buttonPhonePressed.tag = indexPath.section;
            [cellLanShou.buttonPhonePressed addTarget:self action:@selector(buttonPressedPhone:) forControlEvents:UIControlEventTouchUpInside];
            lQuickType = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"quickType"] longValue];
            lEstimated = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"estimated"] longValue];
            consigneeLogitude = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"consigneeLongitude"] doubleValue];
            consigneeLatitude = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"consigneeLatitude"] doubleValue];
            if((0 == consigneeLogitude) || (0 == consigneeLatitude))
            {
                cellLanShou.labelPeiSongFei.text =[NSString stringWithFormat:@"运   费:  %.2f元 (预估)", [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] floatValue]/100];
            }
            else
            {
                cellLanShou.labelPeiSongFei.text = [NSString stringWithFormat:@"运   费:  %.2f元", [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] floatValue]/100];
            }
            UIImage *image = [UIImage imageNamed:@"prompt_fare_box_card"];
            NSInteger leftCapWidth = image.size.width * 0.5f;
            // 顶端盖高度
            NSInteger topCapHeight = image.size.height * 0.5f;
            // 重新赋值
            image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
            
            if((1 == lQuickType) && (1 == lEstimated) && (consigneeLatitude > 0) && (consigneeLogitude > 0))
            {
                fFreight = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] longValue];
                fFreight = fFreight/100;
                lDistance = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"walkingDistance"] integerValue];
                if(lDistance >= 0)
                {
                    fFreight = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] longValue];
                    fFreight = fFreight/100;
                    if(lDistance >= 1000)
                    {
                        lDistance = lDistance/1000;
                        [cellLanShou.contentDisplayBtn setTitle:[NSString stringWithFormat:@"  实际配送%.2f公里，应付运费%.2f元", lDistance, fFreight] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [cellLanShou.contentDisplayBtn setTitle:[NSString stringWithFormat:@"  实际配送%ld米，应付运费%.2f元", (long)lDistance, fFreight] forState:UIControlStateNormal];
                    }
                }
                else
                {
                    [cellLanShou.contentDisplayBtn setTitle:[NSString stringWithFormat:@"  实际配送--公里，应付运费%.2f元", fFreight] forState:UIControlStateNormal];
                }
//                [[self.arratData  objectAtIndex:indexPath.section] setValue:@"" forKey:@"walkingRouteDistance"];
                [cellLanShou.contentDisplayBtn setBackgroundImage:image forState:UIControlStateNormal];
                cellLanShou.contentBtn.row = indexPath.section;
                cellLanShou.contentBtn.contentUIView = cellLanShou.contentDetailView;
                cellLanShou.contentBtn.contentDisplayButton = cellLanShou.contentDisplayBtn;
                [cellLanShou.contentBtn addTarget:self action:@selector(buttonPressedContent:) forControlEvents:UIControlEventTouchUpInside];
                cellLanShou.detailBackgroundBtn.contentUIView = cellLanShou.contentDetailView;
                cellLanShou.detailBackgroundBtn.isShortBtn = NO;
            }
            else
            {
                cellLanShou.contentShortBtn.contentDisplayButton = nil;
                [cellLanShou.contentDisplayShortBtn setBackgroundImage:image forState:UIControlStateNormal];
                cellLanShou.contentShortBtn.contentUIView = cellLanShou.contentShortDetailView;
                cellLanShou.contentShortBtn.row = indexPath.section;
                [cellLanShou.contentShortBtn addTarget:self action:@selector(buttonPressedContent:) forControlEvents:UIControlEventTouchUpInside];
                cellLanShou.detailBackgroundBtn.contentUIView = cellLanShou.contentShortDetailView;
                [cellLanShou.contentDisplayShortBtn setTitle:@"  具体运费最终由实际配送里程决定" forState:UIControlStateNormal];
                cellLanShou.detailBackgroundBtn.isShortBtn = YES;
            }
            cellLanShou.detailBackgroundBtn.row = indexPath.section;
            [cellLanShou.detailBackgroundBtn addTarget:self action:@selector(buttonPressedDetail:) forControlEvents:UIControlEventTouchUpInside];
            if(2 == lQuickType)
            {
                cellLanShou.contentDetailView.hidden = YES;
                cellLanShou.contentShortDetailView.hidden = YES;
                cellLanShou.detailBackgroundBtn.hidden = YES;
                cellLanShou.detailBtn.hidden = YES;
            }
            else
            {
                cellLanShou.detailBackgroundBtn.hidden = NO;
                cellLanShou.detailBtn.hidden = NO;
                if((_iRow >= 0) && !_bHidden && (_iRow == indexPath.section))
                {
                    if(cellLanShou.detailBackgroundBtn.isShortBtn)
                    {
                        cellLanShou.contentShortDetailView.hidden = NO;
                        cellLanShou.contentDetailView.hidden = YES;
                    }
                    else
                    {
                        cellLanShou.contentShortDetailView.hidden = YES;
                        cellLanShou.contentDetailView.hidden = NO;
                    }
                }
                else
                {
                    cellLanShou.contentShortDetailView.hidden = YES;
                    cellLanShou.contentDetailView.hidden = YES;
                }
                
            }
            NSString *quickTypeIconUrl = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"courierRankIconUrl"] toString];
            [self loadIcon:cellLanShou.imageViewPeiSongDengJi withWayQuickTypeIconUrl:quickTypeIconUrl withTableViewcell:cellLanShou];
            
            quickTypeIconUrl = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"quickTypeIconUrl"] toString];
            [self loadOrderTypeIcon:cellLanShou.imageViewOrderType withWayQuickTypeIconUrl:quickTypeIconUrl withTableViewcell:cellLanShou];
            cell = cellLanShou;
        }else{
             static NSString *cellIdentifier = @"OrderWaitLanTableViewCell";
            OrderWaitLanTableViewCell *cellQiangDan = (OrderWaitLanTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (!cellQiangDan) {
                UINib* nib =[UINib nibWithNibName:@"OrderWaitLanTableViewCell" bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
                cellQiangDan = (OrderWaitLanTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            }
            cellQiangDan.labelJInE.text =[NSString stringWithFormat:@"订单金额  %.2f元",[[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"waybillPrice"] floatValue]/100];
            cellQiangDan.labelTime.text =[NSString stringWithFormat:@"发单时间  %@",[CommonUtils getDateForStringTime:[NSString stringWithFormat:@"%@",[[self.arratData  objectAtIndex:indexPath.section] valueForKey:@"createTime"]] withFormat:@"HH:mm"]];
            lQuickType = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"quickType"] longValue];
            lEstimated = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"estimated"] longValue];
            consigneeLogitude = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"consigneeLongitude"] doubleValue];
            consigneeLatitude = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"consigneeLatitude"] doubleValue];
            if((0 == consigneeLogitude) || (0 == consigneeLatitude))
            {
                cellQiangDan.labelPeiSongFei.text =[NSString stringWithFormat:@"运   费:  %.2f元 (预估)", [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] floatValue]/100];
            }
            else
            {
                cellQiangDan.labelPeiSongFei.text = [NSString stringWithFormat:@"运   费:  %.2f元", [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] floatValue]/100];
            }
            UIImage *image = [UIImage imageNamed:@"prompt_fare_box_card"];
            NSInteger leftCapWidth = image.size.width * 0.5f;
            // 顶端盖高度
            NSInteger topCapHeight = image.size.height * 0.5f;
            // 重新赋值
            image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
            
            if((1 == lQuickType) && (1 == lEstimated) && (consigneeLatitude > 0) && (consigneeLogitude > 0))
            {
                fFreight = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] longValue];
                fFreight = fFreight/100;
                lDistance = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"walkingDistance"] integerValue];
                if(lDistance >= 0)
                {
                    fFreight = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] longValue];
                    fFreight = fFreight/100;
                    if(lDistance >= 1000)
                    {
                        lDistance = lDistance/1000;
                        [cellQiangDan.contentDisplayBtn setTitle:[NSString stringWithFormat:@"  实际配送%.2f公里，应付运费%.2f元", lDistance, fFreight] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [cellQiangDan.contentDisplayBtn setTitle:[NSString stringWithFormat:@"  实际配送%ld米，应付运费%.2f元", (long)lDistance, fFreight] forState:UIControlStateNormal];
                    }
                }
                else
                {
                    [cellQiangDan.contentDisplayBtn setTitle:[NSString stringWithFormat:@"  实际配送--公里，应付运费%.2f元", fFreight] forState:UIControlStateNormal];
                }
                [cellQiangDan.contentDisplayBtn setBackgroundImage:image forState:UIControlStateNormal];
                cellQiangDan.contentBtn.row = indexPath.section;
                cellQiangDan.contentBtn.contentUIView = cellQiangDan.contentDetailView;
                cellQiangDan.contentBtn.contentDisplayButton = cellQiangDan.contentDisplayBtn;
                [cellQiangDan.contentBtn addTarget:self action:@selector(buttonPressedContent:) forControlEvents:UIControlEventTouchUpInside];
                cellQiangDan.detailBackgroundBtn.contentUIView = cellQiangDan.contentDetailView;
                cellQiangDan.detailBackgroundBtn.isShortBtn = NO;
            }
            else
            {
                cellQiangDan.contentDisplayShortBtn.contentDisplayButton = nil;
                [cellQiangDan.contentDisplayShortBtn setBackgroundImage:image forState:UIControlStateNormal];
                cellQiangDan.contentShortBtn.contentUIView = cellQiangDan.contentShortDetailView;
                cellQiangDan.contentShortBtn.row = indexPath.section;
                [cellQiangDan.contentShortBtn addTarget:self action:@selector(buttonPressedContent:) forControlEvents:UIControlEventTouchUpInside];
                cellQiangDan.detailBackgroundBtn.contentUIView = cellQiangDan.contentShortDetailView;
                [cellQiangDan.contentDisplayShortBtn setTitle:@"  具体运费最终由实际配送里程决定"  forState:UIControlStateNormal];
                cellQiangDan.detailBackgroundBtn.isShortBtn = YES;
            }
            cellQiangDan.detailBackgroundBtn.row = indexPath.section;
            [cellQiangDan.detailBackgroundBtn addTarget:self action:@selector(buttonPressedDetail:) forControlEvents:UIControlEventTouchUpInside];
            if(2 == lQuickType)
            {
                cellQiangDan.contentDetailView.hidden = YES;
                cellQiangDan.detailBackgroundBtn.hidden = YES;
                cellQiangDan.detailBtn.hidden = YES;
                cellQiangDan.contentShortDetailView.hidden = YES;
            }
            else
            {
                cellQiangDan.detailBackgroundBtn.hidden = NO;
                cellQiangDan.detailBtn.hidden = NO;
                if((_iRow >= 0) && !_bHidden && (_iRow == indexPath.section))
                {
                    if(cellQiangDan.detailBackgroundBtn.isShortBtn)
                    {
                        cellQiangDan.contentShortDetailView.hidden = NO;
                        cellQiangDan.contentDetailView.hidden = YES;
                    }
                    else
                    {
                        cellQiangDan.contentShortDetailView.hidden = YES;
                        cellQiangDan.contentDetailView.hidden = NO;
                    }
                }
                else
                {
                    cellQiangDan.contentShortDetailView.hidden = YES;
                    cellQiangDan.contentDetailView.hidden = YES;
                }
            }
            NSString *quickTypeIconUrl = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"quickTypeIconUrl"] toString];
            [self loadOrderTypeIcon:cellQiangDan.imageViewOrderType withWayQuickTypeIconUrl:quickTypeIconUrl withTableViewcell:cellQiangDan];
            cell = cellQiangDan;
        }
    }else if([self.strType isEqualToString:@"qianshou"]){
        static NSString *cellIdentifier = @"OrderQianShouTableViewCell";
        OrderQianShouTableViewCell *cellQianShou = (OrderQianShouTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cellQianShou) {
            UINib* nib =[UINib nibWithNibName:@"OrderQianShouTableViewCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
            cellQianShou = (OrderQianShouTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        }
        
        cellQianShou.labelJInE.text =[NSString stringWithFormat:@"订单金额  %.2f元",[[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"waybillPrice"] floatValue]/100];
        cellQianShou.labelTime.text =[NSString stringWithFormat:@"发单时间  %@",[CommonUtils getDateForStringTime:[NSString stringWithFormat:@"%@",[[self.arratData  objectAtIndex:indexPath.section] valueForKey:@"createTime"]] withFormat:@"HH:mm"]];
        cellQianShou.labelPeiSongYuan.text =[NSString stringWithFormat:@"配送员:  %@ %@",[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"courierName"],[CommonUtils changePhoneNumberWithNumber:[[self.arratData  objectAtIndex:indexPath.section] valueForKey:@"courierTel"] withType:@" "]];
        cellQianShou.labelShouHuoAddress.text =[NSString stringWithFormat:@"收货地址  %@",[[self.arratData  objectAtIndex:indexPath.section] valueForKey:@"consigneeAddress"]];
        
        cellQianShou.buttonPhonePressed.tag = indexPath.section;
        [ cellQianShou.buttonPhonePressed addTarget:self action:@selector(buttonPressedPhone:) forControlEvents:UIControlEventTouchUpInside];
        lQuickType = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"quickType"] longValue];
        lEstimated = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"estimated"] longValue];
        consigneeLogitude = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"consigneeLongitude"] doubleValue];
        consigneeLatitude = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"consigneeLatitude"] doubleValue];
        if((0 == consigneeLogitude) || (0 == consigneeLatitude))
        {
            cellQianShou.labelPeiSongFei.text =[NSString stringWithFormat:@"运   费:  %.2f元 (预估)", [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] floatValue]/100];
        }
        else
        {
            cellQianShou.labelPeiSongFei.text = [NSString stringWithFormat:@"运   费:  %.2f元", [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] floatValue]/100];
        }
        UIImage *image = [UIImage imageNamed:@"prompt_fare_box_card"];
        NSInteger leftCapWidth = image.size.width * 0.5f;
        // 顶端盖高度
        NSInteger topCapHeight = image.size.height * 0.5f;
        // 重新赋值
        image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
        
        if((1 == lQuickType) && (1 == lEstimated) && (consigneeLatitude > 0) && (consigneeLogitude > 0))
        {
            fFreight = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] longValue];
            fFreight = fFreight/100;
            lDistance = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"walkingDistance"] integerValue];
            if(lDistance >= 0)
            {
                fFreight = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] longValue];
                fFreight = fFreight/100;
                if(lDistance >= 1000)
                {
                    lDistance = lDistance/1000;
                    [cellQianShou.contentDisplayBtn setTitle:[NSString stringWithFormat:@"  实际配送%.2f公里，应付运费%.2f元", lDistance, fFreight] forState:UIControlStateNormal];
                }
                else
                {
                    [cellQianShou.contentDisplayBtn setTitle:[NSString stringWithFormat:@"  实际配送%ld米，应付运费%.2f元", (long)lDistance, fFreight] forState:UIControlStateNormal];
                }
            }
            else
            {
                [cellQianShou.contentDisplayBtn setTitle:[NSString stringWithFormat:@"  实际配送--公里，应付运费%.2f元", fFreight] forState:UIControlStateNormal];
            }
            [cellQianShou.contentDisplayBtn setBackgroundImage:image forState:UIControlStateNormal];
            cellQianShou.contentBtn.row = indexPath.section;
            cellQianShou.contentBtn.contentUIView = cellQianShou.contentDetailView;
            cellQianShou.contentBtn.contentDisplayButton = cellQianShou.contentDisplayBtn;
            [cellQianShou.contentBtn addTarget:self action:@selector(buttonPressedContent:) forControlEvents:UIControlEventTouchUpInside];
            cellQianShou.detailBackgroundBtn.contentUIView = cellQianShou.contentDetailView;
            cellQianShou.detailBackgroundBtn.isShortBtn = NO;
        }
        else
        {
            cellQianShou.contentDisplayShortBtn.contentDisplayButton = nil;
            [cellQianShou.contentDisplayShortBtn setBackgroundImage:image forState:UIControlStateNormal];
            cellQianShou.contentShortBtn.contentUIView = cellQianShou.contentShortDetailView;
            cellQianShou.contentShortBtn.row = indexPath.section;
            [cellQianShou.contentShortBtn addTarget:self action:@selector(buttonPressedContent:) forControlEvents:UIControlEventTouchUpInside];
            cellQianShou.detailBackgroundBtn.contentUIView = cellQianShou.contentShortDetailView;
            [cellQianShou.contentDisplayShortBtn setTitle:@"  具体运费最终由实际配送里程决定"  forState:UIControlStateNormal];
            cellQianShou.detailBackgroundBtn.isShortBtn = YES;
        }

        cellQianShou.detailBackgroundBtn.row = indexPath.section;
        [cellQianShou.detailBackgroundBtn addTarget:self action:@selector(buttonPressedDetail:) forControlEvents:UIControlEventTouchUpInside];
        if(2 == lQuickType)
        {
            cellQianShou.contentDetailView.hidden = YES;
            cellQianShou.detailBackgroundBtn.hidden = YES;
            cellQianShou.detailBtn.hidden = YES;
            cellQianShou.contentShortDetailView.hidden = YES;
        }
        else
        {
            cellQianShou.detailBackgroundBtn.hidden = NO;
            cellQianShou.detailBtn.hidden = NO;
            if((_iRow >= 0) && !_bHidden && (_iRow == indexPath.section))
            {
                if(cellQianShou.detailBackgroundBtn.isShortBtn)
                {
                    cellQianShou.contentShortDetailView.hidden = NO;
                    cellQianShou.contentDetailView.hidden = YES;
                }
                else
                {
                    cellQianShou.contentShortDetailView.hidden = YES;
                    cellQianShou.contentDetailView.hidden = NO;
                }
            }
            else
            {
                cellQianShou.contentShortDetailView.hidden = YES;
                cellQianShou.contentDetailView.hidden = YES;
            }
        }
        
        NSString *quickTypeIconUrl = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"courierRankIconUrl"] toString];
        [self loadIcon:cellQianShou.imageViewPeiSongDengJi withWayQuickTypeIconUrl:quickTypeIconUrl withTableViewcell:cellQianShou];
        quickTypeIconUrl = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"quickTypeIconUrl"] toString];
        [self loadOrderTypeIcon:cellQianShou.imageViewOrderType withWayQuickTypeIconUrl:quickTypeIconUrl withTableViewcell:cellQianShou];
        cell = cellQianShou;

    }else if([self.strType isEqualToString:@"chuli"]){
        
        if ([[[self.arratData  objectAtIndex:indexPath.section] valueForKey:@"killedStatusId"] integerValue] == 1) {
            
            static NSString *cellIdentifier = @"OrderDoingCancelTableViewCell";
            OrderDoingCancelTableViewCell *cellDoingCancel = (OrderDoingCancelTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (!cellDoingCancel) {
                UINib* nib =[UINib nibWithNibName:@"OrderDoingCancelTableViewCell" bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
                cellDoingCancel = (OrderDoingCancelTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            }
            cellDoingCancel.labelJInE.text =[NSString stringWithFormat:@"订单金额  %.2f元",[[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"waybillPrice"] floatValue]/100];
            cellDoingCancel.labelTime.text =[NSString stringWithFormat:@"发单时间  %@",[CommonUtils getDateForStringTime:[NSString stringWithFormat:@"%@",[[self.arratData  objectAtIndex:indexPath.section] valueForKey:@"createTime"]] withFormat:@"HH:mm"]];
            cellDoingCancel.labelPeiSongYuan.text =[NSString stringWithFormat:@"配送员:  %@ %@",[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"courierName"],[CommonUtils changePhoneNumberWithNumber:[[self.arratData  objectAtIndex:indexPath.section] valueForKey:@"courierTel"] withType:@" "]];
            cellDoingCancel.buttonPhonePressed.tag = indexPath.section;
            [ cellDoingCancel.buttonPhonePressed addTarget:self action:@selector(buttonPressedPhone:) forControlEvents:UIControlEventTouchUpInside];
            FLDDLogDebug(@"cellDoingCancel.contentDetailView.frame.size.height:%f", cellDoingCancel.contentDetailView.frame.size.height);
            lQuickType = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"quickType"] longValue];
            lEstimated = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"estimated"] longValue];
            consigneeLogitude = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"consigneeLongitude"] doubleValue];
            consigneeLatitude = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"consigneeLatitude"] doubleValue];
            if((0 == consigneeLogitude) || (0 == consigneeLatitude))
            {
                cellDoingCancel.labelPeiSongFei.text =[NSString stringWithFormat:@"运   费:  %.2f元 (预估)", [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] floatValue]/100];
            }
            else
            {
                cellDoingCancel.labelPeiSongFei.text =[NSString stringWithFormat:@"运   费:  %.2f元", [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] floatValue]/100];
            }
            UIImage *image = [UIImage imageNamed:@"prompt_fare_box_card"];
            NSInteger leftCapWidth = image.size.width * 0.5f;
            // 顶端盖高度
            NSInteger topCapHeight = image.size.height * 0.5f;
            // 重新赋值
            image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
            
            if((1 == lQuickType) && (1 == lEstimated) && (consigneeLatitude > 0) && (consigneeLogitude > 0))
            {
                fFreight = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] longValue];
                fFreight = fFreight/100;
                lDistance = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"walkingDistance"] integerValue];
                if(lDistance >= 0)
                {
                    fFreight = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] longValue];
                    fFreight = fFreight/100;
                    if(lDistance >= 1000)
                    {
                        lDistance = lDistance/1000;
                        [cellDoingCancel.contentDisplayBtn setTitle:[NSString stringWithFormat:@"  实际配送%.2f公里，应付运费%.2f元", lDistance, fFreight] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [cellDoingCancel.contentDisplayBtn setTitle:[NSString stringWithFormat:@"  实际配送%ld米，应付运费%.2f元", (long)lDistance, fFreight] forState:UIControlStateNormal];
                    }
                }
                else
                {
                    [cellDoingCancel.contentDisplayBtn setTitle:[NSString stringWithFormat:@"  实际配送--公里，应付运费%.2f元", fFreight] forState:UIControlStateNormal];
                }
                [cellDoingCancel.contentDisplayBtn setBackgroundImage:image forState:UIControlStateNormal];
                cellDoingCancel.contentBtn.contentUIView = cellDoingCancel.contentDetailView;
                cellDoingCancel.contentBtn.contentDisplayButton = cellDoingCancel.contentDisplayBtn;
                cellDoingCancel.contentBtn.row = indexPath.section;
                [cellDoingCancel.contentBtn addTarget:self action:@selector(buttonPressedContent:) forControlEvents:UIControlEventTouchUpInside];
                cellDoingCancel.detailBackgroundBtn.contentUIView = cellDoingCancel.contentDetailView;
                cellDoingCancel.detailBackgroundBtn.isShortBtn = NO;
            }
            else
            {
                cellDoingCancel.contentDisplayShortBtn.contentDisplayButton = nil;
                [cellDoingCancel.contentDisplayShortBtn setBackgroundImage:image forState:UIControlStateNormal];
                cellDoingCancel.contentShortBtn.contentUIView = cellDoingCancel.contentShortDetailView;
                cellDoingCancel.contentShortBtn.row = indexPath.section;
                [cellDoingCancel.contentShortBtn addTarget:self action:@selector(buttonPressedContent:) forControlEvents:UIControlEventTouchUpInside];
                cellDoingCancel.detailBackgroundBtn.contentUIView = cellDoingCancel.contentShortDetailView;
                [cellDoingCancel.contentDisplayShortBtn setTitle:@"  具体运费最终由实际配送里程决定"  forState:UIControlStateNormal];
                cellDoingCancel.detailBackgroundBtn.isShortBtn = YES;
            }
            cellDoingCancel.detailBackgroundBtn.row = indexPath.section;
            [cellDoingCancel.detailBackgroundBtn addTarget:self action:@selector(buttonPressedDetail:) forControlEvents:UIControlEventTouchUpInside];
            if(2 == lQuickType)
            {
                cellDoingCancel.contentDetailView.hidden = YES;
                cellDoingCancel.detailBackgroundBtn.hidden = YES;
                cellDoingCancel.detailBtn.hidden = YES;
                cellDoingCancel.contentShortDetailView.hidden = YES;
            }
            else
            {
                cellDoingCancel.detailBackgroundBtn.hidden = NO;
                cellDoingCancel.detailBtn.hidden = NO;
                if((_iRow >= 0) && !_bHidden && (_iRow == indexPath.section))
                {
                    if(cellDoingCancel.detailBackgroundBtn.isShortBtn)
                    {
                        cellDoingCancel.contentShortDetailView.hidden = NO;
                        cellDoingCancel.contentDetailView.hidden = YES;
                    }
                    else
                    {
                        cellDoingCancel.contentShortDetailView.hidden = YES;
                        cellDoingCancel.contentDetailView.hidden = NO;
                    }
                }
                else
                {
                    cellDoingCancel.contentShortDetailView.hidden = YES;
                    cellDoingCancel.contentDetailView.hidden = YES;
                }
            }
            FLDDLogDebug(@"cellDoingCancel.contentDetailView.frame.size.height:%f", cellDoingCancel.contentDetailView.frame.size.height);
            FLDDLogDebug(@"cellDoingCancel.buttonPhonePressed.frame.size.height:%f", cellDoingCancel.buttonPhonePressed.frame.size.height);
            NSString *quickTypeIconUrl = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"courierRankIconUrl"] toString];
            [self loadIcon:cellDoingCancel.imageViewPeiSongDengJi withWayQuickTypeIconUrl:quickTypeIconUrl withTableViewcell:cellDoingCancel];
            quickTypeIconUrl = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"quickTypeIconUrl"] toString];
            [self loadOrderTypeIcon:cellDoingCancel.imageViewOrderType withWayQuickTypeIconUrl:quickTypeIconUrl withTableViewcell:cellDoingCancel];
            cell = cellDoingCancel;
        }
        if ([[[self.arratData  objectAtIndex:indexPath.section] valueForKey:@"killedStatusId"] integerValue] == 2)  {
            static NSString *cellIdentifier = @"OrderDoingJuShouTableViewCell";
            OrderDoingJuShouTableViewCell *cellDoingJuShou = (OrderDoingJuShouTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (!cellDoingJuShou) {
                UINib* nib =[UINib nibWithNibName:@"OrderDoingJuShouTableViewCell" bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
                cellDoingJuShou = (OrderDoingJuShouTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            }
            cellDoingJuShou.labelJInE.text =[NSString stringWithFormat:@"订单金额  %.2f元",[[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"waybillPrice"] floatValue]/100];
            cellDoingJuShou.labelTime.text =[NSString stringWithFormat:@"发单时间  %@",[CommonUtils getDateForStringTime:[NSString stringWithFormat:@"%@",[[self.arratData  objectAtIndex:indexPath.section] valueForKey:@"createTime"]] withFormat:@"HH:mm"]];
            cellDoingJuShou.labelPeiSongYuan.text =[NSString stringWithFormat:@"配送员:  %@ %@",[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"courierName"],[CommonUtils changePhoneNumberWithNumber:[[self.arratData  objectAtIndex:indexPath.section] valueForKey:@"courierTel"] withType:@" "]];
            cellDoingJuShou.labelShouHuoAddress.text =[NSString stringWithFormat:@"收货地址  %@",[[self.arratData  objectAtIndex:indexPath.section] valueForKey:@"consigneeAddress"]];
            cellDoingJuShou.labePhoneNumber.text = [NSString stringWithFormat:@"收货电话  %@",[CommonUtils changePhoneNumberWithNumber:[[self.arratData  objectAtIndex:indexPath.section] valueForKey:@"consigneeTel"] withType:@" "] ];
            cellDoingJuShou.buttonPhonePressed.tag = indexPath.section;
            [ cellDoingJuShou.buttonPhonePressed addTarget:self action:@selector(buttonPressedPhone:) forControlEvents:UIControlEventTouchUpInside];
            lQuickType = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"quickType"] longValue];
            lEstimated = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"estimated"] longValue];
            consigneeLogitude = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"consigneeLongitude"] doubleValue];
            consigneeLatitude = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"consigneeLatitude"] doubleValue];
            if((0 == consigneeLogitude) || (0 == consigneeLatitude))
            {
                cellDoingJuShou.labelPeiSongFei.text =[NSString stringWithFormat:@"运   费:  %.2f元 (预估)", [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] floatValue]/100];
            }
            else
            {
                cellDoingJuShou.labelPeiSongFei.text = [NSString stringWithFormat:@"运   费:  %.2f元", [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] floatValue]/100];
            }
            UIImage *image = [UIImage imageNamed:@"prompt_fare_box_card"];
            NSInteger leftCapWidth = image.size.width * 0.5f;
            // 顶端盖高度
            NSInteger topCapHeight = image.size.height * 0.5f;
            // 重新赋值
            image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
            
            if((1 == lQuickType) && (1 == lEstimated) && (consigneeLatitude > 0) && (consigneeLogitude > 0))
            {
                fFreight = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] longValue];
                fFreight = fFreight/100;
                lDistance = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"walkingDistance"] integerValue];
                if(lDistance >= 0)
                {
                    fFreight = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"freight"] longValue];
                    fFreight = fFreight/100;
                    if(lDistance >= 1000)
                    {
                        lDistance = lDistance/1000;
                        [cellDoingJuShou.contentDisplayBtn setTitle:[NSString stringWithFormat:@"  实际配送%.2f公里，应付运费%.2f元", lDistance, fFreight] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [cellDoingJuShou.contentDisplayBtn setTitle:[NSString stringWithFormat:@"  实际配送%ld米，应付运费%.2f元", (long)lDistance, fFreight] forState:UIControlStateNormal];
                    }
                }
                else
                {
                    [cellDoingJuShou.contentDisplayBtn setTitle:[NSString stringWithFormat:@"  实际配送--公里，应付运费%.2f元", fFreight] forState:UIControlStateNormal];
                }
                [cellDoingJuShou.contentDisplayBtn setBackgroundImage:image forState:UIControlStateNormal];
                cellDoingJuShou.contentBtn.contentUIView = cellDoingJuShou.contentDetailView;
                cellDoingJuShou.contentBtn.contentDisplayButton = cellDoingJuShou.contentDisplayBtn;
                cellDoingJuShou.contentBtn.row = indexPath.section;
                [cellDoingJuShou.contentBtn addTarget:self action:@selector(buttonPressedContent:) forControlEvents:UIControlEventTouchUpInside];
                cellDoingJuShou.detailBackgroundBtn.contentUIView = cellDoingJuShou.contentDetailView;
                cellDoingJuShou.detailBackgroundBtn.isShortBtn = NO;
            }
            else
            {
                cellDoingJuShou.contentDisplayShortBtn.contentDisplayButton = nil;
                [cellDoingJuShou.contentDisplayShortBtn setBackgroundImage:image forState:UIControlStateNormal];
                cellDoingJuShou.contentShortBtn.contentUIView = cellDoingJuShou.contentShortDetailView;
                cellDoingJuShou.contentShortBtn.row = indexPath.section;
                [cellDoingJuShou.contentShortBtn addTarget:self action:@selector(buttonPressedContent:) forControlEvents:UIControlEventTouchUpInside];
                cellDoingJuShou.detailBackgroundBtn.contentUIView = cellDoingJuShou.contentShortDetailView;
                [cellDoingJuShou.contentDisplayShortBtn setTitle:@"  具体运费最终由实际配送里程决定"  forState:UIControlStateNormal];
                cellDoingJuShou.detailBackgroundBtn.isShortBtn = YES;
            }
            cellDoingJuShou.detailBackgroundBtn.row = indexPath.section;
            [cellDoingJuShou.detailBackgroundBtn addTarget:self action:@selector(buttonPressedDetail:) forControlEvents:UIControlEventTouchUpInside];
            if(2 == lQuickType)
            {
                cellDoingJuShou.contentDetailView.hidden = YES;
                cellDoingJuShou.detailBackgroundBtn.hidden = YES;
                cellDoingJuShou.detailBtn.hidden = YES;
                cellDoingJuShou.contentShortDetailView.hidden = YES;
            }
            else
            {
                cellDoingJuShou.detailBackgroundBtn.hidden = NO;
                cellDoingJuShou.detailBtn.hidden = NO;
                if((_iRow >= 0) && !_bHidden && (_iRow == indexPath.section))
                {
                    if(cellDoingJuShou.detailBackgroundBtn.isShortBtn)
                    {
                        cellDoingJuShou.contentShortDetailView.hidden = NO;
                        cellDoingJuShou.contentDetailView.hidden = YES;
                    }
                    else
                    {
                        cellDoingJuShou.contentShortDetailView.hidden = YES;
                        cellDoingJuShou.contentDetailView.hidden = NO;
                    }
                }
                else
                {
                    cellDoingJuShou.contentShortDetailView.hidden = YES;
                    cellDoingJuShou.contentDetailView.hidden = YES;
                }
            }
            NSString *quickTypeIconUrl = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"courierRankIconUrl"] toString];
            [self loadIcon:cellDoingJuShou.imageViewPeiSongDengJi withWayQuickTypeIconUrl:quickTypeIconUrl withTableViewcell:cellDoingJuShou];
            quickTypeIconUrl = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"quickTypeIconUrl"] toString];
            [self loadOrderTypeIcon:cellDoingJuShou.imageViewOrderType withWayQuickTypeIconUrl:quickTypeIconUrl withTableViewcell:cellDoingJuShou];
            cell = cellDoingJuShou;
        }
        
    }
    return cell;
//    }
//    @catch (NSException *exception) {
//        FLDDLogInfo(@"exception:%@", exception);
//    }
//    @finally {
//        return nil;
//        
//    }
}

#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hiddenDetail];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
    
    if (self.orderBtnStatus == statusWaitLanshou ) {
        
        OrderDetailViewController* orderDetail = [[OrderDetailViewController alloc]initWithNibName:nil bundle:nil];
        orderDetail.distance = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"walkingDistance"] integerValue];
        NSString* strStatus =[[self.arratData objectAtIndex:indexPath.section]valueForKey:@"status"];
        if ([strStatus isEqualToString:@"待揽收"]) {
            orderDetail.order_status = ORDER_STATUS_WAIT_LANSHOU;
        }else{
            orderDetail.order_status = ORDER_STATUS_WAIT_QIANGDAN;
        }
        
        orderDetail.strWayBillld = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"waybillId"] toString];
        orderDetail.status = orderDetail.order_status;
        [self.navigationController pushViewController:orderDetail animated:YES];
        orderDetail = nil;
        
        
    }else if(self.orderBtnStatus == statusWaitQianShou){
//        [SelfUser currentSelfUser].isNeedReturnLanShou = YES;
        OrderDetailViewController* orderDetail = [[OrderDetailViewController alloc]initWithNibName:nil bundle:nil];
        orderDetail.distance = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"walkingDistance"] integerValue];
        orderDetail.order_status = ORDER_STATUS_WAIT_QIANSHOU;
        orderDetail.strWayBillld = [[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"waybillId"] toString];
        [self.navigationController pushViewController:orderDetail animated:YES];
        orderDetail = nil;
        
    }else{
//        [SelfUser currentSelfUser].isNeedReturnLanShou = YES;
        OrderErrorDetailkViewController* errorDetail = [[OrderErrorDetailkViewController alloc ]initWithNibName:nil bundle:nil];
 
        if ([[[self.arratData  objectAtIndex:indexPath.section] valueForKey:@"killedStatusId"] integerValue] == 1) {
            errorDetail.orderStatus = ORDER_ERROR_STATUS_WAIT_CANCEL;
            errorDetail.isDonig = YES;
        }else{
            errorDetail.orderStatus = ORDER_ERROR_STATUS_WAIT_JUSHOU;
             errorDetail.isDonig = YES;
        }
        errorDetail.strWayBillld =[[[self.arratData objectAtIndex:indexPath.section]valueForKey:@"waybillId"] toString];
        [self.navigationController pushViewController:errorDetail animated:YES];
        errorDetail = nil;
        
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    
    if (self.orderBtnStatus == statusWaitLanshou ) {
        NSString* strStatus =[[self.arratData  objectAtIndex:indexPath.section]valueForKey:@"status"];
        if ([strStatus isEqualToString:@"待揽收"]) {
            
            height =    130;
        }else{
            height =   109;
        }
        
    }else if(self.orderBtnStatus == statusWaitQianShou){
        height =  160;
        
    }else{
        
        if ([[[self.arratData  objectAtIndex:indexPath.section] valueForKey:@"killedStatusId"] integerValue] == 2)  {
            
            return 190;
        }else{
            
            
            return 130;
        }
        
    }
    
    
    
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 12;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView

           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewCellEditingStyleDelete;
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return  NO;
}
#pragma mark 点击改变tableView
-(void)ordersButtonPressed:(UIButton*)sender
{
    _routesIndex = -1;
//    _contentButtonHVBtn = nil;
//    _arrowButtonHVBtn = nil;
//    _iRow = 0;
    [self hiddenDetail];
    
    
    
  
       self.tableView.footerHidden = NO;
    self.isHeadRunIng = NO;
    self.currentPage = 0;
    //    self.arratData = nil;
    self.isHeaderRereshing = YES;
           self.isFooterRereshing = NO;
        __weak __typeof(self)safeSelf = self;
    UIButton* button =sender;
    if (button.tag == 1) {
        self.orderBtnStatus = statusWaitLanshou;
        [SelfUser currentSelfUser].strStatus = @"lanshou";
        [UIView animateWithDuration:0 animations:^{
            safeSelf.sectionHeadView.imageViewLine.center = CGPointMake(WINDOW_WIDTH/6, CGRectGetMidY(self.sectionHeadView.imageViewLine.frame));
            if(safeSelf.arratData.count == 0)
            {
                [safeSelf modifyLanShouBGH];
            }
            else
            {
                [safeSelf modifyBGDisplayH];
         
            }
            //[self.view addSubview: self.buttonSend];
        } completion:^(BOOL finished) {
//            [safeSelf getOrderCount];
            [safeSelf getOrderList];
            

            
        }];


    }else if (button.tag==2){
        self.orderBtnStatus = statusWaitQianShou;
        [SelfUser currentSelfUser].strStatus = @"qianshou";
        [UIView animateWithDuration:0 animations:^{
            safeSelf.sectionHeadView.imageViewLine.center = CGPointMake(WINDOW_WIDTH/2, CGRectGetMidY(self.sectionHeadView.imageViewLine.frame));
            if(safeSelf.arratData.count == 0)
            {
                [safeSelf modifyQianShouBGH];
            }
            else
            {
                [safeSelf modifyBGDisplayH];
          
            }
//            [self.view addSubview: self.buttonSend];
        } completion:^(BOOL finished) {
//             [safeSelf getOrderCount];
            [safeSelf getOrderList];
            
        }];

    }else{
        self.orderBtnStatus = statusWaitDoing;
        [UIView animateWithDuration:0 animations:^{
            safeSelf.sectionHeadView.imageViewLine.center = CGPointMake(WINDOW_WIDTH*5/6, CGRectGetMidY(self.sectionHeadView.imageViewLine.frame));
            if(safeSelf.arratData.count == 0)
            {
                [safeSelf modifyDoingBGH];
            }
            else
            {
                [safeSelf modifyBGDisplayH];
             
            }

        } completion:^(BOOL finished) {
//             [safeSelf getOrderCount];
            [safeSelf getOrderList];
        }];

    }
    
    [self.tableView setContentOffset:CGPointMake(0.0, 0.0) animated:NO];
    [self changeStatus];
    
}

- (void)modifyBGDisplayH
{
//    self.prompLabelC.hidden = YES;
//    self.imageViewLineC.hidden = YES;
//    self.imageViewIconC.hidden = YES;
//    self.prompLabelQ.hidden = YES;
//    self.imageViewLineQ.hidden = YES;
//    self.imageViewIconQ.hidden = YES;
    self.prompLabel.hidden = YES;
//    self.imageViewLine.hidden = YES;
    self.imageViewIcon.hidden = YES;
    self.imageViewBG.hidden = NO;
    self.hView.hidden = YES;
    //[self.view setNeedsDisplay];
}

- (void)modifyLanShouBGH
{
    self.imageViewIcon.hidden = NO;
    self.prompLabel.text = @"暂无订单信息，赶快发布新订单吧";
    self.prompLabel.hidden = NO;
    self.imageViewBG.hidden = NO;
    return;
    

}


- (void)modifyGetFailBGH
{
    self.imageViewIcon.hidden = NO;
    self.prompLabel.text = @"加载失败";
    self.prompLabel.hidden = NO;
    self.imageViewBG.hidden = NO;
    return;
}


- (void)modifyQianShouBGH
{
    self.imageViewIcon.hidden = NO;
    self.prompLabel.text = @"暂无订单信息";
    self.prompLabel.hidden = NO;
    self.imageViewBG.hidden = NO;
    return;
    

    
}

- (void)modifyDoingBGH
{
    self.imageViewIcon.hidden = NO;
    self.prompLabel.text = @"恭喜，没有要处理的订单";
    self.prompLabel.hidden = NO;
    self.imageViewBG.hidden = NO;
    return;
    
    
}


-(void)changeStatus{
    if (self.orderBtnStatus == statusWaitLanshou) {
        self.sectionHeadView.receiveLabel.textColor = UICOLOR(248, 78, 11, 1);
        self.sectionHeadView.sendLabel.textColor = [UIColor blackColor];
        self.sectionHeadView.handleLabel.textColor = [UIColor blackColor];
    }else if (self.orderBtnStatus == statusWaitQianShou){
        self.sectionHeadView.receiveLabel.textColor = [UIColor blackColor];
        self.sectionHeadView.sendLabel.textColor = UICOLOR(248, 78, 11, 1);
        self.sectionHeadView.handleLabel.textColor = [UIColor blackColor];
        
    }else{
        self.sectionHeadView.receiveLabel.textColor = [UIColor blackColor];
        self.sectionHeadView.sendLabel.textColor = [UIColor blackColor];
        self.sectionHeadView.handleLabel.textColor = UICOLOR(248, 78, 11, 1);
    }
    
    
}

#pragma mark -BMKRouteSearchDelegate
- (void)onGetWalkingRouteResult:(BMKRouteSearch *)searcher result:(BMKWalkingRouteResult *)result errorCode:(BMKSearchErrorCode)error
{
    float latitude  = [SelfUser currentSelfUser].mddyAdderssedLocationcoorDinate2D.latitude;
    float longitude = [SelfUser currentSelfUser].mddyAdderssedLocationcoorDinate2D.longitude;
    //数组越界崩溃
    if((_routesIndex == -1) || (_routesIndex >= self.arratData.count) || (latitude < 0) || (longitude < 0))
    {
        return;
    }
    
    //    Order *order;
    NSUInteger i, n = self.arratData.count;
    NSUInteger index = 0;
    //    float lDistance = 1001.0;
    long lQuickType = 2;
    double consigneeLogitude = 0.0;
    double consigneeLatitude = 0.0;
    BOOL findFlag = NO;
    long walkingDistance = 0;
    
    if (error == BMK_SEARCH_NO_ERROR)
    {
        //处理当新订单列表和我的订单订单之间切换时，数组越界崩溃
        if((_routesIndex > -1) && (_routesIndex < self.arratData.count))
        {
            //            order = self.orders[_routesIndex];
            BMKWalkingRouteLine *line = [result.routes objectAtIndex:0];
            NSMutableDictionary* dict =[NSMutableDictionary dictionaryWithDictionary: [self.arratData  objectAtIndex:_routesIndex]];
            [dict setValue:[NSString stringWithFormat:@"%ld", (long)(line.distance)] forKey:@"walkingDistance"];
            FLDDLogDebug(@"_routesIndex : %ld, line.distance%d", (long)_routesIndex, line.distance);
            [self.arratData replaceObjectAtIndex:_routesIndex withObject:dict];
            
            //            order.distance = [NSString stringWithFormat:@"%d", line.distance];
            findFlag = YES;
        }
        
    }
    
    
    BOOL failFlag = NO;
    if (n > 0) {
        for(i = 0; i < n; i++)
        {
            //            FLDDLogDebug(@"self.arratData%@", self.arratData);
            lQuickType = [[[self.arratData  objectAtIndex:i]valueForKey:@"quickType"] longValue];
            consigneeLogitude = [[[self.arratData  objectAtIndex:i]valueForKey:@"consigneeLongitude"] doubleValue];
            consigneeLatitude = [[[self.arratData  objectAtIndex:i]valueForKey:@"consigneeLatitude"] doubleValue];
            walkingDistance = [[[self.arratData  objectAtIndex:i] valueForKey:@"walkingDistance"] integerValue];
            //            order = self.orders[i];
            if((1 == lQuickType) && (consigneeLogitude > 0) && (consigneeLatitude > 0) && (walkingDistance < 0))
            {
                FLDDLogDebug(@"i : %ld", (long)i);
                BMKPlanNode *start = [[BMKPlanNode alloc] init];
                CLLocationCoordinate2D cloStart;
                cloStart.longitude = longitude;
                cloStart.latitude = latitude;
                start.pt = cloStart;
                
                BMKPlanNode *end = [[BMKPlanNode alloc] init];
                CLLocationCoordinate2D cloEnd;
                cloEnd.latitude = consigneeLatitude;
                cloEnd.longitude = consigneeLogitude;
                end.pt = cloEnd;
                
                
                BMKWalkingRoutePlanOption *walkingRoutePlanOption = [[BMKWalkingRoutePlanOption alloc] init];
                walkingRoutePlanOption.from = start;
                walkingRoutePlanOption.to = end;
                
                if (!self.routeSearch) {
                    self.routeSearch = [[BMKRouteSearch alloc] init];
                    self.routeSearch.delegate = self;
                }
                
                BOOL flg = [self.routeSearch walkingSearch:walkingRoutePlanOption];
                
                if (flg) {
                    FLDDLogDebug(@"success");
                    _routesIndex = i;
                    findFlag = YES;
                    break;
                }
                else {
                    FLDDLogInfo(@"failed");
                    failFlag = YES;
                }
                findFlag = YES;
                if(n == i + 1)
                {
                    index++;
                    if(index >= 2)
                    {
                        break;
                    }
                    else if(!failFlag)
                    {
                        break;
                    }
                    else
                    {
                        i = 0;
                        failFlag = NO;
                    }
                }
            }
            
        }
        //        if((findFlag) && ((_iRow >= 0) && !_bHidden))
        if(findFlag)
        {
            [self.tableView reloadData];
        }
        
    }
    
}
#pragma mark -BMKRouteSearch
- (void)getOrderDistance
{
    FLDDLogDebug(@"getOrderDistance");
    //    NSUInteger i, n = self.orders.count;
    //    Order *order;
    //    NSString *latitude = [AppManager valueForKey:@"latitude"];
    //    NSString *longitude = [AppManager valueForKey:@"longitude"];
    //    NSUInteger index = 0;
    BOOL failFlag = NO;
    
    NSUInteger i, n = self.arratData.count;
    //    NSUInteger index = 0;
    //    float lDistance = 1001.0;
    long lQuickType = 2;
    double consigneeLogitude = 0.0;
    double consigneeLatitude = 0.0;
    float latitude  = [SelfUser currentSelfUser].mddyAdderssedLocationcoorDinate2D.latitude;
    float longitude = [SelfUser currentSelfUser].mddyAdderssedLocationcoorDinate2D.longitude;
    long walkingDistance = 0;
    //    BOOL findFlag = NO;
    if (n > 0) {
        for(i = 0; i < n; i++)
        {
            lQuickType = [[[self.arratData  objectAtIndex:i]valueForKey:@"quickType"] longValue];
            consigneeLogitude = [[[self.arratData  objectAtIndex:i]valueForKey:@"consigneeLongitude"] doubleValue];
            consigneeLatitude = [[[self.arratData  objectAtIndex:i]valueForKey:@"consigneeLatitude"] doubleValue];
            walkingDistance = [[[self.arratData  objectAtIndex:i] valueForKey:@"walkingDistance"] integerValue];
            //            order = self.orders[i];
            if((1 == lQuickType) && (consigneeLogitude > 0) && (consigneeLatitude > 0) && (walkingDistance < 0))
            {
                BMKPlanNode *start = [[BMKPlanNode alloc] init];
                CLLocationCoordinate2D cloStart;
                cloStart.longitude = longitude;
                cloStart.latitude = latitude;
                start.pt = cloStart;
                
                BMKPlanNode *end = [[BMKPlanNode alloc] init];
                CLLocationCoordinate2D cloEnd;
                cloEnd.latitude = consigneeLatitude;
                cloEnd.longitude = consigneeLogitude;
                end.pt = cloEnd;
                
                
                BMKWalkingRoutePlanOption *walkingRoutePlanOption = [[BMKWalkingRoutePlanOption alloc] init];
                walkingRoutePlanOption.from = start;
                walkingRoutePlanOption.to = end;
                
                if (!self.routeSearch) {
                    self.routeSearch = [[BMKRouteSearch alloc] init];
                    self.routeSearch.delegate = self;
                }
                
                BOOL flg = [self.routeSearch walkingSearch:walkingRoutePlanOption];
                
                if (flg) {
                    FLDDLogDebug(@"success");
                    g_MBKPermissionSuccessCount = 3;
                    g_routeSearchStat  = STATE_SUCESS;//解决无网络登录，百度地图授权失败，当连接网络时，首先发送刷新首页列表并解析步行距离，结果全失败，后收到百度授权成功通知。
                    start= nil;
                    _routesIndex = i;
                    break;
                }
                else {
                    FLDDLogInfo(@"failed");
                    if(STATE_INIT == g_routeSearchStat)
                    {
                        g_routeSearchStat = STATE_FAIL;//解决无网络登录，百度地图授权失败，当连接网络时，首先发送刷新首页列表并解析步行距离，结果全失败，后收到百度授权成功通知。只标志为首次失败。
                    }
                    failFlag = YES;
                }
                
                //                if(n == i + 1)
                //                {
                //                    index++;
                //                    if(index >= 2)
                //                    {
                //                        break;
                //                    }
                //                    else if(!failFlag)
                //                    {
                //                        break;
                //                    }
                //                    else
                //                    {
                //                        i = 0;
                //                        failFlag = NO;
                //                    }
                //                }
                if(failFlag)
                {
                    break;
                }
            }
            
        }
        
    }
}

#pragma mark发单
-(void)buttonSendPressed{
    [self hiddenDetail];
    if (NotReachable == [SelfUser currentSelfUser].networkStatus) {
        [MBProgressHUD hudShowWithStatus:self :@"当前网络不可用，请检查您的网络设置"];
        return;
    }
    if((g_needUpgrade == 1) && (g_downloadUrl != nil))
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_HEART_VERSION_NOTIFICATION object:nil];
        return;
    }
    
    if(g_loginStat == LOGIN_STATE_LOGIN_SUCESS)
    {
        if (self.remainOrder == 0) {
            [MBProgressHUD hudShowWithStatus:self :@"抱歉，您今日发单量已达上限，明天再来吧！"];
            return;
        }

    }
    else
    {
        [MBProgressHUD hudShowWithStatus:self :@"网络比蜗牛还慢，挤不进去呀"];
        [[NSNotificationCenter defaultCenter]postNotificationName:ONCELOGININ object:self];
        return;
    }
    SoonSendOrderViewController* soon = [[SoonSendOrderViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:soon animated:YES];
    soon = nil;
    
}
-(void)buttonSoonSendPressed{
    [self hiddenDetail];
    if (NotReachable == [SelfUser currentSelfUser].networkStatus) {
        [MBProgressHUD hudShowWithStatus:self :@"当前网络不可用，请检查您的网络设置"];
        return;
    }
    
    if(g_loginStat == LOGIN_STATE_LOGIN_SUCESS)
    {
        if (self.remainOrder == 0) {
            [MBProgressHUD hudShowWithStatus:self :@"抱歉，您今日发单量已达上限，明天再来吧！"];
            return;
        }
        
        if (self.remainQuickOrder == 0) {
            [MBProgressHUD hudShowWithStatus:self :@"抱歉，您今日极速发单量已达上限，明天再来吧！"];
            return;
        }
    }
    else
    {
        [MBProgressHUD hudShowWithStatus:self :@"网络比蜗牛还慢，挤不进去呀"];
        [[NSNotificationCenter defaultCenter]postNotificationName:ONCELOGININ object:self];
        return;
    }
    

    
    if((g_needUpgrade == 1) && (g_downloadUrl != nil))
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_HEART_VERSION_NOTIFICATION object:nil];
        return;
    }
    if (self.viewAlphaBG==nil) {
        
        int height;
        int height_4;
        if (iPhone5) {
            height = -35;
            height_4 = 0;
        }else if (iPhone4){
            height = -43;
            height_4 = -30;
        }
        else{
            
            height = 0;
            height_4 = 0;
            
        }
        UIView* control = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)];
        UIView* viewControlBG = [ [UIImageView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)];
        viewControlBG.userInteractionEnabled = YES;
        viewControlBG.backgroundColor =[UIColor blackColor];
        viewControlBG.alpha = 0.5;
        [control addSubview:viewControlBG];
        
        UIView* viewAlert = [[UIImageView alloc]initWithFrame:CGRectMake(15, WINDOW_HEIGHT/2-180+height, WINDOW_WIDTH-30, 160+height_4)];
        viewAlert.userInteractionEnabled = YES;
        viewAlert.backgroundColor = [UIColor whiteColor];
        viewAlert.layer.cornerRadius = 5;
        [control addSubview:viewAlert];
        
        self.textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 55+height_4, WINDOW_WIDTH-20, 30)];
        self.textField.placeholder = @"请输入订单金额";
        self.textField.delegate = self;
        self.textField.keyboardType = UIKeyboardTypeDecimalPad;
        [viewAlert addSubview:self.textField];
        
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(viewAlert.bounds.size.width-30, 55+height_4, 30, 30)];
        label.text = @"元";
        [viewAlert addSubview:label];
        
        UIView* viewLine = [[UIView alloc]initWithFrame:CGRectMake(0, 95+height_4, WINDOW_WIDTH-20, 1)];
        viewLine.backgroundColor = [UIColor lightGrayColor];
        viewLine.alpha = 0.15;
        [viewAlert addSubview:viewLine];
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:UICOLOR(248, 78, 11, 1) forState:UIControlStateNormal];
        [button setTitle:@"确认发单" forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 100+height_4, viewAlert.bounds.size.width, 60);
        [button addTarget:self action:@selector(buttonQueRenSend) forControlEvents:UIControlEventTouchUpInside];
        [viewAlert addSubview:button];
        [self.view addSubview:control];
        
        UIButton* buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonCancel.frame = CGRectMake(WINDOW_WIDTH-43, WINDOW_HEIGHT/2-195+height,38, 38);
        [buttonCancel setImage:[UIImage imageNamed:@"billed_colsed.png"] forState:UIControlStateNormal];
        [buttonCancel addTarget:self action:@selector(buttonSoonSendCancel) forControlEvents:UIControlEventTouchUpInside];
        [control addSubview:buttonCancel];
        
        
        
        self.viewAlphaBG = control;
    }
    self.textField.text = @"";
    _viewImageControlBG.hidden = NO;
    [self.textField becomeFirstResponder];
    self.viewAlphaBG.hidden = NO;
    self.buttonRightItem.userInteractionEnabled = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if ([CommonUtils checkNumber:string WithTextFieldText:textField.text]) {
        if ([textField.text rangeOfString:@"."].length!=0) {


            if ([textField.text substringToIndex:[textField.text rangeOfString:@"."].location -1].length<=3) {
                if ([textField.text substringFromIndex:[textField.text rangeOfString:@"."].location].length <=2) {
                    
                    return YES;
                }else{
                    return NO;
                }
                
            }else{
                return NO;
            }
        }else{
            
            if ([string isEqualToString:@"."]) {
                            if(textField.text.length == 0){
                                return NO;
                            }
                return YES;
            }else{
                if (textField.text.length <=3) {
                    return YES;
                }else{
                    return NO;
                }
            }
        }
        
    }
 
    
//    [SVProgressHUD showErrorWithStatus:@"请输入正确金额"];
    return NO;
}

+(void)checkNetWork{
    if(nil == g_reachability)
    {
        g_reachability = [Reachability reachabilityWithHostname:@"www.zuixiandao.cn"];
        [g_reachability startNotifier];
    }
    else
    {
        [g_reachability stopNotifier];
        [g_reachability startNotifier];
    }
//    Reachability * reach = [Reachability reachabilityWithHostname:@"www.zuixiandao.cn"];
////    Reachability * reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
//    
//    reach.reachableBlock = ^(Reachability * reachability)
//    {
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //            FLDDLogDebug(@"通知有连接");
//        });
//    };
//    
//    reach.unreachableBlock = ^(Reachability * reachability)
//    {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //            FLDDLogDebug(@"通知无连接");
//        });
//    };
//    
//    [reach startNotifier];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addNavBarView{
    
    if (self.imageViewIconIcon == nil) {
    
        
//        
//        self.imageViewIconIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 72, 25)];
//        self.imageViewIconIcon.image = [UIImage imageNamed:@"logo_actionbar.png"];
//        [self.navigationController.navigationBar addSubview:self.imageViewIconIcon];
        
        
        
        _imageViewNavView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
        
      

        [self.navigationController.navigationBar addSubview:_imageViewNavView];
        
        self.labelTitle = [[UILabel alloc]init];
        self.labelTitle.text  =@"绝味鸭脖(天目山路店)";
//        [self.labelTitle sizeToFit];
        self.labelTitle.font = [UIFont systemFontOfSize:15];
        self.labelTitle.textColor = [UIColor whiteColor];
        self.labelTitle.bounds = CGRectMake(0, 0,WINDOW_WIDTH/2-35, 30);
        self.labelTitle.textAlignment = NSTextAlignmentLeft;
        [self.navigationController.navigationBar addSubview:self.labelTitle];

        
        
        self.buttonRightItem = [[ButtonRightItem alloc]initWithFrame:CGRectMake(WINDOW_WIDTH-50, 0, 44, 44)];
        [self.buttonRightItem setImage:[UIImage imageNamed:@"home_my.png"] forState:UIControlStateNormal];
        
        [  self.buttonRightItem addTarget:self action:@selector(rightBarButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        self.buttonRightItem.adjustsImageWhenHighlighted = NO;
        [self.navigationController.navigationBar addSubview:  self.buttonRightItem];
        
    }
    
    if (!self.remindLabel) {
        self.remindLabel = [[UILabel alloc] init];
        self.remindLabel.text = @"今日剩余100单";
        self.remindLabel.textAlignment =NSTextAlignmentRight;
        self.remindLabel.textColor = [UIColor whiteColor];
        self.remindLabel.font = [UIFont systemFontOfSize:15];
        [self.remindLabel sizeToFit];
        self.remindLabel.text = @"今日剩余0单";

        self.remindLabel.center = CGPointMake(WINDOW_WIDTH - 50 - self.remindLabel.bounds.size.width / 2, self.buttonRightItem.center.y);
    }
    
    [self.navigationController.navigationBar addSubview:self.remindLabel];
    
      self.labelTitle.text=[AppManager valueForKey:@"shopName"];
 
    
    UIView* viewControlBG = [ [UIView alloc]initWithFrame:CGRectMake(0, -20, WINDOW_WIDTH, self.navigationController.navigationBar.frame.size.height+20)];
    viewControlBG.userInteractionEnabled = NO;
    viewControlBG.backgroundColor =[UIColor blackColor];
    viewControlBG.alpha = 0.5;
    viewControlBG.hidden = YES;
    [self.navigationController.navigationBar addSubview:viewControlBG];
    _viewImageControlBG = viewControlBG;
    //    [viewControlBG removeFromSuperview];
    viewControlBG = nil;
    
    
    
    self.buttonRightItem.hidden = NO;
    self.imageViewIconIcon.hidden = NO;
    self.labelTitle.hidden =NO;

    
        if ([[AppManager valueForKey:@"shopGroupIconUrl"] toString].length>=1) {
            [_imageViewNavView setImageWithURL:[NSURL URLWithString:[AppManager valueForKey:@"shopGroupIconUrl"] ] placeholderImage:nil];
             self.labelTitle.center = CGPointMake(CGRectGetMaxX(_imageViewNavView.frame)+self.labelTitle.boundsWide/2+5, _imageViewNavView.center.y );
            _imageViewNavView.hidden = NO;
        }else{
          self.labelTitle.center = CGPointMake(10+self.labelTitle.boundsWide/2-2, _imageViewNavView.center.y );
            _imageViewNavView.hidden = YES;
        }
    
    
//        [SelfUser mddyRequestWIthImageWithWayQuickTypeIconUrl:[AppManager valueForKey:@"shopGroupIconUrl"] withMothed:@"downloadShopGroupICon.htm" withBlock:^(UIImage *image, NSError *error) {
//            if (!error) {
//                
//                if (image != nil) {
//                    _imageViewNavView.image = image;
//                    
//                }
//                else {
//                    self.labelTitle.center = CGPointMake(WINDOW_WIDTH-172+self.labelTitle.bounds.size.width/2-44, CGRectGetMidY(self.imageViewIconIcon.frame));
//                }
//            }else {
//                
//                self.labelTitle.center = CGPointMake(WINDOW_WIDTH-172+self.labelTitle.bounds.size.width/2-44, CGRectGetMidY(self.imageViewIconIcon.frame));
//                
//                
//                
//            }
//            
//        }];
 
    

    
}
-(void)addImageViewNotNet{
    if(self.imageVioewNotNet == nil)
    {
        FLDDLogDebug(@"%f",WINDOW_WIDTH);
        self.imageVioewNotNet = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, iphone6_6P_isYES?WINDOW_WIDTH:375, 30)];
        self.imageVioewNotNet.image = [UIImage imageNamed:@"notNet.png"];
        _noticeLabel = [[UILabel alloc]initWithFrame:CGRectMake(37, 0, 375-37, 30)];
        _noticeLabel.text = @"当前网络不可用，请检查你的网络设置";
        _noticeLabel.font = [UIFont systemFontOfSize:14];
        [self.imageVioewNotNet addSubview:_noticeLabel];
        self.imageVioewNotNet.hidden= YES;
        [self.view addSubview:self.imageVioewNotNet];
    }
}

-(void)reachabilityRecove
{
    [SelfUser currentSelfUser].networkStatus = ReachableViaWiFi;
    [self handleNetChanged];
}

-(void)handleNetChanged
{
    if((ReachableViaWiFi == [SelfUser currentSelfUser].networkStatus) || (ReachableViaWWAN == [SelfUser currentSelfUser].networkStatus))
    {
        FLDDLogInfo("收到网络正常通知。 网络状态：%ld", (long)([SelfUser currentSelfUser].networkStatus));
        self.isHaveNet =YES;
        g_getNetState = STATE_SUCESS;
        
        if((LOGIN_STATE_UNNET_LOGIN == g_loginStat) || (LOGIN_STATE_INIT == g_loginStat))
        {
            //位置更新，并刷新主页
            //            [[NSNotificationCenter defaultCenter] postNotificationName:GET_USER_LOCATION_NOTIFICATION object:nil userInfo:@{@"locationTag" : @(YES)}];
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_NOTIFICATION object:nil];
            return;
        }
        [self showNoticeView];
    }
    else
    {
        if(LOGIN_STATE_INIT == g_loginStat)
        {
            [self modifyGetFailBGH];
        }
        FLDDLogDebug("收到网络异常通知，没有网络！ 网络状态：%ld", (long)([SelfUser currentSelfUser].networkStatus));
        self.isHaveNet =NO;
        g_getNetState = STATE_FAIL;
        //        FLDDLogDebug(@"收到通知无连接");
        
        if ((self.launchView.superview) && (LOGIN_STATE_LOGINING != g_loginStat))
        {
            
            [self.launchView removeFromSuperview];
            self.launchView = nil;
            //                    _displayLoadPage = NO;
            g_loginStat = LOGIN_STATE_UNNET_LOGIN;
            [self showNoticeView];
            
            return;
        }
        [self showNoticeView];
        
    }
    
}
-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    [SelfUser currentSelfUser].networkStatus = [reach currentReachabilityStatus];
    [self handleNetChanged];

//    if([reach isReachable])
//    {
//        self.isHaveNet =YES;
//        g_getNetState = STATE_SUCESS;
//        
//        if((LOGIN_STATE_UNNET_LOGIN == g_loginStat) || (LOGIN_STATE_INIT == g_loginStat))
//        {
//            //位置更新，并刷新主页
////            [[NSNotificationCenter defaultCenter] postNotificationName:GET_USER_LOCATION_NOTIFICATION object:nil userInfo:@{@"locationTag" : @(YES)}];
//            [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_NOTIFICATION object:nil];
//            return;
//        }
//        [self showNoticeView];
//    }
//    else
//    {
//         self.isHaveNet =NO;
//        g_getNetState = STATE_FAIL;
//        //        FLDDLogDebug(@"收到通知无连接");
//        
//        if ((self.launchView.superview) && (LOGIN_STATE_LOGINING != g_loginStat))
//        {
//
//            [self.launchView removeFromSuperview];
//            self.launchView = nil;
//            //                    _displayLoadPage = NO;
//            g_loginStat = LOGIN_STATE_UNNET_LOGIN;
//            [self showNoticeView];
//
//            return;
//        }
//        [self showNoticeView];
//
//    }
//    

}


- (void)loginNotification:(NSNotification *)notification
{
    if((LOGIN_STATE_INIT != g_loginStat) && (LOGIN_STATE_UNNET_LOGIN != g_loginStat))
    {
        [self showNoticeView];
        return;
    }

    if (self.isHaveNet)
    {
        
        NSString *phone = [AppManager valueForKey:@"telephone"];
        NSString *password = [AppManager valueForKey:@"password"];
        if (phone.length != 0 && password.length != 0)
        {
            [self autoLogin];
            [self showNoticeView];
            
   
            
        }
        else
        {
            if(self.launchView != nil)
            {
                [self.launchView removeFromSuperview];
                self.launchView = nil;
            }
//            if (self.isHaveNet)
//            {
                self.isLogin = YES;
                LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                [self.navigationController pushViewController:loginViewController animated:NO];
            loginViewController = nil;
                g_loginStat = LOGIN_STATE_UNAUTO_LOGIN;
                [self showNoticeView];
            

        }
    }
    else
    {
        if(self.launchView != nil)
        {
            [self.launchView removeFromSuperview];
            self.launchView = nil;
        }
    }
    
}

-(void)loginIN{
    self.isLogin = YES;
 
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
 
    [self.navigationController pushViewController:loginViewController animated:NO];
  
    
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
    self.sectionHeadView.receiveButton.userInteractionEnabled = NO;
    self.sectionHeadView.sendButton.userInteractionEnabled = NO;
    self.sectionHeadView.handleButton.userInteractionEnabled = NO;
    [self.activityIndicatorView startAnimating];
      self.tableView.userInteractionEnabled = NO;
//   self.view.userInteractionEnabled = NO;
}
-(void)stopActivityView{
    [  self.activityIndicatorView stopAnimating];
    self.activityIndicatorView =nil;
//    [self.activityIndicatorView removeFromSuperview];
//
    self.sectionHeadView.receiveButton.userInteractionEnabled = YES;
    self.sectionHeadView.sendButton.userInteractionEnabled = YES;
    self.sectionHeadView.handleButton.userInteractionEnabled = YES;
    self.tableView.userInteractionEnabled = YES;
//    self.view.userInteractionEnabled = YES;
}

#pragma mark获取订单列表
-(void)getOrderList{
    FLDDLogDebug(@"getOrderList");
    [self modifyBGDisplayH];
    self.currentPage++;
    NSString* page =[NSString stringWithFormat:@"%d",self.currentPage]
    ;
    //            待揽收订单列表
    //     self.isHeadRunIng?: [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeBlack];
    self.isHeadRunIng?: self.isFooterRereshing?:[self startActivityView];
    
    __weak __typeof(self)safeSelf = self;
    if (self.orderBtnStatus ==statusWaitLanshou) {
        [SelfUser mddyRequestWithMethodName:@"homePageWithToHandoverWaybillListJsonPhone.htm" withParams:@{@"page":page,@"rows":@"10",@"cmdCode":g_handoverWayBillListCmd} withBlock:^(id responseObject, NSError *error) {
            
            if (safeSelf.isHeaderRereshing == YES) {
                [safeSelf.arratData removeAllObjects];
                safeSelf.arratData = nil;
                safeSelf.arratData = [NSMutableArray array];
                
            }
            
            if (!error) {
                @try {
                    FLDDLogDebug(@"2.1.8)待揽?收订单列表%@",responseObject);
                    __weak      NSArray* array =[[responseObject valueForKey:@"toHandoverWaybillList"] valueForKey:@"rows"];
                    self.currentTotal =[[[responseObject valueForKey:@"toHandoverWaybillList"]valueForKey:@"total"]toInt];
                    
                    self.remainOrder = [[responseObject objectForKey:@"todayShopCanPackge"] integerValue];
                    self.remainQuickOrder = [[responseObject objectForKey:@"todayShopCanRapidPackge"] integerValue];
                    [self showRemainOrderNumber];
                    for (NSDictionary* dict in array) {
                        
                        if ([safeSelf.arratData containsObject:dict]) {
                            
                        }else{
                            
                            if((dict.allKeys.count > 0) && (0 == [[dict valueForKey:@"walkingDistance"] integerValue]))
                            {
                                NSMutableDictionary* dic =[NSMutableDictionary dictionaryWithDictionary: dict];
                                [dic setValue: @"-1" forKey:@"walkingDistance"];
                                [safeSelf.arratData addObject:dic];
                            }
                            else
                            {
                                [safeSelf.arratData addObject:dict];
                            }
                        }
                        array = nil;;
                    }
                    [safeSelf getOrderDistance];
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
                
                if(safeSelf.arratData.count == 0)
                {
                    [safeSelf modifyLanShouBGH];
                }
                else
                {
                    [safeSelf modifyBGDisplayH];
                }
                
                
            }
            else
            {
                [safeSelf modifyGetFailBGH];
            }
            
            
            
       
            dispatch_async(dispatch_get_main_queue(), ^{
                   self.strType =@"lanshou";
                     [safeSelf.tableView reloadData];
            });
            
            
            if (safeSelf.isHeaderRereshing == YES) {
                
            }else{
                [safeSelf.tableView setContentOffset:CGPointMake(0,460*(self.currentPage)) animated:YES];
                
            }
            [safeSelf stopActivityView];
            
            [safeSelf stopRereshing];
            
                if (!error) {
            NSString* strCount1 =  [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"toHandoverWaybillCount"] ];
            NSString* strCount2 =  [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"toReceiveWaybillCount"] ];
            NSString* strCount3 =  [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"toCancelAndRejectedWaybillCount"] ];

            [self changedListCountWithType:nil withStrCount1:strCount1 withStrCount2:strCount2 withStrCount3:strCount3];
              [self getPresonalInfoWithCount:[[responseObject valueForKey:@"notifyUnreadCount"] toInt]];
                }
          
            
            
        }];
    }else if (self.orderBtnStatus == statusWaitQianShou){
        FLDDLogDebug(@"getOrderList:cookie = %@", [AppManager valueForKey:@"cookie"]);
        [SelfUser mddyRequestWithMethodName:@"homePageWithToReceiveWaybillListJsonPhone.htm" withParams:@{@"page":page,@"rows":@"10",@"cmdCode":g_receiveWaybillLisCmd} withBlock:^(id responseObject, NSError *error) {
            [safeSelf stopRereshing];
            if (safeSelf.isHeaderRereshing == YES) {
                [safeSelf.arratData removeAllObjects];
                safeSelf.arratData = nil;
                safeSelf.arratData = [NSMutableArray array];
            }
            FLDDLogDebug(@"getOrderList:cookie = %@", [AppManager valueForKey:@"cookie"]);
            if (!error) {
                @try {
                    FLDDLogDebug(@"2.1.11待签收订单列表%@",responseObject);
                    __weak         NSArray* array =[[responseObject valueForKey:@"toReceiveWaybillList"] valueForKey:@"rows"];
                    safeSelf.currentTotal =[[[responseObject valueForKey:@"toReceiveWaybillList"]valueForKey:@"total"]toInt];
                    self.remainOrder = [[responseObject objectForKey:@"todayShopCanPackge"] integerValue];
                    self.remainQuickOrder = [[responseObject objectForKey:@"todayShopCanRapidPackge"] integerValue];
                    [self showRemainOrderNumber];

                    for (NSDictionary* dict in array) {
                        if ([safeSelf.arratData containsObject:dict]) {
                            
                        }else{
                            
                            if((dict.allKeys.count > 0) && (0 == [[dict valueForKey:@"walkingDistance"] integerValue]))
                            {
                                NSMutableDictionary* dic =[NSMutableDictionary dictionaryWithDictionary: dict];
                                [dic setValue: @"-1" forKey:@"walkingDistance"];
                                [safeSelf.arratData addObject:dic];
                            }
                            else
                            {
                                [safeSelf.arratData addObject:dict];
                            }
                        }
                    }
                    array = nil;
//                    _routesIndex = 0;
                    [safeSelf getOrderDistance];
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
                
                if(safeSelf.arratData.count == 0)
                {
                    [safeSelf modifyQianShouBGH];
                }
                else
                {
                    [safeSelf modifyBGDisplayH];
                }
                
            }
            else
            {
                
                [safeSelf modifyGetFailBGH];
                
            }
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                    self.strType =@"qianshou";
                [safeSelf.tableView reloadData];
            });
            if (safeSelf.isHeaderRereshing == YES) {
                
            }else{
                [safeSelf.tableView setContentOffset:CGPointMake(0,460*(safeSelf.currentPage)) animated:YES];
                
            }
            [safeSelf stopActivityView];
            [safeSelf stopRereshing];
            
              if (!error) {
            
            NSString* strCount1 =  [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"toHandoverWaybillCount"] ];
            NSString* strCount2 =  [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"toReceiveWaybillCount"] ];
            NSString* strCount3 =  [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"toCancelAndRejectedWaybillCount"] ];
            
            [self changedListCountWithType:nil withStrCount1:strCount1 withStrCount2:strCount2 withStrCount3:strCount3];

              [self getPresonalInfoWithCount:[[responseObject valueForKey:@"notifyUnreadCount"] toInt]];
              }
            
        }];
        
    }else{
        [SelfUser mddyRequestWithMethodName:@"homePageWithToCancelAndRejectedWaybillListJsonPhone.htm" withParams:@{@"page":page,@"rows":@"10",@"cmdCode":g_cancelAndRejectedWayBillListCmd} withBlock:^(id responseObject, NSError *error) {
            
            if (safeSelf.isHeaderRereshing == YES) {
                [safeSelf.arratData removeAllObjects];
                safeSelf.arratData = nil;
                safeSelf.arratData = [NSMutableArray array];
            }
            if (!error) {
                @try {
                    FLDDLogDebug(@"2.1.14)处理中的订单列表%@",responseObject);
                    
                    __weak        NSArray* array =[[responseObject valueForKey:@"toCancelAndRejectedWaybillList"] valueForKey:@"rows"];
                    safeSelf.currentTotal =[[[responseObject valueForKey:@"toCancelAndRejectedWaybillList"]valueForKey:@"total"]toInt];
                    self.remainOrder = [[responseObject objectForKey:@"todayShopCanPackge"] integerValue];
                    self.remainQuickOrder = [[responseObject objectForKey:@"todayShopCanRapidPackge"] integerValue];
                    [self showRemainOrderNumber];

                    for (NSDictionary* dict in array) {
                        if ([safeSelf.arratData containsObject:dict]) {
                            
                        }else{
                            if((dict.allKeys.count > 0) && (0 == [[dict valueForKey:@"walkingDistance"] integerValue]))
                            {
                                NSMutableDictionary* dic =[NSMutableDictionary dictionaryWithDictionary: dict];
                                [dic setValue: @"-1" forKey:@"walkingDistance"];
                                [safeSelf.arratData addObject:dic];
                            }
                            else
                            {
                                [safeSelf.arratData addObject:dict];
                            }
                        }
                    }
//                    array = nil;
//                    _routesIndex = 0;
                    [safeSelf getOrderDistance];
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
                
                if(safeSelf.arratData.count == 0)
                {
                    [safeSelf modifyDoingBGH];
                }
                else
                {
                    [safeSelf modifyBGDisplayH];
                }
                
            }
            else
            {
                [safeSelf modifyGetFailBGH];
                
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                      self.strType =@"chuli";
                [safeSelf.tableView reloadData];
            });
            if (safeSelf.isHeaderRereshing == YES) {
            }else{
                [safeSelf.tableView setContentOffset:CGPointMake(0,460*(self.currentPage)) animated:YES];
                
            }
            [safeSelf stopActivityView];
            [safeSelf stopRereshing];
              if (!error) {
            NSString* strCount1 =  [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"toHandoverWaybillCount"] ];
            NSString* strCount2 =  [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"toReceiveWaybillCount"] ];
            NSString* strCount3 =  [NSString stringWithFormat:@"%@",[responseObject valueForKey:@"toCancelAndRejectedWaybillCount"] ];
            
            [self changedListCountWithType:nil withStrCount1:strCount1 withStrCount2:strCount2 withStrCount3:strCount3];

              [self getPresonalInfoWithCount:[[responseObject valueForKey:@"notifyUnreadCount"] toInt]];
              }
        }];
    }
}

-(void)changedListCountWithType:(NSString*)type withStrCount1:(NSString*)strCount1 withStrCount2:(NSString*)strCount2 withStrCount3:(NSString*)strCount3{
//    if ([type isEqualToString:@"lanshou"]) {
        if(strCount1.length == 1){
            if ([strCount1 isEqualToString:@"0"]) {
                self.sectionHeadView.receiveLabel.text = @"待揽收(  )";
                self.sectionHeadView.label1.text = @"0";
            }else{
                
                self.sectionHeadView.receiveLabel.text  = @"待揽收(  )";
                self.sectionHeadView.label1.text = strCount1;
            }
        }else if(strCount1.length == 2){
            self.sectionHeadView.receiveLabel.text  =@"待揽收(    )";
            [self.sectionHeadView.receiveLabel sizeToFit];
            self.sectionHeadView.receiveLabel.center = CGPointMake(self.sectionHeadView.receiveButton.center.x, CGRectGetMaxY(self.sectionHeadView.receiveButton.frame) + 8 + self.sectionHeadView.receiveLabel.bounds.size.height / 2);
            self.sectionHeadView.label1.text = strCount1;
            [self.sectionHeadView.label1 sizeToFit ];
            self.sectionHeadView.label1.center = CGPointMake(self.sectionHeadView.receiveLabel.bounds.size.width/2+self.sectionHeadView.label1.bounds.size.width/2+12,self.sectionHeadView.receiveLabel.bounds.size.height/2);
            
        }

//    }else if ([type isEqualToString:@"qianshou"]){
        
        if(strCount2.length == 1){
            if ([strCount2 isEqualToString:@"0"]) {
                self.sectionHeadView.sendLabel.text = @"待签收(  )";
                self.sectionHeadView.label2.text = @"0";
            }else{
                
                self.sectionHeadView.sendLabel.text  = @"待签收(  )";
                self.sectionHeadView.label2.text = strCount2;
            }
        }else if(strCount2.length == 2){
            
            self.sectionHeadView.sendLabel.text  =@"待签收(    )";
            [self.sectionHeadView. sendLabel sizeToFit];
            self.sectionHeadView.sendLabel.center = CGPointMake(self.sectionHeadView.sendButton.center.x, CGRectGetMaxY(self.sectionHeadView.sendButton.frame) + 8 + self.sectionHeadView.sendLabel.bounds.size.height / 2);
            self.sectionHeadView.label2.text = strCount2;
            [self.sectionHeadView.label2 sizeToFit ];
            self.sectionHeadView.label2.center = CGPointMake(self.sectionHeadView.sendLabel.bounds.size.width/2+self.sectionHeadView.label2.bounds.size.width/2+13,self.sectionHeadView.sendLabel.bounds.size.height/2);
        }
        

//    }else if ([type isEqualToString:@"chuli"]){
        if(strCount3.length == 1){
            if ([strCount3 isEqualToString:@"0"]) {
                self.sectionHeadView.handleLabel.text = @"处理中(  )";
                self.sectionHeadView.label3.text = @"0";
            }else{
                
                self.sectionHeadView.handleLabel.text  = @"处理中(  )";
                self.sectionHeadView.label3.text = strCount3;
            }
        }else if(strCount3.length == 2){
            
            
            self.sectionHeadView.handleLabel.text  =@"处理中(    )";
            [self.sectionHeadView.handleLabel sizeToFit];
            self.sectionHeadView.handleLabel.center = CGPointMake(self.sectionHeadView.handleButton.center.x, CGRectGetMaxY(self.sectionHeadView.handleButton.frame) + 8 + self.sectionHeadView.handleLabel.bounds.size.height / 2);
            self.sectionHeadView.label3.text = strCount3;
            [self.sectionHeadView.label3 sizeToFit ];
            self.sectionHeadView.label3.center = CGPointMake(self.sectionHeadView.handleLabel.bounds.size.width/2+self.sectionHeadView.label3.bounds.size.width/2+13,self.sectionHeadView.handleLabel.bounds.size.height/2);
            
        }

//    }
}
#pragma mark 加载更多
-(void)loadMoreOrderList{
    
}
-(void)buttonPressedPhone:(UIButton*)sender{
    [self hiddenDetail];
    UIButton* button=sender;
    NSString *telUrl = [NSString stringWithFormat:@"%@",[[[self.arratData objectAtIndex:button.tag]valueForKey:@"courierTel"] toString]];
    
    self.strTEL = telUrl;
    
    UIAlertView* alert  =[[UIAlertView alloc]initWithTitle:@"  确认拨打配送员电话？" message:telUrl delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
    alert.tag = 101;
    [alert show];
    alert = nil;
    
}

-(void)hiddenDetail
{
    if((nil == _contentHVView) || (_iRow < 0))
    {
        return;
    }
    if(!(_contentHVView.hidden))
    {
        _contentHVView.hidden = YES;
//        if((nil != self.tableView) && (self.arratData.count > 0 ) && (_iRow < self.arratData.count))
//        {
//            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:_iRow]] withRowAnimation:UITableViewRowAnimationNone];
//        }
        
        _iRow = -1;
        _bHidden = YES;
    }
//    _arrowButtonHVBtn.hidden = YES;
}

-(void)buttonPressedDetail:(UIButtonValue*)sender{

    if((nil == sender) || (nil == sender.contentUIView))
    {
        return;
    }
//    sender.detailBackgroundButton.hidden = sender.contentButton.hidden;
    sender.contentUIView.hidden = !(sender.contentUIView.hidden);
//    sender.arrowButton.hidden = sender.contentButton.hidden;
    if(!(sender.contentUIView.hidden))
    {

        if((nil != self.tableView) && (self.arratData.count > 0 ) && (sender.row < self.arratData.count) && (_iRow < self.arratData.count))
        {
            if((_iRow != sender.row) && (_iRow >= 0))
            {
//                _arrowSecondBtnHVBtn = _arrowButtonHVBtn;
//                _contentSecondBtnHVBtn = _contentButtonHVBtn;
//                _arrowSecondBtnHVBtn.hidden =  YES;
//                _contentSecondBtnHVBtn.hidden = YES;
//                _arrowButtonHVBtn =  sender.arrowButton;
//                _contentButtonHVBtn = sender.contentButton;
//                _arrowButtonHVBtn.hidden =  NO;
//                _contentButtonHVBtn.hidden = NO;
//                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:sender.row], [NSIndexPath indexPathForRow:0 inSection:_iRow]] withRowAnimation:UITableViewRowAnimationNone];
                _contentSecondHVView = _contentHVView;
                _contentSecondHVView.hidden = YES;
                _contentHVView = sender.contentUIView;
                _contentHVView.hidden = NO;
                _iRow = sender.row;
                _bHidden = NO;
            }
            else
            {
                _iRow = sender.row;
//                _arrowButtonHVBtn =  sender.arrowButton;
//                _contentButtonHVBtn = sender.contentButton;
//                _arrowButtonHVBtn.hidden =  NO;
//                _contentButtonHVBtn.hidden = NO;
                _contentHVView = sender.contentUIView;
                _contentHVView.hidden = NO;
                _bHidden = NO;
//                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:sender.row]] withRowAnimation:UITableViewRowAnimationNone];
            }
        }
        else
        {
            _iRow = sender.row;
//            _arrowButtonHVBtn =  sender.arrowButton;
//            _contentButtonHVBtn = sender.contentButton;
//            _arrowButtonHVBtn.hidden =  NO;
//            _contentButtonHVBtn.hidden = NO;
            _contentHVView = sender.contentUIView;
            _contentHVView.hidden = NO;
            _bHidden = NO;
        }
        
    }
    else
    {
//        _arrowButtonHVBtn.hidden =  YES;
//        _contentButtonHVBtn.hidden = YES;
        _contentHVView.hidden = YES;
        _iRow = -1;
        _bHidden = YES;
//        if((nil != self.tableView) && (self.arratData.count > 0 ) && (sender.row < self.arratData.count))
//        {
////            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:sender.row]] withRowAnimation:UITableViewRowAnimationNone];
//        }
    
    }

//    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}


-(void)buttonPressedContent:(UIButtonValue*)sender{
    
    if((nil == sender) || (nil == sender.contentUIView))
    {
        return;
    }
    if(!(sender.contentUIView.hidden))
    {
//        sender.contentUIView.hidden = YES;
        _contentHVView = sender.contentUIView;
//        [self.tableView reloadData];
        //跳转到运费模版页面
        FeeWebViewController *feeWebViewController = [[FeeWebViewController alloc] init];
        NSString *waybillIdStr = [[[self.arratData  objectAtIndex:sender.row]valueForKey:@"waybillId"] toString];
        if(waybillIdStr.length > 0)
        {
            feeWebViewController.waybillId = waybillIdStr;
            //        webViewController.type = WebViewTypePolicy;
            feeWebViewController.title = @"配送运费";
            [self.navigationController pushViewController:feeWebViewController animated:YES];
        }

    }
    else
    {
        sender.contentUIView.hidden = NO;
    }
    
//    sender.detailBackgroundButton.hidden = NO;
//    sender.arrowButton.hidden = YES;
//    _arrowButtonHVBtn.hidden = YES;
//    _contentButtonHVBtn.hidden = YES;
//    _iRow = sender.row;
//    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:sender.row ]] withRowAnimation:UITableViewRowAnimationNone];
}

//-(void)buttonPressedArrow:(UIButtonValue*)sender{
//    
//    if((nil == sender) || (nil == sender.contentButton) || (nil == sender.detailButton))
//    {
//        return;
//    }
//    sender.contentButton.hidden = YES;
//    sender.arrowButton.hidden = YES;
//    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//}


//- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    
//    if (alertView == self.alertView) {
//        self.isAlertCherkNet = YES;
//          [HomeViewController checkNetWork];
////        if (self.isHaveNet) {
////            [self.launchView removeFromSuperview];
////        }else{
////    [self.alertView show];
////        
////        }
//    }
//}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1010)
    {
        _isAlertCherkNet = NO;

        if (_needSendNotice)
        {
            if (self.isHaveNet)
            {
                _needSendNotice = NO;
                _isAlertCherkNet = NO;
                [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_VERSION_NOTIFICATION object:nil];
            }
            else
            {
                if(!_isAlertCherkNet && !_isAlertSrvFail)
                {
                    self.alertView = [[UIAlertView alloc] initWithTitle:nil message:@"当前无网络，请打开网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    self.alertView.tag = 1010;
                    _isAlertCherkNet = YES;
                    [self.alertView  show];
                    self.alertView = nil;
                }
            }

        }
        else
        {
            if (!self.isHaveNet)
            {
                if(!_isAlertCherkNet && !_isAlertSrvFail)
                {
                    self.alertView = [[UIAlertView alloc] initWithTitle:nil message:@"当前无网络，请打开网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    self.alertView.tag = 1010;
                    _isAlertCherkNet = YES;
                    [self.alertView  show];
                    self.alertView = nil;
                }
            }
            else
            {
                _isAlertCherkNet = NO;
                [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_NOTIFICATION object:nil];
            }
        }
        
//            NSString *phone = [AppManager valueForKey:@"telephone"];
//            NSString *password = [AppManager valueForKey:@"password"];
//            if (phone.length != 0 && password.length != 0)
//            {
//                
//                //                self.launchView = [[LaunchImageView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT) remind:@"加载中"];
//                //                [self.navigationController.view addSubview:self.launchView];
//                
//                
//                if (self.isHaveNet) {

    }
    else if (alertView.tag == 1888) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            AccountRechargeViewController * messagesViewController = [[AccountRechargeViewController alloc ]initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:messagesViewController animated:YES];
        }
    }
    else if (alertView.tag == 1008)
    {
        switch (buttonIndex)
        {
            case 0:
            {
                [self displayLoginView];
                
                _isAlertSrvFail = NO;
                //                break;
                return;
            }
            case 1:
            {
                _isAlertSrvFail = NO;
                [self autoLogin];
                return;
            }
        }
    }else if (alertView.tag == 101){
        if (buttonIndex ==0) {
            return;
        }
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.strTEL]];
       
             [[UIApplication sharedApplication] openURL:url];
    }else if (alertView.tag == 111){
        if (buttonIndex == 1) {
            NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:settingsURL];
            
        }

    }

    
}
#pragma mark获取门店信息
-(void)getPresonalInfoWithCount:(NSInteger)count{

//     __weak __typeof(self)safeSelf = self;
//    FLDDLogDebug(@"%@",[AppManager valueForKey:@"shopName"]);
//    self.labelTitle.text= [AppManager valueForKey:@"shopName"];
//[SelfUser mddyRequestWithMethodName:@"notifyUnreadCountWithoutTypeJsonPhone.htm" withParams:nil withBlock:^(id responseObject, NSError *error) {
//    FLDDLogDebug(@"%@",responseObject);
// 
//
//    if (!error) {
//        @try {
//          int count = [[responseObject valueForKey:@"count1"] intValue] + [[responseObject valueForKey:@"count2"] intValue];
//            
//            if (count == 0) {
//                safeSelf.buttonRightItem.imageView1.hidden = YES;
//            }else{
//                safeSelf.buttonRightItem.imageView1.hidden = NO;
//                safeSelf.buttonRightItem.label.text = [NSString stringWithFormat:@"%d",count];
//                
//            }
//            
//        }
//        @catch (NSException *exception) {
//            
//        }
//        @finally {
//            
//        }
//    }else{
//         safeSelf.buttonRightItem.imageView1.hidden = YES;
//    }
//}];
    
    if (count == 0) {
        self.buttonRightItem.imageView1.hidden = YES;
    }else{
        self.buttonRightItem.imageView1.hidden = NO;
        if (count>=100) {
            self.buttonRightItem.imageView1.frame = CGRectMake(23, 5,24, 20);
            self.buttonRightItem.imageView1.image =[UIImage imageNamed:@"new02.png"];
//            [self.buttonRightItem.imageView1 sizeToFit];
              self.buttonRightItem.label.text = [NSString stringWithFormat:@"99+"];
            self.buttonRightItem.label.font = [UIFont systemFontOfSize:11];
        
        }else{
            self.buttonRightItem.imageView1 .image = [UIImage imageNamed:@"new_message.png"];
             self.buttonRightItem.imageView1.frame = CGRectMake(26.5, 5,18, 18);
              self.buttonRightItem.label.text = [NSString stringWithFormat:@"%ld",(long)count];
        }
      
        
    }

    
    
}
-(void)buttonQueRenSend{
    
    if (![CLLocationManager locationServicesEnabled]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"定位服务当前可能尚未打开，请在设置中打开！" message:nil delegate:nil cancelButtonTitle:@"确定"otherButtonTitles: nil];
        
        [alertView show];
        return;
        
    }else{
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            
            [HomeViewController requestAlwaysAuthorizationHe];
              return;
        }
      
        
        
    }
    

 
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate locationDingWei];
    self.isJISuButton = YES;
    
    
    self.buttonRightItem.userInteractionEnabled = YES;
    
    _viewImageControlBG.hidden = YES;
    self.viewAlphaBG.hidden = YES;
    [self.textField resignFirstResponder];
     [SelfUser hudShowWithViewcontroller:self];

    
}
-(void)show{
    self.orderBtnStatus =statusWaitLanshou;
    self.currentPage = 0;
//    [self  getPresonalInfo];
    [SelfUser currentSelfUser].strStatus = @"lanshou";
    [self ordersButtonPressed:self.sectionHeadView.receiveButton];
    
    [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];

}
-(void)buttonSoonSendCancel{
    _viewImageControlBG.hidden = YES;
    self.viewAlphaBG.hidden = YES;
    [self.textField resignFirstResponder];
     self.buttonRightItem.userInteractionEnabled = YES;

}
#pragma mark 导航条右边
-(void)rightBarButtonPressed{
    [self hiddenDetail];
    NSLog(@"self:%@", self);

    PersonalViewController* person = [[PersonalViewController alloc ]initWithNibName:nil bundle:nil];
    person.bPrompt = self.buttonRightItem.imageView1.hidden;
    [self.navigationController pushViewController:person animated:YES];
    person = nil;
//    self.tabBarController.selectedIndex = 2;
}

+(void)checkGPS{
    
      NSLog(@"self:%@", self);
    
    if (![CLLocationManager locationServicesEnabled]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"定位服务当前可能尚未打开，请在设置中打开！" message:nil delegate:self cancelButtonTitle:@"确定"otherButtonTitles: nil];
        
        [alertView show];
        
    }else{
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
        
        [HomeViewController requestAlwaysAuthorizationHe];
        
    }
        
    }

}

+ (void)requestAlwaysAuthorizationHe
{
    
    NSLog(@"self:%@", self);
     AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UITabBarController *tabBarController = (UITabBarController *)appdelegate.baseNavigationController.topViewController;
    
    HomeViewController *hVC = (HomeViewController *)tabBarController.viewControllers[0];
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否授权最鲜到门店使用GPS定位服务" message:nil delegate:hVC cancelButtonTitle:@"取消"otherButtonTitles:@"设置", nil];
    alertView.tag =111;
    [alertView show];
    
   
    
}
-(void)locationNoti{
    //    [AppManager setUserDefaultsValue:latitude key:@"latitude"];
    //    [AppManager setUserDefaultsValue:longitude key:@"longitude"];
  
    if (self.isJISuButton) {
        self.isJISuButton = NO;
    }
    else{
        return;
    }
       [SelfUser hudHideWithViewcontroller:self];
    
    if (self.textField.text.length == 0 || [self.textField.text intValue]==0) {
        //        [SVProgressHUD showErrorWithStatus:@"请输入正确金额"];
        [MBProgressHUD hudShowWithStatus:self :@"请输入正确金额"];
    }else{
        
        self.buttonRightItem.userInteractionEnabled = YES;
        
        _viewImageControlBG.hidden = YES;
        self.viewAlphaBG.hidden = YES;
        [self.textField resignFirstResponder];
        //    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeBlack];
        FLDDLogDebug(@"%@",[NSString stringWithFormat:@"%f",[self.textField.text floatValue]*100]);
        
        CGFloat price;
        price =[self.textField.text floatValue]*100;
        
        NSString* strPriFlo = [NSString stringWithFormat:@"%f",price];
        int priceInt;
        priceInt = [strPriFlo intValue];
        __weak __typeof(self)safeSelf = self;
        [SelfUser mddyRequestWithMethodName:@"sendWaybillTopspeedJsonPhone.htm" withParams:@{@"waybillPrice":[NSString stringWithFormat:@"%d",priceInt],@"sendWaybillClerkLatitude":[AppManager valueForKey:@"latitude"],@"sendWaybillClerkLongitude":[AppManager valueForKey:@"longitude"]} withBlock:^(id responseObject, NSError *error) {
            //        [SVProgressHUD dismiss ];
            
               [SelfUser hudHideWithViewcontroller:self];
            [MBProgressHUD hudHideWithViewcontroller:safeSelf];
            FLDDLogDebug(@"极速发单%@",responseObject);
            if (!error) {
                @try {
                    
                    
                    
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
                
                //            [SVProgressHUD showSuccessWithStatus:@"发单成功"];
                [MBProgressHUD hudShowWithStatus:self :@"发单成功"];
                [safeSelf performSelector:@selector(show) withObject:self afterDelay:0.4];
                
                
            }else{
                
                NSInteger mark = [[responseObject objectForKey:@"sendWaybillFailureMark"] integerValue];
                
                if (mark == 1) {
                    
                    UIAlertView *alertView = nil;
                    if ([[SelfUser currentSelfUser].Clerktype isEqualToString:@"1"]) {
                        alertView = [[UIAlertView alloc] initWithTitle:@"发单失败" message:@"账户余额不足，无法发单，请及时充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"充值", nil];
                    }
                    else {
                        alertView = [[UIAlertView alloc] initWithTitle:@"发单失败" message:@"账户余额不足，无法发单，请提醒店长充值" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                      
                    }
                    alertView.tag = 1888;
                    [alertView show];
                }
                else {
                    [MBProgressHUD hudShowWithStatus:safeSelf :[SelfUser currentSelfUser].ErrorMessage];

                }
                //            [SVProgressHUD showErrorWithStatus:[SelfUser currentSelfUser].ErrorMessage];
            }
            
            
        }];
        
    }

    
}

@end
