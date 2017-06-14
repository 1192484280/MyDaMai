//
// Created by chenxiaoyu on 17/2/7.
// Copyright (c) 2017 baidu. All rights reserved.
//
// Ocr主要接口类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface AipOcrManager : NSObject

- (instancetype) init __attribute__((unavailable(
"Use 'initWithLicenseFileData' or 'initWithAK:andSK' instead")));

- (instancetype) initWithLicenseFileData: (NSData *)licenseFileContent;

- (instancetype) initWithAK: (NSString *)ak andSK: (NSString *)sk;

- (instancetype) initWithToken: (NSString *)token;

- (void) detectTextFromImage: (UIImage*)image
                 withOptions: (NSDictionary *)options
              successHandler: (void (^)(id result))successHandler
                 failHandler: (void (^)(NSError* err))failHandler;


- (void) detectIdCardFromImage: (UIImage*)image
                   withOptions: (NSDictionary *)options
                successHandler: (void (^)(id result))successHandler
                   failHandler: (void (^)(NSError* err))failHandler;


- (void) detectBankCardFromImage: (UIImage*)image
                  successHandler: (void (^)(id result))successHandler
                     failHandler: (void (^)(NSError* err))failHandler;


- (void) clearCache;
@end
