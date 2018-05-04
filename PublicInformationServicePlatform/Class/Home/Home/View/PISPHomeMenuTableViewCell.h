//
//  PISPHomeMenuTableViewCell.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/2.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

static const NSInteger MenuSectionMaxColumnCount = 4;
static const NSInteger MenuSectionMaxRowCount = 2;
#define MenuSectionMaxItemCount (MenuSectionMaxColumnCount * MenuSectionMaxRowCount)

@class PISPHomeMenuModel;

@protocol PISPHomeMenuTableViewCellDelegate<NSObject>

- (void)didSelectScrollMenuItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface PISPHomeMenuTableViewCell : UITableViewCell

@property (nonatomic, assign) id<PISPHomeMenuTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSArray<PISPHomeMenuModel *> *models;

@end
