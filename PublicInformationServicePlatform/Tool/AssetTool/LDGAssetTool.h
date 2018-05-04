//
//  CPAssetTool.h
//  CountryTouristAdministration
//
//  Created by 汤亮 on 16/8/2.
//  Copyright © 2016年 daqsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface LDGAssetCollection : NSObject
/**
 *  相册的名字
 */
@property(nonatomic,strong) NSString *title;
/**
 *  该相册的照片数量
 */
@property(nonatomic,assign) NSInteger photoNum;
/**
 *  该相册的第一张图片
 */
@property(nonatomic,strong) PHAsset *firstAsset;
/**
 *  通过该属性可以取得该相册的所有照片
 */
@property(nonatomic,strong) PHAssetCollection *assetCollection;

@end

@interface LDGAssetTool : NSObject

/**
 *  获得所有系统相册和用户自定义相册
 *
 *  @return 所有系统相册和用户自定义相册
 */
+ (NSArray<LDGAssetCollection *> *)getAssetCollections;

/**
 *  取得所有指定多媒体类型的PHAsset实体
 *
 *  @param mediaType 多媒体类型(图片、视频、音频、LivePhoto)
 *  @param ascending 是否按时间升序，否则降序
 *
 *  @return 所有多媒体PHAsset实体
 */
+ (PHFetchResult<PHAsset *> *)getAssetsForMediaType:(PHAssetMediaType)mediaType ascending:(BOOL)ascending;

/**
 *  取到对应的照片实体
 *
 *  @param asset      PHAsset实体
 *  @param sync       是否同步获取
 *  @param targetSize       实际想要的照片大小
 *  @param completion 回调照片
 */
+ (void)requestImageForAsset:(PHAsset *)asset sync:(BOOL)sync targetSize:(CGSize)targetSize completion:(void (^)(UIImage *image))completion;

/**
 *  获取指定相册内的所有图片
 *
 *  @param assetCollection 相册实体
 *  @param ascending       是否按时间升序，否则降序
 *
 *  @return 相册实体下的所有照片
 */
+ (PHFetchResult<PHAsset *> *)getAssetsInAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending;

/**
 *  获取视频路径
 *
 *  @param asset      PHAsset实体
 *  @param completion   回调视频临时保存的路径
 */
+ (void)requestVideoForAsset:(PHAsset *)asset completion:(void (^)(NSString *videoPath))completion;

/**
 *  保存视频到相册
 *
 *  @param path      需要保存视频的本地路径
 *  @param completion   回调视频是否保存成功和PHAsset实体
 */
+ (void)saveVideoToCameraRollAtFileURL:(NSString *)path completion:(void (^)(BOOL success, PHAsset *asset))completion;

+ (void)saveImageToCameraRollFromImage:(UIImage *)image completion:(void (^)(BOOL success, PHAsset *asset))completion;

@end

