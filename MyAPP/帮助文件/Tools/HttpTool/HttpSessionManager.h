//
//  HttpSessionManager.h
//  BeautyApp
//
//  Created by zhangming on 17/2/7.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface HttpSessionManager : AFHTTPSessionManager

+ (instancetype)shareManager;

@end
