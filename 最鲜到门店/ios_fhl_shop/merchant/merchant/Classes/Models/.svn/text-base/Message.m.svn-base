//
//  Message.m
//  FHL
//
//  Created by panume on 14-11-2.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "Message.h"

@implementation Message

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        @try {
            self.id = [[attributes objectForKey:@"id"] toString];
            self.content = [[attributes objectForKey:@"content"] toString];
            self.time = [[attributes objectForKey:@"createTime"] doubleValue];
            self.state = [[attributes objectForKey:@"isRead"] toInt];
            self.title = [[attributes objectForKey:@"title"] toString];
            self.type = [[attributes objectForKey:@"type"] toInt];
          
        }
        @catch (NSException *exception) {
            
        }
    }
    return self;
}

+ (void)messagesWithParams:(NSDictionary *)params block:(void (^)(NSArray *, NSInteger, NSInteger, NSError *,NSInteger ,NSInteger))block
{
    NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
    [muParams setObject:g_messagesCmd forKey:@"cmdCode"];
    
    [[API shareAPI] GET:@"notifyListWithNotifyUnreadCountJsonPhone.htm" params:muParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *body = [responseObject objectForKey:@"body"];
        NSDictionary *response = [body objectForKey:@"notifyList"];
        
        NSInteger total = [[response objectForKey:@"total"] toInt];
        NSInteger page = [[response objectForKey:@"page"] toInt];
        
        NSArray *responseList = [response objectForKey:@"rows"];
        NSMutableArray *messages = [NSMutableArray array];
        NSInteger count1 =[[body objectForKey:@"count1"] toInt];
             NSInteger count2 =[[body objectForKey:@"count2"] toInt];
        for (NSDictionary *attributes in responseList) {
            
            Message *message = [[self alloc] initWithAttributes:attributes];
            
            if (message) {
                [messages addObject:message];
            }
        }
        
        if (block) {
            block(messages, total, page, nil,count1,count2);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(@[], 0, 0, error,-1,-1);
        }
    }];
}

- (void)readMessageWithBlock:(void (^)(NSError *))block
{
    NSMutableDictionary *muParams = [NSMutableDictionary dictionary];
    [muParams setObject:g_readMessageCmd forKey:@"cmdCode"];
    [muParams setObject:self.id forKey:@"notifyId"];
    
    [[API shareAPI] GET:@"readNotifyJsonPhone.htm" params:muParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) {
            block(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(error);
        }
    }];
}

+ (void)messagesCountWithParams:(NSDictionary *)params block:(void (^)(NSInteger, NSError *))block
{
    NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
    [muParams setObject:g_messageCountCmd forKey:@"cmdCode"];
    
    [[API shareAPI] GET:@"notifyUnreadCountJsonPhone.htm" params:muParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *body = [responseObject objectForKey:@"body"];
        NSInteger count = [[body objectForKey:@"count"] toInt];
        
        if (block) {
            block(count, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(0, error);
        }
    }];
}

+ (void)messageDetailWithParams:(NSDictionary *)params block:(void (^)(Message *, NSError *))block
{
    [Message writeToFileWithString:@"detailYES" withFileName:@"name"];
    NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
    [muParams setObject:g_notifyDetailCmd forKey:@"cmdCode"];
    
    [[API shareAPI] GET:@"notifyDetailJsonPhone.htm" params:muParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
          [Message writeToFileWithString:responseObject withFileName:@"name"];
        NSDictionary *body = [responseObject objectForKey:@"body"];
        Message *message = [[self alloc] initWithAttributes:body];
        if (block) {
            block(message, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}
+(void)writeToFileWithString:(NSString*)string withFileName:(NSString*)fileName{
    NSString* fileName1 = [self filePath:fileName];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString* str = nil;
    if ( [fileManager fileExistsAtPath:fileName1]) {
        
        NSData* data = [NSData dataWithContentsOfFile:fileName1];
        
        
        str =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        string = [NSString stringWithFormat:@"%@\n%@",str,string];
    }
    
    [fileManager createFileAtPath:fileName1 contents:[ string dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    
    
    
    
}
+ (NSString*)filePath:(NSString*)fileName {
    NSArray* myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* myDocPath = [myPaths objectAtIndex:0];
    NSString* filePath = [myDocPath stringByAppendingPathComponent:fileName];
    return filePath;
}
@end
