//
//  LDGCacheManager.m
//  FourBigArea
//
//  Created by LiDinggui on 2016/11/18.
//  Copyright © 2016年 LiDinggui. All rights reserved.
//

#import "LDGFileManager.h"

@implementation LDGFileManager

+ (NSString *)stringFromSize:(long long)size
{
    return ((size <= 0) ? @"0B" : [NSByteCountFormatter stringFromByteCount:size countStyle:NSByteCountFormatterCountStyleFile]);
}

+ (long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath])
    {
        return 0;
    }
    else
    {
        NSError *error = nil;
        NSDictionary *attributes = [fileManager attributesOfItemAtPath:filePath error:&error];
        if (error)
        {
            return 0;
        }
        else
        {
            long long size = [[attributes objectForKey:NSFileSize] longLongValue];
            return size;
        }
    }
}

+ (long long)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:folderPath])
    {
        return 0;
    }
    else
    {
        long long folderSize = 0;
        NSString *fileName = @"";
        NSEnumerator *childFilesEnumerator = [[fileManager subpathsAtPath:folderPath] objectEnumerator];
        while ((fileName = [childFilesEnumerator nextObject]) != nil)
        {
            NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:fileAbsolutePath];
        }
        return folderSize;
    }
}

+ (BOOL)deleteFileAtPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath])
    {
        return YES;
    }
    else
    {
        BOOL isDeleted = [fileManager removeItemAtPath:filePath error:nil];
        if (isDeleted)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
}

+ (void)clearFolderAtPath:(NSString *)folderPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:folderPath])
    {
        return;
    }
    else
    {
        [[fileManager subpathsAtPath:folderPath] enumerateObjectsUsingBlock:^(NSString * _Nonnull fileName, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
            [self deleteFileAtPath:fileAbsolutePath];
        }];
    }
}

@end
