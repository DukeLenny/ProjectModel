//
//  NSString+Extension.m
//  CountryTouristAdministration
//
//  Created by LiDinggui on 16/8/17.
//  Copyright © 2016年 daqsoft. All rights reserved.
//

#import "NSString+Extension.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)

//判断字符串是否为空
+ (BOOL)isEmptyWithStr:(NSString *)str
{
    if (!str || [str isEqual:[NSNull null]])
    {
        return YES;
    }
    else
    {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if (trimedString.length == 0)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
}

+ (NSString *)ifIsEmptyWithStr:(NSString *)str
{
    if ([NSString isEmptyWithStr:str])
    {
        return @"";
    }
    else
    {
        return str;
    }
}

+ (BOOL)isNonNegativeIntegerWithStr:(NSString *)str
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[1-9]\\d*|0$"];
    return [predicate evaluateWithObject:str];
}

+ (NSString *)nonNegativeIntegerTranslateToMicrometerDelimiterStyleWithStr:(NSString *)str
{
    if ([self isEmptyWithStr:str])
    {
        return @"0";
    }
    
    if (![self isNonNegativeIntegerWithStr:str])
    {
        return @"0";
    }
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.positiveFormat = @"###,##0";
    return [numberFormatter stringFromNumber:@(str.integerValue)];
}

+ (NSString *)md532BitLowerByAStr:(NSString *)aStr
{
    const char *cStr = [aStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5(cStr, [num intValue], result);
    NSMutableString *resultStr = [NSMutableString stringWithCapacity:0];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [resultStr appendFormat:@"%02x", result[i]];
    }
    return [[NSString stringWithString:resultStr] lowercaseString];
}

+ (NSString *)timeStamp
{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970] * 1000;
    return [NSString stringWithFormat:@"%lld",(long long)timeInterval];
}

+ (NSString *)stringWithComponents:(NSArray<NSString *> *)components separator:(NSString *)separator
{
//    NSString *string = @"";
//    if (components.count > 0)
//    {
//        string = [components objectAtIndex:0];
//        for (NSInteger i = 1; i < components.count; i++)
//        {
//            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@%@",separator,[components objectAtIndex:i]]];
//        }
//    }
//    return string;
    if (components.count <= 0)
    {
        return @"";
    }
    else
    {
        return [components componentsJoinedByString:separator];
    }
}

//NSDate转化为NSString
+ (NSString *)stringFromDate:(NSDate *)date withDateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];//@"yyyy-MM-dd HH:mm:ss"
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSString *string = [dateFormatter stringFromDate:date];
    
    return string;
}

//一种日期格式的NSString转化为另一种日期格式的NSString
+ (NSString *)stringWithDateFormat:(NSString *)dateFormat2 fromString:(NSString *)string1 withDateFormat:(NSString *)dateFormat1
{
    return [NSString stringFromDate:[NSDate dateFromString:string1 withDateFormat:dateFormat1] withDateFormat:dateFormat2];
}

+ (NSString *)URLStringWithString:(NSString *)string rootURLString:(NSString *)rootURLString
{
    if ([NSString isEmptyWithStr:string])
    {
        return @"";
    }
    
    if ([string hasPrefix:@"http"])
    {
        return string;
    }
    
    NSString *prefixString = rootURLString;
    if (![prefixString hasSuffix:@"/"])
    {
        prefixString = [prefixString stringByAppendingString:@"/"];
    }
    NSString *suffixString = string;
    if ([suffixString hasPrefix:@"/"])
    {
        suffixString = [suffixString substringFromIndex:1];
    }
    return [NSString stringWithFormat:@"%@%@",prefixString,suffixString];
}

- (NSString *)substringWithMaxBytesLength:(NSUInteger)maxBytesLength
{
    
    NSString *text = self;
    
    NSUInteger textBytesLength = [text lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    if (textBytesLength > maxBytesLength)
    {
        NSRange range;
        NSUInteger bytesLength = 0;
        for(NSUInteger i = 0; i < text.length && bytesLength <= maxBytesLength; i += range.length)
        {
            range = [text rangeOfComposedCharacterSequenceAtIndex:i];
            bytesLength += strlen([[text substringWithRange:range] UTF8String]);
            if (bytesLength > maxBytesLength)
            {
                NSString *newText = [text substringWithRange:NSMakeRange(0, range.location)];
                return newText;
            }
        }
    }
    return text;
}


@end
