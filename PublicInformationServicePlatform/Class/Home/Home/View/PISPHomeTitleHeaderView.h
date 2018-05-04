//
//  PISPHomeTitleHeaderView.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/2.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PISPHomeTitleHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) void(^checkAllButtonClicked)(UIButton *button);

@end
