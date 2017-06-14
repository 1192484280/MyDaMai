//
//  RecommendLikeModel.h
//  BeautyApp
//
//  Created by zhangming on 17/2/6.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendLikeModel : NSObject

@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *item_id;
@property (copy, nonatomic) NSString *city_id;
@property (copy, nonatomic) NSString *category_id;
@property (copy, nonatomic) NSString *subcategory_id;
@property (copy, nonatomic) NSString *city_name;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *category_name;
@property (copy, nonatomic) NSString *subcategory_name;
@property (copy, nonatomic) NSString *venue_id;
@property (copy, nonatomic) NSString *venue_name;
@property (copy, nonatomic) NSString *show_time;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *tag;

@end
