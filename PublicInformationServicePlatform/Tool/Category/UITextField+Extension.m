//
//  UITextField+Extension.m
//  LearningForPractice
//
//  Created by LiDinggui on 2017/6/26.
//  Copyright © 2017年 DAQSoft. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

//字符数限制,1个Emoji是2个字符,其它都是1个
- (void)editingChangedWithMaxTextLength:(NSUInteger)maxTextLength
{
    if (!self.text)
    {
        return;
    }
    
    NSString *text = self.text;
    
    UITextRange *markedTextRange = [self markedTextRange];
    UITextPosition *markedTextPosition = [self positionFromPosition:markedTextRange.start offset:0];
    
    if (!markedTextPosition)
    {
        if (text.length > maxTextLength)
        {
            NSRange range;
            NSUInteger textLength = 0;
            for(NSUInteger i = 0; i < text.length && textLength <= maxTextLength; i += range.length)
            {
                range = [text rangeOfComposedCharacterSequenceAtIndex:i];
                textLength += [text substringWithRange:range].length;
                if (textLength > maxTextLength)
                {
                    NSString *newText = [text substringWithRange:NSMakeRange(0, range.location)];
                    self.text = newText;
                }
            }
        }
    }
}

//字节数限制,在UTF8中,英文和数字是1个字节,汉字是3个字节,Emoji是3或者4个字节
- (void)editingChangedWithMaxTextBytesLength:(NSUInteger)maxTextBytesLength
{
    if (!self.text)
    {
        return;
    }
    
    NSString *text = self.text;
    
    UITextRange *markedTextRange = [self markedTextRange];
    UITextPosition *markedTextPosition = [self positionFromPosition:markedTextRange.start offset:0];
    
    if (!markedTextPosition)
    {
        NSUInteger textBytesLength = [text lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        if (textBytesLength > maxTextBytesLength)
        {
            NSRange range;
            NSUInteger bytesLength = 0;
            for(NSUInteger i = 0; i < text.length && bytesLength <= maxTextBytesLength; i += range.length)
            {
                range = [text rangeOfComposedCharacterSequenceAtIndex:i];
                bytesLength += strlen([[text substringWithRange:range] UTF8String]);
                if (bytesLength > maxTextBytesLength)
                {
                    NSString *newText = [text substringWithRange:NSMakeRange(0, range.location)];
                    self.text = newText;
                }
            }
        }
    }
}

@end
