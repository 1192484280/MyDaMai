//
//  ZKWebImage.m
//  ZKADviewDemo
//
//  Created by 张日奎 on 16/12/28.
//  Copyright © 2016年 bestdew. All rights reserved.
//

#import "ZKWebImage.h"
#import <ImageIO/ImageIO.h>
#import <CommonCrypto/CommonDigest.h>

@implementation ZKWebImage

#pragma mark -- methods
+ (void)downloadImageWithURL:(NSURL *)url
                     options:(ZKWebImageOptions)options
                    complete:(void (^)(UIImage *image))complete;
{
    if(!options) options = ZKWebImageOptionDefault;
    
    if(options & ZKWebImageOptionOnlyLoad) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            UIImage *image = [self downloadImageWithURL:url isCache:NO];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if(complete) complete(image);
            });
        });
        
        return;
    }
    
    UIImage *image_c = [self getCacheImageWithURL:url];
    
    if(image_c && complete) {
        
        complete(image_c);
        
        if(options & ZKWebImageOptionDefault) return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *image = [self downloadImageWithURL:url isCache:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(complete) complete(image);
        });
    });
}

+ (NSString *)cachePath
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/ZKImageCache"];
    
    [self checkDirectory:path];
    
    return path;
}

+ (float)imagesCacheSize
{
    BOOL isDir = NO;
    unsigned long long total = 0;
    NSString *directoryPath = [self cachePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDir]) {
        
        if (isDir) {
            
            NSError *error = nil;
            NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:&error];
            
            if (error == nil) {
                
                for (NSString *subpath in array) {
                    
                    NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
                    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path
                                                                                          error:&error];
                    if (!error) total += [dict[NSFileSize] unsignedIntegerValue];
                }
            }
        }
    }
    
    return total / (1024.0 * 1024.0);
}

+ (void)clearImageCache
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSString *path = [self cachePath];
        
        [fileManager removeItemAtPath:path error:nil];
        
        [self checkDirectory:path];
    });
}

#pragma mark -- download
+ (UIImage *)downloadImageWithURL:(NSURL *)url isCache:(BOOL)cache
{
    if(!url) return nil;
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    if (cache) [self cacheImageWithData:data url:url];
    
    return [self zk_imageWithData:data];
}

+ (UIImage *)zk_imageWithData:(NSData *)data
{
    if (!data) return nil;
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *image;
    
    if (count <= 1) { // 静态图片
        
        image = [UIImage imageWithData:data];
        
    }else{ // 动态图片
        
        NSMutableArray *images = [NSMutableArray array];
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            duration += [self frameDurationAtIndex:i source:source];
            
            [images addObject:[UIImage imageWithCGImage:image
                                                  scale:[UIScreen mainScreen].scale
                                            orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        if (!duration) duration = (1.0f / 10.0f) * count;
        
        image = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    
    return image;
}

+ (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source
{
    float frameDuration = 0.1f;
    
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    
    if (delayTimeUnclampedProp) {
        
        frameDuration = [delayTimeUnclampedProp floatValue];
        
    }else{
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        
        if (delayTimeProp) frameDuration = [delayTimeProp floatValue];
    }
    
    if (frameDuration < 0.011f) frameDuration = 0.100f;
    
    CFRelease(cfFrameProperties);
    
    return frameDuration;
}

#pragma mark -- cache
+ (void)cacheImageWithData:(NSData *)data url:(NSURL *)url
{
    if (!data) return;
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", [self cachePath],[self md5String:url.absoluteString]];
    
    BOOL create = [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
    
    if (!create) NSLog(@"cache file error for URL: %@", url);
}

+ (UIImage *)getCacheImageWithURL:(NSURL *)url
{
    if(!url) return nil;
    
    NSString *directoryPath = [self cachePath];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", directoryPath,[self md5String:url.absoluteString]];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    return [self zk_imageWithData:data];
}

#pragma mark -- others
/** 检查路径 */
+ (void)checkDirectory:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDir;
    
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        
        [self createBaseDirectoryAtPath:path];
        
    }else if (!isDir) {
        
        NSError *error = nil;
        
        [fileManager removeItemAtPath:path error:&error];
        
        [self createBaseDirectoryAtPath:path];
    }
}

+ (void)createBaseDirectoryAtPath:(NSString *)path
{
    __autoreleasing NSError *error = nil;
    
    [[NSFileManager defaultManager] createDirectoryAtPath:path
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
    if (error) {
        
        NSLog(@"create cache directory failed, error = %@", error);
        
    }else{
        
        [self addDoNotBackupAttribute:path];
    }
}

+ (void)addDoNotBackupAttribute:(NSString *)path
{
    NSURL *url = [NSURL fileURLWithPath:path];
    
    NSError *error = nil;
    
    [url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    
    if (error) NSLog(@"error to set do not backup attribute, error = %@", error);
}

+ (NSString *)md5String:(NSString *)string
{
    if(string == nil || [string length] == 0)  return nil;
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *md5String = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++) {
        
        [md5String appendFormat:@"%02x", outputBuffer[count]];
    }
    
    return md5String;
}

@end
