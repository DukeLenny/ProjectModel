//
//  UINavigationController+Extension.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/3/29.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "UINavigationController+Extension.h"

@implementation UINavigationController (Extension)

- (void)pushWebViewControllerWithURLString:(NSString *)URLString
{
    LDGWebViewController *webViewController = [[LDGWebViewController alloc] initWithAddress:[[NSString ifIsEmptyWithStr:URLString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    webViewController.showsToolBar = NO;
    if (AX_WEB_VIEW_CONTROLLER_iOS9_0_AVAILABLE()) {
        webViewController.webView.allowsLinkPreview = YES;
    }
    [self pushViewController:webViewController animated:YES];
}

@end
