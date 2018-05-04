//
//  UIViewController+Extension.h
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/2/13.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertActionHandler)(UIAlertAction *action);

@class IDMPhoto;
@protocol IDMPhotoBrowserDelegate;

@interface UIViewController (Extension)

- (void)presentAlertControllerWithMessage:(NSString *)message;

- (void)presentAlertControllerWithMessage:(NSString *)message defaultHandler:(AlertActionHandler)defaultHandler;
- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message defaultHandler:(AlertActionHandler)defaultHandler;
- (void)presentAlertControllerWithMessage:(NSString *)message defaultTitle:(NSString *)defaultTitle defaultHandler:(AlertActionHandler)defaultHandler;
- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message defaultTitle:(NSString *)defaultTitle defaultHandler:(AlertActionHandler)defaultHandler;

- (void)presentAVPlayerViewControllerWithVideoURLString:(NSString *)videoURLString;

- (void)authenticateUserLoginWithBlock:(void(^)(void))block;
- (void)presentLoginViewController;


- (CGFloat)topBarHeight;
- (CGFloat)bottomBarHeight;

/**
 弹出图片浏览/查看器(实际上是UIViewController)

 @param photos IDMPhoto数组,by providing either UIImage objects, file paths to images on the device, or URLs to images online
 @param delegate 代理
 */
- (void)presentIDMPhotoBrowserWithPhotos:(NSArray<IDMPhoto *> *)photos delegate:(id<IDMPhotoBrowserDelegate>)delegate initialPageIndex:(NSUInteger)index;

- (void)presentTZImagePickerControllerWithMaxImagesCount:(NSInteger)maxImagesCount columnNumber:(NSInteger)columnNumber selectedAssets:(NSMutableArray *)selectedAssets didFinishPickingPhotosHandle:(void(^)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto))didFinishPickingPhotosHandle;

- (void)presentTZImagePickerControllerWithSelectedAssets:(NSMutableArray *)selectedAssets selectedPhotos:(NSMutableArray *)selectedPhotos index:(NSInteger)index maxImagesCount:(NSInteger)maxImagesCount didFinishPickingPhotosHandle:(void(^)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto))didFinishPickingPhotosHandle;

@end
