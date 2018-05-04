//
//  PISPWeatherModel.h
//  PublicInformationServicePlatform
//
//  Created by LiDinggui on 2018/4/4.
//  Copyright © 2018年 DAQSoft. All rights reserved.
//

#import "LDGBaseModel.h"

@interface PISPWeatherModel : LDGBaseModel

/*
 {
 "pic_d" : "http:\/\/file.geeker.com.cn\/file\/images\/2016\/9\/1\/19-37-39\/1472729859709.png",
 "code_n" : 101,
 "min" : 7,
 "txt_n" : "多云",
 "code_d" : 100,
 "pic_n" : "http:\/\/file.geeker.com.cn\/file\/images\/2016\/9\/1\/19-39-1\/1472729941017.png",
 "unicode_n" : "&#xE002;",
 "max" : 20,
 "txt_d" : "晴",
 "unicode_d" : "&#xE001;"
 }
 */

@property (nonatomic, copy) NSString *pic_d;

@property (nonatomic, assign) NSInteger code_n;

@property (nonatomic, assign) CGFloat min;

@property (nonatomic, copy) NSString *txt_n;

@property (nonatomic, assign) NSInteger code_d;

@property (nonatomic, copy) NSString *pic_n;

@property (nonatomic, copy) NSString *unicode_n;

@property (nonatomic, assign) CGFloat max;

@property (nonatomic, copy) NSString *txt_d;

@property (nonatomic, copy) NSString *unicode_d;

@end
