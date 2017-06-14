//
//  GetAllCityViewModel.m
//  MyAPP
//
//  Created by zhangming on 17/3/14.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "GetAllCityViewModel.h"

@implementation GetAllCityViewModel

+ (void)getAllCityList:(void(^)(NSArray *hostList,NSArray *sectionList,NSArray *cityList))cityList{
    
    NSDictionary *dic = @{
                          @"source" : @"10099",
                          @"version" : @"50403"
                          };
    [HttpTool getUrlWithString:@"https://mapi.damai.cn/NCityList.aspx" parameters:dic success:^(id responseObject) {
        
        NSArray *arr = [SelectCityModel mj_objectArrayWithKeyValuesArray:responseObject];
        arr = [arr subarrayWithRange:NSMakeRange(1, arr.count-1)];
        
        NSArray *hotArr = [arr subarrayWithRange:NSMakeRange(0, 6)];
        NSMutableArray *cityArr = [NSMutableArray array];
        for (int i = 0 ; i < 26 ; i++) {
            NSMutableArray *array = [NSMutableArray array];
            [cityArr addObject:array];
        }
        
        for (SelectCityModel *model in arr) {
            for (int i = 97; i <= 122 ; i++) {
                NSString *str = [model.PinYin substringWithRange:NSMakeRange(0, 1)];
                if ([str isEqualToString:[NSString stringWithFormat:@"%c",(char)i]]) {
                    NSMutableArray *array = cityArr[i - 97];
                    [array addObject:model];
                    break;
                }
            }
        }
        
        for (int i = 0; i < cityArr.count; i++) {
            
            NSArray *arr = cityArr[i];
            if (arr.count == 0) {
                
                [cityArr removeObject:arr];
            }
        }
        
        NSMutableArray *sectionArr = [NSMutableArray array];
        for (NSArray *array in cityArr) {
            SelectCityModel *model = array.firstObject;
            NSString *str = [model.PinYin substringToIndex:1];
            [sectionArr addObject:str];
        }
        
        if (cityList) {
            
            cityList(hotArr,sectionArr,cityArr);
        }
    } failure:^(NSError *error) {
        
        
    }];
    
}

@end
