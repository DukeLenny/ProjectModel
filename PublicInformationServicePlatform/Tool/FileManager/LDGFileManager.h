//
//  LDGCacheManager.h
//  FourBigArea
//
//  Created by LiDinggui on 2016/11/18.
//  Copyright © 2016年 LiDinggui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDGFileManager : NSObject

+ (NSString *)stringFromSize:(long long)size;
+ (long long)fileSizeAtPath:(NSString *)filePath;
+ (long long)folderSizeAtPath:(NSString *)folderPath;
+ (BOOL)deleteFileAtPath:(NSString *)filePath;
+ (void)clearFolderAtPath:(NSString *)folderPath;

@end
