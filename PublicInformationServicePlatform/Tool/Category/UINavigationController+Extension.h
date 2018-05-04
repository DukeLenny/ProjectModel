//
//  UINavigationController+Extension.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/3/29.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Extension)

/**
 push一个"类似微信"的网页浏览器

 @param URLString 动态网页的地址
 */
- (void)pushWebViewControllerWithURLString:(NSString *)URLString;

@end
