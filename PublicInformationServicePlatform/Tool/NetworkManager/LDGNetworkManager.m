//
//  LDGNetworkManager.m
//  FourBigArea
//
//  Created by LiDinggui on 2016/11/19.
//  Copyright © 2016年 LiDinggui. All rights reserved.
//

#import "LDGNetworkManager.h"

#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation LDGNetworkManager

static BOOL _isNetwork;
static AFHTTPSessionManager *_manager;

#pragma mark - 开始监听网络

+ (void)networkStatusWithBlock:(NetworkStatus)networkStatus
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status)
            {
                case AFNetworkReachabilityStatusUnknown:
                    networkStatus ? networkStatus(LDGNetworkStatusUnknown) : nil;
                    _isNetwork = NO;
                    MMLog(@"未知网络");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    networkStatus ? networkStatus(LDGNetworkStatusNotReachable) : nil;
                    _isNetwork = NO;
                    MMLog(@"无网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    networkStatus ? networkStatus(LDGNetworkStatusReachableViaWWAN) : nil;
                    _isNetwork = YES;
                    MMLog(@"蜂窝移动网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    networkStatus ? networkStatus(LDGNetworkStatusReachableViaWiFi) : nil;
                    _isNetwork = YES;
                    MMLog(@"无线局域网");
                    break;
            }
        }];
        
        [manager startMonitoring];
    });
}

+ (BOOL)currentNetworkStatus
{
    [self networkStatusWithBlock:nil];
    return _isNetwork;
}

#pragma mark - GET请求无缓存

+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(NSDictionary *)parameters
                  success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailed)failure
{
    return [self GET:URL parameters:parameters responseCache:nil success:success failure:failure];
}


#pragma mark - POST请求无缓存

+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(NSDictionary *)parameters
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure
{
    return [self POST:URL parameters:parameters responseCache:nil success:success failure:failure];
}


#pragma mark - GET请求自动缓存


+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(NSDictionary *)parameters
            responseCache:(HttpRequestCache)responseCache
                  success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailed)failure
{
    //读取缓存
    responseCache ? responseCache([LDGNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    
    return [_manager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache ? [LDGNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
        MMLog(@"responseObject = %@",[self jsonToString:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure ? failure(error) : nil;
        MMLog(@"error = %@",error);
        
    }];
}


#pragma mark - POST请求自动缓存


+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(NSDictionary *)parameters
             responseCache:(HttpRequestCache)responseCache
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailed)failure
{
    //读取缓存
    responseCache ? responseCache([LDGNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    
    return [_manager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache ? [LDGNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
        MMLog(@"responseObject = %@",[self jsonToString:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure ? failure(error) : nil;
        MMLog(@"error = %@",error);
    }];
    
}

#pragma mark - 上传图片文件

+ (NSURLSessionTask *)uploadWithURL:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                             images:(NSArray<UIImage *> *)images
                               name:(NSString *)name
                           fileName:(NSString *)fileName
                           mimeType:(NSString *)mimeType
                           progress:(HttpProgress)progress
                            success:(HttpRequestSuccess)success
                            failure:(HttpRequestFailed)failure
{
    
    return [_manager POST:URL parameters:parameters constructingBodyWithBlock:^(id formData) {
        //压缩-添加-上传图片
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *imageData = UIImageJPEGRepresentation(image, CompressionQuality);
            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"%@%lu.%@",fileName,(unsigned long)idx,mimeType?mimeType:@"jpeg"] mimeType:[NSString stringWithFormat:@"image/%@",mimeType ? mimeType : @"jpeg"]];
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success ? success(responseObject) : nil;
        MMLog(@"responseObject = %@",[self jsonToString:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure ? failure(error) : nil;
        MMLog(@"error = %@",error);
    }];
}

#pragma mark - 上传文件

+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                             fileDatas:(NSArray<NSData *> *)fileDatas
                               name:(NSString *)name
                           fileName:(NSString *)fileName
                           mimeType:(NSString *)mimeType
                           progress:(HttpProgress)progress
                            success:(HttpRequestSuccess)success
                            failure:(HttpRequestFailed)failure
{
    
    return [_manager POST:URL parameters:parameters constructingBodyWithBlock:^(id formData) {
        [fileDatas enumerateObjectsUsingBlock:^(NSData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [formData appendPartWithFileData:obj name:name fileName:[NSString stringWithFormat:@"%@%lu.%@",fileName,(unsigned long)idx,mimeType] mimeType:mimeType];
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success ? success(responseObject) : nil;
        MMLog(@"responseObject = %@",[self jsonToString:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure ? failure(error) : nil;
        MMLog(@"error = %@",error);
    }];
}

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(HttpProgress)progress
                              success:(void(^)(NSString *))success
                              failure:(HttpRequestFailed)failure
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    NSURLSessionDownloadTask *downloadTask = [_manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
        MMLog(@"下载进度:%.2f%%",100.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        
        MMLog(@"downloadDir = %@",downloadDir);
        
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if(failure && error) {failure(error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        
    }];
    
    //开始下载
    [downloadTask resume];
    
    return downloadTask;
    
}

/**
 *  json转字符串
 */

+ (NSString *)jsonToString:(id)data
{
    if(!data) { return nil; }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


#pragma mark - 初始化AFHTTPSessionManager相关属性
/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager,原理参考地址:http://www.jianshu.com/p/5969bbb4af9f
 *  + (void)initialize该初始化方法在当用到此类时候只调用一次
 */
+ (void)initialize
{
    _manager = [AFHTTPSessionManager manager];
    //设置请求参数的类型:JSON (AFJSONRequestSerializer,AFHTTPRequestSerializer)
//    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置请求的超时时间
//    _manager.requestSerializer.timeoutInterval = 30.f;
    //设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
//    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];

    //打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

#pragma mark - 重置AFHTTPSessionManager相关属性

+ (void)setRequestSerializer:(LDGRequestSerializer)requestSerializer
{
    _manager.requestSerializer = requestSerializer==LDGRequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

+ (void)setResponseSerializer:(LDGResponseSerializer)responseSerializer
{
    _manager.responseSerializer = responseSerializer==LDGResponseSerializerHTTP ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)time
{
    _manager.requestSerializer.timeoutInterval = time;
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field
{
    [_manager.requestSerializer setValue:value forHTTPHeaderField:field];
}

+ (void)openNetworkActivityIndicator:(BOOL)open
{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:open];
}


@end
