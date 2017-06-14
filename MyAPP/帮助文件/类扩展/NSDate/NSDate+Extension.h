//
//  NSDate+Extension.h
//  大麦
//
//  Created by 洪欣 on 16/12/22.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
+ (NSString *)getCurrentDate; // 获取当前日期
+ (NSString *)getTomorrowDay; // 获取明天日期
+ (NSString *)getWeekDate; // 获取一周后的日期
+ (NSString *)getAfterTomorrowDate; // 获取后天的日期
+ (NSString *)getMonthDate; // 获取一个月后的日期
@end
