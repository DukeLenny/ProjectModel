//
//  LDGUserInfo.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/3/26.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "LDGUserInfo.h"

@implementation LDGUserInfo

//+ (NSDictionary *)mj_replacedKeyFromPropertyName
//{
//    return @{@"ID" : @"id"};
//}

+ (LDGUserInfo *)sharedUserInfo
{
    LDGUserInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:[SandBoxDocumentsPath stringByAppendingPathComponent:@"sharedUserInfo.data"]];
    return userInfo?:[[LDGUserInfo alloc] init];
}

+ (void)saveUserInfo:(LDGUserInfo *)userInfo
{
    [NSKeyedArchiver archiveRootObject:userInfo?:[[LDGUserInfo alloc] init] toFile:[SandBoxDocumentsPath stringByAppendingPathComponent:@"sharedUserInfo.data"]];
}

@end
