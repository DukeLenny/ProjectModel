//
//  LDGUtility.m
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/1/12.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import "LDGUtility.h"

#import <AVFoundation/AVFoundation.h>

#import <Photos/Photos.h>

#import "LDGFileManager.h"

#import "LDGNetworkCache.h"

@implementation LDGUtility

+ (PHFetchResult<PHAsset *> *)createdAssetsWithImage:(UIImage *)image creationDate:(NSDate *)creationDate location:(CLLocation *)location
{
    __block NSString *createdAssetId = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        assetChangeRequest.creationDate = creationDate;
        assetChangeRequest.location = location;
        createdAssetId = assetChangeRequest.placeholderForCreatedAsset.localIdentifier;
    } error:nil];
    if (createdAssetId == nil)
    {
        return nil;
    }
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[createdAssetId] options:nil];
}

+ (PHAssetCollection *)createdAssetCollection
{
    NSString *title = [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleNameKey];
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *assetCollection in assetCollections)
    {
        if ([assetCollection.localizedTitle isEqualToString:title])
        {
            return assetCollection;
        }
    }
    __block NSString *createdAssetCollectionId = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdAssetCollectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    if (createdAssetCollectionId == nil)
    {
        return nil;
    }
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdAssetCollectionId] options:nil][0];
}

+ (void)saveImageToAlbum:(UIImage *)image creationDate:(NSDate *)creationDate location:(CLLocation *)location
{
    PHFetchResult<PHAsset *> *assets = [self createdAssetsWithImage:image creationDate:creationDate location:location];
    PHAssetCollection *assetCollection = [self createdAssetCollection];
    if (assets == nil || assetCollection == nil)
    {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
        return;
    }
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        [assetCollectionChangeRequest insertAssets:assets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    if (error)
    {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }
    else
    {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

+ (void)saveImage:(UIImage *)image creationDate:(NSDate *)creationDate location:(CLLocation *)location
{
    PHAuthorizationStatus oldAuthorizationStatus = [PHPhotoLibrary authorizationStatus];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status)
            {
                case PHAuthorizationStatusAuthorized:
                {
                    [self saveImageToAlbum:image creationDate:creationDate location:location];
                }
                    break;
                case PHAuthorizationStatusDenied:
                {
                    if (oldAuthorizationStatus == PHAuthorizationStatusNotDetermined)
                    {
                        
                    }
                    else
                    {
                        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请在iPhone的\"设置-隐私-照片\"选项中,允许%@访问您的相册",[[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleNameKey]]];
                    }
                }
                    break;
                case PHAuthorizationStatusRestricted:
                {
                    [SVProgressHUD showErrorWithStatus:@"因系统原因，无法访问相册"];
                }
                    break;
                    
                default:
                    break;
            }
        });
    }];
}

/**
 *  截取指定时间的视频缩略图
 *
 *
 */
+ (UIImage *)thumbnailImageRequestWithVideoURLString:(NSString *)videoURLString
{
    //创建URL
    NSURL *url = [NSURL URLWithString:[videoURLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    //根据url创建AVURLAsset
    AVURLAsset *urlAsset = [AVURLAsset assetWithURL:url];
    //根据AVURLAsset创建AVAssetImageGenerator
    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    /*截图
     * requestTime:缩略图创建时间
     * actualTime:缩略图实际生成的时间
     */
    NSError *error = nil;
    CMTime time = CMTimeMakeWithSeconds(1, 10);//CMTime是表示电影时间信息的结构体，第一个参数表示是视频第几秒，第二个参数表示每秒帧数.(如果要活的某一秒的第几帧可以使用CMTimeMake方法)
    CMTime actualTime;
    CGImageRef cgImage = [imageGenerator copyCGImageAtTime:time actualTime:&actualTime error:&error];
    if(error){
        MMLog(@"截取视频缩略图时发生错误，错误信息：%@",error.localizedDescription);
        return nil;
    }
    CMTimeShow(actualTime);
    UIImage *image = [UIImage imageWithCGImage:cgImage];//转化为UIImage
    CGImageRelease(cgImage);
    return image;
}

+ (id)unarchiveObjectWithFileName:(NSString *)fileName
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[SandBoxCachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.dataFile",fileName]]];
}

+ (void)archiveRootObject:(id)rootObject toFileName:(NSString *)fileName
{
    [NSKeyedArchiver archiveRootObject:rootObject toFile:[SandBoxCachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.dataFile",fileName]]];
}

+ (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    if ([NSString isEmptyWithStr:htmlString])
    {
        return nil;
    }
    
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute : @(NSUTF8StringEncoding)};
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}

//退出登录
+ (void)logOut
{
    [LDGUserInfo saveUserInfo:[[LDGUserInfo alloc] init]];
//    WINDOW.rootViewController = (UIViewController *)(APPDELEGATE.loginAndRegisterNavigationController);
//    APPDELEGATE.navigationController = nil;
}

//清理缓存
+ (void)clearCache
{
    [LDGFileManager clearFolderAtPath:SandBoxCachesPath];
}

//清理缓存2
+ (void)clearCache2
{
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    [LDGNetworkCache removeAllHttpCache];
    
}

//清理内存
+ (void)clearMemory
{
    [[SDImageCache sharedImageCache] clearMemory];
    [LDGNetworkCache clearHTTPMemory];
    
}

+ (BOOL)currentTimeIsDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger currentHour = [calendar components:NSCalendarUnitHour fromDate:[NSDate date]].hour;
    return currentHour >= 6 && currentHour < 18;
}

@end
