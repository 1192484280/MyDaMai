//
//  RadioUserInfo.h
//  MyAPP
//
//  Created by zhangming on 17/3/6.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadioUserInfo : NSObject

/**
 *  用户编号
 */
@property (nonatomic,assign) NSUInteger uid;
/**
 *  用户昵称
 */
@property (nonatomic,copy) NSString *uname;
/**
 *  用户头像
 */
@property (nonatomic,copy) NSString *icon;

@end
