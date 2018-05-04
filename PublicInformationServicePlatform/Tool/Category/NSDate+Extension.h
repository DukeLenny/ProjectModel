//
//  NSDate+Extension.h
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/2/15.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

//NSString转化为NSDate
+ (NSDate *)dateFromString:(NSString *)string withDateFormat:(NSString *)dateFormat;

//时间戳(NSTimeInterval,如:1497342050000)转化为NSDate
+ (NSDate *)dateWithTimeStamp:(NSTimeInterval)timeStamp;

@end
