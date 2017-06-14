//
//  BaseViewController.m
//  BeautyApp
//
//  Created by zhangming on 17/1/22.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    //[self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:NAVBARCOLOR size:CGSizeMake(ScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:BASEFONT size:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (LoadingView *)loadingView
{
    if (!_loadingView) {
        _loadingView = [[LoadingView alloc] initWithFrame:self.view.bounds];
    }
    return _loadingView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)setupNavBarWithTitle:(NSString *)title
{
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [self.navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self.navBar setTintColor:[UIColor whiteColor]];
    [self.view addSubview:self.navBar];
    [self.navBar setShadowImage:[[UIImage alloc] init]];
    self.navItem = [[UINavigationItem alloc] init];
    [self.navBar pushNavigationItem:self.navItem animated:YES];
    
    [self.navBar setBackgroundImage:[UIImage imageWithColor:NAVBARCOLOR size:CGSizeMake(ScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    self.navItem.title = title;
    
    self.navItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_back_normal" highImageName:@"my" target:self action:@selector(back)];
    [(UIButton *)self.navItem.leftBarButtonItem.customView setImage:[[UIImage imageNamed:@"icon_back_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 获取用户信息
- (NSString *)getUid{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    
    return [ud valueForKey:@"uid"];
    
}
- (NSString *)getUser{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    
    return [ud valueForKey:@"user"];
    
}

- (NSString *)getName{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([self isBlankString:[ud valueForKey:@"name"]]) {
        
        return @"未设置";
    }
    return [ud valueForKey:@"name"];
    
}

- (NSData *)getHeadIm{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *headIm = [ud valueForKey:@"headIm"];
    return headIm;
}
- (void)dealloc
{
    [[HttpSessionManager shareManager].operationQueue cancelAllOperations];
}


- (void)goLogin{
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [self presentViewController:loginVC animated:YES completion:nil];
}


#pragma mark - 发送通知
- (void)postNotifyWithName:(NSString *)name{
    
    NSNotification *notification = [NSNotification notificationWithName:name object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}


#pragma mark - 判断字符串是否为空
- (BOOL) isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    return NO;
    
}

#pragma mark - 加载loading
- (void)addLoadingView:(CGFloat)y{
    
    self.loadingView.y = y;
    self.loadingView.height = ScreenHeight-y-49;
    self.loadingView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.loadingView];
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
