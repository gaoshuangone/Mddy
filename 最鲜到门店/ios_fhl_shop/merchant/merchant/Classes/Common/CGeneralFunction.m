//
//  CGeneralFunction.m
//  FHL
//
//  Created by 郏国上 on 14-10-11.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "CGeneralFunction.h"
#import "Config.h"
#import <CommonCrypto/CommonDigest.h>
#import "sys/utsname.h"
#import "CAnalyzeResult.h"
@implementation CGeneralFunction

///*****************************************************************************
// 函数:      (instancetype)shareFun
// 描述:      产生通用函数对象实例
// 调用:
// 被调用:
// 返回值类型:
// 其它:
// ******************************************************************************/
//+ (instancetype)shareFun
//{
//    static CGeneralFunction *shareFun = nil;
//    static dispatch_once_t onceToken;
//    
//    dispatch_once(&onceToken, ^{
//        shareFun = [self alloc];
//    });
//    return shareFun;
//}



/*****************************************************************************
 函数:  (NSString *)switchNSStringValue : (NSString *)key : (NSUInteger)startIndex : (NSUInteger)endIndex
 描述:  交换字符串中指定两个以0开始编号的位置的字符
 调用:  无
 被调用: (NSString *)getEncodeConfusionKey : (NSString *)key
 返回值: 成功返回字符串，失败返回nil
 其它: 无
 ******************************************************************************/
+ (NSString *)switchNSStringValue : (NSString *)key : (NSUInteger)startIndex : (NSUInteger)endIndex
{
    if(startIndex > endIndex)
    {
        NSUInteger n = startIndex;
        startIndex = endIndex;
        endIndex = n;
    }
    else if(startIndex == endIndex)
    {
        return key;
    }
    
    if(([key length] < 2) || (endIndex > [key length] - 1))
    {
        return nil;
    }
    
    char c, cc;
    
    NSRange range;
    NSString *first = nil;
    NSString *front = nil;
    NSString *back = nil;
    
    c = [key characterAtIndex:startIndex];
    cc = [key characterAtIndex:endIndex];
    if(startIndex > 0)
    {
        range = NSMakeRange(0, startIndex);
        first = [key substringWithRange:range];
    }
    
    range = NSMakeRange(startIndex + 1, endIndex - 1 - startIndex);
    front = [key substringWithRange:range];
    range = NSMakeRange(endIndex + 1, 32 - 1 - endIndex);
    back = [key substringWithRange:range];
    if(nil != first)
    {
        back = [NSString stringWithFormat:@"%@%c%@%c%@", first, cc, front, c, back];
    }
    else
    {
        back = [NSString stringWithFormat:@"%c%@%c%@", cc, front, c, back];
    }
    
    return back;
}

/*****************************************************************************
 函数:  (NSString *)getEncodeConfusionKey : (NSString *)key
 描述:  对发送key字符串进行混淆加密
 调用:  (NSString *)switchNSStringValue : (NSString *)key : (NSUInteger)startIndex : (NSUInteger)endIndex
 被调用: (NSString *)getEncodeKey : (NSString *)phoneId : (NSString *)cmdCode : (NSString *)visitTime
 返回值: 成功返回字符串，失败返回nil
 其它: 规则 ：[0,15],[3,18],[5,12],[6,30],[11,20],[17,25]
 ******************************************************************************/
+ (NSString *)getEncodeConfusionKey : (NSString *)key
{
    if((key == nil) || ([key length] != 32))
    {
        return nil;
    }
    
    
    //    char *key_char = (char *)[key UTF8String];
    //    char c;
    //    c = key_char[0];
    //    key_char[0] = key_char[15];
    //    key_char[15] = c;
    //    c = key_char[3];
    //    key_char[3] = key_char[18];
    //    key_char[18] = c;
    //    c = key_char[5];
    //    key_char[5] = key_char[12];
    //    key_char[12] = c;
    //    c = key_char[6];
    //    key_char[6] = key_char[30];
    //    key_char[30] = c;
    //    c = key_char[11];
    //    key_char[11] = key_char[20];
    //    key_char[20] = c;
    //    c = key_char[17];
    //    key_char[17] = key_char[25];
    //    key_char[25] = c;
    //    return [NSString stringWithFormat:@"%s", key_char];
    
    NSString *src = key;
    
    src = [self switchNSStringValue : src : 0 : 15];
    src = [self switchNSStringValue : src : 3 : 18];
    src = [self switchNSStringValue : src : 5 : 12];
    src = [self switchNSStringValue : src : 6 : 30];
    src = [self switchNSStringValue : src : 11 : 20];
    src = [self switchNSStringValue : src : 17 : 25];
    //    FLDDLogVerbose(@"key = %@, src = %@, length = %lu", key, src, (unsigned long)key.length);
    return src;
}

/*****************************************************************************
 函数:      (NSString *)getEncodeKey : (NSString *)phoneId : (NSString *)cmdCode : (NSString *)visitTime
 描述:      产生客户端加密key
 调用:      无
 被调用:
  返回值: 成功返回字符串，失败返回nil
 其它:
 ******************************************************************************/
+ (NSString *)getEncodeKey:(NSString *)phoneId cmdCode:(NSString *)cmdCode time:(NSString *)visitTime
{
    if((nil == cmdCode) || ([cmdCode isEqualToString:@""]) || (nil == visitTime) || ([visitTime isEqualToString:@""]))
    {
        return nil;
    }
    
    NSString *key = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@%@", g_softkey1, phoneId, cmdCode, visitTime]];
    if((nil == key) || ([key isEqualToString:@""]))
    {
        return nil;
    }
    NSString *softKey = MD5(key);
    
    return [self getEncodeConfusionKey:softKey];
}

/*****************************************************************************
 函数:      (NSMutableDictionary *)getGetModeParamsHeadList : (NSString *)cmdCode
 描述:      生成消息头列表
 调用:
 被调用:
 返回值: 成功返回字符串，失败返回nil
 其它:
 ******************************************************************************/
+ (NSMutableDictionary *)getGetModeParamsHeadList : (NSString *)cmdCode
{
    NSDate *curDate = [NSDate date];
    NSTimeInterval startTime =[curDate timeIntervalSince1970]*1;
    NSString *visitTime = [NSString stringWithFormat:@"%ld",(long)startTime];
    NSMutableDictionary *paramsList = [NSMutableDictionary dictionary];
    
    NSString *phoneId = [AppManager valueForKey:@"phoneId"];
    
    NSString *key = [self getEncodeKey:phoneId cmdCode:cmdCode time:visitTime];
    if(key == nil)
    {
        return nil;
    }
    //   FLDDLogDebug("加密得到的key＝%@", key);
    //    LogDebug("加密得到的key＝%@", key)
    
    //添加字典
    [paramsList setObject:key forKey:@"key"];
    [paramsList setObject:phoneId forKey:@"phoneId"];
    [paramsList setObject:visitTime forKey:@"visitTime"];
    
    return  paramsList;
}

+ (NSMutableDictionary *)getGetModeParamsHeadListWithNewPasswd2:(NSString *)newPasswd oldPasswd:(NSString*)oldPasswd cmdCode:(NSString *)cmdCode
{
    NSDate *curDate = [NSDate date];
    NSTimeInterval startTime =[curDate timeIntervalSince1970]*1;
    NSString *visitTime = [NSString stringWithFormat:@"%ld",(long)startTime];
    NSMutableDictionary *paramsList = [NSMutableDictionary dictionary];
    
    NSString *phoneId = [AppManager valueForKey:@"phoneId"];
    
    NSString *key = [self getEncodeKey:phoneId cmdCode:cmdCode time:visitTime];
    //     FLDDLogDebug(@"有验证码时需要拼接时加密前的phoneID＝%@ cmdCode＝%@,visitTime = %@",phoneId,cmdCode,visitTime);
    if(key == nil)
    {
        return nil;
    }
    
    
    //    NSString *passwdEncode = [self passwordGetDecodeConfusionKey:passwd];//混淆
    //    FLDDLogDebug(@"passwdencode:%@", passwdEncode);
//    NSString *passwdEncode = [passwd stringByAppendingString:visitTime];//
//    
//    passwdEncode = MD5(passwdEncode);
//    
//    passwdEncode = [self passwordGetEecodeConfusionKey:passwdEncode];
    
    //    FLDDLogDebug(@"混淆后的密码after passwd:%@",passwdEncode);
    //添加字典
    [paramsList setObject:key forKey:@"key"];
    [paramsList setObject:phoneId forKey:@"phoneId"];
    [paramsList setObject:visitTime forKey:@"visitTime"];
    [paramsList setObject:newPasswd forKey:@"newPassword"];
     [paramsList setObject:oldPasswd forKey:@"oldPassword"];
    
    return  paramsList;
}

+ (NSMutableDictionary *)getGetModeParamsHeadListWithPasswd:(NSString *)passwd cmdCode:(NSString *)cmdCode
{
  __autoreleasing  NSDate *curDate = [NSDate date];
  NSTimeInterval startTime =[curDate timeIntervalSince1970]*1;
 __autoreleasing   NSString *visitTime = [NSString stringWithFormat:@"%ld",(long)startTime];
__autoreleasing    NSMutableDictionary *paramsList = [NSMutableDictionary dictionary];
    
 __autoreleasing   NSString *phoneId = [AppManager valueForKey:@"phoneId"];
    
    NSString *key = [self getEncodeKey:phoneId cmdCode:cmdCode time:visitTime];
//     FLDDLogDebug(@"有验证码时需要拼接时加密前的phoneID＝%@ cmdCode＝%@,visitTime = %@",phoneId,cmdCode,visitTime);
    if(key == nil)
    {
        return nil;
    }
    
 
//    NSString *passwdEncode = [self passwordGetDecodeConfusionKey:passwd];//混淆
//    FLDDLogDebug(@"passwdencode:%@", passwdEncode);
    NSString *passwdEncode = [passwd stringByAppendingString:visitTime];//
    
    passwdEncode = MD5(passwdEncode);
    
    passwdEncode = [self passwordGetEecodeConfusionKey:passwdEncode];
    
//    FLDDLogDebug(@"混淆后的密码after passwd:%@",passwdEncode);
    //添加字典
    [paramsList setObject:key forKey:@"key"];
    [paramsList setObject:phoneId forKey:@"phoneId"];
    [paramsList setObject:visitTime forKey:@"visitTime"];
    [paramsList setObject:passwdEncode forKey:@"passwd"];
    
    return  paramsList;
}
+ (NSMutableDictionary *)getGetModeParamsHeadListWithPasswd1:(NSString *)passwd cmdCode:(NSString *)cmdCode
{
  __autoreleasing  NSDate *curDate = [NSDate date];
    NSTimeInterval startTime =[curDate timeIntervalSince1970]*1;
 __autoreleasing   NSString *visitTime = [NSString stringWithFormat:@"%ld",(long)startTime];
 __autoreleasing   NSMutableDictionary *paramsList = [NSMutableDictionary dictionary];
    
    NSString *phoneId = [AppManager valueForKey:@"phoneId"];
    
    NSString *key = [self getEncodeKey:phoneId cmdCode:cmdCode time:visitTime];
    //     FLDDLogDebug(@"有验证码时需要拼接时加密前的phoneID＝%@ cmdCode＝%@,visitTime = %@",phoneId,cmdCode,visitTime);
    if(key == nil)
    {
        return nil;
    }
    
    
    //    NSString *passwdEncode = [self passwordGetDecodeConfusionKey:passwd];//混淆
    //    FLDDLogDebug(@"passwdencode:%@", passwdEncode);
    NSString *passwdEncode = [passwd stringByAppendingString:visitTime];//
    
    passwdEncode = MD5(passwdEncode);
    
    passwdEncode = [self passwordGetEecodeConfusionKey:passwdEncode];
    
    //    FLDDLogDebug(@"混淆后的密码after passwd:%@",passwdEncode);
    //添加字典
    [paramsList setObject:key forKey:@"key"];
    [paramsList setObject:phoneId forKey:@"phoneId"];
    [paramsList setObject:visitTime forKey:@"visitTime"];
    [paramsList setObject:passwdEncode forKey:@"identifyingCode"];
    
    return  paramsList;
}

/*****************************************************************************
 函数:      (NSString *)getDecodeConfusionKey : (NSString *)key
 描述:      产生的服务端key字符串混淆加密算法
 调用:      无
 被调用:    (NSString *)getDecodeKey : (NSString *)phoneId : (NSString *)cmdCode : (NSString *)visitTime
 返回值: 成功返回字符串，失败返回nil
 其它: rule：[5,16],[6,17],[9,19],[13,28],[15,21],[18,29]
 ******************************************************************************/
+ (NSString *)getDecodeConfusionKey : (NSString *)key
{
//    FLDDLogDebug("key:%@,lenght%d", key, [key length]);
    if((key == nil) || ([key length] != 32))
    {
        return nil;
    }
    char *key_char = (char *)[key UTF8String];
    char c;
    c = key_char[5];
    key_char[5] = key_char[16];
    key_char[16] = c;
    c = key_char[6];
    key_char[6] = key_char[17];
    key_char[17] = c;
    c = key_char[9];
    key_char[9] = key_char[19];
    key_char[19] = c;
    c = key_char[13];
    key_char[13] = key_char[28];
    key_char[28] = c;
    c = key_char[15];
    key_char[15] = key_char[21];
    key_char[21] = c;
    c = key_char[18];
    key_char[18] = key_char[29];
    key_char[29] = c;
    return [[NSString alloc] initWithString:[NSString stringWithFormat:@"%s", key_char]];
    
}


//密码混淆  rule：[1,16],[3,20,[4,12],[6,20],[11,23],[15,18]
+ (NSString *)passwordGetDecodeConfusionKey : (NSString *)key
{
    //    FLDDLogDebug("key:%@,lenght%d", key, [key length]);
    if((key == nil) || ([key length] != 32))
    {
        return nil;
    }
    char *key_char = (char *)[key UTF8String];
    char c;
    c = key_char[1];
    key_char[1] = key_char[16];
    key_char[16] = c;
    c = key_char[3];
    key_char[3] = key_char[20];
    key_char[20] = c;
    c = key_char[4];
    key_char[4] = key_char[12];
    key_char[12] = c;
    c = key_char[6];
    key_char[6] = key_char[20];
    key_char[20] = c;
    c = key_char[11];
    key_char[11] = key_char[23];
    key_char[23] = c;
    c = key_char[15];
    key_char[15] = key_char[18];
    key_char[18] = c;
    return [[NSString alloc] initWithString:[NSString stringWithFormat:@"%s", key_char]];
    
}

//密码混淆 [0,15],[6,23],[7,14],[9,26],[11,12],[15,18],[25,28]
+ (NSString *)passwordGetEecodeConfusionKey : (NSString *)key
{
    //    FLDDLogDebug("key:%@,lenght%d", key, [key length]);
    if((key == nil) || ([key length] != 32))
    {
        return nil;
    }
    char *key_char = (char *)[key UTF8String];
    char c;
    c = key_char[0];
    key_char[0] = key_char[15];
    key_char[15] = c;
    c = key_char[6];
    key_char[6] = key_char[23];
    key_char[23] = c;
    c = key_char[7];
    key_char[7] = key_char[14];
    key_char[14] = c;
    c = key_char[9];
    key_char[9] = key_char[26];
    key_char[26] = c;
    c = key_char[11];
    key_char[11] = key_char[12];
    key_char[12] = c;
    c = key_char[15];
    key_char[15] = key_char[18];
    key_char[18] = c;
    c = key_char[25];
    key_char[25] = key_char[28];
    key_char[28] = c;
    return [[NSString alloc] initWithString:[NSString stringWithFormat:@"%s", key_char]];
    
}

/*****************************************************************************
 函数:   (NSString *)getDecodeKey : (NSString *)phoneId : (NSString *)cmdCode : (NSString *)visitTime
 描述:   产生服务器加密key
 调用:   无
 被调用:
 返回值: 成功返回字符串，失败返回nil
 其它:
 ******************************************************************************/
+ (NSString *)getDecodeKey : (NSString *)phoneId : (NSString *)cmdCode : (NSString *)visitTime
{
    if((nil == cmdCode) || ([cmdCode isEqualToString:@""]) || (nil == visitTime)
       || ([visitTime isEqualToString:@""]) || (nil == phoneId) || ([phoneId isEqualToString:@""]))
    {
        return nil;
    }
    
    NSString *key = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@%@", g_softkey2, phoneId, cmdCode, visitTime]];
    if((nil == key) || ([key isEqualToString:@""]))
    {
        return nil;
    }
//    FLDDLogDebug("key:%@,lenght%d", key, [key length]);
    NSString *softKey =  MD5(key);
//    FLDDLogDebug("softKey:%@,lenght:%d", softKey, [softKey length]);
    FLDDLogDebug("softKey:%@", softKey);
    //FLDDLogDebug("key:%@", [self getConfusionKey:softKey]);
    return [self getDecodeConfusionKey:softKey];
}

/*****************************************************************************
 函数:   (CAnalyzeResult *)analyzeHead:(NSDictionary *)head
 描述:    解析服务器响应消息头
 调用:   无
 被调用:
 返回值: 解析成功返回字符串，失败返回nil
 其它:
 ******************************************************************************/
+ (CAnalyzeResult *)analyzeHead:(NSDictionary *)head
{
    CAnalyzeResult *analyzeResult = [[CAnalyzeResult alloc] init];
    NSString *result = [NSString stringWithFormat:@"%@",[head objectForKey:@"result"]];
    if(result == nil)
    {
        return nil;
    }
    if(![result isEqualToString:@"1"])
    {
        NSString *message = [NSString stringWithFormat:@"%@",[head objectForKey:@"message"]];
        if(message != nil)
        {
//            [SVProgressHUD showErrorWithStatus:message];
            [MBProgressHUD hudShowWithStatus:self :message];
            return nil;
        }
        return nil;
    }
    else
    {
        NSString *message = [NSString stringWithFormat:@"%@",[head objectForKey:@"message"]];
        if(message != nil)
        {
            //analyzeResult.message = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@", message]];
            //[analyzeResult setMessage:message];
            analyzeResult.message = message;
        }
        else
        {
            analyzeResult.message = nil;
        }
        
    }
    analyzeResult.result = YES;
    
    
    NSString *visitTime  = [NSString stringWithFormat:@"%@",[head objectForKey:@"visitTime"]];
    if(visitTime == nil)
    {
        return nil;
    }
    visitTime = [visitTime stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([visitTime isEqualToString:@""])
    {
        return nil;
    }
    
    NSString *phoneId  = [NSString stringWithFormat:@"%@",[head objectForKey:@"phoneId"]];
    if(phoneId == nil)
    {
        return nil;
    }
    phoneId = [visitTime stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([phoneId isEqualToString:@""])
    {
        return nil;
    }
    
    NSDate *curDate = [NSDate date];
    //FLDDLogDebug("curDate:%@", curDate);
    NSTimeInterval nowTime =[curDate timeIntervalSince1970]*1;
    long  nowTimeValue = (long)nowTime;
    long  visitTimeValue = (long)[visitTime floatValue];
    //发送请求的时间大于收到响应的时间或收到响应的时间比发送请求的时间超过最大允许时间
    if((nowTimeValue < visitTimeValue) || (nowTimeValue - visitTimeValue >= g_maxRespondTime))
    {
        return nil;
    }
    
    NSString *resultKey   = [NSString stringWithFormat:@"%@",[head objectForKey:@"resultKey"]];
    if(resultKey == nil)
    {
        return nil;
    }
    resultKey = [resultKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([resultKey isEqualToString:@""])
    {
        return nil;
    }
    
    NSString *cmdCode = [NSString stringWithFormat:@"%@",[head objectForKey:@"cmdCode"]];
    if(cmdCode == nil)
    {
        return nil;
    }
    cmdCode = [cmdCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([cmdCode isEqualToString:@""])
    {
        return nil;
    }
    
    
    NSString *key = [self getDecodeKey : phoneId : cmdCode : visitTime];
    if((key == nil) || ([resultKey isEqualToString:key]))
    {
        return nil;
    }
    analyzeResult.cmdCode = cmdCode;
    return analyzeResult;
}


/*****************************************************************************
 函数:   (Boolean)checkTelFormat : (NSString *)string
 描述:   检查字符串是否为指定的格式
 调用:
 被调用: ((NSString *)getTextFieldStr : (NSString *)string : (NSString *)textFieldValue
 返回值: 是指定格式返回真，否则为假
 其它:   调用者保证字符串为空的情况，减少重复检查参数
 ******************************************************************************/
+ (Boolean)checkTelFormat : (NSString *)string
{
    char *tel_char = (char *)[string UTF8String];
    NSInteger i;
    i = strlen(tel_char);
    if(i >= 9)
    {
        if((tel_char[3] != ' ') || (tel_char[8] != ' '))
        {
            return NO;
        }
        
    }
    if(i >= 4)
    {
        if(tel_char[3] != ' ')
        {
            return NO;
        }
        
    }
    
    if(i == 3)
    {
        return NO;
    }
    else if(i == 8)
    {
        return NO;
    }
    
    return YES;
    
}


/*****************************************************************************
 函数:   (NSString *)getCorrectTelStr : (NSString *)string
 描述:   字符串格式化处理
 调用:
 被调用: ((NSString *)getTextFieldStr : (NSString *)string : (NSString *)textFieldValue
 返回值:
 其它:   调用者保证字符串为空的情况，减少重复检查参数
 ******************************************************************************/
+ (NSString *)getCorrectTelStr : (NSString *)string
{
    //多一个字符位为了保证能放下增加空格的字符串
    NSString *str = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%@", string, @"1"]];
    char *tel_char = (char *)[str UTF8String];
    char *newTel_char = (char *)[string UTF8String];
    char c;
    NSInteger i, j, len;
    memset(newTel_char, 0, strlen(newTel_char));
    len = strlen(tel_char);
    
    j = 0;
    for(i = 0; i < len - 1; i++)
    {
        c = tel_char[i];
        if(c != ' ')
        {
            newTel_char[j++] = c;
        }
        
    }
    
    memset(tel_char, 0, len);
    j = 0;
    for(i = 0; i < strlen(newTel_char); i++)
    {
        c = newTel_char[i];
        tel_char[j++] = c;
        
        if((i == 2) || (i == 6))
        {
            tel_char[j++] = ' ';
        }
    }
    
    
    return [[NSString alloc] initWithString:[NSString stringWithFormat:@"%s", tel_char]];
    
}

/*****************************************************************************
 函数:   (NSString *)getTextFieldStr : (NSString *)string : (NSString *)textFieldValue
 描述:   字符串拼接，判断字符串是否为指定格式，字符串格式化
 调用:   (Boolean)checkTelFormat1 : (NSString *)string,
 (NSString *)getCorrectTelStr : (NSString *)string
 被调用: (BOOL)textField:(UITextField *)textField
 shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 返回值:
 其它:
 ******************************************************************************/
+ (NSString *)getTextFieldStr : (NSString *)string : (NSString *)textFieldValue
{
    char *tel_char = (char *)[string UTF8String];
    char *textFieldValue_char = (char *)[textFieldValue UTF8String];
    NSString *resultStr = nil;
    NSInteger len1, len2;
    len1 = strlen(textFieldValue_char);
    len2 = strlen(tel_char);
    if((len1 == 0) && (len2 == 1))
    {
        return string;
    }
    if((len1 == 1) && (len2 == 0))
    {
        return @"";
    }
    else if((textFieldValue_char[len1 - 1] == ' ') && (tel_char[len2 - 1] != ' ') && (len1 > len2) && (len1 != len2 + 2))
    {
        tel_char[len2 - 1] = '\0';
        return [[NSString alloc] initWithString:[NSString stringWithFormat:@"%s", tel_char]];
    }
    
    
    if((string == nil) || ([string isEqualToString:@""]))
    {
        return @"";
    }
    
    if([self checkTelFormat:string])
    {
        return string;
    }
    
    
    resultStr = [self getCorrectTelStr:string];
    return resultStr;
    
}

/*****************************************************************************
 函数:   (NSString *)getNewStr : (NSString *)string : (NSString *)textFieldValue : (NSInteger)index
 描述:   中间增加字符处理
 调用:
 被调用: (BOOL)textField:(UITextField *)textField
 shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
 返回值:
 其它:
 ******************************************************************************/
+ (NSString *)getNewStr : (NSString *)string : (NSString *)textFieldValue : (NSInteger)index
{
    if((string == nil) || (textFieldValue == nil) || (index < 0) || (index > [textFieldValue length]))
    {
        return nil;
    }
    
    
    char c;
    NSInteger i, j;
    NSString *str = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%@", textFieldValue, @"1"]];
    char *tel_char = (char *)[str UTF8String];
    char *new_char = (char *)[string UTF8String];
    char *textFieldValue_char = (char *)[textFieldValue UTF8String];
    NSInteger len1, len2;
    len1 = strlen(textFieldValue_char);
    len2 = strlen(tel_char);
    if((len1 == 0) && (len2 == 0))
    {
        return string;
    }
    
    memset(tel_char, 0, len2);
    
    j = 0;
    for(i = 0; i < len1; i++)
    {
        if(i == index)
        {
            tel_char[j++] = new_char[0];
        }
        c = textFieldValue_char[i];
        tel_char[j++] = c;
    }
    
    return [[NSString alloc] initWithString:[NSString stringWithFormat:@"%s", tel_char]];
}

/*****************************************************************************
 函数:   (BOOL)checkNewStrLength : (NSString *)string : (NSString *)textFieldValue
 描述:   检查复制的字符串和文本种的字符串拼接在一起的字符串已经超过了最大手机号长度字符串13
 调用:
 被调用:
 返回值:
 其它:
 ******************************************************************************/
+ (BOOL)checkNewStrLength : (NSString *)string : (NSString *)textFieldValue
{
    long i, j, m, n;
    m = [string length];
    if(m > 13)
    {
        return NO;
    }
    
    n =[textFieldValue length];
    if(m + n > 13)
    {
        return NO;
    }
    j = 0;
    char *tel_char = (char *)[string UTF8String];
    for(i = 0; i < m; i++)
    {
        if(tel_char[i] == ' ')
        {
            j++;
        }
    }
    
    if(j > 2)
    {
        return NO;
    }
    
    
    if(n > 0)
    {
        char *textFieldValue_char = (char *)[textFieldValue UTF8String];
        for(i = 0; i < n; i++)
        {
            if(textFieldValue_char[i] == ' ')
            {
                j++;
            }
        }
        
        if(j > 2)
        {
            return NO;
        }
        else if(m + (2 - j) + n > 13)
        {
            return NO;
        }
        
    }
    
    
    return YES;
}



+ (BOOL)inputTelephone : (UITextField *)textField : (NSRange)range : (NSString *)string
{
    if((string.length == 1)&& (range.length == 0))
    {
        if(textField.text.length <= 1)
        {
            return YES;
        }
        else if((textField.text.length >= 4) && (textField.text.length <= 6) &&  (range.location >= 4) && (range.location <= 6))
        {
            return YES;
        }
        else if((textField.text.length >= 9) && (textField.text.length <= 12) &&  (range.location >= 9) && (range.location <= 11))
        {
            return YES;
        }
    }
    else if((string.length == 0)&& (range.length == 1))
    {
        if(textField.text.length <= 2)
        {
            return YES;
        }
        else if((textField.text.length >= 5) && (textField.text.length <= 7) &&  (range.location >= 4) && (range.location <= 6))
        {
            return YES;
        }
        else if((textField.text.length >= 10) && (textField.text.length <= 13) &&  (range.location >= 9) && (range.location <= 12))
        {
            return YES;
        }
        
    }
    
    //文本内容的长度限制
    if((range.location > 12) || (([textField.text length] >= 13) && (![string isEqualToString:@""])))
    {
        
        return NO;
    }
    
    else
    {
        //限制粘贴成的字符串超过手机号的长度
        if ((string != nil) && (![string isEqualToString:@""]))
        {
            if(![self checkNewStrLength:string :textField.text])
            {
                return NO;
            }
        }
        
        NSString *newStr = @"";
        if(![string isEqualToString:@""])  //增加字符操作时
        {
            //判断是否是在尾部增加
            if([textField.text length] == range.location)
            {
                //判断是否是输入的第一个字符
                if(textField.text != nil)
                {
                    //组装非格式的字符串
                    newStr = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%@", textField.text, string]];
                }
                else
                {
                    newStr = string;
                }
            }
            else
            {
                //中间增加字符处理
                newStr = [self getNewStr:string:textField.text:(range.location)];
                if(newStr == nil)
                {
                    return NO;
                }
                
            }
            
        }
        else //删除字符操作时
        {
            NSUInteger len = [textField.text length];
            //当只有一个字符，采用系统文本框删除处理
            if(len == 1)
            {
                return YES;
            }
            char *tel_char = (char *)[textField.text UTF8String];
            char *textFieldValue_char = (char *)[textField.text UTF8String];
            NSInteger i, j, k;
            memset(tel_char, 0, len);
            j = 0;
            k = range.location;
            //当是删除空格时连带删除前面的字符
            if(k == 3)
            {
                textFieldValue_char[3] = '\0';
                textFieldValue_char[2] = '\0';
            }
            else if(k == 8)
            {
                textFieldValue_char[8] = '\0';
                textFieldValue_char[7] = '\0';
            }
            //删除对应的字符，并生成新的非格式化的字符串
            for(i = 0; i < len; i++)
            {
                if((i != k) && (textFieldValue_char[i] != '\0'))
                {
                    tel_char[j++] = textFieldValue_char[i];
                }
            }
            
            newStr = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%s", tel_char]];
        }
        
        //字符串格式化
        string = [self getTextFieldStr : newStr : textField.text];
        textField.text = string;
        //            FLDDLogDebug("text value string: %@", string);
        return NO;
    }
}


@end
