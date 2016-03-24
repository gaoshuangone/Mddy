//
//  CAnalyzeResult.h
//  FHL
//
//  Created by 郏国上 on 14-10-11.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CAnalyzeResult : NSObject
//{
//    Boolean result;
//    NSString *cmdCode;
//    NSString *message;
//}
//-(void)setResult:(Boolean)bRresult;
//-(void)setMessage:(NSString *)sMessage;
//-(void)setCmdCode : (NSString *)sCmdCode;
@property Boolean result;
@property(nonatomic,copy) NSString *cmdCode;
@property(nonatomic,copy) NSString *message;

//- (id)init;
@end
