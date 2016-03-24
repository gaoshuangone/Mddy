//
//  self.h
//  merchant
//
//  Created by gs on 14/11/8.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewCellValue.h"

@interface SelfUser : NSObject
@property (nonatomic, strong) NSString *id;//用户id
@property (nonatomic, strong) NSString *phone;//用户手机号
@property (nonatomic, strong) NSString *identity;//用户身份证号
@property (nonatomic, strong) NSString *password;//用户密码



@property (nonatomic,assign) BOOL isNoNetFlag;//错误标志当前网络不可用，请检查您的网络设置
@property (nonatomic, strong) NSString *shopName;//用户名
@property (nonatomic,strong) NSString* ErrorMessage;//错误信息
@property (nonatomic,strong) UIImage* imageMddy;//门店图片
@property (nonatomic,strong) NSDictionary* dictPresonInfo;//登陆成功后返回
@property (nonatomic,assign) BOOL isLogin;//输入验证码后进入home刷新
@property (nonatomic,assign) BOOL isNeedLogin;//推送中和退出登录用到
@property (nonatomic, strong) NSString* Clerktype;//判断店员和店长
@property (nonatomic,strong) NSString* strStatus;//区分代待揽收和签收 @"lanshou"
@property (nonatomic,assign) BOOL  isNeedReturnLanShou;//判断返回时是否要回到待揽收
@property (strong,nonatomic) NSString* strQuHaoTEL;//
@property (nonatomic,strong) NSString* innerMessage;//错误信息
@property (assign,nonatomic)  BOOL busyLoginIn;
@property (strong, nonatomic) NSString* proVinceCode;//省级区域编码
@property (strong, nonatomic) NSString* cityCode;//市级区域编码
@property (strong, nonatomic) NSString* countyCode;//区级区域编码
@property (strong, nonatomic) NSString* cityName;//市级区域
@property (strong, nonatomic) NSString* shopGroupIconUrl;//门店优质的图标

@property (nonatomic, assign) NSInteger networkStatus;
@property (nonatomic, strong) BMKLocationService *locationService;

@property (assign, nonatomic)CLLocationCoordinate2D mddyAdderssedLocationcoorDinate2D;




@property (nonatomic, strong) NSString *userNo;//工号
@property (nonatomic, assign) WorkState workState;//用户工作状态（上班或下班）
@property (nonatomic, strong) NSString *portrait;//用户头像url
@property (nonatomic, strong) UIImage *portraitImage;//用户头像照片
@property (nonatomic, strong) NSString *state;//用户状态（配送员状态:0未注册、1考试中、2审核中、3已审核通过、4已审核驳回、5已冻结、6已入黑名单 -1未登录）
@property (nonatomic, strong) NSString *identityFront;//身份证前照片url
@property (nonatomic, strong) UIImage *identityFrontImage;
@property (nonatomic, strong) NSString *identityBack;//身份证后照片url
@property (nonatomic, strong) UIImage *identityBackImage;
@property (nonatomic, strong) NSString *experience;//配送经验
@property (nonatomic, strong) NSString *vehicle;//交通工具
@property (nonatomic, strong) NSString *workArea;//工作区域
@property (nonatomic, strong) NSString *account;//用户账户余额
@property (nonatomic, strong) BMKMapManager *userBMKMapManager;//用户账户余额

@property (nonatomic, assign) NSInteger remainOrder;//剩余可发单数量
@property (nonatomic, assign) NSInteger remainQuickOrder;//剩余可发极速单量
@property (nonatomic, assign) NSInteger unreadMessage;//未读消息数量


+ (instancetype)currentSelfUser;
+(void)shopInfoWithBlock:(void(^)(id resongseObjec, NSError*error))block;
+(void)clerkListWithBlock:(void(^)(id resongseObjecj,NSError* error))block;
+(void)mddyRequestWithMethodName:(NSString*)methodName withParams:(NSDictionary*)params withBlock:(void(^)(id responseObject,NSError* error))block;
+(void)mddyRequestWIthImageWithBrandID:(NSString*)brandId withBlock:(void(^)(UIImage* image, NSError* error))block;
+(void)mddyRequestWIthImageWithWaybillId:(NSString *)billId withIndex:(NSString*)index withBlock:(void (^)(UIImage *image, NSError *error))block;
+(void)mddyRequestWIthImageWithWayQuickTypeIconUrl:(NSString *)quickTypeIconUrl withMothed:(NSString*)mothed withBlock:(void (^)(UIImage *image, NSError *error))block;
+(void)mddyRequestWithImageWithFileName:(NSString *)fileName  withWayQuickTypeIconUrl:(NSString *)quickTypeIconUrl withTableViewcell:(TableViewCellValue *)cell withIconArr:(NSMutableArray *)fetchingIconArr withMothed:(NSString*)mothed withBlock:(void (^)(UIImage *image, NSError *error, bool bDefault))block;
+(NSString *)mddyGetFileNameWithIconUrl:(NSString *)quickTypeIconUrl;
+(void)mddyRequestWithOrderTypeImageWithFileName:(NSString *)fileName  withWayQuickTypeIconUrl:(NSString *)quickTypeIconUrl withTableViewcell:(TableViewCellValue *)cell withIconArr:(NSMutableArray *)fetchingIconArr withMothed:(NSString*)mothed withBlock:(void (^)(UIImage *image, NSError *error, bool bDefault))block;

+(void)hudShowWithViewcontroller:(id)viewcontroller;//显示活动指示器
+(void)hudHideWithViewcontroller:(id)viewcontroller;//隐藏活动指示器
@end
