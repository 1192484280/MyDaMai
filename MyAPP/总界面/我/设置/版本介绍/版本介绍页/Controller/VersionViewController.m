//
//  VersionViewController.m
//  BeautyApp
//
//  Created by zhangming on 17/2/16.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "VersionViewController.h"
#import "AppDescripeViewController.h"
@interface VersionViewController ()

@end

@implementation VersionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    self.version.text = [NSString stringWithFormat:@"当前版本号%@",appCurVersionNum];
    
    [self setupNavBarWithTitle:@"关于安源"];
}
- (IBAction)onDescripeBtn:(id)sender {
    
    AppDescripeViewController *appVC = [[AppDescripeViewController alloc] init];
    [self.navigationController pushViewController:appVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
