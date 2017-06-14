//
//  SingleClass.m
//  大麦
//
//  Created by 洪欣 on 16/12/21.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "SingleClass.h"
static SingleClass *_single = nil;
@implementation SingleClass
+ (id)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _single = [[self alloc] init];
    });
    
    return _single;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _single = [super allocWithZone:zone];
    });
    return _single;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _single;
}

@end
