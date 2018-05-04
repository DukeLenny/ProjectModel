//
//  PISPPromotionalVideoTableViewCell.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/10.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PISPPromotionalVideoModel;

@interface PISPPromotionalVideoTableViewCell : UITableViewCell

@property (nonatomic, strong) PISPPromotionalVideoModel *model;

@property (nonatomic, copy) void(^playVideoAction)(UIButton *button);

@end
