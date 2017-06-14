//
//  AppDelegate.m
//  MyAPP
//
//  Created by zhangming on 17/3/1.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "AppDelegate.h"
#import "HeaderViewController.h"
#import "RecommendViewController.h"
#import "ShowViewController.h"
#import "DiscoverViewController.h"
#import "MeViewController.h"
#import "ZKADView.h"
#import "IQKeyboardManager.h"

@interface AppDelegate ()<ZKADViewDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [Tools addSqliteList];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:[[HeaderViewController alloc] init]];
    nav1.tabBarItem.title = @"推荐";
    nav1.tabBarItem.image = [[UIImage imageNamed:@"icon_tab1_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav1.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_tab1_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:[[ShowViewController alloc] init]];
    nav2.tabBarItem.title = @"秀";
    nav2.tabBarItem.image = [[UIImage imageNamed:@"icon_tab2_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav2.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_tab2_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:[[DiscoverViewController alloc] init]];
    nav3.tabBarItem.title = @"听";
    nav3.tabBarItem.image = [[UIImage imageNamed:@"icon_tab3_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav3.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_tab3_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:[[MeViewController alloc] init]];
    nav4.tabBarItem.title = @"我";
    nav4.tabBarItem.image = [[UIImage imageNamed:@"icon_tab4_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav4.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_tab4_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:BASEFONT size:13],NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:BASEFONT size:13],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#D33B47"]} forState:UIControlStateSelected];
    tabbar.viewControllers = @[nav1,nav2,nav3,nav4];
    //设置标签栏的颜色
    tabbar.tabBar.barTintColor = [UIColor whiteColor];
    self.window.rootViewController = tabbar;
    [self.window makeKeyAndVisible];
    
    /** 添加广告页 */
    [self addADView];
    
    /** 获取广告图URL */
    [self getADImageURL];
    
    //键盘管理
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    return YES;
}

- (void)addADView
{
    ZKADView *adView = [[ZKADView alloc] init];
    adView.tag = 100;
    adView.duration = 5;
    adView.waitTime = 5;
    adView.skipType = SkipButtonTypeTimeAndText;
    adView.options = ZKWebImageOptionDefault;
    adView.delegate = self;
    
    // 必须先将adView添加到父视图上才能调用 reloadDataWithURL: 方法加载广告图
    [self.window addSubview:adView];
}

- (void)getADImageURL
{
    // 此处推荐使用tag来获取adView，勿使用全局变量。因为在AppDelegate中将其设为全局变量时，不会被释放
    ZKADView *adView = (ZKADView *)[self.window viewWithTag:100];
    
    // 模拟从服务器上获取广告图URL
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *urlString = @"http://c.hiphotos.baidu.com/image/pic/item/d62a6059252dd42a6a943c180b3b5bb5c8eab8e7.jpg";
        
        
        [adView reloadDataWithURL:[NSURL URLWithString:urlString]]; // 加载广告图
    });
}

#pragma mark -- ZKADView Delegate
- (void)adImageLoadFinish:(ZKADView *)adView image:(UIImage *)image
{
    NSLog(@"%@", image);
}

- (void)adImageDidClick:(ZKADView *)adView
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://baidu.com"]
                                       options:@{}
                             completionHandler:nil];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"BeautyApp"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
