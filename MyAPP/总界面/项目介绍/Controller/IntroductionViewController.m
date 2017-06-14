//
//  IntroductionViewController.m
//  MyAPP
//
//  Created by zhangming on 17/3/21.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "IntroductionViewController.h"
#import "IntroductionHeaderView.h"
#import "IntroductionScrollView.h"
#import "IntroductionBottomView.h"

@interface IntroductionViewController ()<UIScrollViewDelegate>

@property (weak , nonatomic) IntroductionHeaderView *headerView;
@property (weak , nonatomic) IntroductionScrollView *scrollView;
@property (weak , nonatomic) IntroductionBottomView *bottomView;

@end

@implementation IntroductionViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupNaviBar];
}

- (void)setupNaviBar{
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:BASEFONT size:15]}];
    [navBar setTintColor:[UIColor whiteColor]];
    [self.view addSubview:navBar];
    [navBar setShadowImage:[[UIImage alloc] init]];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    [navBar pushNavigationItem:navItem animated:YES];
    [navBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(ScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    navItem.title = @"项目介绍";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item0 = [UIBarButtonItem itemWithImageName:@"icon_share_normal" highImageName:@"m" target:self action:@selector(onItem0)];
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImageName:@"icon_collection_normal" selectedImageName:@"icon_collection_normal_add" target:self action:@selector(onItem1:)];
    
    navItem.rightBarButtonItems = @[item0,item1];
    navItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_back_normal" highImageName:@"m" target:self action:@selector(onBack)];
    [(UIButton *)navItem.leftBarButtonItem.customView setImage:[[UIImage imageNamed:@"icon_back_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
}

- (void)onItem0{
    
    NSLog(@"收藏");
    
}

- (void)onItem1:(UIButton *)button{
    
    NSLog(@"分享");
    button.selected = !button.selected;
}

- (void)onBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setupUI{
    
    IntroductionScrollView *scrollView = [[IntroductionScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.contentInset = UIEdgeInsetsMake(256, 0, 40, 0);
    [scrollView setContentOffset:CGPointMake(0, -265)];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    IntroductionHeaderView *headerView = [[IntroductionHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 265)];
    [self.view addSubview:headerView];
    self.headerView = headerView;

    IntroductionBottomView *bottomView = [[IntroductionBottomView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 40, ScreenWidth, 40)];
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.headerView updateSubViewsWithScrollOffsetY:scrollView.contentOffset.y];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
