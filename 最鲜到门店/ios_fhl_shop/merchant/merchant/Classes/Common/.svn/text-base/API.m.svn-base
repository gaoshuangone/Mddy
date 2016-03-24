 //

//  API.m
//  FHL
//
//  Created by panume on 14-9-22.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "API.h"
#import "Config.h"
#import <CommonCrypto/CommonDigest.h>
#import "sys/utsname.h"
#import "HomeViewController.h"
#import "Reachability.h"

//static NSString * const BaseURL = @"http://172.16.28.152:8080/fhl/phone/mddy/";
static NSString * const ApilyURL = @"http://fhl.zuixiandao.cn:8081/phone/mddy/";//不要动这个

//static NSString * const BaseURL = @"http://172.16.28.163:8081/fhl/phone/mddy/";

//static NSString * const BaseURL = @"http://172.16.28.165:8080/fhl/phone/mddy/";

//static NSString * const BaseURL = @"http://fhlali.zuixiandao.cn:8081/phone/mddy/";
//static NSString * const BaseURL = @"http://172.16.28.91:8080/fhl/phone/mddy/";
//static NSString * const BaseURL = @"http://172.16.28.98/fhl/phone/mddy/";
//static NSString * const BaseURL = @"http://fhl.zuixiandao.cn:8081/phone/mddy/";//base里边两个DEBUG的注视去掉

static NSString * const BaseURL = @"http://test.zuixiandao.cn/fhl/phone/mddy/";


//static NSString * const BaseURL = @"http://pre.zuixiandao.cn/fhl/phone/mddy/";

static NSString * const ErrorDomain = @"JW_ERROR_DOMAIN";
//static NSString * const ErrrorDes = @"服务器繁忙，请稍候再试";
//static NSString * const ErrrorDes = @"网络比蜗牛还慢，挤不进去呀";
//static NSString * const ErrrorNoNetDes = @"当前网络不可用，请检查您的网络设置";
static NSString * const ErrrorDes = @"网络太差了，请稍后再试";
static NSString * const ErrrorNoNetDes = @"网络太差了，请稍后再试";

@implementation API


+ (instancetype)shareAPI

{
    static API *shareAPI = nil;
    static dispatch_once_t onceToken;
//#ifdef DEBUG
    
    if (![BaseURL isEqualToString:@"http://fhl.zuixiandao.cn:8081/phone/mddy/"]) {
        NSString *baseUrl = [AppManager valueForKey:@"RootUrl"];
        
        if (baseUrl.length == 0) {
            baseUrl = @"http://test.zuixiandao.cn/fhl/phone/mddy/";
//            baseUrl = BaseURL;
            [AppManager setUserDefaultsValue:baseUrl key:@"RootUrl"];
             [AppManager setUserDefaultsValue:@"测试test" key:@"RootUrlIndex"];
            
        }
        dispatch_once(&onceToken, ^{
            shareAPI = [[API alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        });
    }else{
        dispatch_once(&onceToken, ^{
            shareAPI = [[self alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
            
        });
    }
    
//#else
//    dispatch_once(&onceToken, ^{
//        shareAPI = [[self alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
//        
//    });
//#endif
    
    shareAPI.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];//设置相应内容类型
    
    //    shareAPI.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"image/jpeg"];//设置相应内容类型
    
    
    [shareAPI.requestSerializer setTimeoutInterval:g_requeRespondTime];
    return shareAPI;
}


- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }

    self.requestSerializer.timeoutInterval = 30;
   
    return self;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method URLString:(NSString *)URLString parameters:(NSMutableDictionary *)parameters error:(NSError *)error
{
    NSMutableURLRequest *muRequest = nil;
    if ([method isEqualToString:@"POST"]) {
        
        NSString *cmdCode = [parameters objectForKey:@"cmdCode"];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[CGeneralFunction getGetModeParamsHeadList:cmdCode]];
        [params setObject:cmdCode forKey:@"cmdCode"];
        
        NSString *urlStr = @"?";
        for (int i = 0; i < [params allKeys].count; i ++) {
            urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@",[params allKeys][i],[params allValues][i]]];
            if (i != [params allValues].count - 1) {
                urlStr = [urlStr stringByAppendingString:@"&"];
            }
        }
        
        //        [params addEntriesFromDictionary:parameters];
        
        //        FLDDLogDebug(@"request paramters:%@", params);
        
        
        
        
        //        NSString *allUrlStr = [[URLString stringByAppendingString:urlStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *allUrlStr = [URLString stringByAppendingString:urlStr];
        
        NSURL *url = [NSURL URLWithString:allUrlStr relativeToURL:self.baseURL];
        
        muRequest = [self.requestSerializer requestWithMethod:method URLString:[url absoluteString] parameters:parameters error:&error];
        
        url = nil;
        
        //    NSData *cookiesData = [AppManager objectForKey:@"userCookie"];
        //
        //    if([cookiesData length]) {
        //        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesData];
        //        NSHTTPCookie *cookie;
        //        for (cookie in cookies) {
        //            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        //        }
        //    }
        
        NSString *cookie = [AppManager valueForKey:@"cookie"];
        
        [muRequest addValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    else {
        
        NSString *cmdCode = [parameters objectForKey:@"cmdCode"];
        NSString *passwd = [parameters objectForKey:@"passwd"];
        NSString *identifyingCode = [parameters objectForKey:@"identifyingCode"];
        NSString* oldPassword = [parameters objectForKey:@"oldPassword"];
        
      NSMutableDictionary *params = [NSMutableDictionary dictionary];
        if (passwd.length > 0) {
         
            params = [NSMutableDictionary dictionaryWithDictionary:[CGeneralFunction getGetModeParamsHeadListWithPasswd:passwd cmdCode:cmdCode]];
            
            [parameters removeObjectForKey:@"passwd"];
        }else if(identifyingCode.length>0){
            params = [NSMutableDictionary dictionaryWithDictionary:[CGeneralFunction getGetModeParamsHeadListWithPasswd1:identifyingCode cmdCode:cmdCode]];
            
            [parameters removeObjectForKey:@"identifyingCode"];
       }
            else if (oldPassword.length >0){
//            params = [NSMutableDictionary dictionaryWithDictionary:[CGeneralFunction getGetModeParamsHeadListWithPasswd2:[parameters objectForKey:@"newPassword"] cmdCode:cmdCode]];
                params =[NSMutableDictionary dictionaryWithDictionary:[CGeneralFunction getGetModeParamsHeadListWithNewPasswd2:[parameters objectForKey:@"newPassword"] oldPasswd:[parameters objectForKey:@"oldPassword"] cmdCode:cmdCode]];
            [parameters removeObjectForKey:@"newPassword"];
        }
        else {
            NSDictionary* dictD =[CGeneralFunction getGetModeParamsHeadList:cmdCode];
            params = [NSMutableDictionary dictionaryWithDictionary:dictD];
            dictD = nil;
        }
        
        
        [params addEntriesFromDictionary:parameters];
        
        NSLog(@"%@",self.baseURL);
        FLDDLogDebug(@"request paramters:%@\n", params);
        
      
            muRequest = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:params error:&error];
       
        
        //    NSData *cookiesData = [AppManager objectForKey:@"userCookie"];
        //
        //    if([cookiesData length]) {
        //        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesData];
        //        NSHTTPCookie *cookie;
        //        for (cookie in cookies) {
        //            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        //        }
        //    }
        if ([cmdCode isEqualToString:(NSString *)g_loginCmd] || [cmdCode isEqualToString:(NSString *)g_reloginCmd] || [cmdCode isEqualToString:(NSString *)g_checkUpdateCmd]) {
            
        }else{
            NSString *cookie = [AppManager valueForKey:@"cookie"];
            //
            [muRequest addValue:cookie forHTTPHeaderField:@"Cookie"];
        }
       
        //    [muRequest setValue:cookie forHTTPHeaderField:@"Cookie"];
        //
        //cookie
        //    NSArray *cookieStorage = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString]]];
        //    NSDictionary *cookieHeaders = [NSHTTPCookie requestHeaderFieldsWithCookies:cookieStorage];
        //    for (NSString *key in cookieHeaders) {
        //        [muRequest addValue:cookieHeaders[key] forHTTPHeaderField:key];
        //    }
        //
        params = nil;
        parameters = nil;
    }
    
    
    return muRequest;
}


// the request with file
- (NSMutableURLRequest *)multipartFormRequestWithMethod:(NSString *)method
                                              URLString:(NSString *)URLString
                                             parameters:(NSDictionary *)parameters
                              constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
                                                  error:(NSError *)error
{
    
   
    
    NSString *cmdCode = [parameters objectForKey:@"cmdCode"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[CGeneralFunction getGetModeParamsHeadList:cmdCode]];
    [params setObject:cmdCode forKey:@"cmdCode"];
    
    NSString *urlStr = @"?";
    for (int i = 0; i < [params allKeys].count; i ++) {
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@",[params allKeys][i],[params allValues][i]]];
        if (i != [params allValues].count - 1) {
            urlStr = [urlStr stringByAppendingString:@"&"];
        }
    }
    
    //    [params addEntriesFromDictionary:parameters];
    
    FLDDLogDebug(@"request paramters:%@", params);
    
    
    //    NSString *urlStr = @"?";
    //    for (int i = 0; i < [params allKeys].count; i ++) {
    //        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@",[params allKeys][i],[params allValues][i]]];
    //        if (i != [params allValues].count - 1) {
    //        urlStr = [urlStr stringByAppendingString:@"&"];
    //        }
    //    }
    
    NSString *allUrlStr = [URLString stringByAppendingString:urlStr] ;
    
    NSURL *url = [NSURL URLWithString:allUrlStr relativeToURL:self.baseURL];
    
  __autoreleasing  NSMutableURLRequest *mutableRequest = [self.requestSerializer multipartFormRequestWithMethod:method URLString:[url absoluteString] parameters:parameters constructingBodyWithBlock:block error:nil];
    
    //    NSData *cookiesData = [AppManager objectForKey:@"userCookie"];
    //
    //    if([cookiesData length]) {
    //        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesData];
    //        NSHTTPCookie *cookie;
    //        for (cookie in cookies) {
    //            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    //        }
    //    }
    
    NSString *cookie = [AppManager valueForKey:@"cookie"];
    
    [mutableRequest addValue:cookie forHTTPHeaderField:@"Cookie"];
    
    return mutableRequest;
}

- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request
                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
 __autoreleasing   AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = self.responseSerializer;
    operation.shouldUseCredentialStorage = self.shouldUseCredentialStorage;
    operation.credential = self.credential;
    operation.securityPolicy = self.securityPolicy;
    

    
    operation.completionQueue = self.completionQueue;
    operation.completionGroup = self.completionGroup;
    
    [operation setCompletionBlockWithSuccess:success failure:failure];
    
    return operation;
}


- (NSString *)getRequestCmdCode:(NSMutableURLRequest *)request
{
    NSString *cmdCode = nil;
    if(request == nil)
    {
        return nil;
    }
    @try {
        NSString *query = request.URL.query;
        if(query.length < 8)
        {
            return nil;
        }
        NSRange range1 = [query rangeOfString:@"cmdCode="];
        NSString *str = [query substringFromIndex:range1.location];
        NSRange range2 = [str rangeOfString:@"&"];
        NSRange range = NSMakeRange(range1.length, (range2.location - range1.length));
//        NSRange range = NSMakeRange(range1.location + range1.length, range2.location - (range1.location + range1.length));
        cmdCode = [str substringWithRange:range];
        
        FLDDLogDebug(@"cmdCode:%@", cmdCode);
    }
    @catch (NSException *exception) {
        FLDDLogError(@"exception: %@", exception);
        return nil;
    }
    
    return cmdCode;
}

- (NSURLRequest *)getPageHttpRequest:(NSString *)method URLString:(NSString *)URLString parameters:(NSMutableDictionary *)parameters error:(NSError *)error
{
    NSURLRequest *muRequest = nil;
    
    NSString *cmdCode = [parameters objectForKey:@"cmdCode"];
    
 __autoreleasing   NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[CGeneralFunction getGetModeParamsHeadList:cmdCode]];
    [params setObject:cmdCode forKey:@"cmdCode"];
    
    NSString *urlStr = @"?";
    for (int i = 0; i < [params allKeys].count; i ++) {
        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@",[params allKeys][i],[params allValues][i]]];
        if (i != [params allValues].count - 1) {
            urlStr = [urlStr stringByAppendingString:@"&"];
        }
    }
    NSURL* url = nil;
    NSString *allUrlStr = [URLString stringByAppendingString:urlStr];
     if ([cmdCode isEqualToString:@"apily_cmdCode"]) {
   url = [NSURL URLWithString:allUrlStr relativeToURL:[NSURL URLWithString:ApilyURL]];
     }else{
 url = [NSURL URLWithString:allUrlStr relativeToURL:self.baseURL];
     }

    muRequest = [self.requestSerializer requestWithMethod:method URLString:[url absoluteString] parameters:parameters error:&error];
    
   
    //    NSString *cookie = [AppManager valueForKey:@"cookie"];
    //
    //    [muRequest addValue:cookie forHTTPHeaderField:@"Cookie"];
    
    return muRequest;
}

- (NSURLRequest *)GetRequest:(NSString *)URLString params:(NSDictionary *)parameters
{
    return  [self getPageHttpRequest:@"GET" URLString:URLString parameters:[NSMutableDictionary dictionaryWithDictionary:parameters] error:nil];
}

- (void)GET:(NSString *)URLString params:(NSDictionary *)parameters
                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
  NSMutableDictionary*  parameter1 = [NSMutableDictionary dictionaryWithDictionary:parameters];

   NSMutableURLRequest *mutableRequest = [self requestWithMethod:@"GET" URLString:URLString parameters:parameter1  error:nil];
    
        NSString *cmdCode = [self getRequestCmdCode:mutableRequest];
        FLDDLogDebug(@"g_loginStat:%d,cmdCode:%@, g_checkUpdateCmd:%@", g_loginStat,cmdCode, g_checkUpdateCmd);
        if((LOGIN_STATE_UNNET_LOGIN == g_loginStat) && (cmdCode != nil) && (!([cmdCode isEqualToString:(NSString *)g_loginCmd] || [cmdCode isEqualToString:(NSString *)g_reloginCmd]  || [cmdCode isEqualToString:(NSString *)g_checkUpdateCmd])))
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_NOTIFICATION object:nil];
        }
    
    
    AFHTTPRequestOperation *operation  = [self httpRequestWithRequest:mutableRequest success:success failure:failure];
    mutableRequest = nil;
    
    [self.operationQueue addOperation:operation];
    operation = nil;
    parameters = nil;
    parameter1 = nil;
}

- (void)POST:(NSString *)URLString params:(NSDictionary *)parameters
     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableURLRequest *mutableRequest = [self requestWithMethod:@"POST" URLString:URLString parameters:[NSMutableDictionary dictionaryWithDictionary:parameters] error:nil];
    
    AFHTTPRequestOperation *operation  = [self httpRequestWithRequest:mutableRequest success:success failure:failure];

    
    [self.operationQueue addOperation:operation];
}

- (void)POST:(NSString *)URLString parameters:(id)parameters
                    constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableURLRequest *mutableRequest = [self multipartFormRequestWithMethod:@"POST" URLString:URLString parameters:[NSMutableDictionary dictionaryWithDictionary:parameters] constructingBodyWithBlock:block error:nil];
    
    AFHTTPRequestOperation *operation  = [self httpRequestWithRequest:mutableRequest success:success failure:failure];

    
    [self.operationQueue addOperation:operation];
}


- (void)PUT:(NSString *)URLString parameters:(id)parameters
                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableURLRequest *mutableRequest = [self requestWithMethod:@"PUT" URLString:URLString parameters:[NSMutableDictionary dictionaryWithDictionary:parameters] error:nil];
    
    AFHTTPRequestOperation *operation  = [self httpRequestWithRequest:mutableRequest success:success failure:failure];

    
    [self.operationQueue addOperation:operation];
}

- (void)DELETE:(NSString *)URLString parameters:(id)parameters
                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableURLRequest *mutableRequest = [self requestWithMethod:@"DELETE" URLString:URLString parameters:[NSMutableDictionary dictionaryWithDictionary:parameters] error:nil];
    
    AFHTTPRequestOperation *operation  = [self httpRequestWithRequest:mutableRequest success:success failure:failure];
    
    [self.operationQueue addOperation:operation];
}



- (AFHTTPRequestOperation *)httpRequestWithRequest:(NSMutableURLRequest *)request
                                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
      
    
        if(NotReachable == [SelfUser currentSelfUser].networkStatus)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:REACHABILITY_RECOVE_NOTIFICATION object:nil];
        }
        FLDDLogDebug(@"请求的operation request url:%@", [NSString stringWithFormat:@"%@", operation.request.URL]);
        FLDDLogDebug(@"请求的responseObject:%@", responseObject);
        FLDDLogDebug(@"~~~~~~~~~innerMessage＝%@，message ＝ %@~~~~~~~~~~",[[responseObject objectForKey:@"head"] objectForKey:@"innerMessage"],[[responseObject objectForKey:@"head"] objectForKey:@"message"]);
        
 
        NSDictionary *resultHead = [responseObject objectForKey:@"head"];
         [SelfUser currentSelfUser].ErrorMessage =[resultHead objectForKey:@"message"];
         [SelfUser currentSelfUser].innerMessage =[resultHead objectForKey:@"innerMessage"];
        if ([[resultHead objectForKey:@"result"] integerValue] == 1)  {
            success(operation, responseObject);
        }
       
        else if ([[resultHead objectForKey:@"result"] integerValue] == 2){
            NSString *errorDes = [resultHead objectForKey:@"message"];
//            NSError *error = [[NSError alloc] initWithDomain:ErrorDomain code:-100 userInfo:@{NSLocalizedDescriptionKey : errorDes}];
            
            NSError *error = nil;
            if([[resultHead objectForKey:@"cmdCode"] integerValue] == 1000)
            {
                error = [[NSError alloc] initWithDomain:ErrorDomain code:-100 userInfo:@{NSLocalizedDescriptionKey : errorDes, NSLocalizedFailureReasonErrorKey : g_errorReLoginFail}];
            }
            else
            {
                error = [[NSError alloc] initWithDomain:ErrorDomain code:-100 userInfo:@{NSLocalizedDescriptionKey : errorDes}];
            }

            failure(operation, error);
        }
        else if ([[resultHead objectForKey:@"result"] integerValue] == 3) {
            
            
        if ( [[AppManager valueForKey:@"isFirst"]isEqualToString:@"2"]) {
            
            [[NSNotificationCenter defaultCenter]postNotificationName:ONCELOGININ object:self];
            
            
        }
            NSString *errorDes = [resultHead objectForKey:@"message"];
            NSError *error = [[NSError alloc] initWithDomain:ErrorDomain code:-500 userInfo:@{NSLocalizedDescriptionKey : errorDes}];
            
            failure(operation, error);
        }
       

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        @try {
            if(NotReachable == [SelfUser currentSelfUser].networkStatus)
            {
                [SelfUser currentSelfUser].ErrorMessage = ErrrorNoNetDes;
                [SelfUser currentSelfUser].isNoNetFlag = YES;
                
                
//                if ([SVProgressHUD isVisible]) {
//                    
//                }else{
//                    [SVProgressHUD showErrorWithStatus:ErrrorNoNetDes];
//
//                }
                //无网络连接检查
//                [HomeViewController checkNet];
                
//                return;
                failure(operation, error);
            }
            else
            {
            
                
            [SelfUser currentSelfUser].ErrorMessage = ErrrorDes;
                FLDDLogInfo(@"错误信息 request url:%@", [NSString stringWithFormat:@"%@", operation.request.URL]);
                FLDDLogInfo(@"错误信息error:%@", [error description]);
                failure(operation, error);
                //        [SelfUser currentSelfUser].ErrorMessage = ErrrorDes;
//                  failure(operation, error);
            }
//            if(NotReachable == [SelfUser currentSelfUser].networkStatus)
//            {
//                //无网络连接
//                [SelfUser currentSelfUser].ErrorMessage = ErrrorNoNetDes;
//                [SVProgressHUD showErrorWithStatus:ErrrorNoNetDes];
//                //                        return;
//            }
//            else
//            {
//                [SelfUser currentSelfUser].ErrorMessage = ErrrorDes;
//            }
            //            if(error != nil)
            //            {
            //                NSString *failStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            //                LogInfo(@"fail:%@", failStr);
            //
            //                if((g_connectServerOffineCode ==  error.code) || ([g_connectServerOffine isEqualToString: failStr]) || ([g_connectServerFail isEqualToString: failStr]))
            //                {
            //                    if(NotReachable == [SelfUser currentSelfUser].networkStatus)
            //                    {
            //                        //无网络连接
            //                        [SelfUser currentSelfUser].ErrorMessage = ErrrorNoNetDes;
            //                        [SVProgressHUD showErrorWithStatus:ErrrorNoNetDes];
            ////                        return;
            //                    }
            //                    else
            //                    {
            //                        [SelfUser currentSelfUser].ErrorMessage = ErrrorDes;
            //                    }
            //
            //
            //
            //                }
            //                else
            //                {
            //                    //服务器挂掉
            //
            //                    [SelfUser currentSelfUser].ErrorMessage = ErrrorDes;
            //                }
            //            }
            //            else
            //            {
            //
            //                //超时时间
            //                [SelfUser currentSelfUser].ErrorMessage = ErrrorDes;
            ////                if ( [[AppManager valueForKey:@"isFirst"]isEqualToString:@"2"]) {
            ////
            ////
            ////                            [[NSNotificationCenter defaultCenter]postNotificationName:ONCELOGININ object:self];
            ////
            ////                    
            ////                }
            //            }
        }
        @catch (NSException *exception) {
            [SelfUser currentSelfUser].ErrorMessage = ErrrorDes;
        }
        
        
 
    }];
    
    return operation;
}

- (void)REQUES:(NSString *)method WITHURL:(NSString *)URLString params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(id, NSError *))failure
{
    NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSMutableURLRequest *muRequest = nil;
    if ([method isEqualToString:@"POST"]) {
        muRequest = [self multipartFormRequestWithMethod:method URLString:URLString parameters:muParams constructingBodyWithBlock:nil error:nil];
    }
    else {
        muRequest = [self requestWithMethod:method URLString:URLString parameters:muParams error:nil];
    }
    
    NSString *cmdCode = [self getRequestCmdCode:muRequest];
    FLDDLogDebug(@"g_loginStat:%d,cmdCode:%@, g_checkUpdateCmd:%@", g_loginStat,cmdCode, g_checkUpdateCmd);
    if((LOGIN_STATE_UNNET_LOGIN == g_loginStat) && (cmdCode != nil) && (!([cmdCode isEqualToString:(NSString *)g_loginCmd] || [cmdCode isEqualToString:(NSString *)g_reloginCmd]  || [cmdCode isEqualToString:(NSString *)g_checkUpdateCmd])))
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_NOTIFICATION object:nil];
    }
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:muRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(NotReachable == [SelfUser currentSelfUser].networkStatus)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:REACHABILITY_RECOVE_NOTIFICATION object:nil];
        }
        FLDDLogDebug(@"请求的operation request url:%@", [NSString stringWithFormat:@"%@", operation.request.URL]);
        FLDDLogDebug(@"请求的responseObject:%@", responseObject);
        FLDDLogDebug(@"~~~~~~~~~innerMessage＝%@，message ＝ %@~~~~~~~~~~",[[responseObject objectForKey:@"head"] objectForKey:@"innerMessage"],[[responseObject objectForKey:@"head"] objectForKey:@"message"]);
        
        
        NSDictionary *resultHead = [responseObject objectForKey:@"head"];
        [SelfUser currentSelfUser].ErrorMessage =[resultHead objectForKey:@"message"];
        [SelfUser currentSelfUser].innerMessage =[resultHead objectForKey:@"innerMessage"];
        if ([[resultHead objectForKey:@"result"] integerValue] == 1)  {
            success(operation, responseObject);
        }
        
        else if ([[resultHead objectForKey:@"result"] integerValue] == 2){
            
            NSString *errorDes = [resultHead objectForKey:@"message"];
            //            NSError *error = [[NSError alloc] initWithDomain:ErrorDomain code:-100 userInfo:@{NSLocalizedDescriptionKey : errorDes}];
            
            NSError *error = nil;
            if([[resultHead objectForKey:@"cmdCode"] integerValue] == 1000)
            {
                error = [[NSError alloc] initWithDomain:ErrorDomain code:-100 userInfo:@{NSLocalizedDescriptionKey : errorDes, NSLocalizedFailureReasonErrorKey : g_errorReLoginFail}];
            }
            else
            {
                error = [[NSError alloc] initWithDomain:ErrorDomain code:-100 userInfo:@{NSLocalizedDescriptionKey : errorDes}];
            }
            
            failure(responseObject, error);
        }
        else if ([[resultHead objectForKey:@"result"] integerValue] == 3) {
            
            
            if ( [[AppManager valueForKey:@"isFirst"]isEqualToString:@"2"]) {
                
                [[NSNotificationCenter defaultCenter]postNotificationName:ONCELOGININ object:self];
                
                
            }
            NSString *errorDes = [resultHead objectForKey:@"message"];
            NSError *error = [[NSError alloc] initWithDomain:ErrorDomain code:-500 userInfo:@{NSLocalizedDescriptionKey : errorDes}];
            
            failure(nil, error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        @try {
            if(NotReachable == [SelfUser currentSelfUser].networkStatus)
            {
                [SelfUser currentSelfUser].ErrorMessage = ErrrorNoNetDes;
                [SelfUser currentSelfUser].isNoNetFlag = YES;
                
                failure(operation, error);
            }
            else
            {
                
                [SelfUser currentSelfUser].ErrorMessage = ErrrorDes;
                FLDDLogInfo(@"错误信息 request url:%@", [NSString stringWithFormat:@"%@", operation.request.URL]);
                FLDDLogInfo(@"错误信息error:%@", [error description]);
                failure(operation, error);
                ;
            }
        }
        @catch (NSException *exception) {
            [SelfUser currentSelfUser].ErrorMessage = ErrrorDes;
        }
    }];
    
    [self.operationQueue addOperation:operation];
}


#pragma mark - Private

- (void)getPhoneIdWithBlock:(void (^)(NSString *, NSError *))block
{
//    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    [self GET:@"needPhoneIdJsonPhone.htm" params:@{@"cmdCode": g_phoneIdCmd,@"imei":[[UIDevice currentDevice].identifierForVendor UUIDString]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            
            NSDictionary *info = [responseObject objectForKey:@"body"];
            
            NSString *phoneId = [info objectForKey:@"phoneId"];
            
            block(phoneId ,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        FLDDLogInfo(@"response:%@",operation.response);
        FLDDLogInfo(@"error:%@", [error localizedDescription]);
        
        block(nil, error);
    }];
}

- (void)hitHeartWithParams:(NSDictionary *)params block:(void (^)(NSError *))block
{
    @autoreleasepool {
        

  __autoreleasing  NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
    [muParams setObject:g_hitHeartCmd forKey:@"cmdCode"];
    
    [self GET:@"heartbeatJsonPhone.htm" params:muParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            FLDDLogDebug(@"success");
            @try
            {
                NSDictionary *body = [responseObject objectForKey:@"body"];
                g_needUpgrade = [[body objectForKey:@"needUpgrade"] integerValue];//是否强制更新
                if(g_needUpgrade == 1)
                {
                    g_downloadUrl = [body objectForKey:@"downloadUrl"];//新版本下载地址
                }
                else
                {
                    g_needUpgrade = 0;
                    g_downloadUrl = nil;
                }
                
            }
            @catch (NSException *exception) {
                FLDDLogError(@"hitHeartWithParams, exception%@", exception)
                
            }
            
            if (block) {
                block(nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        FLDDLogInfo(@"error:%@", error);
        if (block) {
            block(error);
        }
    }];
    }
}

- (void)updateLocationParams:(NSDictionary *)params block:(void (^)(NSError *))block
{
    NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
    [muParams setObject:g_updateLocationCmd forKey:@"cmdCode"];
    
    [self GET:@"resetLngLatJsonPhone.htm" params:muParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            FLDDLogDebug(@"success");
            if (block) {
                block(nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        FLDDLogInfo(@"error");
        if (block) {
            block(error);
        }
    }];
}

- (void)setPushWithParams:(NSDictionary *)params block:(void (^)(NSError *))block
{
    [self GET:@"pushPhoneParamJsonPhone.htm" params:@{@"cmdCode" : g_pushConfigCmd} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        FLDDLogDebug(@"%@",responseObject);
        if (block) {
            block(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(error);
        }
    }];
}

- (void)shopLogWithParams:(NSDictionary *)params block:(void (^)(UIImage *, NSError *))block
{
    @autoreleasepool {
        
 __autoreleasing   NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
    [muParams setObject:g_fileDownloadCmd forKey:@"cmdCode"];
    
  __autoreleasing  NSMutableURLRequest *request = [self requestWithMethod:@"GET" URLString:@"downloadBrandLogoJsonPhone.htm" parameters:muParams error:nil];

    
   __autoreleasing AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        FLDDLogDebug(@"Response: %@", responseObject);
        
        if (block) {
            block(responseObject, nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
    
    [requestOperation start];
}
}

- (void)portraitWithBlock:(void (^)(UIImage *, NSError *))block
{
    
}

- (void)imageFileWithUrl:(NSString *)URLString withBrandId:(NSString*)brandId  block:(void (^)(UIImage *, NSError *))block
{
//    NSMutableDictionary *muParams = [NSMutableDictionary dictionary];
//    if ([URLString isEqualToString:@""]) {
//        <#statements#>
//    }
    @autoreleasepool {
        
  
   __autoreleasing NSDictionary* dictParams = @{@"brandId":brandId};
  __autoreleasing    NSMutableDictionary* muParams = [NSMutableDictionary dictionaryWithDictionary:dictParams];
//    NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithObject:g_fileDownloadCmd forKey:@"cmdCode"];
    [muParams setObject:g_fileDownloadCmd  forKey:@"cmdCode"];
    
     __autoreleasing    NSMutableURLRequest *request = [self requestWithMethod:@"GET" URLString:URLString parameters:muParams error:nil];
    
  __autoreleasing  AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        FLDDLogDebug(@"下载图片为Response: %@", responseObject);
        
        if (block) {
            block(responseObject, nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
    
    [requestOperation start];
    }
    
}

- (void)imageFileWithUrl:(NSString *)URLString withBullid:(NSString*)bullid withIndex:(NSString*)index  block:(void (^)(UIImage *image, NSError *error))block
{
    //    NSMutableDictionary *muParams = [NSMutableDictionary dictionary];
    //    if ([URLString isEqualToString:@""]) {
    //        <#statements#>
    //    }
    @autoreleasepool {
        
   
 __autoreleasing   NSDictionary* dictParams = @{@"waybillId":bullid,@"index":index};
  __autoreleasing  NSMutableDictionary* muParams = [NSMutableDictionary dictionaryWithDictionary:dictParams];
    //    NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithObject:g_fileDownloadCmd forKey:@"cmdCode"];
    [muParams setObject:@"10122" forKey:@"cmdCode"];
    
  __autoreleasing  NSMutableURLRequest *request = [self requestWithMethod:@"GET" URLString:URLString parameters:muParams error:nil];
    
  __autoreleasing  AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        FLDDLogDebug(@"下载图片为Response: %@", responseObject);
        
        if (block) {
            block(responseObject, nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        FLDDLogInfo(@"%@",error);
        if (block) {
            block(nil, error);
        }
    }];
    
    [requestOperation start];
    }
    
}



@end
