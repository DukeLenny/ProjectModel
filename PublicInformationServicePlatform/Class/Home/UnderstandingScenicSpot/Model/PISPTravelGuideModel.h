//
//  PISPTravelGuideModel.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/9.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "LDGBaseModel.h"

@interface PISPTravelGuideModel : LDGBaseModel

@property (nonatomic, copy) NSString *digest;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger recommended;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger collection;

@property (nonatomic, assign) NSInteger share;

@property (nonatomic, copy) NSString *updateTime;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, assign) NSInteger viewCount;

@property (nonatomic, assign) NSInteger givePoint;

@property (nonatomic, assign) NSInteger comment;

@end
