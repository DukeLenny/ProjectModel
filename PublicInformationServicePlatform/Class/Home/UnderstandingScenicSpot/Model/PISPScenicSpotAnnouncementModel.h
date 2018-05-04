//
//  PISPScenicSpotAnnouncementModel.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/9.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "LDGBaseModel.h"

@interface PISPScenicSpotAnnouncementModel : LDGBaseModel

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, assign) NSInteger viewCount;

@property (nonatomic, copy) NSString *summary;

@end
