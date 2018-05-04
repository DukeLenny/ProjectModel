//
//  NSString+Extension.h
//  CountryTouristAdministration
//
//  Created by LiDinggui on 16/8/17.
//  Copyright © 2016年 daqsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

//判断字符串是否为空
+ (BOOL)isEmptyWithStr:(NSString *)str;

+ (NSString *)ifIsEmptyWithStr:(NSString *)str;

//判断字符串是否为非负整数
+ (BOOL)isNonNegativeIntegerWithStr:(NSString *)str;

//非负整数转化为带有千分位分隔符的样式###,##0
+ (NSString *)nonNegativeIntegerTranslateToMicrometerDelimiterStyleWithStr:(NSString *)str;

+ (NSString *)md532BitLowerByAStr:(NSString *)aStr;

+ (NSString *)timeStamp;

+ (NSString *)stringWithComponents:(NSArray<NSString *> *)components separator:(NSString *)separator;

//NSDate转化为NSString
+ (NSString *)stringFromDate:(NSDate *)date withDateFormat:(NSString *)dateFormat;

//一种日期格式的NSString转化为另一种日期格式的NSString
+ (NSString *)stringWithDateFormat:(NSString *)dateFormat2 fromString:(NSString *)string1 withDateFormat:(NSString *)dateFormat1;

+ (NSString *)URLStringWithString:(NSString *)string rootURLString:(NSString *)rootURLString;

- (NSString *)substringWithMaxBytesLength:(NSUInteger)maxBytesLength;

@end
