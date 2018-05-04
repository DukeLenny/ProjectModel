//
//  PISPHomeSurroundingTableViewCell.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/2.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PISPHomeSurroundingTableViewCell : UITableViewCell

@property (nonatomic, copy) void(^buttonClicked)(UIButton *button);

@end
