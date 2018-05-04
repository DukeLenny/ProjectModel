//
//  PISPBannerModel.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/19.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "LDGBaseModel.h"

@interface PISPBannerModel : LDGBaseModel

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *des;

@property (nonatomic, copy) NSString *posName;

@property (nonatomic, copy) NSString *posHeight;

@property (nonatomic, copy) NSString *videos;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *posWidth;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, copy) NSString *lang;

@property (nonatomic, copy) NSString *beginTime;

@property (nonatomic, copy) NSString *pics;

@property (nonatomic, copy) NSString *posCode;

@end
