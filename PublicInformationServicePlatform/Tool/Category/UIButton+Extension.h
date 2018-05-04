//
//  UIButton+Extension.h
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/2/3.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIButtonContentLayoutType)
{
    UIButtonContentLayoutTypeLeftImageRightTitle = 0,
    UIButtonContentLayoutTypeLeftTitleRightImage,
    UIButtonContentLayoutTypeTopImageBottomTitle,
    UIButtonContentLayoutTypeTopTitleBottomImage
};

@interface UIButton (Extension)

- (void)setImageWithURLString:(NSString *)urlString placeholderImageName:(NSString *)placeholderImageName;

- (void)setImageWithURLString:(NSString *)urlString placeholderImageName:(NSString *)placeholderImageName completed:(SDExternalCompletionBlock)completedBlock;

- (void)setBackgroundImageWithURLString:(NSString *)urlString placeholderImageName:(NSString *)placeholderImageName;

- (void)setContentEdgeInsetsWithLayoutType:(UIButtonContentLayoutType)layoutType space:(CGFloat)space;

@end
