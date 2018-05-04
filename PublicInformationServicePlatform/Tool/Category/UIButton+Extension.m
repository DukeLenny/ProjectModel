//
//  UIButton+Extension.m
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/2/3.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (void)setImageWithURLString:(NSString *)urlString placeholderImageName:(NSString *)placeholderImageName
{
    [self sd_setImageWithURL:[NSURL URLWithString:[[NSString ifIsEmptyWithStr:urlString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placeholderImageName]];
}

- (void)setImageWithURLString:(NSString *)urlString placeholderImageName:(NSString *)placeholderImageName completed:(SDExternalCompletionBlock)completedBlock
{
    [self sd_setImageWithURL:[NSURL URLWithString:[[NSString ifIsEmptyWithStr:urlString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placeholderImageName] options:0 completed:completedBlock];
}

- (void)setBackgroundImageWithURLString:(NSString *)urlString placeholderImageName:(NSString *)placeholderImageName
{
    [self sd_setBackgroundImageWithURL:[NSURL URLWithString:[[NSString ifIsEmptyWithStr:urlString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placeholderImageName]];
}

- (void)setContentEdgeInsetsWithLayoutType:(UIButtonContentLayoutType)layoutType space:(CGFloat)space
{
    UIImage *image = [self imageForState:UIControlStateNormal];
    NSString *title = [self titleForState:UIControlStateNormal];
    if (!image || title.length <= 0)
    {
        return;
    }
    CGSize imageSize = image.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    CGFloat titleWidth = titleSize.width;
    CGFloat titleHeight = titleSize.height;
    CGFloat contentWidth = imageWidth + titleWidth;
    CGFloat edgeInset = space / 2.0;
    if (layoutType == UIButtonContentLayoutTypeLeftImageRightTitle)
    {
        self.imageEdgeInsets = UIEdgeInsetsMake(0, -edgeInset, 0, edgeInset);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, edgeInset, 0, -edgeInset);
    }
    else if (layoutType == UIButtonContentLayoutTypeLeftTitleRightImage)
    {
        self.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth + edgeInset, 0, -(titleWidth + edgeInset));
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + edgeInset), 0, imageWidth + edgeInset);
    }
    else if (layoutType == UIButtonContentLayoutTypeTopImageBottomTitle)
    {
        self.imageEdgeInsets = UIEdgeInsetsMake(-((imageHeight + space + titleHeight) / 2.0 - imageHeight / 2.0), contentWidth / 2.0 - imageWidth / 2.0, (imageHeight + space + titleHeight) / 2.0 - imageHeight / 2.0, -(contentWidth / 2.0 - imageWidth / 2.0));
        self.titleEdgeInsets = UIEdgeInsetsMake((imageHeight + space + titleHeight) / 2.0 - titleHeight / 2.0, -(contentWidth / 2.0 - titleWidth / 2.0), -((imageHeight + space + titleHeight) / 2.0 - titleHeight / 2.0), contentWidth / 2.0 - titleWidth / 2.0);
    }
    else if (layoutType == UIButtonContentLayoutTypeTopTitleBottomImage)
    {
        self.imageEdgeInsets = UIEdgeInsetsMake((imageHeight + space + titleHeight) / 2.0 - imageHeight / 2.0, contentWidth / 2.0 - imageWidth / 2.0, -((imageHeight + space + titleHeight) / 2.0 - imageHeight / 2.0), -(contentWidth / 2.0 - imageWidth / 2.0));
        self.titleEdgeInsets = UIEdgeInsetsMake(-((imageHeight + space + titleHeight) / 2.0 - titleHeight / 2.0), -(contentWidth / 2.0 - titleWidth / 2.0), (imageHeight + space + titleHeight) / 2.0 - titleHeight / 2.0, contentWidth / 2.0 - titleWidth / 2.0);
    }
}

@end
