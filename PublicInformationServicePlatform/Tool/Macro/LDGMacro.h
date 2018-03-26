//
//  LDGMacro.h
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/1/12.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#ifndef LDGMacro_h
#define LDGMacro_h

//#ifdef DEBUG
//#define MMLog( s, ... ) NSLog( @"< %@ > ( 第%d行 ) %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
//#else
//#define MMLog( s, ... )
//#endif

#ifdef DEBUG
#define MMLog(format, ...) printf("class: <%s:(%d) > method: %s \n%s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String])
#else
#define MMLog(format, ...)
#endif

#define  AutomaticallyAdjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)

#define GetWeakSelf __weak typeof(self) weakSelf = self;

//16进制RGB值转换到UIColor
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//屏幕的宽
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

//屏幕的高
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)//4,4s//淘汰
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)//5,5s,SE
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)//6,6s,7,8
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)//6 plus,6s plus,7 plus,8 plus
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)//X

#define SandBoxDocumentsPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define SandBoxCachesPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#define APP [UIApplication sharedApplication]
#define APPDELEGATE ((AppDelegate *)[APP delegate])
#define WINDOW [APPDELEGATE window]

#define UserDefaults [NSUserDefaults standardUserDefaults]

#define NavigationBarBarTintColor UIColorFromRGB(0xB70A07)
#define NavigationBarTintColor [UIColor whiteColor]
#define TabBarTintColor NavigationBarBarTintColor
#define NavigationBarTitleForegroundColor NavigationBarTintColor

#define USER_INFO [LDGUserInfo sharedUserInfo]
#define USER_ID (USER_INFO.ID)

#define SeparatorColor UIColorFromRGB(0xE0E0E0)
#define ViewBackgroundColor UIColorFromRGB(0xF5F6F7)
#define ImageViewBackgroundColor UIColorFromRGB(0xEEEEEE)

#define TimeStamp [NSString timeStamp]

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#endif /* LDGMacro_h */
