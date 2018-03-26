//
//  QYJQUtility.h
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/1/12.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>

@interface LDGUtility : NSObject

+ (UIImage *)thumbnailImageRequestWithVideoURLString:(NSString *)videoURLString;

+ (void)saveImage:(UIImage *)image creationDate:(NSDate *)creationDate location:(CLLocation *)location;

+ (BOOL)currentTimeIsDay;

+ (id)unarchiveObjectWithFileName:(NSString *)fileName;
+ (void)archiveRootObject:(id)rootObject toFileName:(NSString *)fileName;

+ (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString;

//退出登录
+ (void)logOut;

//清理缓存
+ (void)clearCache;

//清理缓存2
+ (void)clearCache2;

//清理内存
+ (void)clearMemory;

@end
