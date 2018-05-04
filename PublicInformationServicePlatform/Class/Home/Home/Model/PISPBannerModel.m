//
//  PISPBannerModel.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/19.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "PISPBannerModel.h"

@implementation PISPBannerModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id",@"des" : @"description"};
}

@end
