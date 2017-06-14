//
//  LoginStore.m
//  MyAPP
//
//  Created by zhangming on 17/3/16.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "LoginStore.h"

@implementation LoginStore
    
- (void)requestWithSuccess:(void (^)())success failure:(void (^)(NSError *))failure{
    
    
    NSDictionary *dic = @{
                          @"name":@"123",
                          @"tel":@"1234"
                          };
    NSString *url = [NSString stringWithFormat:@"%@get.php",URL];
    [HttpTool getUrlWithString:url parameters:dic success:^(id responseObject) {
        
        NSLog(@"");
    } failure:^(NSError *error) {
        
        NSLog(@"");
    }];

    
}
    
    
@end
