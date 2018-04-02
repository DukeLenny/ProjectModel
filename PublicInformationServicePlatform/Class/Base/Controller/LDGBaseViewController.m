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
    return NO;
}

//当self.navigationController != nil && [self.navigationController isKindOfClass:[UINavigationController class]] && self.navigationController.navigationBarHidden = NO,这个方法不会调用
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return PreferredStatusBarStyle;
}

#pragma mark - Rotation
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
