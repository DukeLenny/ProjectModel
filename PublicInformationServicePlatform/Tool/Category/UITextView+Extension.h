//
//  UITextView+Extension.h
//  LearningForPractice
//
//  Created by LiDinggui on 2017/6/26.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)

//字符数限制,1个Emoji是2个字符,其它都是1个
- (void)didChangeWithMaxTextLength:(NSUInteger)maxTextLength;

//字节数限制,在UTF8中,英文和数字是1个字节,汉字是3个字节,Emoji是3或者4个字节
- (void)didChangeWithMaxTextBytesLength:(NSUInteger)maxTextBytesLength;

@end
