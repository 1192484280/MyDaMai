//
//  RecommendListModel.m
//  BeautyApp
//
//  Created by zhangming on 17/2/7.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "RecommendListModel.h"

@implementation RecommendListModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"list" : @"RecommendListSubModel"};
}

- (CGFloat)height
{
    if (!_height) {
        if (self.list.count > 0) {
            if (self.type.integerValue == 1) {
                _height = self.list.count * 120 + 5;
            }else if (self.type.integerValue == 2) {
                _height = 85;
            }else if (self.type.integerValue == 3) {
                _height = 185;
            }else if (self.type.integerValue == 4) {
                CGFloat itemW = (ScreenWidth - 8) / 2;
                CGFloat itemH = itemW / 16 * 7;
                _height = itemH * (self.list.count / 2) + 10;
            }else if (self.type.integerValue == 10) {
                _height = self.list.count * 100 + 5;
            }else if (self.type.integerValue == 12) {
                _height = (ScreenWidth - 15) / 4 + 5;
            }
        }
    }
    return _height;
}

@end
