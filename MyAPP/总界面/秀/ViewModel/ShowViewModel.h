//
//  ShowViewModel.h
//  大麦
//
//  Created by 洪欣 on 16/12/21.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowRequestModel.h"
@interface ShowViewModel : NSObject

+ (void)getAllTypeModel:(ShowRequestModel *)md List:(void(^)(NSArray *array, NSInteger total))list Failure:(void(^)(NSError *error))failure;

@end
