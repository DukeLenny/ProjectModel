//
//  PISPNotMissScenicSpotTableViewCell.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/10.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PISPNotMissScenicSpotModel;

@interface PISPNotMissScenicSpotTableViewCell : UITableViewCell

@property (nonatomic, strong) PISPNotMissScenicSpotModel *model;

@property (nonatomic, copy) void(^buttonClicked)(UIButton *button);

@property (nonatomic, copy) void(^viewTaped)(void);

@end
