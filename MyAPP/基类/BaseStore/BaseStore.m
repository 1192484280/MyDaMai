//
//  BaseStore.m
//  Fashion
//
//  Created by zhangming on 16/7/26.
//  Copyright © 2016年 youjiesi. All rights reserved.
//

#import "BaseStore.h"
#import "NSString+MD5HexDigest.h"

@implementation BaseStore

- (void)requestWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure{
    NSLog(@"基类被调用");
}

+ (NSString *)getTime{
    //获取系统当前的时间戳
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: dat];
    
    NSDate *localeDate = [dat  dateByAddingTimeInterval: interval];
    NSTimeInterval a=[localeDate timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];//转为字符型
    return timeString;
}

+ (NSString *)getSign:(NSDictionary *)dic withTime:(NSString *)time{
    
    
    NSArray *signArr = [[dic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {

        return [obj1 compare:obj2 options:NSNumericSearch];
        
    }];
    
    NSMutableString *getSign = [NSMutableString string];
    for (int i =0; i<signArr.count; i++) {
        [getSign appendFormat:@"%@",[dic valueForKey:signArr[i]]];
    }
    
    
    [getSign appendString:time];
    [getSign appendFormat:@"shishang"];
    NSLog(@"%@",getSign);
    return [getSign md5HexDigest];
    
}

#pragma mark - 判断字符串是否为空
- (BOOL) isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    return NO;
    
}
@end
