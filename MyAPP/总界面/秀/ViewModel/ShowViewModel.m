//
//  ShowViewModel.m
//  大麦
//
//  Created by 洪欣 on 16/12/21.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "ShowViewModel.h"
#import "ShowViewCellModel.h"

@implementation ShowViewModel

+ (void)getAllTypeModel:(ShowRequestModel *)md List:(void (^)(NSArray *, NSInteger))list Failure:(void (^)(NSError *))failure
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
    [dic setObject:(md.EndTime ? md.EndTime : @"") forKey:@"EndTime"];
    [dic setObject:(md.StartTime ? md.StartTime : @"") forKey:@"StartTime"];
    [dic setObject:md.cc forKey:@"cc"];
    [dic setObject:(md.cityid ? md.cityid : @"1725") forKey:@"cityid"];
    [dic setObject:md.mc forKey:@"mc"];
    [dic setObject:md.ot forKey:@"ot"];
    [dic setObject:md.p forKey:@"p"];
    [dic setObject:md.ps forKey:@"ps"];
    [dic setObject:@"10099" forKey:@"source"];
    [dic setObject:@"50402" forKey:@"version"];
    
    [HttpTool getUrlWithString:@"http://mapi.damai.cn/ProjLst.aspx" parameters:dic success:^(id responseObject) {
        NSArray *array = [ShowViewCellModel mj_objectArrayWithKeyValuesArray:responseObject[@"l"]];
        if (list) {
            list(array,[responseObject[@"t"] integerValue]);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
