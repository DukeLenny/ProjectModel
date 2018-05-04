//
//  PISPKnowYouCanSeeTableViewCell.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/11.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PISPKnowYouCanSeeModel;

@interface PISPKnowYouCanSeeTableViewCell : UITableViewCell

@property (nonatomic, strong) PISPKnowYouCanSeeModel *model;

@property (nonatomic, copy) void(^viewTaped)(void);

@end
