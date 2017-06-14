//
//  RecommendViewController.m
//  大麦大麦！
//
//  Created by zhangming on 17/1/12.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "RecommendViewController.h"
#import "SelectCityModel.h"
#import "RecommendLikeCell.h"
//#import "HorizontalButton.h"
#import "RecommendHeaderView.h"
#import "RecommendViewModel.h"
#import "RecommendShufflingModel.h"
#import "RecommendTypeModel.h"
#import <CoreLocation/CoreLocation.h>

@interface RecommendViewController ()<CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) CLLocationManager *locationManager;
//@property (weak, nonatomic) UINavigationBar *navBar;
@property (strong, nonatomic) SelectCityModel *model;
@property (weak, nonatomic) BAButton *cityBtn;
@property (weak, nonatomic) UIImageView *bgImg;
@property (weak, nonatomic) UIVisualEffectView *effectView;
@property (weak, nonatomic) UIButton *searchBtn;
@property (weak, nonatomic) RecommendHeaderView *headerView;
@property (strong, nonatomic) RecommendViewModel *viewModel;
@property (copy, nonatomic) NSArray *likeList;
@end

static NSString *recommendLikeCellId = @"recommendLikeViewCellId";

@implementation RecommendViewController

- (SelectCityModel *)model
{
    if (!_model) {
        _model = [[SelectCityModel alloc] init];
    }
    return _model;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = SetColor(250, 250, 250);
    
    [self addLocation];
    [self createNavigationItem];
    [self setUpTableView];
    
    
    [self addLoadingView:64];
}

- (void)addLocation{
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

#pragma mark - < 定位失败 >
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied) {
        [self errorLocation];
    }else if ([error code] == kCLErrorLocationUnknown) {
        [self errorLocation];
    }
}

- (void)errorLocation
{
    if ([self.cityBtn.currentTitle isEqualToString:@"武汉"]) {
        return;
    }
    SelectCityModel *model = [[SelectCityModel alloc] init];
    model.n = @"武汉";
    [self.cityBtn setTitle:model.n forState:UIControlStateNormal];
    self.model =  model;
    [self refreshList];
    [self.loadingView removeFromSuperview];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    self.model.lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    self.model.lng = [NSString stringWithFormat:@"%f",coordinate.longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            
        }
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            if (!placemark.locality) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                self.model.n = placemark.administrativeArea;
            }else{
                self.model.n = placemark.locality;
            }
            self.model.i = [Tools queryCityId:self.model.n];
            SingleClass *single = [SingleClass sharedInstance];
            single.cityName = [self.model.n substringToIndex:self.model.n.length - 1];
            single.cityId =self.model.i;
            single.latitude = self.model.lat;
            single.longitude = self.model.lng;
            [self.cityBtn setTitle:[self.model.n substringToIndex:self.model.n.length - 1] forState:UIControlStateNormal];

            [self refreshList];
        }
    }];
    [self.loadingView removeFromSuperview];
    [self.locationManager stopUpdatingLocation];
}

- (void)refreshList
{
    self.viewModel = [[RecommendViewModel alloc] init];
    HXWeakSelf
    [self.viewModel getCityId:self.model.i ShufflingFigureArray:^(NSArray *array) {
        
        RecommendShufflingModel *model = array.firstObject;
        [weakSelf.bgImg sd_setImageWithURL:[NSURL URLWithString:model.Pic]];
        weakSelf.headerView.shufflingAy = array;
    } Failure:^(NSError *error) {
        
    }];
    
    [self.viewModel getCityId:self.model.i TypeList:^(RecommendTypeModel *model, CGFloat headerViewHeight) {
        
        weakSelf.headerView.typeAy = model.btnCtx;
        weakSelf.headerView.headlines = model.headline;
        weakSelf.headerView.headerList = model.list;
        weakSelf.headerView.height = headerViewHeight;
        [weakSelf.loadingView removeFromSuperview];
        weakSelf.tableView.tableHeaderView = weakSelf.headerView;
        
        
    } Failure:^(NSError *error) {
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.loadingView removeFromSuperview];
        
    }];
    
    [self.viewModel getCityId:self.model.i NewListModels:^(NSArray *array) {
        weakSelf.headerView.rNewList = array;
    } Failure:^(NSError *error) {
        
    }];
    
    [self.viewModel getModel:self.model LikeListModels:^(NSArray *array) {
        weakSelf.likeList = array;
        [weakSelf.tableView reloadData];
    } Failure:^(NSError *error) {
        
    }];
}

#pragma mark - 导航栏确定按钮
- (void)createNavigationItem
{
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [self.view addSubview:navBar];
    self.navBar = navBar;
    
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    [navBar pushNavigationItem:navItem animated:YES];
    [navBar setBackgroundImage:[UIImage imageWithColor:[NAVBARCOLOR colorWithAlphaComponent:0] size:CGSizeMake(ScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    
    BAButton *cityBtn = [[BAButton alloc] init];
    cityBtn.frame = CGRectMake(0, 0, 60, 30);
    [cityBtn setTitle:@"定位中" forState:UIControlStateNormal];
    [cityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cityBtn setImage:[UIImage imageNamed:@"btn_cityArrow"] forState:UIControlStateNormal];
    cityBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    cityBtn.padding = 0;
    cityBtn.buttonPositionStyle = BAButtonPositionStyleCenter;
    self.cityBtn = cityBtn;
    navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cityBtn];
    
    UIBarButtonItem *rightOne = [UIBarButtonItem itemWithImageName:@"my_message" highImageName:@"my" target:self action:@selector(messageClick)];
    
    UIBarButtonItem *rightTwo = [UIBarButtonItem itemWithImageName:@"icon_saomiao_normal" highImageName:@"my" target:self action:@selector(QrCodeClick)];
    navItem.rightBarButtonItems = @[rightOne,rightTwo];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"搜索明星、演唱会、场馆" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor colorWithHexString:@"#f9f9f9"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"index_search"] forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[[UIColor colorWithHexString:@"#f3f3f3"] colorWithAlphaComponent:0.3]];
    searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    searchBtn.width = ScreenWidth * 0.6;
    searchBtn.height = 30;
    //searchBtn.layer.masksToBounds = YES;
    searchBtn.layer.cornerRadius = 4;
    navItem.titleView = searchBtn;
    self.searchBtn = searchBtn;
}

- (void)setUpTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor clearColor];
    [tableView registerClass:[RecommendLikeCell class] forCellReuseIdentifier:recommendLikeCellId];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 64, 0);
    [self.view addSubview:tableView];
    tableView.tableFooterView.height = 20;
    self.tableView = tableView;
    tableView.mj_header = [HXRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshList)];
    
    RecommendHeaderView *headerView = [[RecommendHeaderView alloc] init];
    tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, -5, ScreenWidth + 10, ScreenWidth / 16 * 9 + 10)];
    bgImg.centerX = ScreenWidth / 2;
    bgImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.view insertSubview:bgImg atIndex:0];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = bgImg.bounds;
    [bgImg addSubview:effectView];
    self.effectView = effectView;
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    maskView.backgroundColor = [[UIColor colorWithHexString:@"#e2f9444"] colorWithAlphaComponent:0.6];
    [self.view insertSubview:maskView atIndex:1];
    self.bgImg = bgImg;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.likeList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendLikeCellId];
    cell.model = self.likeList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha = offsetY / 100;
    [self.navBar setBackgroundImage:[UIImage imageWithColor:[NAVBARCOLOR colorWithAlphaComponent:alpha] size:CGSizeMake(ScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    
    if (offsetY > 100) {
        [self.searchBtn setBackgroundColor:[[UIColor colorWithHexString:@"#444444"] colorWithAlphaComponent:0.3]];
    }else {
        [self.searchBtn setBackgroundColor:[[UIColor colorWithHexString:@"#f3f3f3"] colorWithAlphaComponent:0.3]];
    }
    
    CGFloat H = ScreenWidth / 16 * 9 + 10 - offsetY;
    
    if (offsetY > 0) {
        H = ScreenWidth / 16 * 9 + 10;
    }
    self.bgImg.frame = CGRectMake(-5, -5, ScreenWidth + 10, H);
    self.effectView.frame = self.bgImg.bounds;
}

- (void)messageClick{
    
    NSLog(@"消息");
}

- (void)QrCodeClick{
    
    NSLog(@"扫描");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
