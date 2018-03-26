//
//  UIViewController+Extension.h
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/2/13.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertActionHandler)(UIAlertAction *action);

@interface UIViewController (Extension)

- (void)presentAlertControllerWithMessage:(NSString *)message;

- (void)presentAlertControllerWithMessage:(NSString *)message defaultHandler:(AlertActionHandler)defaultHandler;
- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message defaultHandler:(AlertActionHandler)defaultHandler;
- (void)presentAlertControllerWithMessage:(NSString *)message defaultTitle:(NSString *)defaultTitle defaultHandler:(AlertActionHandler)defaultHandler;
- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message defaultTitle:(NSString *)defaultTitle defaultHandler:(AlertActionHandler)defaultHandler;

- (void)presentAVPlayerViewControllerWithVideoURLString:(NSString *)videoURLString;

- (void)authenticateUserLoginWithBlock:(void(^)(void))block;

@end
