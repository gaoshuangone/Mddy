////
////  HttpHelper.m
////  CSD
////
////  Created by zly on 12-12-6.
////  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
////
//
//#import "HttpHelper.h"
//#import "ASIFormDataRequest.h"
//#import "ASIHTTPRequest.h"
//@implementation HttpHelper
//
//static NSInteger TIME_OUT=10; //超时时间
//
//+(NSString *)post:(NSString *)urlString desString:(NSString *)desString
//{
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
//    NSMutableData *data=[NSMutableData dataWithData:[desString dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
//    [request addRequestHeader:@"content-length" value:[NSString stringWithFormat:@"%d",[data length]]];
//    [request addRequestHeader:@"Content-Type" value:@"application/json"];
//    [request setPostBody:data];
//    [request startSynchronous];
//    NSError *error = [request error];
//    NSLog(@"网址：%@ ",urlString);
//    if (!error) {
//        NSLog(@"返回值：%@ ",[request responseString]);
//    }
//    else
//    {
//        NSLog(@"提交失败");
//    }
//    return [request responseString];
//}
//
//+(NSData *)postData:(NSString *)urlString jsonString:(NSString *)jsonString
//{
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]]; 
//    NSMutableData *data=[NSMutableData dataWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setDefaultResponseEncoding:NSUTF8StringEncoding];   
//    [request addRequestHeader:@"content-length" value:[NSString stringWithFormat:@"%d",[data length]]];
//    [request addRequestHeader:@"Content-Type" value:@"application/json"];
//    [request setPostBody:data]; 
//    [request startSynchronous];
//    NSError *error = [request error];
//    NSLog(@"网址：%@ ",urlString);
//    if (!error) {
//        NSLog(@"返回值：%@ ",[request responseString]);        
//    }
//    else
//    {
//         NSLog(@"提交失败");
//    }    
//    return [request responseData];
//}
//
//+(NSString *)get:(NSString *)urlString
//{
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]]; 
//    request.timeOutSeconds = TIME_OUT; 
//    [request setDefaultResponseEncoding:NSUTF8StringEncoding];   
//    [request addRequestHeader:@"Content-Type" value:@"application/json"];  
//    [request startSynchronous];
//    NSError *error = [request error];
//    NSLog(@"网址：%@ ",urlString);
//    if (!error) {
//        NSLog(@"返回值：%@ ",[request responseString]);        
//    }
//    else
//    {
//        NSLog(@"提交失败");
//    }    
//    return [request responseString];
//}
//
//
//+(NSData *)getData:(NSString *)urlString
//{
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]]; 
//    request.timeOutSeconds = TIME_OUT; 
//    [request setDefaultResponseEncoding:NSUTF8StringEncoding];   
//    [request addRequestHeader:@"Content-Type" value:@"application/json"];
//    [request startSynchronous];
//    NSError *error = [request error];
//    NSLog(@"网址：%@ ",urlString);
//    if (!error) {
//       // NSLog(@"返回值：%@ ",[request responseString]);
//    }
//    else
//    {
//        NSLog(@"提交失败,%@",[error localizedDescription]);
//    }    
//    return [request responseData];
//}
//
//+(BOOL)isNetwork
//{
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//    [request startSynchronous];
//    NSError *error = [request error];
//    if (!error) {
//        return YES;
//    }
//    else
//        return NO;
//}
//
////将url编码
//+(NSString *)encodeUrl:(NSString *)url
//{
//    NSLog(@"url:%@",url);
//    return (NSString *)CFURLCreateStringByAddingPercentEscapes(    NULL,    (CFStringRef)url,    NULL,    (CFStringRef)@"!*'();:@&=+$,/?%#[]",    kCFStringEncodingUTF8 );
//}
//@end
