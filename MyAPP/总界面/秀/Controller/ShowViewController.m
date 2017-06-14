//
//  ShowViewController.m
//  大麦大麦！
//
//  Created by zhangming on 17/1/12.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "ShowViewController.h"
#import "TypeScrollView.h"
//#import "HorizontalButton.h"
#import "ShowSelectTypeView.h"
#import "ShowSubViewController.h"
#import "ShowChildScrollView.h"
#import "SelectCityViewController.h"

@interface ShowViewController ()<TypeScrollViewDelegate,ShowChildScrollViewDelegate>

@property (copy, nonatomic) NSArray *titles;
@property (weak, nonatomic) TypeScrollView *typeView;
@property (weak, nonatomic) BAButton *cityBtn;
@property (weak, nonatomic) UIButton *rightBtn;
@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) ShowSelectTypeView *timeTypeView;
@property (weak, nonatomic) ShowChildScrollView *scrollView;



@end

@implementation ShowViewController




- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (ShowSelectTypeView *)timeTypeView
{
    if (!_timeTypeView) {
        _timeTypeView = [[ShowSelectTypeView alloc] initWithFrame:CGRectMake(0, 64 - 250, ScreenWidth, 250)];
    }
    return _timeTypeView;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didBgViewClick)]];
    }
    return _bgView;
}

- (void)didBgViewClick
{
    [self didRightClick:self.rightBtn];
}

- (NSArray *)titles{
    
    if (!_titles) {
        
        _titles = @[@"全部分类",@"演唱会",@"音乐会",@"话剧歌剧",@"舞蹈芭蕾",@"曲苑杂坛",@"体育比赛",@"度假休闲",@"周边商品",@"儿童亲子",@"动漫"];
    }
    return _titles;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubViewController];
    
    [self setupUI];
    
    [self setupNavBar];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectTypeNotification:) name:NOTIFY_TYPESELECT object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedCityNotification:) name:NOTIFY_CITYSELECT object:nil];
    
}

- (void)selectTypeNotification:(NSNotification *)notification{
    
    [self didRightClick:self.rightBtn];
    
}
- (void)selectedCityNotification:(NSNotification *)notification
{
    SelectCityModel *model = notification.userInfo[@"model"];
    [self.cityBtn setTitle:model.n forState:UIControlStateNormal];
}

- (void)addSubViewController
{
    ShowSubViewController *subVC1 = [[ShowSubViewController alloc] init];
    [self addChildViewController:subVC1];
    
    ShowSubViewController *subVC2 = [[ShowSubViewController alloc] init];
    [self addChildViewController:subVC2];
    
}

- (void)setupUI{

    self.view.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
    TypeScrollView *typeView = [[TypeScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 40) Titles:self.titles];
    typeView.myDelegate = self;
    typeView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self.view addSubview:typeView];
    self.typeView = typeView;
    
    ShowChildScrollView *scrollView = [[ShowChildScrollView alloc] initWithFrame:CGRectMake(0, 104, ScreenWidth, ScreenHeight - 104) ChildViewControllers:self.childViewControllers MaxCount:self.titles.count];
    scrollView.myDelegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

#pragma mark - TypeScrollViewDelegate
- (void)didTypeWithIndex:(NSInteger)index
{
    [self.scrollView scrollViewWithIndex:index];
}

- (void)scrollViewEndSlideWithIndex:(NSInteger)index
{
    [self.typeView selectedButtonForIndex:index];
}

- (void)setupNavBar
{
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [self.view addSubview:navBar];
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    [navBar pushNavigationItem:navItem animated:YES];
    [navBar setBackgroundImage:[UIImage imageWithColor:NAVBARCOLOR size:CGSizeMake(ScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    navItem.title = @"秀";
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:BASEFONT size:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //HorizontalButton *cityBtn = [HorizontalButton buttonWithType:UIButtonTypeCustom];
    BAButton *cityBtn = [[BAButton alloc] init];
    cityBtn.frame = CGRectMake(0, 0, 60, 30);
    SingleClass *single = [SingleClass sharedInstance];
    [cityBtn setTitle:(single.cityName ? single.cityName : @"大连") forState:UIControlStateNormal];
    [cityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cityBtn setImage:[UIImage imageNamed:@"btn_cityArrow"] forState:UIControlStateNormal];
    cityBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    cityBtn.padding = 0;
    cityBtn.buttonPositionStyle = BAButtonPositionStyleCenter;
    self.cityBtn = cityBtn;
    [cityBtn addTarget:self action:@selector(didCityBtnClick) forControlEvents:UIControlEventTouchUpInside];
    navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cityBtn];
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[[UIImage imageNamed:@"icon_screening_bottom_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(didRightClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.size = rightBtn.currentImage.size;
    self.rightBtn = rightBtn;
    navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [navBar setTintColor:[UIColor whiteColor]];
    
    [self.view insertSubview:self.timeTypeView belowSubview:navBar];
}



- (void)didCityBtnClick{
 
    
    SelectCityViewController *selectCityVC = [[SelectCityViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:selectCityVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didRightClick:(UIButton *)button{
    
    NSLog(@"点击时间");
    button.selected = !button.selected;
    
    if (button.selected) {
        [self.view insertSubview:self.bgView belowSubview:self.timeTypeView];
        [UIView animateWithDuration:0.25 animations:^{
            button.transform = CGAffineTransformMakeRotation(M_PI);
            self.timeTypeView.y = 64;
            self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        }];
    }else {
        [UIView animateWithDuration:0.25 animations:^{
            button.transform = CGAffineTransformIdentity;
            self.timeTypeView.y = 64-250;
            self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        } completion:^(BOOL finished) {
            [self.bgView removeFromSuperview];
        }];
    }
}





- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
