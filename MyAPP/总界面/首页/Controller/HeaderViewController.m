//
//  HeaderViewController.m
//  Family
//
//  Created by zhangming on 17/5/27.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "HeaderViewController.h"
#import "ReViewController.h"
#import "HotViewController.h"
#import "SocietyViewController.h"

@interface HeaderViewController ()

@property (copy, nonatomic) NSArray *controllersArr;
@property (copy, nonatomic) NSArray *titlesArr;
    
@end

@implementation HeaderViewController

- (NSArray *)controllersArr{
    
    if (!_controllersArr) {
        
        ReViewController *vc1 = [[ReViewController alloc] init];
        HotViewController *vc2 = [[HotViewController alloc] init];
        SocietyViewController *vc3 = [[SocietyViewController alloc] init];
        _controllersArr = @[vc1,vc2,vc3];
    }
    
    return _controllersArr;
}

- (NSArray *)titlesArr{
    
    
    if (!_titlesArr) {
        
        _titlesArr = @[@"推荐",@"热点",@"记录"];
    }
    return _titlesArr;
}
    
- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setNavBar];

    self.collectionViewBarOffsetY = 64;
    self.cellSpacing = 25;
    self.cellWidth = 60;
}

- (void)setNavBar{
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [self.view addSubview:navBar];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    [navBar pushNavigationItem:navItem animated:YES];
    [navBar setBackgroundImage:[UIImage imageWithColor:NAVBARCOLOR size:CGSizeMake(ScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    
    BAButton *newsBtn = [[BAButton alloc] init];
    newsBtn.frame = CGRectMake(0, 0, 45, 45);
    [newsBtn setTitle:@"消息" forState:UIControlStateNormal];
    [newsBtn setImage:[UIImage imageNamed:@"icon_news"] forState:UIControlStateNormal];
    [newsBtn addTarget:self action:@selector(onNews) forControlEvents:UIControlEventTouchUpInside];
    newsBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    newsBtn.padding = 12;
    newsBtn.buttonPositionStyle = BAButtonPositionStyleTop;
    navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:newsBtn];
    
    UIBarButtonItem *rightOnew = [UIBarButtonItem itemWithImageName:@"icon_message" highImageName:@"my" target:self action:@selector(onRightOne)];
    
    UIBarButtonItem *rightTwo = [UIBarButtonItem itemWithImageName:@"icon_saomiao_normal" highImageName:@"my" target:self action:@selector(onRightTwo)];
    
    navItem.rightBarButtonItems = @[rightTwo,rightOnew];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"搜索新闻、舆论" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor colorWithHexString:@"#f9f9f9"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"index_search"] forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3]];
    searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    searchBtn.width = ScreenWidth * 0.6;
    searchBtn.height = 30;
    searchBtn.layer.cornerRadius = 4;
    navItem.titleView = searchBtn;
    
}

- (void)onNews{
    
    NSLog(@"消息");
}

- (void)onRightOne{
    
    NSLog(@"右1");
}
    
- (void)onRightTwo{
    
    NSLog(@"右2");
}
#pragma mark - TYPagerControllerDataSource
    
- (NSInteger)numberOfControllersInPagerController
{
    return self.controllersArr.count;
}
    
    
- (NSString *)pagerController:(TYPagerController *)pagerController titleForIndex:(NSInteger)index{
    
    return self.titlesArr[index];
}
    
    
- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index{
    
    return self.controllersArr[index];
}
    
    
#pragma mark - override delegate
- (void)pagerController:(TYTabPagerController *)pagerController configreCell:(TYTabTitleViewCell *)cell forItemTitle:(NSString *)title atIndexPath:(NSIndexPath *)indexPath{
    
    [super pagerController:pagerController configreCell:cell forItemTitle:title atIndexPath:indexPath];
}
    
    
- (void)pagerController:(TYTabPagerController *)pagerController didSelectAtIndexPath:(NSIndexPath *)indexPath{
    
        NSLog(@"didSelectAtIndexPath %@",indexPath);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
