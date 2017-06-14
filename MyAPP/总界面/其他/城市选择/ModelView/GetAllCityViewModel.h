//
//  GetAllCityViewModel.h
//  MyAPP
//
//  Created by zhangming on 17/3/14.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetAllCityViewModel : NSObject

+ (void)getAllCityList:(void(^)(NSArray *hostList,NSArray *sectionList,NSArray *cityList))cityList;

@end
