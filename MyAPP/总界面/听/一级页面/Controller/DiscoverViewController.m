//
//  DiscoverViewController.m
//  大麦大麦！
//
//  Created by zhangming on 17/1/12.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverHeadView.h"
#import "RadioCarousel.h"
#import "RadioHostList.h"
#import "RadioAllList.h"
#import "RadioListCell.h"
#import "RadioListViewController.h"
@interface DiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>


/**
 *  存放顶部视图的数据
 */
@property (nonatomic,strong) NSMutableArray *radioHeaderArray;
/**
 *  表格头部视图
 */
@property (nonatomic,strong) DiscoverHeadView *headerView;

/**
 *  表格
 */
@property (nonatomic, strong) UITableView *radiotableView;

/**
 *  表格数据源数组
 */
@property (nonatomic,strong) NSMutableArray *radioAllListArray;

@end

@implementation DiscoverViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"听";
    
    [self.view addSubview:self.radioTableView];
    
    self.radiotableView.tableHeaderView = self.headerView;
    self.radiotableView.tableFooterView = [[UIView alloc] init];
    

    [self postRequest];
    
    //下拉刷新
    MJWeakSelf
    self.radioTableView.mj_header = [HXRefreshHeader headerWithRefreshingBlock:^{
        
        [weakSelf postRequest];
    }];
    
    
    
    self.loadingView.y = 104;
    self.loadingView.height = ScreenHeight-104-49;
    self.loadingView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.loadingView];
}

#pragma mark - 请求数据
- (void)postRequest{
    
    
    [HttpTool getUrlWithString:@"http://api2.pianke.me/ting/radio" parameters:nil success:^(id responseObject) {
        
        NSDictionary *dataDic = responseObject[@"data"];
        NSMutableArray *headerarray = [RadioCarousel mj_objectArrayWithKeyValuesArray:dataDic[@"carousel"]];
        NSMutableArray *hotarray = [RadioHostList mj_objectArrayWithKeyValuesArray:dataDic[@"hotlist"]];
        [self.radioHeaderArray addObject:headerarray];
        [self.radioHeaderArray addObject:hotarray];
        //设置表格头部视图的数据
        self.headerView.listArray = self.radioHeaderArray;
        //设置表格的数据
        self.radioAllListArray = [RadioAllList mj_objectArrayWithKeyValuesArray:dataDic[@"alllist"]];
        
        [self.radioTableView reloadData];
        [self.loadingView removeFromSuperview];
        [self.radioTableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        
        {
            [SVProgressHUD showErrorWithStatus:@"网络请求超时"];
            [self.loadingView removeFromSuperview];
            [self.radioTableView.mj_header endRefreshing];
        }
        
    }];
    
    
}

#pragma mark - 表格数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.radioAllListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadioListCell *cell = [RadioListCell cellWith:tableView];
    cell.allList = self.radioAllListArray[indexPath.row];
    return cell;
}


#pragma mark - 表格代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [RadioListCell getCellHeight:indexPath];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadioListViewController *radioListVC = [[RadioListViewController alloc] init];
    [radioListVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:radioListVC animated:YES];
}


#pragma mark -
#pragma mark - 懒加载
- (NSMutableArray *)radioHeaderArray
{
    if (!_radioHeaderArray) {
        _radioHeaderArray = [NSMutableArray array];
    }
    return _radioHeaderArray;
}


- (NSMutableArray *)radioAllListArray
{
    
    if (!_radioAllListArray) {
        _radioAllListArray = [NSMutableArray array];
    }
    return _radioAllListArray;
}

- (UITableView *)radioTableView{
    
    if (!_radiotableView) {
        
        _radiotableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-113) style:UITableViewStylePlain];
        _radiotableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _radiotableView.delegate = self;
        _radiotableView.dataSource = self;
    }
    return _radiotableView;
}

- (DiscoverHeadView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[DiscoverHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, (180 + HotImageW + 2 * Margin))];
        
        HXWeakSelf
        _headerView.block = ^(NSString *url){
            
            
        };
    }
    return _headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
