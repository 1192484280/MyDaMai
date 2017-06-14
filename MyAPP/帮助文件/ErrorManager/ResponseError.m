//
//  ResponseError.m
//  ZhiNengJiaJu
//
//  Created by qianfeng on 15/11/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ResponseError.h"
#import "BaseStore.h"

@implementation ResponseError

+ (NSError *)inspectError:(NSDictionary *)responseObject {
    if ([responseObject[@"result"] integerValue] == 1) {
        return nil;
    } else {
        NSError *error = [NSError errorWithDomain:ResponseFailureDomain code:[responseObject[@"result"] integerValue] userInfo:@{NSLocalizedDescriptionKey:responseObject[@"msg"], NSLocalizedFailureReasonErrorKey:responseObject[@"msg"]}];
        return error;
    }
}

+ (UIAlertController *)handleError:(NSError *)error {
    if ([[error domain] isEqualToString:ResponseFailureDomain]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[error localizedDescription] message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *  action) {
        }]];
        return alert;
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络错误，请检查您的网络配置" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
        }]];
        return alert;
    }
}

+ (UIAlertController *)registerstoreError
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"两次密码不一致" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
    }]];
    return alert;
}
@end
