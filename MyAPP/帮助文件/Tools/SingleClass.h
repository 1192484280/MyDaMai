//
//  SingleClass.h
//  大麦
//
//  Created by 洪欣 on 16/12/21.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleClass : NSObject
@property (copy, nonatomic) NSString *cityId;
@property (copy, nonatomic) NSString *cityName;
@property (copy, nonatomic) NSString *longitude;
@property (copy, nonatomic) NSString *latitude;

@property (copy, nonatomic) NSString *startTime;
@property (copy, nonatomic) NSString *endTime;
@property (assign, nonatomic) NSInteger ot;

+ (id)sharedInstance;
@end
