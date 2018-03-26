//
//  CPAssetTool.m
//  CountryTouristAdministration
//
//  Created by 汤亮 on 16/8/2.
//  Copyright © 2016年 daqsoft. All rights reserved.
//

#import "LDGAssetTool.h"

@implementation LDGAssetCollection

@end

@implementation LDGAssetTool

+ (NSString *)transformAblumTitle:(NSString *)title
{
    if ([title isEqualToString:@"Slo-mo"]) {
        return @"慢动作";
    } else if ([title isEqualToString:@"Recently Added"]) {
        return @"最近添加";
    } else if ([title isEqualToString:@"Favorites"]) {
        return @"最爱";
    } else if ([title isEqualToString:@"Recently Deleted"]) {
        return @"最近删除";
    } else if ([title isEqualToString:@"Videos"]) {
        return @"视频";
    } else if ([title isEqualToString:@"All Photos"]) {
        return @"所有照片";
    } else if ([title isEqualToString:@"Selfies"]) {
        return @"自拍";
    } else if ([title isEqualToString:@"Screenshots"]) {
        return @"屏幕快照";
    } else if ([title isEqualToString:@"Camera Roll"]) {
        return @"相机胶卷";
    }else if ([title isEqualToString:@"My Photo Stream"]){
        return @"我的照片流";
    }
    return title;
}

#pragma mark - 获得所有系统相册和用户自定义相册
+ (NSArray<LDGAssetCollection *> *)getAssetCollections
{
    NSMutableArray<LDGAssetCollection *> *assetCollections = [NSMutableArray array];
    //获取系统相册
    PHFetchResult *smartAlbum = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *assetCollection in smartAlbum) {
        if (!([assetCollection.localizedTitle isEqualToString:@"Recently Deleted"] || [assetCollection.localizedTitle isEqualToString:@"Videos"])) {
            PHFetchResult<PHAsset *> *result = [self getAssetsInAssetCollection:assetCollection ascending:NO];
            if (result.count > 0) {
                LDGAssetCollection *assstCollection = [[LDGAssetCollection alloc] init];
                assstCollection.title = [self transformAblumTitle:assetCollection.localizedTitle];
                assstCollection.photoNum = result.count;
                assstCollection.firstAsset = result.firstObject;
                assstCollection.assetCollection = assetCollection;
                [assetCollections addObject:assstCollection];
            }
        }
    }
    //用户创建的相册
    PHFetchResult *userAlbum = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    for (PHAssetCollection *assetCollection in userAlbum) {
        PHFetchResult<PHAsset *> *result = [self getAssetsInAssetCollection:assetCollection ascending:NO];
        if (result.count > 0) {
            LDGAssetCollection *assstCollection = [[LDGAssetCollection alloc] init];
            assstCollection.title = [self transformAblumTitle:assetCollection.localizedTitle];
            if (assstCollection.title == nil) {
                assstCollection.title = assetCollection.localizedTitle;
            }
            assstCollection.photoNum = result.count;
            assstCollection.firstAsset = result.firstObject;
            assstCollection.assetCollection = assetCollection;
            [assetCollections addObject:assstCollection];
        }
    }
    return assetCollections;
}

#pragma mark - 取到所有的asset资源
+ (PHFetchResult<PHAsset *> *)getAssetsForMediaType:(PHAssetMediaType)mediaType ascending:(BOOL)ascending
{
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
    PHFetchResult<PHAsset *> *result = [PHAsset fetchAssetsWithMediaType:mediaType options:option];
    return result;
}

#pragma mark - 获取asset相对应的照片
+ (void)requestImageForAsset:(PHAsset *)asset sync:(BOOL)sync targetSize:(CGSize)targetSize completion:(void (^)(UIImage *image))completion
{
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    //resizeMode：对请求的图像怎样缩放。有三种选择：None，不缩放；Fast，尽快地提供接近或稍微大于要求的尺寸；Exact，精准提供要求的尺寸。
    //deliveryMode：图像质量。有三种值：Opportunistic，在速度与质量中均衡；HighQualityFormat，不管花费多长时间，提供高质量图像；FastFormat，以最快速度提供好的质量。这个属性只有在 synchronous 为 true 时有效。
    //networkAccessAllowed：是否允许从iCloud下图片
    option.resizeMode = PHImageRequestOptionsResizeModeNone;//控制照片尺寸
    option.synchronous = sync;
    option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;//控制照片质量
    option.networkAccessAllowed = YES;
    //param：targetSize 即你想要的图片尺寸，若想要原尺寸则可输入PHImageManagerMaximumSize
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeDefault options:option resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        completion(image);
    }];
}

#pragma mark - 获得指定相册的所有照片
+ (PHFetchResult<PHAsset *> *)getAssetsInAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending
{
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
    PHFetchResult<PHAsset *> *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
    return result;
}

#pragma mark - 获取视频数据
+ (void)requestVideoForAsset:(PHAsset *)asset completion:(void (^)(NSString *videoPath))completion
{
    if (asset.mediaType == PHAssetMediaTypeVideo || asset.mediaSubtypes == PHAssetMediaSubtypePhotoLive) {
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        // 查找中等质量的视频
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeMediumQualityFormat;
        // 导出中等质量的视频
        [[PHImageManager defaultManager] requestExportSessionForVideo:asset options:options exportPreset:AVAssetExportPresetMediumQuality resultHandler:^(AVAssetExportSession * _Nullable exportSession, NSDictionary * _Nullable info) {
            NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"report.mov"];
            [NSFileManager.defaultManager removeItemAtPath:path error:NULL];
            exportSession.outputURL = [NSURL fileURLWithPath:path];
            exportSession.outputFileType = AVFileTypeQuickTimeMovie;
            [exportSession exportAsynchronouslyWithCompletionHandler:^{
                completion(path);
            }];
        }];
    } else {
        completion(nil);
    }
}

#pragma mark - 保存视频
+ (void)saveVideoToCameraRollAtFileURL:(NSString *)path completion:(void (^)(BOOL success, PHAsset *asset))completion
{
    // 保存视频到相机胶卷
    __block PHObjectPlaceholder *videoPlaceholder = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        videoPlaceholder = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:[NSURL fileURLWithPath:path]].placeholderForCreatedAsset;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[videoPlaceholder.localIdentifier] options:nil].firstObject;
                completion(YES, asset);
            }else {
                completion(NO, nil);
            }
        });
    }];
}

#pragma mark - 保存相片
+ (void)saveImageToCameraRollFromImage:(UIImage *)image completion:(void (^)(BOOL success, PHAsset *asset))completion
{
    // 保存相片到相机胶卷
    __block PHObjectPlaceholder *videoPlaceholder = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        videoPlaceholder = [PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[videoPlaceholder.localIdentifier] options:nil].firstObject;
                completion(YES, asset);
            }else {
                completion(NO, nil);
            }
        });
    }];
}

@end
