//
//  PISPReservationServiceHomeModel.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/8.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "LDGBaseModel.h"

@interface PISPReservationServiceHomeModel : LDGBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *backgroundImageName;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIImage *logoImage;

@end
