//
//  NSDate+Extension.m
//  大麦
//
//  Created by 洪欣 on 16/12/22.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+ (NSString *)getCurrentDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[self date]];
    return dateTime;
}

+ (NSString *)getTomorrowDay
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[self date]];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

+ (NSString *)getWeekDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60*7 sinceDate:[NSDate date]];
    NSString *dateTime = [formatter stringFromDate:nextDate];
    return dateTime;
}

+ (NSString *)getAfterTomorrowDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60*2 sinceDate:[NSDate date]];
    NSString *dateTime = [formatter stringFromDate:nextDate];
    return dateTime;
}

+ (NSString *)getMonthDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60*30 sinceDate:[NSDate date]];
    NSString *dateTime = [formatter stringFromDate:nextDate];
    return dateTime;
}

@end
