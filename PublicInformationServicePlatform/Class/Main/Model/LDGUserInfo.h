//
//  LDGUserInfo.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/3/26.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "LDGBaseModel.h"

@interface LDGUserInfo : LDGBaseModel

//@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *openid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) NSInteger sex;//1为男性，2为女性
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *country;//国家，如中国为CN
@property (nonatomic, copy) NSString *headimgurl;
@property (nonatomic, copy) NSString *unionid;

+ (LDGUserInfo *)sharedUserInfo;
+ (void)saveUserInfo:(LDGUserInfo *)userInfo;

@end
