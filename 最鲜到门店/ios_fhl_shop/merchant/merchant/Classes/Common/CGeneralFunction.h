//
//  CGeneralFunction.h
//  FHL
//
//  Created by 郏国上 on 14-10-11.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CAnalyzeResult.h"

@interface CGeneralFunction : NSObject

//+ (NSString *)getEncodeKey : (NSString *)phoneId : (NSString *)cmdCode : (NSString *)visitTime;
+ (NSMutableDictionary *)getGetModeParamsHeadList : (NSString *)cmdCode;
+ (NSMutableDictionary *)getGetModeParamsHeadListWithPasswd:(NSString *)passwd cmdCode:(NSString *)cmdCode;


+ (NSMutableDictionary *)getGetModeParamsHeadListWithPasswd1:(NSString *)passwd cmdCode:(NSString *)cmdCode;
+ (NSMutableDictionary *)getGetModeParamsHeadListWithNewPasswd2:(NSString *)newPasswd oldPasswd:(NSString*)oldPasswd cmdCode:(NSString *)cmdCode;

+ (NSString *)passwordGetDecodeConfusionKey : (NSString *)key;

+ (CAnalyzeResult *)analyzeHead:(NSDictionary *)head;

+ (Boolean)checkTelFormat : (NSString *)string;
+ (NSString *)getCorrectTelStr : (NSString *)string;
+ (NSString *)getTextFieldStr : (NSString *)string : (NSString *)textFieldValue;
+ (NSString *)getNewStr : (NSString *)string : (NSString *)textFieldValue : (NSInteger)index;
+ (BOOL)checkNewStrLength : (NSString *)string : (NSString *)textFieldValue;

+ (BOOL)inputTelephone : (UITextField *)textField : (NSRange)range : (NSString *)string;

+ (NSString *)getEncodeConfusionKey : (NSString *)key;
+ (NSString *)switchNSStringValue : (NSString *)key : (NSUInteger)startIndex : (NSUInteger)endIndex;
@end
