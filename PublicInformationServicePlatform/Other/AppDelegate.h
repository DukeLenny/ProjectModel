//
//  AppDelegate.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/3/26.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LDGTabBarController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)setWindowRootViewController;

@property (nonatomic, strong) LDGTabBarController *tabBarController;

@end

