//
//  SelectCityViewController.m
//  MyAPP
//
//  Created by zhangming on 17/3/14.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "SelectCityViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "GetAllCityViewModel.h"
#import "SelectCityHeaderView.h"
#import "DBPrivateHelperController.h"
@interface SelectCityViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@property (copy , nonatomic) NSArray *sectionArr;
@property (copy , nonatomic) NSArray *hotCityArr;
@property (copy , nonatomic) NSArray *cityArr;
@property (copy , nonatomic) NSArray *locationArr;
@property (weak , nonatomic) UITableView *tableView;
@property (strong , nonatomic) CLLocationManager *locationManager;

@end

static NSString *selectCityHeaderViewId = @"selectCityHeaderViewId";

@implementation SelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.sectionArr = @[@"GPS定位到的城市"];
    SelectCityModel *model = [[SelectCityModel alloc] init];
    model.n = @"定位中";
    self.locationArr = @[model];
    [self setupNaviUI];
    [self addLocation];
    [self setupUI];
    
    [self.view addSubview:self.loadingView];
}

#pragma mark - 设置导航栏
- (void)setupNaviUI{
    
    self.title = @"城市选择";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(ScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"close_red" highImageName:@"my" target:self action:@selector(closeClick)];

}

- (void)closeClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 定位
- (void)addLocation{
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
}

#pragma mark - 定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    if ([error code] == kCLErrorDenied) {
        //用户拒绝定位
        //[self errorLocation];
        [self popupAlertView];
    }else if([error code] == kCLErrorLocationUnknown){
        //位置目前未知
        [self errorLocation];
    }
}

#pragma mark - 弹出允许权限帮助页
- (void)popupAlertView
{
    DBPrivateHelperController *privateHelper = [DBPrivateHelperController helperForType:DBPrivacyTypeLocation];
    privateHelper.snapshot = [self snapshot];
    privateHelper.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:privateHelper animated:YES completion:nil];
}
- (UIImage *)snapshot
{
    id <UIApplicationDelegate> appDelegate = [[UIApplication sharedApplication] delegate];
    UIGraphicsBeginImageContextWithOptions(appDelegate.window.bounds.size, NO, appDelegate.window.screen.scale);
    [appDelegate.window drawViewHierarchyInRect:appDelegate.window.bounds afterScreenUpdates:NO];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}
- (void)errorLocation{
    
    SelectCityModel *model = [[SelectCityModel alloc] init];
    model.n = @"大连市";
    self.locationArr = [NSArray arrayWithObject:model];
    HXWeakSelf
    [GetAllCityViewModel getAllCityList:^(NSArray *hostList, NSArray *sectionList, NSArray *cityList) {
        
        weakSelf.hotCityArr = hostList;
        NSMutableArray *array = [NSMutableArray arrayWithArray:sectionList];
        [array insertObject:@"热门城市" atIndex:0];
        [array insertObject:@"GPS定位到的城市" atIndex:0];
        weakSelf.sectionArr = array;
        weakSelf.cityArr = cityList;
        [weakSelf.tableView reloadData];
    }];
    [self.loadingView removeFromSuperview];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    SelectCityModel *model = [[SelectCityModel alloc] init];
    model.lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    model.lng = [NSString stringWithFormat:@"%f",coordinate.longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            
        }
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            if (!placemark.locality) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                model.n = placemark.administrativeArea;
            }else{
                model.n = placemark.locality;
            }
            model.i = [Tools queryCityId:model.n];
            self.locationArr = [NSArray arrayWithObject:model];
            HXWeakSelf
            [GetAllCityViewModel getAllCityList:^(NSArray *hostList, NSArray *sectionList, NSArray *cityList) {
                weakSelf.hotCityArr = hostList;
                NSMutableArray *array = [NSMutableArray arrayWithArray:sectionList];
                [array insertObject:@"热门城市" atIndex:0];
                [array insertObject:@"GPS定位到的城市" atIndex:0];
                weakSelf.sectionArr = array;
                weakSelf.cityArr = cityList;
                [weakSelf.tableView reloadData];
               [self.loadingView removeFromSuperview];
            }];
            
        }
    }];
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - 设置界面UI
- (void)setupUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-49) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[SelectCityHeaderView class] forHeaderFooterViewReuseIdentifier:selectCityHeaderViewId];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return self.locationArr.count;
    }else if(section == 1){
        
        return self.hotCityArr.count;
    }else{
        
        return [self.cityArr[section - 2] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *selectCityViewCellId = @"selectCityViewCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selectCityViewCellId];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectCityViewCellId];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    
    if (indexPath.section == 0) {
        
        SelectCityModel *model = self.locationArr.firstObject;
        cell.textLabel.text = model.n;
    }else if (indexPath.section == 1){
        
        SelectCityModel *model = self.hotCityArr[indexPath.row];
        cell.textLabel.text = model.n;
    }else{
        
        SelectCityModel *model = self.cityArr[indexPath.section -2][indexPath.row];
        cell.textLabel.text = model.n;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    SelectCityHeaderView *headerView = [[SelectCityHeaderView alloc] initWithReuseIdentifier:selectCityHeaderViewId];
    
    headerView.title = [self.sectionArr[section] uppercaseString];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SelectCityModel *model;
    if (indexPath.section == 0) {
        
        model = self.locationArr[indexPath.row];
        if ([model.n isEqualToString:@"定位失败"]) {
            return;
        }
        model.n = [model.n substringToIndex:model.n.length-1];
    }else if (indexPath.section == 1){
        
        model = self.hotCityArr[indexPath.row];
    }else{
        
        model = self.cityArr[indexPath.section - 2][indexPath.row];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    SingleClass *single = [SingleClass sharedInstance];
    single.cityName = model.n;
    single.cityId = model.i;
    single.latitude = model.lat;
    single.longitude = model.lng;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_CITYSELECT object:nil userInfo:@{@"model" :model}];
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
