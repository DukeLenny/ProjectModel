//
//  QYJQNavigationController.m
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/1/12.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import "LDGNavigationController.h"

#define BackBarButtonItemTitle @""
#define NavigationBarBackIndicatorImageName @"nav_back"
#define NavigationBarBackgroundImageName @"nav_bg"



@interface LDGNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation LDGNavigationController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.translucent = NO;
    bar.tintColor = NavigationBarTintColor;
    bar.backIndicatorImage = [UIImage imageNamed:NavigationBarBackIndicatorImageName];
    bar.backIndicatorTransitionMaskImage = [UIImage imageNamed:NavigationBarBackIndicatorImageName];
    bar.shadowImage = UIImage.new;
    //    [bar setBackgroundImage:[UIImage imageNamed:NavigationBarBackgroundImageName] forBarMetrics:UIBarMetricsDefault];
    bar.barTintColor = NavigationBarBarTintColor;
    [bar setTitleTextAttributes:@{
                                  NSForegroundColorAttributeName: NavigationBarTitleForegroundColor,
                                  NSFontAttributeName: [UIFont boldSystemFontOfSize:NavigationBarTitleFontSize]
                                  }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    
    // 代理
    self.delegate = self;
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan
{
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - UIGestureRecognizerDelegate
// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.viewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:BackBarButtonItemTitle style:UIBarButtonItemStylePlain target:nil action:NULL];
}

#pragma mark - Rotation
- (BOOL)shouldAutorotate
{
    if ([self.topViewController respondsToSelector:@selector(shouldAutorotate)])
    {
        return [self.topViewController shouldAutorotate];
    }
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([self.topViewController respondsToSelector:@selector(supportedInterfaceOrientations)])
    {
        return [self.topViewController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    if ([self.topViewController respondsToSelector:@selector(preferredInterfaceOrientationForPresentation)])
    {
        return [self.topViewController preferredInterfaceOrientationForPresentation];
    }
    return UIInterfaceOrientationPortrait;
}

@end
