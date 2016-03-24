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

+ (void)loginWithParams:(NSDictionary *)params block:(void (^)(NSError *))block
{
    
    [[API shareAPI] POST:@"fileupload/servlet/fileServlet" params:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                block(nil);
                
            });
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(error);
                
            });
        }
    }];

}

+ (void)registerWithParams:(NSDictionary *)params imageDate:(NSDictionary *)imageParams block:(void (^)(NSError *))block
{
    
    NSMutableDictionary *muParams = [NSMutableDictionary dictionaryWithDictionary:params];
  
    [muParams setObject:g_registerCmd forKey:@"cmdCode"];
    
    [[API shareAPI] POST:@"" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        UIImage *portrait = [imageParams objectForKey:@"portrait"];
        NSData *portraitData = UIImageJPEGRepresentation(portrait, 1);
        
        UIImage *frontId = [imageParams objectForKey:@"frontId"];
        NSData *frontIdData = UIImageJPEGRepresentation(frontId, 1);
        
        UIImage *backId = [imageParams objectForKey:@"backId"];
        NSData *backIdData = UIImageJPEGRepresentation(backId, 1);
        
        [formData appendPartWithFileData:portraitData name:@"portrait" fileName:@"portrait.jpg" mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:frontIdData name:@"frontId" fileName:@"frontId.jpg" mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:backIdData name:@"backId" fileName:@"backId.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure");
    }];
}

@end
