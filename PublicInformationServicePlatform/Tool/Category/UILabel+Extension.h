//
//  UILabel+Extension.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/4.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

//NSAttributedString *attributedText
- (void)setAttributedTextWithRange:(NSRange)range font:(UIFont *)font textColor:(UIColor *)textColor;

@end
