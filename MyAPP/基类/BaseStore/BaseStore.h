//
//  BaseStore.h
//  Fashion
//
//  Created by zhangming on 16/7/26.
//  Copyright © 2016年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseError.h"
#import "NSString+MD5HexDigest.h"

#define URL @"http://localhost/"

//成功返回的标志
#define SuccessResponseCode 1

//网络回传失败域
#define ResponseFailureDomain @"ResponseFailureDomain"

@interface BaseStore : NSObject

- (void)requestWithSuccess:(void(^)())success failure:(void(^)(NSError *error))failure;

//时间戳
+(NSString *)getTime;

//拼接签名
+(NSString *)getSign:(NSDictionary *)dic withTime:(NSString *)time;

// 判断字符串是否为空
- (BOOL) isBlankString:(NSString *)string;
@end
