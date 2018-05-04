//
//  UIImageView+Extension.m
//  QuanYuJingQu
//
//  Created by LiDinggui on 2017/2/3.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

- (void)setImageWithURLString:(NSString *)urlString placeholderImageName:(NSString *)placeholderImageName
{
    [self sd_setImageWithURL:[NSURL URLWithString:[[NSString ifIsEmptyWithStr:urlString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:placeholderImageName]];
}

- (void)setImageWithURLString:(NSString *)urlString placeholderImageName:(NSString *)placeholderImageName completed:(SDExternalCompletionBlock)completedBlock
{
    [self sd_setImageWithURL:[NSURL URLWithString:[[NSString ifIsEmptyWithStr:urlString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:placeholderImageName] completed:completedBlock];
}

@end
