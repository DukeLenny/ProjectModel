//
//  NSMutableDictionary+PISPParameters.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/17.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (PISPParameters)

+ (NSMutableDictionary *)parameters;

- (void)addDefaultParameters;

@end
