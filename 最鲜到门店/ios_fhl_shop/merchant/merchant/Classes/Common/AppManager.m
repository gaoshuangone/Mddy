//
//  AppManager.m
//  FHL
//
//  Created by panume on 14-9-26.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "AppManager.h"
#import <CommonCrypto/CommonDigest.h>


@implementation AppManager


+ (NSString *)md5:(NSString *)str
{
    
    if((nil == str) || ([str isEqualToString:@""]))
    {
        return nil;
    }
    const char *cStr = [str UTF8String];
    
    unsigned char result[16];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
//    FLDDLogDebug("result:%s,lenght:%lu", result, strlen((char *)result));
    
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0],result[1],result[2],result[3],
            
            result[4],result[5],result[6],result[7],
            
            result[8],result[9],result[10],result[11],
            
            result[12],result[13],result[14],result[15]];
}

+ (void)setUserDefaultsValue:(id)value key:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (NSString *)valueForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+(BOOL) isValidateMobile:(NSString *)mobile
{
//    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
//    if ([mobile toString].length<=3) {
//        return NO;
//    }
//    if ([[mobile substringToIndex:2] isEqualToString:@"17"]) {
//        return YES;
//    }
//    //手机号以13， 15，18开头，八个 \d 数字字符
//    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
//    return [phoneTest evaluateWithObject:mobile];
     mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *phoneRegex = @"^[1][3,4,5,7,8][0-9]{9}$";

    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)isChinese:(NSString *)string
{
    const char *str = [string UTF8String];
    if (strlen(str) == 3) {
        return YES;
    }
    return NO;
}

//写文件
+ (void)writeToDocumentWithImageData:(NSData *)data name:(NSString *)fileName
{
    NSString *path = [self filePath:fileName];
    
    [data writeToFile:path atomically:YES];
}

//读取文件
+ (NSData *)readDataFromDocumentWithName:(NSString *)fileName
{
    NSString *path = [self filePath:fileName];
    
    return [NSData dataWithContentsOfFile:path];
}
//获取文件路径
+ (NSString*)filePath:(NSString*)fileName {
    NSArray* myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* myDocPath = [myPaths objectAtIndex:0];
    NSString* filePath = [myDocPath stringByAppendingPathComponent:fileName];
    return filePath;
}

+ (NSString *)dateStringWithFormatter:(NSString *)formatter timeInterval:(NSTimeInterval)timeInterval
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:formatter];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *result = [dateFormatter stringFromDate:date];
    return result;
    
}

+ (void)addLocalNotificationWithTimeInterval:(NSTimeInterval)timeInterval orderId:(NSString *)orderId content:(NSString *)alertBody
{
//    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//    
//    if (localNotification) {
//        //时区
//        localNotification.timeZone=[NSTimeZone defaultTimeZone];
//        //推送事件---15 * 60秒后
//        localNotification.fireDate=[[NSDate date] dateByAddingTimeInterval:timeInterval];
//        //推送内容
//        localNotification.alertBody = alertBody;
//        
//
//        //应用右上角红色图标数字
//        localNotification.applicationIconBadgeNumber = 1;
//        //            注：
//        //1:格式一定要支持播放，常用的格式caf
//        //2:音频播放时间不能大于30秒
//        //3:在Resource里要找到音频文件，倒入时最好能点项目名称右键add导入
//        //            _localNotification.soundName = @"jingBao2.caf";
//        //设置按钮
//        localNotification.alertAction = @"关闭";
//        //判断重复与否
//        localNotification.repeatInterval = 0;
//        //存入的字典，用于传入数据，区分多个通知
//        NSMutableDictionary *dicUserInfo = [[NSMutableDictionary alloc] init];
//        [dicUserInfo setValue:orderId forKey:@"orderId"];
//        
//        localNotification.userInfo = [NSDictionary dictionaryWithObject:dicUserInfo forKey:@"orderInfo"];
//        
//        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//    }
}

+ (void)setUserBoolValue:(BOOL)value key:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)boolValueForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+ (BOOL)isPasswordValid:(NSString *)password
{
    
    NSCharacterSet *alphaSet = [NSCharacterSet alphanumericCharacterSet];
    BOOL valid = [[password stringByTrimmingCharactersInSet:alphaSet] isEqualToString:@""];
    
    return valid;
//    NSString *regex=@"^[A-Za-z0-9]+$";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    if (![predicate evaluateWithObject:password]) {
//        return YES;
//    }
//    return NO;
}
@end
