 //
//  User.m
//  FHL
//
//  Created by panume on 14-9-25.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "User.h"

@implementation User

+ (instancetype)currentUser
{
    static User *currentUser = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        currentUser = [[User alloc] init];
    });
    return currentUser;
}


+ (void)reLoginWithFixedPasswordJsonPhone:(NSDictionary *)params block:(void (^)(NSError *))block{//固定密码重新登录
    
  __autoreleasing  NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    [muParams setObject:g_reloginCmd forKey:@"cmdCode"];
    FLDDLogDebug(@"reLoginWithFixedPasswordJsonPhone:cookie = %@", [AppManager valueForKey:@"cookie"]);
    
//    [[API shareAPI] GET:@"reLoginWithFixedPasswordJsonPhone.htm" params:muParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
         [[API shareAPI] GET:@"reLoginJsonPhone.htm" params:muParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
//             //模拟自动登录超时
//             [SelfUser currentSelfUser].ErrorMessage = @"dfdsf";
//             [SelfUser currentSelfUser].isNoNetFlag = YES;
//             block([[NSError alloc] initWithDomain:@"JW_ERROR_DOMAIN" code:-100 userInfo:@{NSLocalizedDescriptionKey : @"errorDes"}]);
//             return ;
             
        NSString *cookie = [operation.response.allHeaderFields objectForKey:@"Set-Cookie"];//保存Cookie（仅登录成功后保存）
        [AppManager setUserDefaultsValue:cookie key:@"cookie"];
        FLDDLogDebug(@"reLoginWithFixedPasswordJsonPhone:cookie = %@", [AppManager valueForKey:@"cookie"]);
        NSDictionary *responseBody = [responseObject objectForKey:@"body"];
        [SelfUser currentSelfUser].Clerktype = [[responseBody  valueForKey:@"clerkType"] toString];
        [User currentUser].state = [[responseBody objectForKey:@"statusId"] toString];
        FLDDLogDebug(@"%@",responseObject);
        [SelfUser currentSelfUser].dictPresonInfo = responseBody ;
        [SelfUser currentSelfUser].strQuHaoTEL =[[responseBody objectForKey:@"telCode"] toString];
        [SelfUser currentSelfUser].shopName = [[responseBody objectForKey:@"shopName"] toString];
        [SelfUser currentSelfUser].shopGroupIconUrl = [[responseBody objectForKey:@"shopGroupIconUrl"] toString];
             
             [SelfUser currentSelfUser].remainOrder = [[responseBody objectForKey:@"todayShopCanPackge"] integerValue];
             [SelfUser currentSelfUser].remainQuickOrder = [[responseBody objectForKey:@"todayShopCanRapidPackge"] integerValue];
             [SelfUser currentSelfUser].unreadMessage = [[responseBody objectForKey:@"notifyUnreadCount"] integerValue];
        
        CLLocationCoordinate2D mddyCoor2D;
        mddyCoor2D.latitude =[[responseBody objectForKey:@"shopLatitude"] doubleValue];
        mddyCoor2D.longitude =[[responseBody objectForKey:@"shopLongitude"] doubleValue];
        [SelfUser currentSelfUser].mddyAdderssedLocationcoorDinate2D = mddyCoor2D;
             
             
        [SelfUser currentSelfUser].shopGroupIconUrl = [[responseBody objectForKey:@"shopGroupIconUrl"] toString];
        [AppManager setUserDefaultsValue:[[responseBody objectForKey:@"shopName"] toString] key:@"shopName"];
        [AppManager setUserDefaultsValue:[[responseBody objectForKey:@"shopGroupIconUrl"] toString] key:@"shopGroupIconUrl"];
        [AppManager setUserDefaultsValue:[[responseBody objectForKey:@"shopTel"] toString] key:@"shopTel"];//店长的手机号
        [AppManager setUserDefaultsValue:[[responseBody objectForKey:@"shopAddress"] toString] key:@"shopAddress"];
             
            
        
        [SelfUser mddyRequestWIthImageWithBrandID:[[responseBody objectForKey:@"brandIdUrl"] toString] withBlock:^(UIImage * image, NSError *error) {
                         if (!error) {
                             
                             if (image == nil) {
                                                            }
                             else {
                                 
                             }
                         }else {
                             
                             
                             
                         }
                     }];
             
            [SelfUser mddyRequestWIthImageWithWayQuickTypeIconUrl:[[responseBody objectForKey:@"shopGroupIconUrl"] toString] withMothed:@"downloadShopGroupICon.htm" withBlock:^(UIImage *image, NSError *error) {
                if (!error) {
                    
                    if (image == nil) {
                    }
                    else {
                        
                    }
                }else {
                    
                    
                    
                }

             }];

        
        
        [SelfUser currentSelfUser].countyCode =[[responseBody objectForKey:@"countyCode"] toString];
        [SelfUser currentSelfUser].cityCode =[[responseBody objectForKey:@"cityCode"] toString];
        
        [SelfUser currentSelfUser].proVinceCode =[[responseBody objectForKey:@"provinceCode"] toString];
        [SelfUser currentSelfUser].cityName =[[responseBody objectForKey:@"cityName"] toString];
        [User currentUser].g_newVersionURL = nil;
        NSString *hasNewVersion= [[responseBody objectForKey:@"hasNewVersion"] toString];
        if([hasNewVersion isEqualToString:@"0"])
        {
            [User currentUser].g_versionState = VERSION_STATE_NO_UPDATE;
        }
        else
        {
            NSString *needUpgrade= [[responseBody objectForKey:@"needUpgrade"] toString];
            if([needUpgrade isEqualToString:@"1"])
            {
                [User currentUser].g_versionState = VERSION_STATE_FORCE_UPDATE;
            }
            else
            {
                [User currentUser].g_versionState = VERSION_STATE_REMIND_UPDATE;
            }
            NSString *downloadUrl= [[responseBody objectForKey:@"downloadUrl"] toString];
            [User currentUser].g_newVersionURL = downloadUrl;
        }
        
        FLDDLogDebug(@"%@",responseObject);
        if (block) {
            block(nil);
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [User currentUser].state = @"-1";
        
        if (block) {
            block(error);
        }
    }];
 
    
}

+ (void)reLoginNoSessionWithFixedPasswordJsonPhone:(NSDictionary *)params block:(void (^)(NSError *))block{//固定密码重新登录
    
    __autoreleasing  NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    [muParams setObject:g_reloginCmd forKey:@"cmdCode"];
    
    //    [[API shareAPI] GET:@"reLoginWithFixedPasswordJsonPhone.htm" params:muParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [[API shareAPI] GET:@"reLoginJsonPhone.htm" params:muParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *cookie = [operation.response.allHeaderFields objectForKey:@"Set-Cookie"];//保存Cookie（仅登录成功后保存）
        [AppManager setUserDefaultsValue:cookie key:@"cookie"];
        NSDictionary *responseBody = [responseObject objectForKey:@"body"];
        [SelfUser currentSelfUser].Clerktype = [[responseBody  valueForKey:@"clerkType"] toString];
        [User currentUser].state = [[responseBody objectForKey:@"statusId"] toString];
        FLDDLogDebug(@"%@",responseObject);
        [SelfUser currentSelfUser].dictPresonInfo = responseBody ;
        
        [SelfUser currentSelfUser].strQuHaoTEL =[[responseBody objectForKey:@"telCode"] toString];
        CLLocationCoordinate2D mddyCoor2D;
        mddyCoor2D.latitude =[[responseBody objectForKey:@"shopLatitude"] doubleValue];
        mddyCoor2D.longitude =[[responseBody objectForKey:@"shopLongitude"] doubleValue];
        [SelfUser currentSelfUser].mddyAdderssedLocationcoorDinate2D = mddyCoor2D;
        
        [SelfUser currentSelfUser].remainOrder = [[responseBody objectForKey:@"todayShopCanPackge"] integerValue];
        [SelfUser currentSelfUser].remainQuickOrder = [[responseBody objectForKey:@"todayShopCanRapidPackge"] integerValue];
        [SelfUser currentSelfUser].unreadMessage = [[responseBody objectForKey:@"notifyUnreadCount"] integerValue];
        
        [SelfUser currentSelfUser].shopName = [[responseBody objectForKey:@"shopName"] toString];
        
         [SelfUser currentSelfUser].shopGroupIconUrl = [[responseBody objectForKey:@"shopGroupIconUrl"] toString];
             [AppManager setUserDefaultsValue:[[responseBody objectForKey:@"shopGroupIconUrl"] toString] key:@"shopGroupIconUrl"];
        [AppManager setUserDefaultsValue:[[responseBody objectForKey:@"shopName"] toString] key:@"shopName"];
        
        [AppManager setUserDefaultsValue:[[responseBody objectForKey:@"shopTel"] toString] key:@"shopTel"];//店长的手机号
        //        [AppManager setUserDefaultsValue:[[responseBody objectForKey:@"shopTel"] toString] key:@"telephone"];
        
        
        [AppManager setUserDefaultsValue:[[responseBody objectForKey:@"shopAddress"] toString] key:@"shopAddress"];
        
        [SelfUser mddyRequestWIthImageWithBrandID:[[responseBody objectForKey:@"brandIdUrl"] toString] withBlock:^(UIImage * image, NSError *error) {
            if (!error) {
                
                if (image == nil) {
                }
                else {
                    
                }
            }else {
                
                
                
            }
        }];
        
        [SelfUser mddyRequestWIthImageWithWayQuickTypeIconUrl:[[responseBody objectForKey:@"shopGroupIconUrl"] toString] withMothed:@"downloadShopGroupICon.htm" withBlock:^(UIImage *image, NSError *error) {
            if (!error) {
                
                if (image == nil) {
                }
                else {
                    
                }
            }else {
                
                
                
            }
            
        }];
        
        
        [SelfUser currentSelfUser].countyCode =[[responseBody objectForKey:@"countyCode"] toString];
        [SelfUser currentSelfUser].cityCode =[[responseBody objectForKey:@"cityCode"] toString];
        
        [SelfUser currentSelfUser].proVinceCode =[[responseBody objectForKey:@"provinceCode"] toString];
        [SelfUser currentSelfUser].cityName =[[responseBody objectForKey:@"cityName"] toString];
        [User currentUser].g_newVersionURL = nil;
        NSString *hasNewVersion= [[responseBody objectForKey:@"hasNewVersion"] toString];
        if(![hasNewVersion isEqualToString:@"0"])
        {
            NSString *needUpgrade= [[responseBody objectForKey:@"needUpgrade"] toString];
            if([needUpgrade isEqualToString:@"1"])
            {
                NSString *downloadUrl= [[responseBody objectForKey:@"downloadUrl"] toString];
                g_needUpgrade = 1;
                g_downloadUrl = downloadUrl;
            }

        }
        
        FLDDLogDebug(@"%@",responseObject);
        if (block) {
            block(nil);
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [User currentUser].state = @"-1";
        
        if (block) {
            block(error);
        }
    }];
    
    
}


+ (void)loginWithFixedPasswordJsonPhone:(NSDictionary *)params block:(void (^)(NSError *))block{//固定密码登录
 __autoreleasing   NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    [muParams setObject:g_loginCmd forKey:@"cmdCode"];
    
    [[API shareAPI] GET:@"loginJsonPhone.htm" params:muParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *cookie = [operation.response.allHeaderFields objectForKey:@"Set-Cookie"];//保存Cookie（仅登录成功后保存）
        [AppManager setUserDefaultsValue:cookie key:@"cookie"];
        NSDictionary *responseBody = [responseObject objectForKey:@"body"];
        [SelfUser currentSelfUser].Clerktype = [[responseBody  valueForKey:@"clerkType"] toString];
        [User currentUser].state = [[responseBody objectForKey:@"statusId"] toString];
        FLDDLogDebug(@"%@",responseObject);
        [SelfUser currentSelfUser].dictPresonInfo = responseBody ;
        
        [SelfUser currentSelfUser].remainOrder = [[responseBody objectForKey:@"todayShopCanPackge"] integerValue];
        [SelfUser currentSelfUser].remainQuickOrder = [[responseBody objectForKey:@"todayShopCanRapidPackge"] integerValue];
        [SelfUser currentSelfUser].unreadMessage = [[responseBody objectForKey:@"notifyUnreadCount"] integerValue];

        [SelfUser currentSelfUser].strQuHaoTEL =[[responseBody objectForKey:@"telCode"] toString];
        
        CLLocationCoordinate2D mddyCoor2D;
        mddyCoor2D.latitude =[[responseBody objectForKey:@"shopLatitude"] doubleValue];
        mddyCoor2D.longitude =[[responseBody objectForKey:@"shopLongitude"] doubleValue];
        [SelfUser currentSelfUser].mddyAdderssedLocationcoorDinate2D = mddyCoor2D;
        
        
        [SelfUser currentSelfUser].shopName = [[responseBody objectForKey:@"shopName"] toString];
        
        
        [AppManager setUserDefaultsValue:[[responseBody objectForKey:@"shopName"] toString] key:@"shopName"];
        
           [AppManager setUserDefaultsValue:[[responseBody objectForKey:@"shopGroupIconUrl"] toString] key:@"shopGroupIconUrl"];
        [AppManager setUserDefaultsValue:[[responseBody objectForKey:@"shopTel"] toString] key:@"shopTel"];//店长的手机号
//        [AppManager setUserDefaultsValue:[[responseBody objectForKey:@"shopTel"] toString] key:@"telephone"];
        
         [AppManager setUserDefaultsValue:[[responseBody objectForKey:@"shopAddress"] toString] key:@"shopAddress"];
        
    
        [SelfUser mddyRequestWIthImageWithBrandID:[[responseBody objectForKey:@"brandIdUrl"] toString] withBlock:^(UIImage * image, NSError *error) {
            if (!error) {
                
                if (image == nil) {
                }
                else {
                    
                }
            }else {
                
            }
        }];
        
        [SelfUser mddyRequestWIthImageWithWayQuickTypeIconUrl:[[responseBody objectForKey:@"shopGroupIconUrl"] toString] withMothed:@"downloadShopGroupICon.htm" withBlock:^(UIImage *image, NSError *error) {
            if (!error) {
                
                if (image == nil) {
                }
                else {
                    
                }
            }else {
                
                
                
            }
            
        }];
        
        [SelfUser currentSelfUser].countyCode =[[responseBody objectForKey:@"countyCode"] toString];
        [SelfUser currentSelfUser].cityCode =[[responseBody objectForKey:@"cityCode"] toString];
        
        [SelfUser currentSelfUser].proVinceCode =[[responseBody objectForKey:@"provinceCode"] toString];
        [SelfUser currentSelfUser].cityName =[[responseBody objectForKey:@"cityName"] toString];
        [User currentUser].g_newVersionURL = nil;
        NSString *hasNewVersion= [[responseBody objectForKey:@"hasNewVersion"] toString];
        if([hasNewVersion isEqualToString:@"0"])
        {
            [User currentUser].g_versionState = VERSION_STATE_NO_UPDATE;
        }
        else
        {
            NSString *needUpgrade= [[responseBody objectForKey:@"needUpgrade"] toString];
            if([needUpgrade isEqualToString:@"1"])
            {
                [User currentUser].g_versionState = VERSION_STATE_FORCE_UPDATE;
            }
            else
            {
                [User currentUser].g_versionState = VERSION_STATE_REMIND_UPDATE;
            }
            NSString *downloadUrl= [[responseBody objectForKey:@"downloadUrl"] toString];
            [User currentUser].g_newVersionURL = downloadUrl;
        }
        FLDDLogDebug(@"%@",responseObject);
        if (block) {
            block(nil);
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [User currentUser].state = @"-1";
        
        if (block) {
            block(error);
        }
    }];

}
+ (void)validPasswordIdentifyingJsonPhone:(NSDictionary *)params block:(void (^)(NSError *))block{//验证找回密码验证码
  __autoreleasing  NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    [muParams setObject:g_validPasswordIdentifyingCmd forKey:@"cmdCode"];
    
    [[API shareAPI] GET:@"validPasswordIdentifyingJsonPhone.htm" params:muParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *cookie = [operation.response.allHeaderFields objectForKey:@"Set-Cookie"];//保存Cookie（仅登录成功后保存）
        [AppManager setUserDefaultsValue:cookie key:@"cookie"];

        FLDDLogDebug(@"%@",responseObject);
        if (block) {
            block(nil);
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [User currentUser].state = @"-1";
        
        if (block) {
            block(error);
        }
    }];
}
+ (void)loginWithParams:(NSDictionary *)params block:(void (^)(NSError *))block
{
   __autoreleasing NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    [muParams setObject:g_loginCmd forKey:@"cmdCode"];
    
    [[API shareAPI] GET:@"loginJsonPhone.htm" params:muParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *cookie = [operation.response.allHeaderFields objectForKey:@"Set-Cookie"];//保存Cookie（仅登录成功后保存）
        [AppManager setUserDefaultsValue:cookie key:@"cookie"];
    
        NSDictionary *responseBody = [responseObject objectForKey:@"body"];
         [SelfUser currentSelfUser].Clerktype = [[responseBody  valueForKey:@"clerkType"] toString];
        [User currentUser].state = [[responseBody objectForKey:@"statusId"] toString];
         FLDDLogDebug(@"%@",responseObject);
        [SelfUser currentSelfUser].dictPresonInfo = responseBody ;
        
        [SelfUser currentSelfUser].strQuHaoTEL =[[responseBody objectForKey:@"telCode"] toString];
        
        [SelfUser currentSelfUser].shopName = [[responseBody objectForKey:@"shopName"] toString];
        [AppManager setUserDefaultsValue:[[responseBody objectForKey:@"shopName"] toString] key:@"shopName"];
           [AppManager setUserDefaultsValue:[[responseBody objectForKey:@"shopGroupIconUrl"] toString] key:@"shopGroupIconUrl"];
        [SelfUser currentSelfUser].countyCode =[[responseBody objectForKey:@"countyCode"] toString];
        [SelfUser currentSelfUser].cityCode =[[responseBody objectForKey:@"cityCode"] toString];
        CLLocationCoordinate2D mddyCoor2D;
        mddyCoor2D.latitude =[[responseBody objectForKey:@"shopLatitude"] doubleValue];
        mddyCoor2D.longitude =[[responseBody objectForKey:@"shopLongitude"] doubleValue];
        [SelfUser currentSelfUser].mddyAdderssedLocationcoorDinate2D = mddyCoor2D;
        
        [SelfUser currentSelfUser].proVinceCode =[[responseBody objectForKey:@"provinceCode"] toString];
        [SelfUser currentSelfUser].cityName =[[responseBody objectForKey:@"cityName"] toString];
        [User currentUser].g_newVersionURL = nil;
        NSString *hasNewVersion= [[responseBody objectForKey:@"hasNewVersion"] toString];
        if([hasNewVersion isEqualToString:@"0"])
        {
            [User currentUser].g_versionState = VERSION_STATE_NO_UPDATE;
        }
        else
        {
            NSString *needUpgrade= [[responseBody objectForKey:@"needUpgrade"] toString];
            if([needUpgrade isEqualToString:@"1"])
            {
                [User currentUser].g_versionState = VERSION_STATE_FORCE_UPDATE;
            }
            else
            {
                [User currentUser].g_versionState = VERSION_STATE_REMIND_UPDATE;
            }
            NSString *downloadUrl= [[responseBody objectForKey:@"downloadUrl"] toString];
            [User currentUser].g_newVersionURL = downloadUrl;
        }
        if (block) {
            block(nil);
          
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [User currentUser].state = @"-1";

        if (block) {
            block(error);
        }
    }];

}

+ (void)reLoginWithParams:(NSDictionary *)params block:(void (^)(NSError *))block
{
    @autoreleasepool {
        
  
    NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    [muParams setObject:g_reloginCmd forKey:@"cmdCode"];
    
//    [AppManager setUserDefaultsValue:@"" key:@"cookie"];
    
    [[API shareAPI] GET:@"reLoginJsonPhone.htm" params:muParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *cookie = [operation.response.allHeaderFields objectForKey:@"Set-Cookie"];//保存Cookie（仅登录成功后保存）
        [AppManager setUserDefaultsValue:cookie key:@"cookie"];
        
        FLDDLogDebug(@"%@",responseObject);
      
        NSDictionary *responseBody = [responseObject objectForKey:@"body"];
        [SelfUser currentSelfUser].Clerktype = [[responseBody  valueForKey:@"clerkType"] toString];
        [User currentUser].state = [[responseBody objectForKey:@"statusId"] toString];
        [SelfUser currentSelfUser].dictPresonInfo = responseBody ;
        
        [SelfUser currentSelfUser].strQuHaoTEL =[[responseBody objectForKey:@"telCode"] toString];
        
        [SelfUser currentSelfUser].shopName = [[responseBody objectForKey:@"shopName"] toString];
        CLLocationCoordinate2D mddyCoor2D;
        mddyCoor2D.latitude =[[responseBody objectForKey:@"shopLatitude"] doubleValue];
        mddyCoor2D.longitude =[[responseBody objectForKey:@"shopLongitude"] doubleValue];
        [SelfUser currentSelfUser].mddyAdderssedLocationcoorDinate2D = mddyCoor2D;

        [SelfUser currentSelfUser].countyCode =[[responseBody objectForKey:@"countyCode"] toString];
        [SelfUser currentSelfUser].cityCode =[[responseBody objectForKey:@"cityCode"] toString];
        
        [SelfUser currentSelfUser].proVinceCode =[[responseBody objectForKey:@"provinceCode"] toString];
        [SelfUser currentSelfUser].cityName =[[responseBody objectForKey:@"cityName"] toString];
        [User currentUser].g_newVersionURL = nil;
        NSString *hasNewVersion= [[responseBody objectForKey:@"hasNewVersion"] toString];
        if([hasNewVersion isEqualToString:@"0"])
        {
            [User currentUser].g_versionState = VERSION_STATE_NO_UPDATE;
        }
        else
        {
            NSString *needUpgrade= [[responseBody objectForKey:@"needUpgrade"] toString];
            if([needUpgrade isEqualToString:@"1"])
            {
                [User currentUser].g_versionState = VERSION_STATE_FORCE_UPDATE;
            }
            else
            {
                [User currentUser].g_versionState = VERSION_STATE_REMIND_UPDATE;
            }
            NSString *downloadUrl= [[responseBody objectForKey:@"downloadUrl"] toString];
            [User currentUser].g_newVersionURL = downloadUrl;
        }
        
        
        if (block) {
            block(nil);
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        FLDDLogInfo(@"reLoginWithParams fail.");
        [User currentUser].state = @"-1";
        
        if (block) {
            block(error);
        }
    }];
    }
}

+ (void)registerWithParams:(NSDictionary *)params imageDate:(NSDictionary *)imageParams block:(void (^)(NSError *))block
{
     @autoreleasepool {
  __autoreleasing  NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
  
    [muParams setObject:g_registerCmd forKey:@"cmdCode"];
    
    [[API shareAPI] POST:@"courierRegisteJsonPhone.htm" parameters:muParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
     __autoreleasing   UIImage *portrait = [imageParams objectForKey:@"headPortrait"];
   __autoreleasing     NSData *portraitData = UIImageJPEGRepresentation(portrait, 1);
        
    __autoreleasing    UIImage *frontId = [imageParams objectForKey:@"idPic1"];
   __autoreleasing     NSData *frontIdData = UIImageJPEGRepresentation(frontId, 1);
        
       __autoreleasing UIImage *backId = [imageParams objectForKey:@"idPic2"];
    __autoreleasing    NSData *backIdData = UIImageJPEGRepresentation(backId, 1);
        
        [formData appendPartWithFileData:portraitData name:@"headPortrait" fileName:@"portrait.jpg" mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:frontIdData name:@"idPic1" fileName:@"frontId.jpg" mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:backIdData name:@"idPic2" fileName:@"backId.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        FLDDLogDebug(@"success");
        block(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        FLDDLogInfo(@"failure");
        block(error);
    }];
     }
}

+ (void)autoCodeWithParams:(NSDictionary *)params block:(void (^)(NSError *))block
{
     @autoreleasepool {
  __autoreleasing  NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    [muParams setObject:g_loginCheckCodeCmd forKey:@"cmdCode"];
    
    [[API shareAPI] GET:@"needPasswordJsonPhone.htm" params:muParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) {
            block (nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(error);
        }
    }];
     }
}

+ (void)getVersionSNOWithParams:(NSDictionary *)params block:(void (^)(NSError *))block
{
    @autoreleasepool {
  __autoreleasing  NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    [muParams setObject:g_checkUpdateCmd forKey:@"cmdCode"];
    
    [[API shareAPI] GET:@"hasNewVersionIOSJsonPhone.htm" params:muParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @try {
            NSDictionary *responseBody = [responseObject objectForKey:@"body"];
            //FLDDLogDebug(@"%@", responseBody);
            
            
            [User currentUser].g_newVersionURL = nil;
            NSString *hasNewVersion= [[responseBody objectForKey:@"hasNewVersion"] toString];
            if([hasNewVersion isEqualToString:@"0"])
            {
                [User currentUser].g_versionState = VERSION_STATE_NO_UPDATE;
            }
            else
            {
                NSString *needUpgrade= [[responseBody objectForKey:@"needUpgrade"] toString];
                if([needUpgrade isEqualToString:@"1"])
                {
                    [User currentUser].g_versionState = VERSION_STATE_FORCE_UPDATE;
                }
                else
                {
                    [User currentUser].g_versionState = VERSION_STATE_REMIND_UPDATE;
                }
                NSString *downloadUrl= [[responseBody objectForKey:@"downloadUrl"] toString];
                [User currentUser].g_newVersionURL = downloadUrl;
            }
        }
        @catch (NSException *exception) {
//            NSDictionary *responseBody = [responseObject objectForKey:@"body"];
//            FLDDLogError(@"%@", responseBody);
        }


        //[User currentUser].g_versionState = VERSION_STATE_FORCE_UPDATE;
        //[User currentUser].g_newVersionURL = @"https://itunes.apple.com/cn/app/ccms/id862895482?l=zh&ls=1&mt=8";
        
        if (block) {
            block (nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            //[User currentUser].g_newVersionURL = @"https://itunes.apple.com/cn/app/ccms/id862895482?l=zh&ls=1&mt=8";
            //[User currentUser].g_versionState = VERSION_STATE_FORCE_UPDATE;
            [User currentUser].g_versionState = VERSION_STATE_FETCH_FAIL;
            block(error);
        }
    }];
    }
}

+ (void)modifyUserWorkStatusWithParams:(NSDictionary *)params block:(void (^)(NSError *))block
{
    NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
    NSString *urlStr = @"";
//    BOOL on = [params objectForKey:@"workStatus"];
    
    WorkState status = [User currentUser].workState;
    
    if (status == WorkStateOn) {
        [muParams setObject:g_endWorkCmd forKey:@"cmdCode"];
        urlStr = @"endWorkJsonPhone.htm";
    }
    else {
        [muParams setObject:g_startWorkCmd forKey:@"cmdCode"];
        urlStr = @"startWorkJsonPhone.htm";
    }
    
    [muParams removeObjectForKey:@"workStatus"];
    
    [[API shareAPI] GET:urlStr params:muParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) {
            block(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(error);
        }
    }];
}

+ (void)questionWithParams:(NSDictionary *)params block:(void (^)(id, NSError *))block
{
    NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
    [muParams setObject:g_getQuestionsCmd forKey:@"cmdCode"];

    [[API shareAPI] GET:@"needCourierTestJsonPhone.htm" params:muParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        FLDDLogDebug(@"responseObject:%@",responseObject);
        if (block) {
            block(responseObject ,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        FLDDLogInfo(@"failure");
    }];
}

+ (void)incomeWithParams:(NSDictionary *)params block:(void (^)(NSString *, NSError *))block
{
    NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
    [muParams setObject:g_getQuestionsCmd forKey:@"cmdCode"];
    
    [[API shareAPI] GET:@"totalAmountJsonPhone.htm" params:muParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSDictionary *body = [responseObject objectForKey:@"body"];
        
        NSString *income = [[body objectForKey:@"money"] toString];
        
        if (block) {
            block(income, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(@"0",error);
        }
    }];
}

+ (void)personalInfoWithBlock:(void (^)(id , NSError *))block
{
    [[API shareAPI] GET:@"profileJsonPhone.htm" params:@{@"cmdCode" : g_personalInfoCmd} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        FLDDLogDebug(@"res:%@", responseObject);
        if (block) {
            block([responseObject objectForKey:@"body"], nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

+ (void)accountBalanceWithBlock:(void (^)(NSString *, NSError *))block
{
    [[API shareAPI] GET:@"accountBalanceJsonPhone.htm" params:@{@"cmdCode" : g_accountAmontCmd} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *body = [responseObject objectForKey:@"body"];
        
        NSString *account = [[body objectForKey:@"accountBalance"] toString];
        
        if (block) {
            block(account,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}


+ (NSURLRequest *)getFreightTemplateExplanationPageRequest : (NSString*)waybillId
{
    NSMutableDictionary *muParams = [NSMutableDictionary dictionary];
    
    [muParams setObject:g_freightTemplatePageDownloadCmd forKey:@"cmdCode"];
    [muParams setObject:waybillId forKey:@"waybillId"];
    
    return [[API shareAPI] GetRequest:@"freightTemplateExplanationIosJsonPhone.htm" params:muParams];
}

+ (NSURLRequest *)getUserPlicyPageRequest
{
    NSMutableDictionary *muParams = [NSMutableDictionary dictionary];
    
    [muParams setObject:g_userPlicyPageDownloadCmd forKey:@"cmdCode"];
    
    return [[API shareAPI] GetRequest:@"toBusinessPolicyIOS.htm" params:muParams];
}
+ (NSURLRequest *)getBookPageRequestWithOrderNumb:(NSString *)orderNumber
{
    NSMutableDictionary *muParams = [NSMutableDictionary dictionary];
    
    [muParams setObject:g_apliy forKey:@"cmdCode"];
    [muParams setObject:orderNumber forKey:@"orderNumber"];
    
    return [[API shareAPI] GetRequest:@"shopRechageCCBIOSH5.htm" params:muParams];
}

@end
