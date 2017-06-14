//
//  HttpSessionManager.m
//  BeautyApp
//
//  Created by zhangming on 17/2/7.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "HttpSessionManager.h"

@implementation HttpSessionManager

static id _instance;

+ (id)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)shareManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone{
    
    return _instance;
    
}

@end
