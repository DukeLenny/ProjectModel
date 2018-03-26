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

@implementation UIViewController (Extension)

- (void)presentAlertControllerWithMessage:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
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
    if (USER_INFO.ID != nil)
    {
        if (block)
        {
            block();
        }
    }
    else
    {
        [self presentViewController:[[UIStoryboard storyboardWithName:@"LoginAndRegister" bundle:nil] instantiateInitialViewController] animated:YES completion:nil];
    }
}

@end
