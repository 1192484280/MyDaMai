//
//  CheckStrNullTool.h
//  MyAPP
//
//  Created by zhangming on 17/3/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckStrNullTool : NSObject

#pragma mark - 检测后台返回数据是否为空
+ (NSString *)checkStrNull:(NSString *)str;

#pragma mark - 判断是否为手机号
+ (BOOL)ifPhone:(NSString *)tel;

#pragma mark - 判断是否为邮箱
+ (BOOL)ifEmail:(NSString *)email;

@end
