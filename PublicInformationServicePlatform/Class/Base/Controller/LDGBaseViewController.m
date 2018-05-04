//
//  QYJQBaseViewController.m
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/1/12.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import "LDGBaseViewController.h"

@interface LDGBaseViewController ()

@end

@implementation LDGBaseViewController

#pragma mark - StatusBar
- (BOOL)prefersStatusBarHidden
{
    return PrefersStatusBarHidden;
}

//当self.navigationController != nil && [self.navigationController isKindOfClass:[UINavigationController class]] && self.navigationController.navigationBarHidden = NO,这个方法不会调用
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return PreferredStatusBarStyle;
}

#pragma mark - Rotation
/*
 如果界面A(竖屏) Push到界面B(横屏),那么在界面B需要在合适的时机(例如viewWillAppear)执行:
 NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
 [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
 
 NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
 [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
 或者:
 if([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
 
        SEL selector = NSSelectorFromString(@"setOrientation:");
 
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
 
        [invocation setSelector:selector];
 
        [invocation setTarget:[UIDevice currentDevice]];
 
        int val = UIInterfaceOrientationLandscapeLeft;//横屏
 
        [invocation setArgument:&val atIndex:2];
 
        [invocation invoke];
 
}
 
 在iOS 9 之后横屏时，状态栏会消失。
 解决方法：确保plist 中的【View controller-based status bar appearance】为YES，然后重写ViewController的 - (BOOL)prefersStatusBarHidden ，返回值是NO。
 - (BOOL)prefersStatusBarHidden
 {
     return NO;
 }
 */
- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    MMLog(@"%@ dealloc.",NSStringFromClass([self class]));
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
