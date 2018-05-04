//
//  QYJQNetworkManager.m
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/1/12.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import "DLNetworkManager.h"

@implementation DLNetworkManager

//static NSString * const BaseURLString = @"/";//内网
//static NSString * const BaseURLString = @"/";//外网

#pragma mark - POST
//默认不开启网络数据缓存,开启正在请求的转圈圈提示
+ (__kindof NSURLSessionTask *)postRequestWithInterfaceName:(NSString *)interfaceName parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    return [self postRequestWithInterfaceName:interfaceName parameters:parameters success:success failure:failure showHUDWithStatus:HUD_LOADING_STATUS cache:NO];
}

//默认不开启网络数据缓存,正在请求的转圈圈提示:status为nil,不提示;status为HUD_LOADING_STATUS,提示但无文本;status为其它值时提示且显示文本status
+ (__kindof NSURLSessionTask *)postRequestWithInterfaceName:(NSString *)interfaceName parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure showHUDWithStatus:(NSString *)status
{
    return [self postRequestWithInterfaceName:interfaceName parameters:parameters success:success failure:failure showHUDWithStatus:status cache:NO];
}

//默认开启正在请求的转圈圈提示,网络数据缓存:cache为YES,开启;cache为NO,不开启
+ (__kindof NSURLSessionTask *)postRequestWithInterfaceName:(NSString *)interfaceName parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure cache:(BOOL)cache
{
    return [self postRequestWithInterfaceName:interfaceName parameters:parameters success:success failure:failure showHUDWithStatus:HUD_LOADING_STATUS cache:cache];
}

+ (__kindof NSURLSessionTask *)postRequestWithInterfaceName:(NSString *)interfaceName parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure showHUDWithStatus:(NSString *)status cache:(BOOL)cache
{
    NSString *URLString = [NSString stringWithFormat:@"%@%@",BaseURLString,interfaceName];
    return [self postRequestWithURLString:URLString parameters:parameters success:success failure:failure showHUDWithStatus:status cache:cache];
}

//默认不开启网络数据缓存,开启正在请求的转圈圈提示
+ (__kindof NSURLSessionTask *)postRequestWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    return [self postRequestWithURLString:URLString parameters:parameters success:success failure:failure showHUDWithStatus:HUD_LOADING_STATUS cache:NO];
}

//默认不开启网络数据缓存,正在请求的转圈圈提示:status为nil,不提示;status为HUD_LOADING_STATUS,提示但无文本;status为其它值时提示且显示文本status
+ (__kindof NSURLSessionTask *)postRequestWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure showHUDWithStatus:(NSString *)status
{
    return [self postRequestWithURLString:URLString parameters:parameters success:success failure:failure showHUDWithStatus:status cache:NO];
}

//默认开启正在请求的转圈圈提示,网络数据缓存:cache为YES,开启;cache为NO,不开启
+ (__kindof NSURLSessionTask *)postRequestWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure cache:(BOOL)cache
{
    return [self postRequestWithURLString:URLString parameters:parameters success:success failure:failure showHUDWithStatus:HUD_LOADING_STATUS cache:cache];
}

+ (__kindof NSURLSessionTask *)postRequestWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure showHUDWithStatus:(NSString *)status cache:(BOOL)cache
{
    if (status != nil)
    {
        [SVProgressHUD showWithStatus:status];
    }
    
    MMLog(@"\n\n请求地址: %@\n\n请求参数:\n%@",URLString,parameters);
    NSURLSessionTask *task = [LDGNetworkManager POST:URLString parameters:parameters responseCache:cache?success:nil success:^(id responseObject) {
        if (status != nil)
        {
            [SVProgressHUD dismiss];
        }
        
//        NSString *sessionState = responseObject[@"data"][@"sessionState"];
//        if ([sessionState isEqualToString:@"false"])
//        {
//            WINDOW.rootViewController = (UIViewController *)(APPDELEGATE.loginAndRegisterNavigationController);
//            APPDELEGATE.navigationController = nil;
//            [WINDOW.rootViewController presentAlertControllerWithMessage:@"登录会话已过期,请重新登录"];
//        }
//        else
//        {
            success?success(responseObject):nil;
//        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:HUD_ERROR_STATUS];
        failure?failure(error):nil;
    }];
    return task;
}

#pragma mark - GET
//默认不开启网络数据缓存,开启正在请求的转圈圈提示
+ (__kindof NSURLSessionTask *)getRequestWithInterfaceName:(NSString *)interfaceName parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    return [self getRequestWithInterfaceName:interfaceName parameters:parameters success:success failure:failure showHUDWithStatus:HUD_LOADING_STATUS cache:NO];
}

//默认不开启网络数据缓存,正在请求的转圈圈提示:status为nil,不提示;status为HUD_LOADING_STATUS,提示但无文本;status为其它值时提示且显示文本status
+ (__kindof NSURLSessionTask *)getRequestWithInterfaceName:(NSString *)interfaceName parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure showHUDWithStatus:(NSString *)status
{
    return [self getRequestWithInterfaceName:interfaceName parameters:parameters success:success failure:failure showHUDWithStatus:status cache:NO];
}

//默认开启正在请求的转圈圈提示,网络数据缓存:cache为YES,开启;cache为NO,不开启
+ (__kindof NSURLSessionTask *)getRequestWithInterfaceName:(NSString *)interfaceName parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure cache:(BOOL)cache
{
    return [self getRequestWithInterfaceName:interfaceName parameters:parameters success:success failure:failure showHUDWithStatus:HUD_LOADING_STATUS cache:cache];
}

+ (__kindof NSURLSessionTask *)getRequestWithInterfaceName:(NSString *)interfaceName parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure showHUDWithStatus:(NSString *)status cache:(BOOL)cache
{
    NSString *URLString = [NSString stringWithFormat:@"%@%@",BaseURLString,interfaceName];
    
    return [self getRequestWithURLString:URLString parameters:parameters success:success failure:failure showHUDWithStatus:status cache:cache];
}

//默认不开启网络数据缓存,开启正在请求的转圈圈提示
+ (__kindof NSURLSessionTask *)getRequestWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    return [self getRequestWithURLString:URLString parameters:parameters success:success failure:failure showHUDWithStatus:HUD_LOADING_STATUS cache:NO];
}

//默认不开启网络数据缓存,正在请求的转圈圈提示:status为nil,不提示;status为HUD_LOADING_STATUS,提示但无文本;status为其它值时提示且显示文本status
+ (__kindof NSURLSessionTask *)getRequestWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure showHUDWithStatus:(NSString *)status
{
    return [self getRequestWithURLString:URLString parameters:parameters success:success failure:failure showHUDWithStatus:status cache:NO];
}

//默认开启正在请求的转圈圈提示,网络数据缓存:cache为YES,开启;cache为NO,不开启
+ (__kindof NSURLSessionTask *)getRequestWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure cache:(BOOL)cache
{
    return [self getRequestWithURLString:URLString parameters:parameters success:success failure:failure showHUDWithStatus:HUD_LOADING_STATUS cache:cache];
}

+ (__kindof NSURLSessionTask *)getRequestWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure showHUDWithStatus:(NSString *)status cache:(BOOL)cache
{
    if (status != nil)
    {
        [SVProgressHUD showWithStatus:status];
    }
    
    MMLog(@"\n\n请求地址: %@\n\n请求参数:\n%@",URLString,parameters);
    NSURLSessionTask *task = [LDGNetworkManager GET:[URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:parameters responseCache:cache?success:nil success:^(id responseObject) {
        if (status != nil)
        {
            [SVProgressHUD dismiss];
        }
        success?success(responseObject):nil;
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:HUD_ERROR_STATUS];
        failure?failure(error):nil;
    }];
    return task;
}


@end
