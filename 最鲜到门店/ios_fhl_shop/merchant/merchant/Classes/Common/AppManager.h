//
//  AppManager.h
//  FHL
//
//  Created by panume on 14-9-26.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppManager : NSObject

+ (NSString *)md5:(NSString *)str;

+ (void)setUserDefaultsValue:(id)value key:(NSString *)key;

+ (NSString *)valueForKey:(NSString *)key;


+(BOOL) isValidateMobile:(NSString *)mobile;

+ (BOOL)isChinese:(NSString *)string;

+ (void)writeToDocumentWithImageData:(NSData *)data name:(NSString *)fileName;

+ (NSData *)readDataFromDocumentWithName:(NSString *)fileName;

+ (NSString*)filePath:(NSString*)fileName;

+ (NSString *)dateStringWithFormatter:(NSString *)formatter timeInterval:(NSTimeInterval)timeInterval;

+ (void)addLocalNotificationWithTimeInterval:(NSTimeInterval)timeInterval orderId:(NSString *)orderId content:(NSString *)alertBody;
+ (void)setUserBoolValue:(BOOL)value key:(NSString *)key;
+ (BOOL)boolValueForKey:(NSString *)key;


+ (BOOL)isPasswordValid:(NSString *)password;

@end
