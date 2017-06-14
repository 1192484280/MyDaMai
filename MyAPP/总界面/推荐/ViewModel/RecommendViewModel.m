//
//  RecommendViewModel.m
//  BeautyApp
//
//  Created by zhangming on 17/2/6.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "RecommendViewModel.h"
#import "RecommendTypeModel.h"
#import "RecommendShufflingModel.h"
#import "RecommendListModel.h"
#import "RecommendNewModel.h"
#import "RecommendLikeModel.h"
@implementation RecommendViewModel

- (void)getCityId:(NSString *)cityId ShufflingFigureArray:(void (^)(NSArray *))shuffling Failure:(void (^)(NSError *))failure
{
    NSDictionary *dic = @{@"cityId" : (cityId ? cityId : @"586") ,
                          @"source" : @"10099" ,
                          @"version" : @"50403"};
    
    [HttpTool getUrlWithString:@"https://gw.damai.cn/index/banner/2/list.json" parameters:dic success:^(id responseObject) {
        
        NSArray *ay = [RecommendShufflingModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        if (shuffling) {
            shuffling(ay);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)getCityId:(NSString *)cityId TypeList:(void (^)(RecommendTypeModel *, CGFloat))typeMd Failure:(void (^)(NSError *))failure
{
    NSDictionary *dic = @{@"cityId" : (cityId ? cityId : @"586") ,
                          @"source" : @"10099" ,
                          @"version" : @"50403"};
    
    [HttpTool getUrlWithString:@"https://mapi.damai.cn/Proj/Panev3.aspx" parameters:dic success:^(id responseObject) {
        RecommendTypeModel *model = [RecommendTypeModel mj_objectWithKeyValues:responseObject];
        CGFloat height = 0;
        CGFloat shufflingH = ScreenWidth / 16 * 9;
        CGFloat typeH = 210;
        CGFloat headlinesH = 45;
        CGFloat middleH = 0;
        CGFloat margin = 10;
        CGFloat couponsH = 0;
        CGFloat rNewH = 250;
        CGFloat typeTenH = 0;
        CGFloat titleViewH = 0;
        CGFloat twoViewH = 0;
        CGFloat threeViewH = 0;
        CGFloat twelveViewH = 0;
        for (RecommendListModel *md in model.list) {
            if (md.title.length > 0) {
                margin += 10;
                titleViewH += 50;
                if (md.subTitle.length > 0) {
                    titleViewH += 22;
                }
            }
            if (md.list.count > 0) {
                if (md.type.integerValue == 1) {
                    couponsH += md.height;
                }else if (md.type.integerValue == 2) {
                    twoViewH += md.height;
                }else if (md.type.integerValue == 3) {
                    threeViewH += md.height;
                }else if (md.type.integerValue == 4) {
                    middleH += md.height;
                }else if (md.type.integerValue == 10) {
                    typeTenH += md.height;
                }else if (md.type.integerValue == 12) {
                    twelveViewH += md.height;
                }
            }
            if (md.type.integerValue == 6) {
                
            }else if (md.type.integerValue == 11) {
                margin -= 10;
            }
        }
        height = shufflingH + typeH + headlinesH + middleH + couponsH + margin + rNewH + typeTenH + titleViewH + twoViewH + threeViewH + twelveViewH;
        if (typeMd) {
            typeMd(model,height);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)getCityId:(NSString *)cityId NewListModels:(void (^)(NSArray *))models Failure:(void (^)(NSError *))failure
{
    NSDictionary *dic = @{@"cityId" : (cityId ? cityId : @"586") ,
                          @"source" : @"10099" ,
                          @"version" : @"50403"};
    
    [HttpTool getUrlWithString:@"https://mapi.damai.cn/proj/HotProjV1.aspx" parameters:dic success:^(id responseObject) {
        NSArray *array = [RecommendNewModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        if (models) {
            models(array);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)getModel:(SelectCityModel *)model LikeListModels:(void (^)(NSArray *))models Failure:(void (^)(NSError *))failure
{
    NSDictionary *dic = @{@"cityId" : (model.i ? model.i : @"586") ,
                          @"lat" : (model.lat ? model.lat : @"30.59") ,
                          @"lon" : (model.lng ? model.lng : @"114.31") ,
                          @"source" : @"10099" ,
                          @"version" : @"50403" ,
                          @"visitorId" : @"WDlko02HVRUDAFVsiJfmDUk6"};
    
    [HttpTool getUrlWithString:@"https://mapi.damai.cn/proj/Intelligence/index.aspx" parameters:dic success:^(id responseObject) {
        NSArray *array = [RecommendLikeModel mj_objectArrayWithKeyValuesArray:responseObject];
        if (models) {
            models(array);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
