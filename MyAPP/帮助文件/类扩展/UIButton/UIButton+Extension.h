//
//  UIButton+Extension.h
//  BeautyApp
//
//  Created by zhangming on 17/1/22.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/** 扩大btn点击范围 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end
