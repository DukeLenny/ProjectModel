//
//  NSMutableArray+Extension.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/8.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Extension)

/**
 将一个一维数组拆分重组成一个二维数组

 @param array 一维数组
 @param maxItemCount 二维数组中每一个元素(数组)的最大元素个数
 @return 二维数组
 */
+ (NSMutableArray *)doubleDimensionalArrayWithOneDimensionalArray:(NSArray *)array everySectionMaxItemCount:(NSInteger)maxItemCount;

@end
