//
//  LDGNetworkManager.h
//  FourBigArea
//
//  Created by LiDinggui on 2016/11/19.
//  Copyright © 2016年 LiDinggui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "LDGNetworkCache.h"

typedef NS_ENUM(NSUInteger, LDGNetworkStatus) {
    /** 未知网络*/
    LDGNetworkStatusUnknown,
    /** 无网络*/
    LDGNetworkStatusNotReachable,
    /** 蜂窝移动网络*/
    LDGNetworkStatusReachableViaWWAN,
    /** 无线局域网*/
    LDGNetworkStatusReachableViaWiFi
};

typedef NS_ENUM(NSUInteger, LDGRequestSerializer) {
    /** 设置请求数据为JSON格式*/
    LDGRequestSerializerJSON,
    /** 设置请求数据为二进制格式*/
    LDGRequestSerializerHTTP,
};

typedef NS_ENUM(NSUInteger, LDGResponseSerializer) {
    /** 设置响应数据为JSON格式*/
    LDGResponseSerializerJSON,
    /** 设置响应数据为二进制格式*/
    LDGResponseSerializerHTTP,
};

/** 请求成功的Block */
typedef void(^HttpRequestSuccess)(id responseObject);

/** 请求失败的Block */
typedef void(^HttpRequestFailed)(NSError *error);

/** 缓存的Block */
typedef void(^HttpRequestCache)(id responseCache);

/** 上传或者下载的进度, progress.completedUnitCount:当前大小 - progress.totalUnitCount:总大小*/
typedef void(^HttpProgress)(NSProgress *progress);

/** 网络状态的Block*/
typedef void(^NetworkStatus)(LDGNetworkStatus status);

@interface LDGNetworkManager : NSObject

/**
 *  实时获取网络状态,通过Block回调实时获取(此方法可多次调用)
 */
+ (void)networkStatusWithBlock:(NetworkStatus)networkStatus;

/**
 *  实时获取当前网络状态,有网:YES,无网:NO
 */
+ (BOOL)currentNetworkStatus;

/**
 *  GET请求,无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)GET:(NSString *)URL
                        parameters:(NSDictionary *)parameters
                           success:(HttpRequestSuccess)success
                           failure:(HttpRequestFailed)failure;

/**
 *  GET请求,自动缓存
 *
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param responseCache 缓存数据的回调
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)GET:(NSString *)URL
                        parameters:(NSDictionary *)parameters
                     responseCache:(HttpRequestCache)responseCache
                           success:(HttpRequestSuccess)success
                           failure:(HttpRequestFailed)failure;

/**
 *  POST请求,无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)POST:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                            success:(HttpRequestSuccess)success
                            failure:(HttpRequestFailed)failure;

/**
 *  POST请求,自动缓存
 *
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param responseCache 缓存数据的回调
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)POST:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                      responseCache:(HttpRequestCache)responseCache
                            success:(HttpRequestSuccess)success
                            failure:(HttpRequestFailed)failure;

/**
 *  上传图片文件
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param images     图片数组
 *  @param name       文件对应服务器上的字段
 *  @param fileName   文件名
 *  @param mimeType   图片文件的类型,例:png、jpeg(默认类型)....
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)uploadWithURL:(NSString *)URL
                                  parameters:(NSDictionary *)parameters
                                      images:(NSArray<UIImage *> *)images
                                        name:(NSString *)name
                                    fileName:(NSString *)fileName
                                    mimeType:(NSString *)mimeType
                                    progress:(HttpProgress)progress
                                     success:(HttpRequestSuccess)success
                                     failure:(HttpRequestFailed)failure;

+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                             parameters:(NSDictionary *)parameters
                              fileDatas:(NSArray<NSData *> *)fileDatas
                                   name:(NSString *)name
                               fileName:(NSString *)fileName
                               mimeType:(NSString *)mimeType
                               progress:(HttpProgress)progress
                                success:(HttpRequestSuccess)success
                                failure:(HttpRequestFailed)failure;

/**
 *  下载文件
 *
 *  @param URL      请求地址
 *  @param fileDir  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */
+ (__kindof NSURLSessionTask *)downloadWithURL:(NSString *)URL
                                       fileDir:(NSString *)fileDir
                                      progress:(HttpProgress)progress
                                       success:(void(^)(NSString *filePath))success
                                       failure:(HttpRequestFailed)failure;


#pragma mark - 重置AFHTTPSessionManager相关属性
/**
 *  设置网络请求参数的格式:默认为JSON格式
 *
 *  @param requestSerializer LDGRequestSerializerJSON(JSON格式),LDGRequestSerializerHTTP(二进制格式),
 */
+ (void)setRequestSerializer:(LDGRequestSerializer)requestSerializer;

/**
 *  设置服务器响应数据格式:默认为JSON格式
 *
 *  @param responseSerializer LDGResponseSerializerJSON(JSON格式),LDGResponseSerializerHTTP(二进制格式)
 */
+ (void)setResponseSerializer:(LDGResponseSerializer)responseSerializer;

/**
 *  设置请求超时时间:默认为30S
 *
 *  @param time 时长
 */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time;

/**
 *  设置请求头
 */
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

/**
 *  是否打开网络状态转圈菊花:默认打开
 *
 *  @param open YES(打开), NO(关闭)
 */
+ (void)openNetworkActivityIndicator:(BOOL)open;

@end
