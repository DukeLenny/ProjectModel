//
//  LDGGlobalConstant.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/3/26.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#ifndef LDGGlobalConstant_h
#define LDGGlobalConstant_h

static NSString *HUD_ERROR_STATUS = @"网络错误";
static NSString *HUD_NODATA_STATUS = @"暂无数据";
static NSString *HUD_LOADING_STATUS = @"正在请求...";

static const CGFloat CompressionQuality = (0.5);//0.3~0.7

static const CGFloat CornerRadius = (3.0);

static NSString *PageSize = @"10";

static const CGFloat NavigationBarTitleFontSize = (18.0);

static const BOOL PrefersStatusBarHidden = NO;
static const UIStatusBarStyle PreferredStatusBarStyle = UIStatusBarStyleLightContent;

static NSString *kAuthScope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";
static NSString *kAuthState = @"xxx";

//测试环境网址
//static NSString *BaseURLString = @"http://192.168.0.33:12588/api/scapi/app/";
//周桥电脑本地网址
static NSString *BaseURLString = @"http://192.168.2.125:12588/api/scapi/app/";

/////////////////////////////////////////////////////////////////////////华丽的分割线////////////////////////////////////////////////////////////

static NSString *HomeViewWillAppear = @"HomeViewWillAppear";

static const BOOL HideHomeSurroundingSection = YES;

//赛里木湖appkey：0939809b-82e3-4e62-a41f-2b761461dc16
static NSString *JKBAppKey = @"0939809b-82e3-4e62-a41f-2b761461dc16";
static NSString *JKBBaseURLString = @"http://jkb66.com/wap/common/";
static NSString *JKBMemberId = @"15389";
static NSString *JKBSource = @"shelves";
static NSString *JKBSpecialtyReservationWid = @"736";
static NSString *JKBHotelReservationWid = @"735";
static NSString *JKBTicketReservationWid = @"721";

//站点代码
static NSString *SiteCode = @"slmhjqapp";

static NSString *WXAppID = @"wxffc9df981b7a71db";//注意设置Target-Info-URL Types-URL Schemes
static NSString *WXAppSecret = @"9ac8f369e79b32909f0d878d5bb405a7";
static NSString *WXBaseURLString = @"https://api.weixin.qq.com/sns/";

static NSString *WebBaseURLString = @"http://192.168.7.157:5656/dist/view/";



#endif /* LDGGlobalConstant_h */
