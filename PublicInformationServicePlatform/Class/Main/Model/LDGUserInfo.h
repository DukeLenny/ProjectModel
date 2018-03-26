//
//  LDGUserInfo.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/3/26.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "LDGBaseModel.h"

@interface LDGUserInfo : LDGBaseModel

@property (nonatomic, copy) NSString *ID;

+ (LDGUserInfo *)sharedUserInfo;
+ (void)saveUserInfo:(LDGUserInfo *)userInfo;

@end
