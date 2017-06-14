//
//  ZKADImageView.h
//  BBC
//
//  Created by 张日奎 on 16/11/14.
//  Copyright © 2016年 bestdew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKWebImage.h"

NS_ASSUME_NONNULL_BEGIN

@class ZKADView;

typedef NS_ENUM(NSUInteger, SkipButtonType) {
    
    SkipButtonTypeNone         = 0, // 无
    SkipButtonTypeTime         = 1, // 倒计时
    SkipButtonTypeText         = 2, // 跳过
    SkipButtonTypeTimeAndText  = 3  // 倒计时 + 跳过
};

@protocol ZKADViewDelegate <NSObject>

@optional

/** 图片加载完成的回调 */
- (void)adImageLoadFinish:(ZKADView *)adView image:(nullable UIImage *)image;

/** 图片点击的代理方法 */
- (void)adImageDidClick:(ZKADView *)adView;

@end

@interface ZKADView : UIImageView

/** 广告图的停留时间，最小3s(默认5s) */
@property (nonatomic, assign) NSUInteger duration;

/** 未检测到数据时，启动图的等待时间，最小1s(默认3s) */
@property (nonatomic, assign) NSUInteger waitTime;

/** 缓存机制 */
@property (nonatomic, assign) ZKWebImageOptions options;

/** 右上角按钮类型 */
@property (nonatomic, assign) SkipButtonType skipType;

/** 代理 */
@property (nonatomic, weak) id<ZKADViewDelegate> delegate;

/** 广告图URL */
@property (nullable, nonatomic, readonly) NSURL *url;

/** 加载广告图 */
- (void)reloadDataWithURL:(nullable NSURL *)url;

@end

NS_ASSUME_NONNULL_END
