//
//  NSMutableDictionary+PISPParameters.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/17.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "NSMutableDictionary+PISPParameters.h"

@implementation NSMutableDictionary (PISPParameters)

+ (NSMutableDictionary *)parameters
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"siteCode"] = SiteCode;
    parameters[@"lang"] = @"cn";
    return parameters;
}

- (void)addDefaultParameters
{
    [self addEntriesFromDictionary:[NSDictionary dictionaryWithDictionary:[NSMutableDictionary parameters]]];
}

@end
