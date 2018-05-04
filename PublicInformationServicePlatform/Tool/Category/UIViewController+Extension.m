//
//  UIViewController+Extension.m
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/2/13.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import "UIViewController+Extension.h"

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <IDMPhotoBrowser/IDMPhotoBrowser.h>
#import <TZImagePickerController/TZImagePickerController.h>

@implementation UIViewController (Extension)

- (void)presentAlertControllerWithMessage:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)presentAlertControllerWithMessage:(NSString *)message defaultHandler:(AlertActionHandler)defaultHandler
{
    [self presentAlertControllerWithTitle:@"提示" message:message defaultHandler:defaultHandler];
}

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message defaultHandler:(AlertActionHandler)defaultHandler
{
    [self presentAlertControllerWithTitle:title message:message defaultTitle:@"确定" defaultHandler:defaultHandler];
}

- (void)presentAlertControllerWithMessage:(NSString *)message defaultTitle:(NSString *)defaultTitle defaultHandler:(AlertActionHandler)defaultHandler
{
    [self presentAlertControllerWithTitle:@"提示" message:message defaultTitle:defaultTitle defaultHandler:defaultHandler];
}

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message defaultTitle:(NSString *)defaultTitle defaultHandler:(AlertActionHandler)defaultHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:defaultTitle style:UIAlertActionStyleDefault handler:defaultHandler]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)presentAVPlayerViewControllerWithVideoURLString:(NSString *)videoURLString
{
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:[[NSString URLStringWithString:videoURLString rootURLString:BaseURLString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    playerViewController.player = player;
    playerViewController.showsPlaybackControls = YES;
    playerViewController.videoGravity = AVLayerVideoGravityResizeAspect;
    [self presentViewController:playerViewController animated:YES completion:nil];
}

- (void)authenticateUserLoginWithBlock:(void (^)(void))block
{
    if (USER_ID != nil)
    {
        if (block)
        {
            block();
        }
    }
    else
    {
        [self presentLoginViewController];
    }
}

- (void)presentLoginViewController
{
    [self presentViewController:[[UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil] instantiateInitialViewController] animated:YES completion:nil];
}

- (CGFloat)topBarHeight
{
    return StatusBarHeight + self.navigationController.navigationBar.bounds.size.height;
}

- (CGFloat)bottomBarHeight
{
    CGFloat bottomBarHeight = self.tabBarController.tabBar.bounds.size.height;
    if (IS_IPHONE_X)
    {
        bottomBarHeight += 34.0;
    }
    return bottomBarHeight;
}

- (void)presentIDMPhotoBrowserWithPhotos:(NSArray<IDMPhoto *> *)photos delegate:(id<IDMPhotoBrowserDelegate>)delegate initialPageIndex:(NSUInteger)index
{
    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos];
    browser.delegate = delegate;
    browser.displayToolbar = YES;
    browser.displayActionButton = NO;
    browser.displayArrowButton = YES;
    browser.displayCounterLabel = YES;
//    browser.leftArrowImage = [UIImage imageNamed:@"IDMPhotoBrowser_customArrowLeft.png"];
//    browser.rightArrowImage = [UIImage imageNamed:@"IDMPhotoBrowser_customArrowRight.png"];
//    browser.leftArrowSelectedImage = [UIImage imageNamed:@"IDMPhotoBrowser_customArrowLeftSelected.png"];
//    browser.rightArrowSelectedImage = [UIImage imageNamed:@"IDMPhotoBrowser_customArrowRightSelected.png"];
//    browser.actionButtonTitles = @[@"Option 1", @"Option 2", @"Option 3", @"Option 4"];
//    browser.actionButtonImage
//    browser.actionButtonSelectedImage
    //trackTintColor,progressTintColor,doneButtonRightInset,doneButtonTopInset,doneButtonSize,scaleImage
    browser.arrowButtonsChangePhotosAnimated = YES;
    browser.useWhiteBackgroundColor = NO;
    browser.displayDoneButton = YES;
//    browser.doneButtonImage = [UIImage imageNamed:@"IDMPhotoBrowser_customDoneButton.png"];
    browser.autoHideInterface = NO;
    browser.usePopAnimation = YES;
    browser.forceHideStatusBar = NO;
    browser.disableVerticalSwipe = NO;
    browser.dismissOnTouch = YES;
    [browser setInitialPageIndex:index];
    [self presentViewController:browser animated:YES completion:nil];
}

- (void)presentTZImagePickerControllerWithMaxImagesCount:(NSInteger)maxImagesCount columnNumber:(NSInteger)columnNumber selectedAssets:(NSMutableArray *)selectedAssets didFinishPickingPhotosHandle:(void(^)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto))didFinishPickingPhotosHandle
{
    if (maxImagesCount <= 0)
    {
        return;
    }
    
    TZImagePickerController *imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:maxImagesCount columnNumber:columnNumber delegate:nil pushPhotoPickerVc:YES];
    imagePickerController.isSelectOriginalPhoto = YES;
    if (maxImagesCount > 1)
    {
        imagePickerController.selectedAssets = selectedAssets;
    }
    imagePickerController.sortAscendingByModificationDate = NO;
    imagePickerController.allowPickingOriginalPhoto = YES;
    imagePickerController.allowPickingVideo = NO;
    imagePickerController.allowPickingGif = NO;
    imagePickerController.allowPickingImage = YES;
    imagePickerController.allowTakePicture = YES;
    imagePickerController.allowPreview = YES;
    imagePickerController.statusBarStyle = PreferredStatusBarStyle;
    imagePickerController.showSelectBtn = NO;
    imagePickerController.allowCrop = YES;
    imagePickerController.needCircleCrop = NO;
//    imagePickerController.photoSelImageName
//    imagePickerController.photoOriginSelImageName
//    imagePickerController.photoNumberIconImageName
    imagePickerController.oKButtonTitleColorNormal = NavigationBarBarTintColor;
    imagePickerController.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    imagePickerController.naviBgColor = NavigationBarBarTintColor;
    imagePickerController.naviTitleColor = NavigationBarTitleForegroundColor;
    imagePickerController.naviTitleFont = [UIFont boldSystemFontOfSize:NavigationBarTitleFontSize];
    imagePickerController.barItemTextColor = NavigationBarTintColor;
    //    imagePickerController.barItemTextFont
    imagePickerController.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (assets.count > 0)
        {
            didFinishPickingPhotosHandle(photos,assets,isSelectOriginalPhoto);
        }
    };
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)presentTZImagePickerControllerWithSelectedAssets:(NSMutableArray *)selectedAssets selectedPhotos:(NSMutableArray *)selectedPhotos index:(NSInteger)index maxImagesCount:(NSInteger)maxImagesCount didFinishPickingPhotosHandle:(void(^)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto))didFinishPickingPhotosHandle
{
    TZImagePickerController *imagePickerController = [[TZImagePickerController alloc] initWithSelectedAssets:selectedAssets selectedPhotos:selectedPhotos index:index];
    imagePickerController.maxImagesCount = maxImagesCount;
    imagePickerController.isSelectOriginalPhoto = YES;
    imagePickerController.sortAscendingByModificationDate = NO;
    imagePickerController.allowPickingOriginalPhoto = YES;
    imagePickerController.allowPickingVideo = NO;
    imagePickerController.allowPickingGif = NO;
    imagePickerController.allowPickingImage = YES;
    imagePickerController.allowTakePicture = NO;
    imagePickerController.statusBarStyle = PreferredStatusBarStyle;
    imagePickerController.showSelectBtn = YES;
    imagePickerController.oKButtonTitleColorNormal = NavigationBarBarTintColor;
    imagePickerController.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    imagePickerController.naviBgColor = NavigationBarBarTintColor;
    imagePickerController.naviTitleColor = NavigationBarTitleForegroundColor;
    imagePickerController.naviTitleFont = [UIFont boldSystemFontOfSize:NavigationBarTitleFontSize];
    imagePickerController.barItemTextColor = NavigationBarTintColor;
    imagePickerController.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (assets.count > 0)
        {
            didFinishPickingPhotosHandle(photos,assets,isSelectOriginalPhoto);
        }
    };
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

@end
