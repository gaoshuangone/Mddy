//
//  Config.h
//  fhl
//
//  Created by user on 14-2-25.
//  Copyright (c) 2014年 epro. All rights reserved.
//

#ifndef fhl_Config_h
#define fhl_Config_h
#import "Reachability.h"

enum LOGIN_STATE {
    LOGIN_STATE_INIT = 0,
    LOGIN_STATE_LOGIN_SUCESS,
    LOGIN_STATE_LOGINING,
    LOGIN_STATE_UNAUTO_LOGIN,
    LOGIN_STATE_UNNET_LOGIN,
    LOGIN_STATE_EXIT_LOGIN
};


//STATE_INIT为初始化状态(非稳定状态)，STATE_SUCESS为成功或YES，STATE_FAIL为失败或NO
enum STATE {
    STATE_INIT = 0,
    STATE_SUCESS,
    STATE_FAIL
};
//static const NSString *g_baseURL = @"http://172.16.28.152:8080/fhl";
//static const NSString *g_loginURL = @"fhl/phone/psy/needPasswordJsonPhone.htm";
//static const NSString *g_loginCheckCodeURL = @"fhl/phone/psy/loginJsonPhone.htm";
//static const NSString *g_loginURL = @"fileupload/servlet/fileServlet"

//#define FHL_VISION "1.0.1"
static const NSString *g_fhlVision = @"1.0.1";
static const NSString *g_hudStatus = @"请稍后...";
static const NSInteger g_requeRespondTime =  10;
static const NSInteger g_maxRespondTime =  300;
static const NSInteger g_checkCodeLength =  6;
static const NSString *g_softkey1 = @"ukweuyjsy3as7gh23asdnm4j6wk8vbu634skbf26d";
static const NSString *g_softkey2 = @"pkywjtkujkc6y74jmguysdjk32dakf7zclhfwszcrm";

static const NSString *g_bUDID = @"12321323242343242321ee";
static const NSString *g_closeHud = @"CLOSE_HUD";
static const NSString *g_loginNetError = @"网络繁忙，请重新提交！";
static const NSString *g_propertiesFileName = @"fhlProperties.plist";

/**
 *define cmdCode
 */
static const NSString *g_handoverWayBillListCmd = @"1006";                             //待揽收        homePageWithToHandoverWaybillListJsonPhone.htm
static const NSString *g_receiveWaybillLisCmd = @"1007";                               //待签收        homePageWithToReceiveWaybillListJsonPhone.htm
static const NSString *g_cancelAndRejectedWayBillListCmd = @"1008";                    //处理中        homePageWithToCancelAndRejectedWaybillListJsonPhone.htm

static const NSString *g_validPasswordIdentifyingCmd  = @"1009";                       //找回密码验证码  validPasswordIdentifyingJsonPhone.htm
static const NSString *g_loginCmd = @"1001";                                           //登录          loginJsonPhone loginWithFixedPasswordJsonPhone.htm
static const NSString *g_reloginCmd = @"1000";                                         //重新登录       reloginJsonPhone reLoginWithFixedPasswordJsonPhone.htm
static const NSString *g_loginCheckCodeCmd = @"1002";                                  //获取验证码     needPasswordJsonPhone
static const NSString *g_registerCmd = @"1003";//注册
static const NSString *g_personalInfoCmd = @"1004";//用户信息
static const NSString *g_portraitCmd = @"1005";//用户头像
static const NSString *g_shopInfoCmd = @"1006";                                        //获取门店资料    shopInfoJsonPhone
static const NSString *g_clerkListCmd = @"1007";                                       //获取门店店员列表 clerkListJsonPhone
static const NSString *g_logoutCmd = @"1008";                                          //退出当前用户    logoutJsonPhone


static const NSString *g_phoneIdCmd = @"9999";                                         //获取phoneId    needPhoneIdJsonPhone
static const NSString *g_hitHeartCmd = @"0001";                                        //手机心跳        heartbeatJsonPhone
static const NSString *g_updateLocationCmd = @"0002";//更新用户经纬度
static const NSString *g_startWorkCmd = @"0003";//上班
static const NSString *g_endWorkCmd = @"0004";//下班
static const NSString *g_pushConfigCmd = @"0005";                                      //配置push       pushPhoneParamJsonPhone

static const NSString *g_getQuestionsCmd = @"2000";//获取在线题目
static const NSString *g_shopLogCmd = @"2001";//获取商店log
static const NSString *g_sendWaybillCmd = @"2002";                                     //发单           sendWaybillJsonPhone.htm
static const NSString *g_clerkAddCmd = @"2003";                                        //添加门店店员     clerkAddJsonPhone
static const NSString *g_clerkDelCmd = @"2004";                                        //)删除门店店员     clerkDelJsonPhone
static const NSString *g_feedBackCmd = @"2005";                                        //)反馈与建议     feedBackJsonPhone

static const NSString *g_orderCountCmd = @"3000";//今日接单数
static const NSString *g_captureOrdersCmd = @"3001";//可抢单列表
static const NSString *g_captureOrderCmd = @"3002";//抢单
static const NSString *g_receivedCountOrderCmd = @"3003";//待揽收运单个数
static const NSString *g_sendCountOrderCmd = @"3004";//待签收运单个数
static const NSString *g_cancelAndRefuseCountOrderCmd = @"3005";//取消and拒绝运单总和
static const NSString *g_refuseCountOrderCmd = @"3006";//拒绝运单个数
static const NSString *g_receivedOrdersCmd = @"3007";//待揽收运单列表
static const NSString *g_sendOrdersCmd = @"3008";//待签收运单列表
static const NSString *g_cancelOrdersCmd = @"3009";//待取消运单列表
static const NSString *g_refuseOrdersCmd = @"3010";//待拒绝运单列表
static const NSString *g_handoverWaybillDetailCmd = @"3011";                           //待处理订单详情  toHandoverWaybillDetailJsonPhone.htm
static const NSString *g_receiveWaybillDetailCmd = @"3012";                            //待签收订单详情  toReceiveWaybillDetailJsonPhone.htm
static const NSString *g_hasEndWaybillDetailCmd = @"3013";                             //已经完成订单详情 hasEndWaybillDetailJsonPhone.htm
static const NSString *g_cancelWaybillDetailCmd = @"3014";                             //取消中的订单详情 toCancelWaybillDetailJsonPhone.htm
static const NSString *g_dealWaybillDetailCmd = @"3015";                               //拒收中的订单详情 toDealWaybillDetailJsonPhone.htm
static const NSString *g_hasEndWaybillListCmd = @"3016";                               //已完成订单列表   hasEndWaybillListJsonPhone

static const NSString *g_messagesCmd = @"4000";//消息
static const NSString *g_readMessageCmd = @"4001";//阅读消息
static const NSString *g_messageCountCmd = @"4002";//消息数量
static const NSString *g_notifyUnreadCountCmd = @"4003";                               //消息数量        notifyUnreadCountWithoutTypeJsonPhone.htm
static const NSString *g_notifyDetailCmd = @"4004";                                    //消息数量        notifyDetailJsonPhone

static const NSString *g_equipmentCmd = @"5000";//获取装备列表

static const NSString *g_accountAmontCmd = @"6000";//账户余额
static const NSString *g_accountsCmd = @"6001";//账户明细

static const NSString *g_fileDownloadCmd = @"10000";//下载image
static const NSString *g_checkUpdateCmd = @"10001";//版本检查

static const NSString *g_userPlicyPageDownloadCmd = @"8104";//下载使用条款页面
static const NSString *g_freightTemplatePageDownloadCmd = @"8105";
static const NSString *g_shopAccountBlanceJsonPhoneCountCmd = @"4004";
static const NSString *g_shopAccountBlanceLogJsonPhoneCountCmd = @"4005";
NSString *g_versionSNO;//版本号
#define INPUT_LENGTH_LIMIT  150

#define pageBtnHeight 100
static const NSString *g_connectServerFail = @"Could not connect to the server.";
static const NSString *g_connectServerOffine = @"未能连接到服务器。";
//static const NSString *g_connectServerNetOffine = @"The Internet connection appears to be offline.";
static const NSInteger g_connectServerOffineCode = -1004;
static NSString * const g_errorReLoginFail = @"服务器器返回，自动登录失败";

static const NSString *g_apliy = @"apily_cmdCode";//特殊的一个，提交支付宝返回结果修改baseurl的，不要随便用

static const NSUInteger g_iconLable = 0;
NSString *g_telephone;
BOOL g_freshCheckCodePage;
NSUInteger g_needUpgrade;//是否强制更新
NSString *g_downloadUrl;//新版本下载地址


NSUInteger g_timeCount;
NSTimer *g_getCheckCodeTimer;
enum LOGIN_STATE g_loginStat;
enum STATE g_getNetState;
Reachability * g_reachability;
//Boolean g_firstCheckNet;
Boolean g_showNoNetNotice;
NSString *g_messageInfo;
enum STATE g_routeSearchStat;//解决无网络登录，百度地图授权失败，当连接网络时，首先发送刷新首页列表并解析步行距离，结果全失败，后收到百度授权成功通知。若首次失败就标志为失败，若成功过就不再标志为失败。
NSUInteger g_MBKPermissionSuccessCount; //首次百度授权成功次数，最大为3.
//NSString *g_phoneId;
//NSString *g_UserName;
//NSString *g_Password;
//statusId;
//NSString *g_VehicleConditionsMail;
//NSString *serverUrl;
//NSString *strRoleType;
//NSString *sp_id;
//NSString *sp_name;
//NSString *strToken;
//NSInteger cellWidth;
//NSString *strVId;
//NSString *strVehicleNo;
//NSString *strVState;
//NSInteger pageCount;
//NSMutableArray *g_pageQueue;
//NSString *g_destinationPage;
//NSString *mobile;
//NSString *g_processKey;
//NSString *email_recv;
//NSString *email_cc;
//NSString *strTId;
//NSString *g_HistoryPlaybackInterval;
//NSString *g_DefaultOperator;
//NSString *g_DefaultOperatorName;
//NSString *g_deviceType;
//NSUInteger g_deviceHeight;
//NSUInteger g_deviceWidth;
//NSString *g_channel;
//NSString *g_tType;
//NSString *g_latestVersion;
//NSString *g_loginTimeOut;
//NSFileHandle *g_pipeWriteHandle;
//NSTimeInterval g_pushTime;
//NSTimeInterval g_pushIntervalSecond;
//double g_latitude;
//double g_longitude;
//BOOL g_fdWriteFlag;
//NSInteger g_fd;
//NSInteger g_localClientFd;
//in_port_t g_uIPPort;
//char *g_IP;
//BOOL g_loginTimeOutFlag;
//BOOL taskFlag;
////BOOL VehicleMonitorFlag;
////enum VEHICLE_MENU_STATE vehicleMenuState;
//enum SHIFT_STATE g_LoginShiftState;
//NSLock *theLock;
//NSLock *theTryLock;
//NSCondition *g_tc;
////NSCondition *g_puTc;
////msgLen = 0;
//NSString *g_token;

//NSURL *serverUrl;
#endif