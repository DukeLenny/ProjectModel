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

@end
