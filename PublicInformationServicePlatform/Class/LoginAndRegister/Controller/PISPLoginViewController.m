//
//  PISPLoginViewController.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/3/28.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPLoginViewController.h"

#import "UIViewController+Cloudox.h"

#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "WechatAuthSDK.h"

@interface PISPLoginViewController ()<WXApiManagerDelegate, WechatAuthAPIDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *weChatLogoImageView;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation PISPLoginViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(barButtonClicked)];
    
    self.shapeLayer = [[CAShapeLayer alloc] init];
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.strokeColor = [UIColor colorWithWhite:1.0 alpha:0.5].CGColor;
    self.shapeLayer.lineWidth = 5.0;
    [self.view.layer addSublayer:self.shapeLayer];
    
    [WXApiManager sharedManager].delegate = self;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.weChatLogoImageView.layer.cornerRadius = self.weChatLogoImageView.bounds.size.height / 2.0;
    self.weChatLogoImageView.layer.masksToBounds = YES;
    
    self.shapeLayer.path = [UIBezierPath bezierPathWithArcCenter:self.weChatLogoImageView.center radius:self.weChatLogoImageView.bounds.size.height / 2.0 + 2.0 startAngle:0 endAngle:M_PI clockwise:NO].CGPath;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navBarBgAlpha = @"0.0";
}

- (void)dealloc
{
    [WXApiManager sharedManager].delegate = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - RequestData
- (void)getAccessTokenWithCode:(NSString *)code
{
    NSDictionary *parameters = @{
                                 @"appid" : WXAppID,
                                 @"secret" : WXAppSecret,
                                 @"code" : code,
                                 @"grant_type" : @"authorization_code"
                                 };
    [DLNetworkManager getRequestWithURLString:[WXBaseURLString stringByAppendingString:@"oauth2/access_token"] parameters:parameters success:^(id responseObject) {
        NSString *access_token = responseObject[@"access_token"];
        NSString *openid = responseObject[@"openid"];
        if (![NSString isEmptyWithStr:access_token])
        {
            [self getUserInfoWithAccessToken:access_token openid:openid];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"获取access_token失败"];
        }
    } failure:nil];
}

- (void)getUserInfoWithAccessToken:(NSString *)accessToken openid:(NSString *)openid
{
    NSDictionary *parameters = @{
                                 @"access_token" : accessToken,
                                 @"openid" : openid
                                 };
    [DLNetworkManager getRequestWithURLString:[WXBaseURLString stringByAppendingString:@"userinfo"] parameters:parameters success:^(id responseObject) {
        LDGUserInfo *userInfo = [LDGUserInfo mj_objectWithKeyValues:responseObject];
        if (userInfo.openid)
        {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [LDGUserInfo saveUserInfo:userInfo];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"登录失败"];
        }
    } failure:nil];
}

#pragma mark - Method
- (void)barButtonClicked
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginButtonClicked:(UIButton *)sender
{
    if (![WXApi isWXAppInstalled])
    {
        [self presentAlertControllerWithMessage:@"您尚未安装微信客户端,您可以以游客的身份使用其它功能"];
        return;
    }
    
    if (![WXApi isWXAppSupportApi])
    {
        [self presentAlertControllerWithMessage:@"您的微信客户端版本太旧了,您可以以游客的身份使用其它功能"];
        return;
    }
    
    [self sendAuthRequest];
}

- (void)sendAuthRequest
{
    BOOL flag = [WXApiRequestHandler sendAuthRequestScope: kAuthScope
                                        State:kAuthState
                                       OpenID:WXAppSecret
                             InViewController:self];
    if (!flag)
    {
        [SVProgressHUD showErrorWithStatus:@"发送微信登录授权请求失败"];
    }
}

#pragma mark - WechatAuthAPIDelegate
- (void)onAuthFinish:(int)errCode AuthCode:(NSString *)authCode
{
    
}

#pragma mark - WXApiManagerDelegate
- (void)managerDidRecvAuthResponse:(SendAuthResp *)response
{
    /*
     WXSuccess           = 0,    < 成功
    WXErrCodeCommon     = -1,   < 普通错误类型
    WXErrCodeUserCancel = -2,   < 用户点击取消并返回
    WXErrCodeSentFail   = -3,   < 发送失败
    WXErrCodeAuthDeny   = -4,   < 授权失败
    WXErrCodeUnsupport  = -5,   < 微信不支持
     */
    if (response.errCode == 0)
    {
        [self getAccessTokenWithCode:response.code];
    }
    else if (response.errCode == -2)
    {
        
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"微信登录授权失败"];
    }
}

@end
