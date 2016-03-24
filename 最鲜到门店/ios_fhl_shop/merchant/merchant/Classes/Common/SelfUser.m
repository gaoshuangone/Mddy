//
//  self.m
//  merchant
//
//  Created by gs on 14/11/8.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "SelfUser.h"
//#import "TableViewCellValue.h"

@implementation SelfUser
+ (instancetype)currentSelfUser
{
    static SelfUser *currentUser = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        currentUser = [[SelfUser alloc] init];
    });
    return currentUser;
}
//获取门店资料
+(void)shopInfoWithBlock:(void (^)(id, NSError *))block{
        @autoreleasepool {
    [[ API shareAPI] GET:@"shopInfoJsonPhone.htm" params:@{@"cmdCode":g_shopInfoCmd} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        FLDDLogDebug(@"%@",responseObject);
        if(block){
            block([responseObject objectForKey:@"body"],nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(block){
            block(nil,error);
        }
    }];
        }
}
//获取门店店员列表
+(void)clerkListWithBlock:(void (^)(id,NSError *))block{
        @autoreleasepool {
    [[API shareAPI] GET:@"clerkListJsonPhone.htm" params:@{@"cmdCode":g_clerkListCmd} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        FLDDLogDebug(@"%@",responseObject);
        if (block) {
            block([responseObject objectForKey:@"body"],nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(block){
            block(nil,error);
        }
    }];
        }
}
+(void)mddyRequestWithMethodName:(NSString*)methodName  withParams:(NSDictionary *)params withBlock:(void (^)(id, NSError *))block{
// __autoreleasing  NSMutableDictionary* paramAdd = [NSMutableDictionary dictionaryWithDictionary:params];
   NSMutableDictionary* paramAdd =[[NSMutableDictionary alloc]initWithDictionary:params];
    if((nil == params) || (nil == [params objectForKey:@"cmdCode"]))
    {
//        if ([methodName isEqualToString:@"resetPasswordJsonPhone.htm"]) {
//            [paramAdd setObject:g_loginCmd forKey:@" "];
//        }else{
            [paramAdd setObject:g_personalInfoCmd forKey:@"cmdCode"];
//        }
    }

    @autoreleasepool {
        
        [[API shareAPI] REQUES:@"GET" WITHURL:methodName params:paramAdd success:^(AFHTTPRequestOperation *operation, id responseObject) {
            FLDDLogDebug(@"请求到的数据responseObjiect＝:%@",responseObject);
            if (block) {
                if(nil != responseObject)
                {
                    block([responseObject valueForKey:@"body"] ,nil);
                }
                else
                {
                    block(responseObject ,nil);
                }
            }

        } failure:^(id responseObject, NSError *error) {
            if (block) {
                FLDDLogDebug(@"错误信息error:%@", [error description]);
                FLDDLogDebug(@"错误信息responseObjec:%@", responseObject);
                if(nil != responseObject)
                {
                    if([responseObject isKindOfClass:[AFHTTPRequestOperation class]])
                    {
                        block(responseObject, error);
                    }
                    else
                    {
                        block([responseObject valueForKey:@"body"], error);
                    }
                }
                else
                {
                    block(responseObject, error);
                }
                
            }

        }];
 
//
//    [[API shareAPI] GET:methodName params:paramAdd success:^(AFHTTPRequestOperation *operation, id responseObject) {
////
////        if ([[[[responseObject valueForKey:@"head"]valueForKey:@"result"] toString] isEqualToString:@"3"]) {
////            NSString *phone = [AppManager valueForKey:@"telephone"];
////            NSString *password = [AppManager valueForKey:@"password"];
//////            FLDDLogDebug(@"取到密码%@",password);
////            if (phone == nil || password == nil) {
////                return;
////                
////            }
//            
////            NSDictionary *params = @{@"clerkTel": phone,
////                                     @"passwd" : password};
//            
//            
//            
////        }
//        operation = nil;
//        
//      FLDDLogDebug(@"请求到的数据responseObjiect＝:%@",responseObject);
//        if (block) {
//            block([responseObject valueForKey:@"body"] ,nil);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        block(nil,error);
//              operation = nil;
////        if ( [[SelfUser currentSelfUser].innerMessage isEqualToString:@"您还没登录，请重新登录"]) {
////            if ( [[AppManager valueForKey:@"isFirst"]isEqualToString:@"2"]) {
////            
////                        [[NSNotificationCenter defaultCenter]postNotificationName:ONCELOGININ object:self];
////            
////
////            }
////           
////        }
//        FLDDLogDebug(@"*****************************请求出错**********%@***********************************************",methodName) ;
//    }];
   
    }
 paramAdd = nil;
    params = nil;
}
+(void)mddyRequestWIthImageWithBrandID:(NSString *)brandId withBlock:(void (^)(UIImage *image, NSError *))block{
      @autoreleasepool {
    FLDDLogDebug(@"brandId,%@",brandId);
          if (brandId == nil) {
             
              return;
          }
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg",brandId];
      
    NSData *imageData = [AppManager readDataFromDocumentWithName:fileName];
          
          NSString* str = nil;
          if ([AppManager valueForKey:@"telephone"]!=nil) {
              NSLog(@"%@",[AppManager valueForKey:@"telephone"]);
              str = [AppManager valueForKey:[AppManager valueForKey:@"telephone"]];
              NSLog(@"!@#%@",str);
          }

          
    if (imageData > 0 && str.length>0) {
 NSLog(@"~~%@",[AppManager valueForKey:@"telephone"]);
        block([UIImage imageWithData:imageData],nil);
    }else{
        
        [[API shareAPI]imageFileWithUrl:@"downloadBrandLogoJsonPhone.htm" withBrandId:brandId  block:^(UIImage *image, NSError *error) {
            if (!error) {

                if (image) {
                    
                    
                    [AppManager setUserDefaultsValue:fileName key:[AppManager valueForKey:@"telephone"]];
//                   NSString*  str = [AppManager valueForKey:[AppManager valueForKey:@"telephone"]];
//                    NSLog(@"~~!@#%@——————%@",str,[AppManager valueForKey:@"telephone"]);
                
                    [AppManager writeToDocumentWithImageData:UIImageJPEGRepresentation(image, 1) name:fileName];
                    block([UIImage imageWithData:[AppManager readDataFromDocumentWithName:fileName]],nil);
                }
                else {
                    if (block) {
                        block(nil, nil);

                    }
                }
                
                
            }else{
                FLDDLogDebug(@"**********************************请求图片出错**********************************");
                if (block) {
                    block(nil, nil);
                    
                }

            }
            
        }];
    }
      }
}
+(void)mddyRequestWIthImageWithWaybillId:(NSString *)billId withIndex:(NSString*)index withBlock:(void (^)(UIImage *image, NSError *error))block{
      @autoreleasepool {
    FLDDLogDebug(@"拒收取图片的billId,%@",billId);
    NSString *fileName = [NSString stringWithFormat:@"%@%@.jpg",billId,index];
    NSData *imageData = [AppManager readDataFromDocumentWithName:fileName];
    if (imageData > 0) {
        
        block([UIImage imageWithData:imageData],nil);
    }else{
        [[API shareAPI] imageFileWithUrl:@"downloadrejectedPhotoJsonPhone.htm" withBullid:billId withIndex:index block:^(UIImage *image, NSError *error) {
            if (!error) {
                
                if (image) {
                    [AppManager writeToDocumentWithImageData:UIImageJPEGRepresentation(image, 1) name:fileName];
                    block([UIImage imageWithData:[AppManager readDataFromDocumentWithName:fileName]],nil);
                }
                
                
            }else{
                FLDDLogDebug(@"**********************************请求图片出错**********************************");
            }

        }];
           }
      }
}

+(void)mddyRequestWIthImageWithWayQuickTypeIconUrl:(NSString *)quickTypeIconUrl withMothed:(NSString*)mothed withBlock:(void (^)(UIImage *image, NSError *error))block{
    @autoreleasepool {
        
        
        if (quickTypeIconUrl.length<=0) {
              block(nil, nil);
            return;
        }
        NSRange rang = [quickTypeIconUrl rangeOfString:@"="];
        NSString *fileName  = nil;
//        NSLog(@"!!!%d",[rang.location ]);
     
        if (rang.location==NSNotFound ) {
            rang =[quickTypeIconUrl rangeOfString:@"images/"];
          fileName = [NSString stringWithFormat:@"%@",[quickTypeIconUrl substringFromIndex:rang.location+7]];

        }else{
           fileName = [NSString stringWithFormat:@"%@",[quickTypeIconUrl substringFromIndex:rang.location+1]];
        }
       

      
        NSData *imageData = [AppManager readDataFromDocumentWithName:fileName];
        if (imageData > 0) {
            
            block([UIImage imageWithData:imageData],nil);
        }else{
            [[API shareAPI]imageFileWithUrl:quickTypeIconUrl withBrandId:quickTypeIconUrl  block:^(UIImage *image, NSError *error) {
                if (!error) {
                    
                    if (image) {
                        FLDDLogDebug(@"请求图片通用的方法%@",quickTypeIconUrl);
                        [AppManager writeToDocumentWithImageData:UIImageJPEGRepresentation(image, 1) name:fileName];
                        block([UIImage imageWithData:[AppManager readDataFromDocumentWithName:fileName]],nil);
                    }
                    else {
                        if (block) {
                            block(nil, nil);
                            
                        }
                    }
                    
                    
                }else{
                    FLDDLogDebug(@"**********************************请求图片出错**********************************");
                    if (block) {
                        block(nil, nil);
                        
                    }
                    
                }
                
            }];
        }
    }
}
+(NSString *)mddyGetFileNameWithIconUrl:(NSString *)quickTypeIconUrl
{
    @autoreleasepool {
        if (quickTypeIconUrl.length<=0) {
            return nil;
        }
        NSRange rang = [quickTypeIconUrl rangeOfString:@"="];
        NSString *fileName  = nil;
        //        NSLog(@"!!!%d",[rang.location ]);
        
        if (rang.location==NSNotFound ) {
            rang =[quickTypeIconUrl rangeOfString:@"images/"];
            fileName = [NSString stringWithFormat:@"%@",[quickTypeIconUrl substringFromIndex:rang.location+7]];
            
        }else{
            fileName = [NSString stringWithFormat:@"%@",[quickTypeIconUrl substringFromIndex:rang.location+1]];
        }
        return fileName;
    }
}

+(void)mddyRequestWithOrderTypeImageWithFileName:(NSString *)fileName  withWayQuickTypeIconUrl:(NSString *)quickTypeIconUrl withTableViewcell:(TableViewCellValue *)cell withIconArr:(NSMutableArray *)fetchingIconArr withMothed:(NSString*)mothed withBlock:(void (^)(UIImage *image, NSError *error, bool bDefault))block
{
    @autoreleasepool {
        if ((fileName.length<=0) || (nil == cell) || (nil == fetchingIconArr) || (0 == quickTypeIconUrl.length))
        {
            block(nil,nil, YES);
            return;
        }
        cell.orderTypeIconFileName = fileName;
        NSData *imageData = [AppManager readDataFromDocumentWithName:fileName];
        if (imageData > 0) {
            cell.imageViewOrderTypeIcon.image = [UIImage imageWithData:imageData];
            cell.bNeedGetOrderTypeIcon = NO;
            cell.imageViewOrderTypeIcon.bounds = CGRectMake(0, 0, 15, 15);
            cell.imageViewOrderTypeIcon.contentMode = UIViewContentModeScaleToFill;
            block(nil,nil,YES);
        }else{
            cell.bNeedGetOrderTypeIcon = YES;
            bool findFlag = NO;
            for (TableViewCellValue * cellTemp in fetchingIconArr)
            {
                if ((cellTemp.bNeedGetOrderTypeIcon) && [cellTemp.orderTypeIconFileName isEqualToString:cell.orderTypeIconFileName])
                {
                    findFlag = YES;
                    break;
                }
            }
            if(!findFlag)
            {
                [fetchingIconArr addObject:cell];
                [[API shareAPI]imageFileWithUrl:quickTypeIconUrl withBrandId:quickTypeIconUrl  block:^(UIImage *image, NSError *error) {
                    if (!error) {
                        if (image) {
                            FLDDLogDebug(@"请求图片通用的方法%@",quickTypeIconUrl);
                            [AppManager writeToDocumentWithImageData:UIImagePNGRepresentation(image) name:fileName];
                            block([UIImage imageWithData:[AppManager readDataFromDocumentWithName:fileName]],nil,NO);
                        }
                        else {
                            block([UIImage imageNamed:@"icon_default_card"],nil,YES);
                        }
                        
                    }else{
                        FLDDLogDebug(@"**********************************请求图片出错**********************************");
                        block([UIImage imageNamed:@"icon_default_card"],nil,YES);
                    }
                    
                }];
                
            }
            
        }
    }
}

+(void)mddyRequestWithImageWithFileName:(NSString *)fileName  withWayQuickTypeIconUrl:(NSString *)quickTypeIconUrl withTableViewcell:(TableViewCellValue *)cell withIconArr:(NSMutableArray *)fetchingIconArr withMothed:(NSString*)mothed withBlock:(void (^)(UIImage *image, NSError *error, bool bDefault))block
    {
    @autoreleasepool {
        
//        if (quickTypeIconUrl.length<=0) {
//            block(nil, nil);
//            return;
//        }
//        NSRange rang = [quickTypeIconUrl rangeOfString:@"="];
//        NSString *fileName  = nil;
//        //        NSLog(@"!!!%d",[rang.location ]);
//        
//        if (rang.location==NSNotFound ) {
//            rang =[quickTypeIconUrl rangeOfString:@"images/"];
//            fileName = [NSString stringWithFormat:@"%@",[quickTypeIconUrl substringFromIndex:rang.location+7]];
//            
//        }else{
//            fileName = [NSString stringWithFormat:@"%@",[quickTypeIconUrl substringFromIndex:rang.location+1]];
//        }
        if ((fileName.length<=0) || (nil == cell) || (nil == fetchingIconArr) || (0 == quickTypeIconUrl.length))
        {
            block(nil,nil, YES);
            return;
        }
        cell.iconFileName = fileName;
        NSData *imageData = [AppManager readDataFromDocumentWithName:fileName];
        if (imageData > 0) {
            cell.imageViewIcon.image = [UIImage imageWithData:imageData];
            cell.bNeedGetIcon = NO;
            cell.imageViewIcon.bounds = CGRectMake(0, 0, 15, 15);
            cell.imageViewIcon.contentMode = UIViewContentModeScaleToFill;
            block(nil,nil, YES);
            //                    block([UIImage imageWithData:imageData],nil);
        }else{
            cell.bNeedGetIcon = YES;
            bool findFlag = NO;
            for (TableViewCellValue * cellTemp in fetchingIconArr)
            {
                if ((cellTemp.bNeedGetIcon) && [cellTemp.iconFileName isEqualToString:cell.iconFileName])
                {
                    findFlag = YES;
                    break;
                }
            }
            if(!findFlag)
            {
                [fetchingIconArr addObject:cell];
                [[API shareAPI]imageFileWithUrl:quickTypeIconUrl withBrandId:quickTypeIconUrl  block:^(UIImage *image, NSError *error) {
                    if (!error) {
//                        NSMutableArray *fetchingIconArrTemp = [NSMutableArray array];
                        if (image) {
                            FLDDLogDebug(@"请求图片通用的方法%@",quickTypeIconUrl);
                            [AppManager writeToDocumentWithImageData:UIImagePNGRepresentation(image) name:fileName];
                            block([UIImage imageWithData:[AppManager readDataFromDocumentWithName:fileName]],nil,NO);
                            //                                block([UIImage imageWithData:[AppManager readDataFromDocumentWithName:fileName]],nil);
//                            NSData *imageDataTemp = [AppManager readDataFromDocumentWithName:fileName];
//                            for (TableViewCellValue * cellTemp in fetchingIconArr)
//                            {
//                                if ((cellTemp.bNeedGetIcon) && [cellTemp.iconFileName isEqualToString:cell.iconFileName])
//                                {
//                                    //重新生成图像，防止原来同组的一个商家的组icon变更（退出该商家组），其它的组icon全变更
//                                    if (imageDataTemp.length > 0) {
//                                        cellTemp.imageViewIcon.image = [UIImage imageWithData:imageDataTemp];
//                                        cellLanShou.imageViewIcon.bounds = CGRectMake(0, 0, 15, 15);
//                                        cellLanShou.imageViewIcon.contentMode = UIViewContentModeScaleToFill;
//                                        //                                                cellTemp.imageViewIcon.image = image;
//                                        cellTemp.bNeedGetIcon = NO;
//                                    }
//                                    else
//                                    {
//                                        cellTemp.bNeedGetIcon = NO;
//                                        cellTemp.imageViewIcon.image = [UIImage imageNamed:@"icon_default_card"];
//                                        cellLanShou.imageViewIcon.bounds = CGRectMake(0, 0, 15, 15);
//                                        cellLanShou.imageViewIcon.contentMode = UIViewContentModeScaleToFill;
//                                    }
//                                }
//                                else
//                                {
//                                    [fetchingIconArrTemp addObject:cellTemp];
//                                }
//                            }
//                            [self.fetchingIconArr removeAllObjects];
//                            self.fetchingIconArr = fetchingIconArrTemp;
//                            [self.tableView reloadData];
                        }
                        else {
                            block([UIImage imageNamed:@"icon_default_card"],nil,YES);
                            //                                if (block) {
                            //                                    block(nil, nil);
                            //
                            //                                }
//                            for (TableViewCellValue * cellTemp in self.fetchingIconArr)
//                            {
//                                if ((cellTemp.bNeedGetIcon) && [cellTemp.iconFileName isEqualToString:cellLanShou.iconFileName])
//                                {
//                                    cellTemp.bNeedGetIcon = NO;
//                                    cellTemp.imageViewIcon.image = [UIImage imageNamed:@"icon_default_card"];
//                                    cellLanShou.imageViewIcon.bounds = CGRectMake(0, 0, 15, 15);
//                                    cellLanShou.imageViewIcon.contentMode = UIViewContentModeScaleToFill;
//                                }
//                                else
//                                {
//                                    [fetchingIconArrTemp addObject:cellTemp];
//                                }
//                            }
//                            [self.fetchingIconArr removeAllObjects];
//                            self.fetchingIconArr = fetchingIconArrTemp;
//                            [self.tableView reloadData];
                        }
                        
                    }else{
                        FLDDLogDebug(@"**********************************请求图片出错**********************************");
                        block([UIImage imageNamed:@"icon_default_card"],nil,YES);
//                        //                            if (block) {
//                        //                                block(nil, nil);
//                        //
//                        //                            }
//                        NSMutableArray *fetchingIconArrTemp = [NSMutableArray array];
//                        for (TableViewCellValue * cellTemp in self.fetchingIconArr)
//                        {
//                            if ((cellTemp.bNeedGetIcon) && [cellTemp.iconFileName isEqualToString:cellLanShou.iconFileName])
//                            {
//                                cellTemp.bNeedGetIcon = NO;
//                                cellTemp.imageViewIcon.image = [UIImage imageNamed:@"icon_default_card"];
//                                cellLanShou.imageViewIcon.bounds = CGRectMake(0, 0, 15, 15);
//                                cellLanShou.imageViewIcon.contentMode = UIViewContentModeScaleToFill;
//                            }
//                            else
//                            {
//                                [fetchingIconArrTemp addObject:cellTemp];
//                            }
//                        }
//                        [self.fetchingIconArr removeAllObjects];
//                        self.fetchingIconArr = fetchingIconArrTemp;
//                        [self.tableView reloadData];
//                        
                    }
                    
                }];
                
            }
            
        }
    }
}
#pragma mark 显示活动指示器
+(void)hudShowWithViewcontroller:(id)viewcontroller
{
    UIViewController* viewc=viewcontroller;
    MBProgressHUD* hud = [[MBProgressHUD alloc] initWithView:viewc.view];
    [viewc.view addSubview:hud];
    hud.labelText = @"加载中...";
    hud.tag =101;
    [hud show:YES];
}
#pragma  mark 隐藏活动指示器
+(void)hudHideWithViewcontroller:(id)viewcontroller
{
    UIViewController* viewc=viewcontroller;
    MBProgressHUD* hud =(MBProgressHUD*)[viewc.view viewWithTag:101];
//    [hud hide:YES];
    [hud removeFromSuperview];
    hud = nil;
}



@end
