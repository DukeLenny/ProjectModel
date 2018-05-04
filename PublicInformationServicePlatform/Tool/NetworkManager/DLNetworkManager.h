//
//  QYJQNetworkManager.h
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/1/12.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLNetworkManager : NSObject

#pragma mark - POST
//默认不开启网络数据缓存,开启正在请求的转圈圈提示
+ (__kindof NSURLSessionTask *)postRequestWithInterfaceName:(NSString *)interfaceName parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

//默认不开启网络数据缓存,正在请求的转圈圈提示:status为nil,不提示;status为@"",提示但无文本;status为其它值时提示且显示文本status
+ (__kindof NSURLSessionTask *)postRequestWithInterfaceName:(NSString *)interfaceName parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure showHUDWithStatus:(NSString *)status;

//默认开启正在请求的转圈圈提示,网络数据缓存:cache为YES,开启;cache为NO,不开启
+ (__kindof NSURLSessionTask *)postRequestWithInterfaceName:(NSString *)interfaceName parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure cache:(BOOL)cache;

+ (__kindof NSURLSessionTask *)postRequestWithInterfaceName:(NSString *)interfaceName parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure showHUDWithStatus:(NSString *)status cache:(BOOL)cache;

//默认不开启网络数据缓存,开启正在请求的转圈圈提示
+ (__kindof NSURLSessionTask *)postRequestWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

//默认不开启网络数据缓存,正在请求的转圈圈提示:status为nil,不提示;status为@"",提示但无文本;status为其它值时提示且显示文本status
+ (__kindof NSURLSessionTask *)postRequestWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure showHUDWithStatus:(NSString *)status;

//默认开启正在请求的转圈圈提示,网络数据缓存:cache为YES,开启;cache为NO,不开启
+ (__kindof NSURLSessionTask *)postRequestWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure cache:(BOOL)cache;

+ (__kindof NSURLSessionTask *)postRequestWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure showHUDWithStatus:(NSString *)status cache:(BOOL)cache;

#pragma mark - GET
//默认不开启网络数据缓存,开启正在请求的转圈圈提示
+ (__kindof NSURLSessionTask *)getRequestWithInterfaceName:(NSString *)interfaceName parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

//默认不开启网络数据缓存,正在请求的转圈圈提示:status为nil,不提示;status为@"",提示但无文本;status为其它值时提示且显示文本status
+ (__kindof NSURLSessionTask *)getRequestWithInterfaceName:(NSString *)interfaceName parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure showHUDWithStatus:(NSString *)status;

//默认开启正在请求的转圈圈提示,网络数据缓存:cache为YES,开启;cache为NO,不开启
+ (__kindof NSURLSessionTask *)getRequestWithInterfaceName:(NSString *)interfaceName parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure cache:(BOOL)cache;

+ (__kindof NSURLSessionTask *)getRequestWithInterfaceName:(NSString *)interfaceName parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure showHUDWithStatus:(NSString *)status cache:(BOOL)cache;

//默认不开启网络数据缓存,开启正在请求的转圈圈提示
+ (__kindof NSURLSessionTask *)getRequestWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

//默认不开启网络数据缓存,正在请求的转圈圈提示:status为nil,不提示;status为@"",提示但无文本;status为其它值时提示且显示文本status
+ (__kindof NSURLSessionTask *)getRequestWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure showHUDWithStatus:(NSString *)status;

//默认开启正在请求的转圈圈提示,网络数据缓存:cache为YES,开启;cache为NO,不开启
+ (__kindof NSURLSessionTask *)getRequestWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure cache:(BOOL)cache;

+ (__kindof NSURLSessionTask *)getRequestWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure showHUDWithStatus:(NSString *)status cache:(BOOL)cache;

@end
