//
//  RecommendListModel.h
//  BeautyApp
//
//  Created by zhangming on 17/2/7.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendListModel : NSObject

@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSArray *list;
@property (copy, nonatomic) NSString *subTitle;
@property (assign, nonatomic) CGFloat height;

@end
