//
//  Tools.h
//  大麦
//
//  Created by 洪欣 on 16/12/15.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Tools : NSObject
+ (void)addSqliteList;
+ (NSArray *)queryCityInformation:(NSString *)city;
+ (NSString *)queryCityId:(NSString *)cityName;
+ (CGFloat)getAttributedTextHeight:(NSString *)text MaxWidth:(CGFloat)width Attributes:(NSDictionary *)attributes;
@end
