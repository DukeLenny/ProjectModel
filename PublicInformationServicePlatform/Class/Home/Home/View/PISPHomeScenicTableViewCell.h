//
//  PISPHomeScenicTableViewCell.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/2.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PISPNotMissScenicSpotModel;

@protocol PISPHomeScenicTableViewCellDelegate<NSObject>

- (void)didSelectCollectionViewItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface PISPHomeScenicTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray<PISPNotMissScenicSpotModel *> *models;

@property (nonatomic, assign) id<PISPHomeScenicTableViewCellDelegate> delegate;

@end
