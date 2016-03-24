//
//  config.h
//  ccms
//
//  Created by user on 14-2-25.
//  Copyright (c) 2014年 epro. All rights reserved.
//

#ifndef fhl_Macro_h
#define fhl_Macro_h

enum VERSION_STATE {
    VERSION_STATE_INIT = 0,
    VERSION_STATE_FORCE_UPDATE,
    VERSION_STATE_REMIND_UPDATE,
    VERSION_STATE_NO_UPDATE,
    VERSION_STATE_FETCH_FAIL
};
//enum SHIFT_STATE {
//    SHIFT_STATE_INIT,
//    SHIFT_STATE_AUTO_LOGIN,
//    SHIFT_STATE_LOGIN_END,
//    SHIFT_STATE_LOGINING,
//    SHIFT_STATE_UNLOGIN_SEARCH_BILL,
//    SHIFT_STATE_UNLOGIN,
//    SHIFT_STATE_UNLOGIN_CHOOSE_DEFAULT_OPERATOR
//} LOGIN_SHIFT_STATE;
//
//
//enum REFRESH_STATE {
//    ALL_REFRESH_STATE,
//    CURVE_ARR_REFRESH_STATE,
//    CURVE_REFRESH_STATE,
//    ZOOM_REFRESH_STATE
//} ;
////typedef sex  VEHICLE_MENU_STATE1;
//enum REFRESH_STATE g_refreshState;


//NSURL *serverUrl;
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)

#endif


#ifdef DEBUG
#ifndef FLDDLogError
#define FLDDLogError(format, ...)                                                                                   \
{                                                                                                                   \
DDLogError((@"%@.m:%s:%d Err:" format), NSStringFromClass([self class]), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);                \
}
#endif



#ifndef FLDDLogWarn
#define FLDDLogWarn(format, ...)                                                                                   \
{                                                                                                                  \
DDLogWarn((@"%@.m:%s:%d Warn:" format), NSStringFromClass([self class]), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);               \
}
#endif



#ifndef FLDDLogInfo
#define FLDDLogInfo(format, ...)                                                                                   \
{                                                                                                                  \
DDLogInfo((@"%@.m:%s:%d Info:" format), NSStringFromClass([self class]), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);               \
}
#endif



#ifndef FLDDLogDebug
#define FLDDLogDebug(format, ...)                                                                                    \
{                                                                                                                 \
DDLogDebug((@"%@.m:%s:%d Debug:" format), NSStringFromClass([self class]), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);               \
}
#endif



#ifndef FLDDLogVerbose
#define FLDDLogVerbose(format, ...)                                                                               \
{                                                                                                                 \
DDLogVerbose((@"%@.m:%s:%d Verbose:" format), NSStringFromClass([self class]), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);        \
}
#endif
#else
#define FLDDLogError(...) {};
#define FLDDLogWarn(...) {};
#define FLDDLogInfo(...) {};
#define FLDDLogDebug(...) {};
#define FLDDLogVerbose(...) {};
#endif


//自定义日志开关
#ifdef DEBUG
static const NSInteger g_printLogLevel =  3;   // 仅当  isPrintLog 值大于0的时候才输出日志，关闭日志打印讲1改为任意其他数值即可
#else
static const NSInteger g_printLogLevel =  0;   // 仅当  isPrintLog 值大于0的时候才输出日志，关闭日志打印讲1改为任意其他数值即可
#endif

#ifndef LogInfo
#define LogInfo(format, ...)            \
{                                       \
if(2 < g_printLogLevel)                 \
{                                   \
NSLog((@"%@.m:%d Info:" format), NSStringFromClass([self class]), __LINE__, ## __VA_ARGS__); \
}                                   \
}
#endif

#ifndef LogDebug
#define LogDebug(format, ...)            \
{                                       \
if(1 < g_printLogLevel)                 \
{                                   \
NSLog((@"%@.m:%d Debug:" format), NSStringFromClass([self class]), __LINE__, ## __VA_ARGS__); \
}                                   \
}
#endif

#ifndef LogError
#define LogError(format, ...)            \
{                                       \
if(0 < g_printLogLevel)                 \
{                                   \
NSLog((@"%@.m:%d Error:" format), NSStringFromClass([self class]), __LINE__, ## __VA_ARGS__); \
}                                   \
}
#endif
