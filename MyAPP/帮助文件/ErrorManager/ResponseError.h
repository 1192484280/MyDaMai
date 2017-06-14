//
//  ResponseError.h
//  ZhiNengJiaJu
//
//  Created by qianfeng on 15/11/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ResponseError : NSObject

+ (NSError *)inspectError:(NSDictionary *)responseObject;

+ (UIAlertController *)handleError:(NSError *)error;

+ (UIAlertController *)registerstoreError;
@end
