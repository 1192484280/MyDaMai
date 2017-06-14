//
//  BaseViewController.h
//  BeautyApp
//
//  Created by zhangming on 17/1/22.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingView.h"
@interface BaseViewController : UIViewController

@property (strong, nonatomic) LoadingView *loadingView;

@property (strong, nonatomic) UINavigationBar *navBar;

@property (strong, nonatomic) UINavigationItem *navItem;

/**
 * 设置页面标题
 */


- (void)setupNavBarWithTitle:(NSString *)title;

/**
 * 获取用户信息
 */
- (NSString *)getUid;
- (NSString *)getUser;
- (NSString *)getName;
- (NSData *)getHeadIm;

/**
 * 跳到登录页面
 */
- (void)goLogin;

/**
 * 发送通知
 */
- (void)postNotifyWithName:(NSString *)name;


/**
 * 判断字符串是否为空
 */


- (BOOL)isBlankString:(NSString *)string;


- (void)addLoadingView:(CGFloat)y;
@end
