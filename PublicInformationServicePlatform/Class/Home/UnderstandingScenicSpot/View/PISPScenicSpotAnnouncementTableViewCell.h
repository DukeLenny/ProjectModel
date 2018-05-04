//
//  PISPScenicSpotAnnouncementTableViewCell.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/9.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PISPScenicSpotAnnouncementModel;

@interface PISPScenicSpotAnnouncementTableViewCell : UITableViewCell

@property (nonatomic, strong) PISPScenicSpotAnnouncementModel *model;

@property (nonatomic, copy) void(^viewTaped)(void);

@end
