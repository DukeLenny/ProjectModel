//
//  PISPHomeMenuModel.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/3.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "LDGBaseModel.h"
#import "YANScrollMenu.h"

@interface PISPHomeMenuModel : LDGBaseModel<YANObjectProtocol>

/**
 *  显示文本
 */
@property (nonatomic, copy) NSString *itemDescription;
/**
 *  显示图片，可以为NSURL,NSString,UIImage三种格式
 */
@property (nonatomic, strong) id itemImage;
/**
 *  占位图片
 */
@property (nonatomic, strong) UIImage *itemPlaceholder;

@end
