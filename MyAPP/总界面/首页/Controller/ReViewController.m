//
//  ReViewController.m
//  MyAPP
//
//  Created by zhangming on 17/6/2.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "ReViewController.h"
#import "BooksCell.h"
#import "ReHeaderView.h"

@interface ReViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) ReHeaderView *headerView;

@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray *listArr;
@property (copy, nonatomic) NSArray *typeArr;
@property (copy, nonatomic) NSArray *likeArr;
@property (copy, nonatomic) NSArray *imgArr;
@end
@interface ReViewController ()

@end

@implementation ReViewController

- (NSArray *)typeArr{
    
    if (!_typeArr) {
        
        _typeArr = @[@"热门",@"精品",@"书吧",@"大咖",@"大连",@"主播"];
    }
    return _typeArr;
}

- (NSArray *)likeArr{
    
    if (!_likeArr) {
        
        _likeArr = @[@"摸金天师",@"民调局异闻",@"财富学者"];
    }
    
    return _likeArr;
}

- (NSArray *)imgArr{
    
    if (!_imgArr) {
        
        _imgArr = @[@"icon_slide01",@"icon_slide02",@"icon_slide03",@"icon_slide04"];
    }
    return _imgArr;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTableView];
    
    [self RefreshList];
    
}

- (void)RefreshList{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)setTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 -40-39) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    
    [self.view addSubview:tableView];
    
    ReHeaderView *headerView = [[ReHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth / 16 * 9 + 88)];
    self.headerView = headerView;
    
    tableView.tableHeaderView = headerView;
    
    UIView *footerView = [[UIView alloc] init];
    footerView.height = 10;
    tableView.tableFooterView = footerView;
    
    
    HXWeakSelf
    tableView.mj_header = [HXRefreshHeader headerWithRefreshingBlock:^{
        
        [weakSelf RefreshList];
        
    }];
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf RefreshList];
        
    }];
    footer.stateLabel.hidden = YES;
    tableView.mj_footer = footer;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section <= 1) {
        
        return 1;
    }
    return 15;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [BooksCell getHeightWithIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 9.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BooksCell *cell = [BooksCell tempWithTableView:tableView andIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
