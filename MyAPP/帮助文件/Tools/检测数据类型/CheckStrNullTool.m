//
//  CheckStrNullTool.m
//  MyAPP
//
//  Created by zhangming on 17/3/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "CheckStrNullTool.h"

@implementation CheckStrNullTool

#pragma mark - 检测后台返回数据是否为空
+ (NSString *)checkStrNull:(NSString *)str
{
    NSString *tmpStr =  [NSString stringWithFormat:@"%@",str];
    if ([str isKindOfClass:[NSNull class]]||
        [tmpStr isEqualToString:@"(null)"]||
        [tmpStr isEqualToString:@"<null>"]) {
        tmpStr = @"暂无数据";
    }
    return tmpStr;
}

#pragma mark - 判断是否为有效手机号
+ (BOOL)ifPhone:(NSString *)tel
{
    //注册手机号判断
    NSString *phoneRegex = @"1[3|5|7|8|][0-9]{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    BOOL isMatch = [phoneTest evaluateWithObject:tel];
    
    if (isMatch) {
     
        return YES;
    }
    
    return NO;
}

#pragma mark - 判断是否为有效邮箱
+ (BOOL)ifEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
