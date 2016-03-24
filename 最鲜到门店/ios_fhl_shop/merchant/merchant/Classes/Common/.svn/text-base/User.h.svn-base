//
//  User.h
//  FHL
//
//  Created by panume on 14-9-25.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WorkState) {
    WorkStateOn,
    WorkStateOff
};

@interface User : NSObject

@property (nonatomic, strong) NSString *id;//用户id
@property (nonatomic, strong) NSString *phone;//用户手机号
@property (nonatomic, strong) NSString *identity;//用户身份证号
@property (nonatomic, strong) NSString *password;//用户密码
@property (nonatomic, strong) NSString *name;//用户名
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
@property (nonatomic, strong) NSString *g_newVersionURL;//新版本地址
@property enum VERSION_STATE g_versionState;//版本状态
@property BOOL g_bVersionUpdatePrompt;//版本更新提示框是否在显示

+ (instancetype)currentUser;
+ (void)loginWithParams:(NSDictionary *)params block:(void(^)(NSError *error))block;
+ (void)reLoginWithParams:(NSDictionary *)params block:(void(^)(NSError *error))block;

+ (void)registerWithParams:(NSDictionary *)params imageDate:(NSDictionary *)imageParams block:(void (^)(NSError *error))block;
+ (void)autoCodeWithParams:(NSDictionary *)params block:(void(^)(NSError *error))block;
+ (void)modifyUserWorkStatusWithParams:(NSDictionary *)params block:(void(^)(NSError *error))block;

+ (void)questionWithParams:(NSDictionary *)params block:(void(^)(id responseObjec, NSError *error))block;

+ (void)incomeWithParams:(NSDictionary *)params block:(void(^)(NSString *income, NSError *error))block;

+ (void)personalInfoWithBlock:(void(^)(id responseObjec, NSError *error))block;

+ (void)accountBalanceWithBlock:(void(^)(NSString *account, NSError *error))block;
+ (void)getVersionSNOWithParams:(NSDictionary *)params block:(void (^)(NSError *))block;
+ (void)validPasswordIdentifyingJsonPhone:(NSDictionary *)params block:(void (^)(NSError *))block;//验证找回密码验证码
+ (void)loginWithFixedPasswordJsonPhone:(NSDictionary *)params block:(void (^)(NSError *))block;//固定密码登录
+ (void)reLoginWithFixedPasswordJsonPhone:(NSDictionary *)params block:(void (^)(NSError *))block;//固定密码重新登录
+ (void)reLoginNoSessionWithFixedPasswordJsonPhone:(NSDictionary *)params block:(void (^)(NSError *))block;//固定密码重新登录


+ (NSURLRequest *)getUserPlicyPageRequest;
+ (NSMutableURLRequest *)getBookPageRequestWithOrderNumb:(NSString*)orderNumber;
+ (NSURLRequest *)getFreightTemplateExplanationPageRequest : (NSString*)waybillid;
@end
