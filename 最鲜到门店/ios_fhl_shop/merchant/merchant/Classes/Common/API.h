//
//  API.h
//  FHL
//
//  Created by panume on 14-9-22.
//  Copyright (c) 2014年 JUEWEI. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface API : AFHTTPRequestOperationManager

+ (instancetype)shareAPI;

- (void)GET:(NSString *)URLString params:(NSDictionary *)params
                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)POST:(NSString *)URLString params:(NSDictionary *)params
                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)POST:(NSString *)URLString parameters:(id)parameters
                    constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)PUT:(NSString *)URLString parameters:(id)parameters
                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)DELETE:(NSString *)URLString parameters:(id)parameters
                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


- (void)getPhoneIdWithBlock:(void (^)(NSString *phoneId, NSError *error))block;//获取phoneId
- (void)hitHeartWithParams:(NSDictionary *)params block:(void(^)(NSError *error))block;//心跳
- (void)updateLocationParams:(NSDictionary *)params block:(void(^)(NSError *error))block;//更新地理位置
- (void)setPushWithParams:(NSDictionary *)params block:(void(^)(NSError *error))block;//发送push信息
- (void)shopLogWithParams:(NSDictionary *)params block:(void(^)(UIImage *image, NSError *error))block;

- (void)portraitWithBlock:(void(^)(UIImage *image, NSError *error))block;

- (void)imageFileWithUrl:(NSString *)URLString withBrandId:(NSString*)brandId  block:(void(^)(UIImage *image, NSError *error))block;
- (void)imageFileWithUrl:(NSString *)URLString withBullid:(NSString*)bullid withIndex:(NSString*)index  block:(void (^)(UIImage *, NSError *))block;

- (NSMutableURLRequest *)GetRequest:(NSString *)URLString params:(NSDictionary *)parameters;

- (void)REQUES :(NSString *)method WITHURL:(NSString *)URLString params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(id responseObject, NSError *error))failure;

@end
