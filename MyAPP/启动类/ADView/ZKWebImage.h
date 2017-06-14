//
//  ZKWebImage.h
//  ZKADviewDemo
//
//  Created by 张日奎 on 16/12/28.
//  Copyright © 2016年 bestdew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, ZKWebImageOptions) {
    
    ZKWebImageOptionDefault   = 1 << 0, // 有缓存，读取缓存，不重新加载；没缓存先加载，并缓存
    ZKWebImageOptionOnlyLoad  = 1 << 1, // 只加载，不缓存
    ZKWebImageOptionRefresh   = 1 << 2  // 先读缓存，再加载刷新图片和缓存
};

@interface ZKWebImage : NSObject

/**
 异步下载图片
 
 @param url      图片URL
 @param options  缓存机制
 @param complete 下载完成的回调
 */
+ (void)downloadImageWithURL:(NSURL *)url
                     options:(ZKWebImageOptions)options
                    complete:(void (^)(UIImage *image))complete;

/** 获取图片缓存路径 */
+ (NSString *)cachePath;

/** 获取图片缓存大小(M) */
+ (float)imagesCacheSize;

/** 清除图片本地缓存 */
+ (void)clearImageCache;

@end
