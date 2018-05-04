//
//  PISPAKeyAlarmReportImageCollectionViewCell.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/16.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHAsset;

static const CGFloat ButtonImageTitleSpacing = 4.0;
#define ITEM_WIDTH (64.0)
#define ITEM_HEIGHT ITEM_WIDTH

@interface PISPAKeyAlarmReportImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) PHAsset *asset;

@property (nonatomic, copy) void(^imageButtonClicked)(UIButton *button);

@end
