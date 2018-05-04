//
//  PISPHomeMoreFooterView.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/2.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PISPHomeMoreFooterView : UITableViewHeaderFooterView

@property (nonatomic, copy) void(^moreButtonClicked)(UIButton *button);

@end
