//
//  NSMutableArray+Extension.m
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/8.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "NSMutableArray+Extension.h"

@implementation NSMutableArray (Extension)

+ (NSMutableArray *)doubleDimensionalArrayWithOneDimensionalArray:(NSArray *)array everySectionMaxItemCount:(NSInteger)maxItemCount
{
    NSMutableArray<NSArray *> *bigArray = [[NSMutableArray alloc] init];
    NSMutableArray *smallArray = [[NSMutableArray alloc] init];
    NSInteger lastItemSection = 0;
    for (NSInteger i = 0; i < array.count; i++)
    {
        NSInteger section = i / maxItemCount;
        //        NSInteger item = i % maxItemCount;
        if (section == lastItemSection)
        {
            [smallArray addObject:array[i]];
        }
        else
        {
            [bigArray addObject:[NSArray arrayWithArray:smallArray]];
            smallArray = [[NSMutableArray alloc] init];
            [smallArray addObject:array[i]];
            lastItemSection = section;
        }
    }
    [bigArray addObject:[NSArray arrayWithArray:smallArray]];
    return bigArray;
}

@end
