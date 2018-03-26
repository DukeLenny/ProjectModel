//
//  QYJQTabBarController.m
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/1/12.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import "LDGTabBarController.h"

@interface LDGTabBarController ()

@end

@implementation LDGTabBarController

+ (void)initialize
{
    UITabBar *tabBar = [UITabBar appearance];
    tabBar.translucent = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.tintColor = TabBarTintColor;
    
//    self.tabBar.hidden = YES;
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

#pragma mark - Rotation

- (BOOL)shouldAutorotate
{
    if ([self.selectedViewController respondsToSelector:@selector(shouldAutorotate)])
    {
        return [self.selectedViewController shouldAutorotate];
    }
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([self.selectedViewController respondsToSelector:@selector(supportedInterfaceOrientations)])
    {
        return [self.selectedViewController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    if ([self.selectedViewController respondsToSelector:@selector(preferredInterfaceOrientationForPresentation)])
    {
        return [self.selectedViewController preferredInterfaceOrientationForPresentation];
    }
    return UIInterfaceOrientationPortrait;
}

@end
