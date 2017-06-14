/**
 * @file
 * @author 郝
 * @date 2016-07-16
 */
#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>

@interface NSString (md5)

-(NSString *) md5HexDigest;

@end
