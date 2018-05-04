//
//  PISPHomeHeadTableViewCell.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/2.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PISPHomeHeadTableViewCellDelegate <NSObject>

- (void)didSelectCycleScrollViewItemAtIndex:(NSInteger)index;

@end

@class PISPWeatherModel, PISPPeopleCountModel;

@interface PISPHomeHeadTableViewCell : UITableViewCell

@property (assign, nonatomic) id<PISPHomeHeadTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSArray *imageURLStringsGroup;
@property (nonatomic, strong) NSArray *titlesGroup;

@property (nonatomic, strong) PISPWeatherModel *weatherModel;
@property (nonatomic, strong) PISPPeopleCountModel *peopleCountModel;

@end
