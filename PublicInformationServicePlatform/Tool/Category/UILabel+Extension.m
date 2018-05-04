//
//  UILabel+Extension.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/4.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

- (void)setAttributedTextWithRange:(NSRange)range font:(UIFont *)font textColor:(UIColor *)textColor
{
    if (self.text.length <= 0 || range.location == NSNotFound)
    {
        return;
    }
    
    UIFont *especialFont = font?:self.font;
    UIColor *especialTextColor = textColor?:self.textColor;
    
    NSMutableAttributedString *attributedString = nil;
    if (self.attributedText)
    {
        attributedString  = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }
    else
    {
        attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    }
    [attributedString setAttributes:@{NSFontAttributeName : especialFont, NSForegroundColorAttributeName : especialTextColor} range:range];
    self.attributedText = attributedString;
}

@end
