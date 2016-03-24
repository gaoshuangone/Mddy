//
//  Message.h
//  FHL
//
//  Created by panume on 14-11-2.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic, strong) NSString *id;//消息id
@property (nonatomic, strong) NSString *title;//消息标题
@property (nonatomic, strong) NSString *content;//消息内容
@property (nonatomic, assign) NSTimeInterval time;//消息时间
@property (nonatomic, assign) NSInteger type;//消息类型（1系统消息或2运单消息）
@property (nonatomic, assign) NSInteger state;//消息状态（0未读,1已读）
@property (nonatomic, strong) NSString *url;//消息链接

@property (nonatomic,strong)  NSString *count1;
@property (nonatomic,strong)  NSString *count2;
+ (void)messagesWithParams:(NSDictionary *)params block:(void(^)(NSArray *messages, NSInteger total, NSInteger page, NSError *error,NSInteger count1,NSInteger count2))block;
- (void)readMessageWithBlock:(void(^)(NSError *error))block;
+ (void)messagesCountWithParams:(NSDictionary *)params block:(void(^)(NSInteger count, NSError *error))block;

+ (void)messageDetailWithParams:(NSDictionary *)params block:(void(^)(Message *message, NSError *error))block;

@end
