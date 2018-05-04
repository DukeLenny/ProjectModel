//
//  PISPTravelGuideTableViewCell.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/9.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PISPTravelGuideModel;

@interface PISPTravelGuideTableViewCell : UITableViewCell

@property (nonatomic, strong) PISPTravelGuideModel *model;

@property (nonatomic, copy) void(^viewTaped)(void);

@end
