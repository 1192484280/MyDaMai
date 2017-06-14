//
//  ShowSubViewController.m
//  MyAPP
//
//  Created by zhangming on 17/3/10.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "ShowSubViewController.h"
#import "ShowCell.h"
#import "ShowRequestModel.h"
#import "ShowViewModel.h"
#import "IntroductionViewController.h"

@interface ShowSubViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (strong, nonatomic) NSMutableArray *list;

@property (strong, nonatomic) ShowRequestModel *Md;

@property (assign , nonatomic) BOOL Refreshing;

@end

@implementation ShowSubViewController


- (ShowRequestModel *)Md
{
    if (!_Md) {
        _Md = [[ShowRequestModel alloc] init];
    }
    return _Md;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setup];
    
}

- (void)setup{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-104) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //tableView数据为空时显示内容代理
    tableView.emptyDataSetSource = self;
    tableView.emptyDataSetDelegate = self;
    tableView.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
    self.tableView = tableView;
    
    UIView *footerView = [[UIView alloc] init];
    footerView.height = 10;
    tableView.tableFooterView = footerView;
    
    
    HXWeakSelf
    tableView.mj_header = [HXRefreshHeader headerWithRefreshingBlock:^{
        
        weakSelf.Refreshing = YES;
        weakSelf.Md.p = @"1";
        [weakSelf loadData:weakSelf.Md Complete:nil];
        
    }];
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        weakSelf.Refreshing = YES;
        weakSelf.Md.p = [NSString stringWithFormat:@"%d",weakSelf.Md.p.intValue + 1];
        [weakSelf loadData:weakSelf.Md Complete:nil];
        
    }];
    footer.stateLabel.hidden = YES;
    tableView.mj_footer = footer;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 9.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShowCell *cell = [ShowCell tempTableViewCellWith:tableView];
    cell.model = self.list[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ShowCell *cell = (ShowCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",cell.title.text);
    
    IntroductionViewController *introducVC = [[IntroductionViewController alloc] init];
    [introducVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:introducVC animated:YES];
}

#pragma mark -
#pragma mark - DZNEmptyDataSetDelegate(没有数据时显示)
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"该页面暂时没有数据";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:BASEFONT size:14],NSForegroundColorAttributeName:[UIColor grayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"moren_noproject"];
}
//btn文字
//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
//{
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
//    
//    return [[NSAttributedString alloc] initWithString:@"刷新" attributes:attributes];
//}

//背景色
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}


//- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
//{
//    NSLog(@"点击刷新");
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - 加载数据
- (void)loadData:(ShowRequestModel *)model Complete:(void(^)())complete
{
    if (model.p.integerValue == 1 && !self.Refreshing) {
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    self.Md = model;
    HXWeakSelf
    [ShowViewModel getAllTypeModel:self.Md List:^(NSArray *array, NSInteger total) {
        [weakSelf.tableView.mj_header endRefreshing];
        if (weakSelf.Md.p.intValue == 1) {
            weakSelf.list = [NSMutableArray arrayWithArray:array];
        }else {
            [weakSelf.list addObjectsFromArray:array];
        }
        [weakSelf.tableView reloadData];
        if (total == weakSelf.list.count) {
            weakSelf.tableView.mj_footer.hidden = YES;
        }else {
            weakSelf.tableView.mj_footer.hidden = NO;
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        weakSelf.Refreshing = NO;
        
        
        if (complete) {
            complete();
        }
    } Failure:^(NSError *error) {
        weakSelf.Refreshing = NO;
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        if (weakSelf.Md.p.intValue > 1) {
            weakSelf.Md.p = [NSString stringWithFormat:@"%d",weakSelf.Md.p.intValue - 1];
        }
        if (complete) {
            complete();
        }
    }];
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
