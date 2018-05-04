//
//  PISPPeopleCountModel.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/4.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "LDGBaseModel.h"

@interface PISPPeopleCountModel : LDGBaseModel

@property (nonatomic, assign) NSInteger maxCapacity;
@property (nonatomic, assign) NSInteger realTimeCount;

@end
