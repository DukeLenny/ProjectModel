//
//  NSDate+Extension.m
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/2/15.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

//NSString转化为NSDate
+ (NSDate *)dateFromString:(NSString *)string withDateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];//@"yyyy-MM-dd HH:mm:ss"
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSDate *date = [dateFormatter dateFromString:string];
    
    return date;
}

//时间戳(NSTimeInterval,如:1497342050000)转化为NSDate
+ (NSDate *)dateWithTimeStamp:(NSTimeInterval)timeStamp
{
    return [NSDate dateWithTimeIntervalSince1970:timeStamp / 1000.0];
}

@end
