//
//  PISPReservationServiceHomeTableViewCell.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/8.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PISPReservationServiceHomeModel;

@interface PISPReservationServiceHomeTableViewCell : UITableViewCell

@property (nonatomic, strong) PISPReservationServiceHomeModel *model;
@property (nonatomic, copy) void(^viewTaped)(void);

@end
