//
//  UIImageView+Extension.h
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/2/3.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)

- (void)setImageWithURLString:(NSString *)urlString placeholderImageName:(NSString *)placeholderImageName;

- (void)setImageWithURLString:(NSString *)urlString placeholderImageName:(NSString *)placeholderImageName completed:(SDExternalCompletionBlock)completedBlock;

@end
