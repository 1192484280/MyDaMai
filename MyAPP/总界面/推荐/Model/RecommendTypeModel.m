//
//  RecommendTypeModel.m
//  BeautyApp
//
//  Created by zhangming on 17/2/7.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "RecommendTypeModel.h"

@implementation RecommendTypeModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{
             @"btnCtx":@"RecommendTypeBtnModel",
             @"headline":@"RecommendHeaderlinesModel",
             @"list":@"RecommendListModel"
             };
}
@end
