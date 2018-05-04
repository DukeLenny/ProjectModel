//
//  AppDelegate.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/3/26.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "AppDelegate.h"

#import "LDGTabBarController.h"
#import "LDGNavigationController.h"

#import "WXApiManager.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate

#pragma mark - LifeCycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setStatusBar];
    
    [self setSharedURLCache];
    [self setSDWebImage];
    [self setHUDConfiguration];
    [self setNetworkStatus];
    
    [self setWXApi];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self setWindowRootViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [LDGUtility clearMemory];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

#pragma mark - OtherMethods
- (void)setHUDConfiguration
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setMinimumDismissTimeInterval:1.2];
}

- (void)setSharedURLCache
{
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
}

- (void)setSDWebImage
{
    [[SDImageCache sharedImageCache].config setShouldDecompressImages:NO];
    [[SDWebImageDownloader sharedDownloader] setShouldDecompressImages:NO];
}

- (void)setNetworkStatus
{
    [LDGNetworkManager networkStatusWithBlock:^(LDGNetworkStatus status) {
        if (status == LDGNetworkStatusUnknown || status == LDGNetworkStatusNotReachable)
        {
            [SVProgressHUD showErrorWithStatus:@"网络未连接"];
        }
    }];
}

- (void)setWindowRootViewController
{
    LDGTabBarController *tabBarController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    [tabBarController addChildViewController:[self mineNavigationController]];
    tabBarController.delegate = self;
    self.window.rootViewController = tabBarController;
}

- (LDGNavigationController *)mineNavigationController
{
    LDGWebViewController *mineWebViewController = [[LDGWebViewController alloc] initWithAddress:[JKBUserCenterURLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    mineWebViewController.showsToolBar = NO;
    if (AX_WEB_VIEW_CONTROLLER_iOS9_0_AVAILABLE()) {
        mineWebViewController.webView.allowsLinkPreview = YES;
    }
    LDGNavigationController *mineNavigationController = [[LDGNavigationController alloc] initWithRootViewController:mineWebViewController];
    mineNavigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_personal_selected"];
    mineNavigationController.tabBarItem.title = @"我的";
    mineNavigationController.tabBarItem.image = [UIImage imageNamed:@"tab_personal_normal"];
    mineNavigationController.tabBarItem.tag = 3;
    return mineNavigationController;
}

- (void)setStatusBar
{
    APPLICATION.statusBarStyle = PreferredStatusBarStyle;
    APPLICATION.statusBarHidden = PrefersStatusBarHidden;
}

- (void)setWXApi
{
    [WXApi startLogByLevel:WXLogLevelNormal logBlock:^(NSString *log) {
        MMLog(@"log : %@", log);
    }];
    
    //向微信注册
    [WXApi registerApp:WXAppID enableMTA:YES];
    
    //向微信注册支持的文件类型
    UInt64 typeFlag = MMAPP_SUPPORT_TEXT | MMAPP_SUPPORT_PICTURE | MMAPP_SUPPORT_LOCATION | MMAPP_SUPPORT_VIDEO |MMAPP_SUPPORT_AUDIO | MMAPP_SUPPORT_WEBPAGE | MMAPP_SUPPORT_DOC | MMAPP_SUPPORT_DOCX | MMAPP_SUPPORT_PPT | MMAPP_SUPPORT_PPTX | MMAPP_SUPPORT_XLS | MMAPP_SUPPORT_XLSX | MMAPP_SUPPORT_PDF;
    
    [WXApi registerAppSupportContentFlag:typeFlag];
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController.tabBarItem.title isEqualToString:@"我的"])
    {
        //点击"我的"
        if (USER_ID)
        {
            return YES;
        }
        else
        {
            [tabBarController presentLoginViewController];
            return NO;
        }
    }
    return YES;
}

@end
